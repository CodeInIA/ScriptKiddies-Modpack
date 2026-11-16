// Builds the modpack downloads from the newest version on Modrinth.
//
//   node scripts/build-modpack.mjs
//
// Writes to build/: the .mrpack as published, a .zip with every mod jar (for players who use the
// official launcher), and version.txt. Each jar is checked against its SHA-512. Prints the
// version number, so the workflow can tell whether it is new.
import { createHash } from "node:crypto";
import { mkdir, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { execFileSync } from "node:child_process";

const PROJECT = process.env.MODRINTH_PROJECT ?? "scriptkiddies-modpack";
const API = "https://api.modrinth.com/v2";
const headers = { "User-Agent": "ScriptKiddies-modpack-builder" };
if (process.env.MODRINTH_TOKEN) headers.Authorization = process.env.MODRINTH_TOKEN;

async function get(url) {
  const response = await fetch(url, { headers });
  if (!response.ok) throw new Error(`${url}: ${response.status}`);
  return response;
}

const versions = await (await get(`${API}/project/${PROJECT}/version`)).json();
const latest = versions.find((v) => v.status === "listed") ?? versions[0];
if (!latest) throw new Error("the project has no versions");
const pack = latest.files.find((f) => f.filename.endsWith(".mrpack"));
if (!pack) throw new Error(`version ${latest.version_number} has no .mrpack`);

await rm("build", { recursive: true, force: true });
await mkdir("build/mods", { recursive: true });
const mrpack = Buffer.from(await (await get(pack.url)).arrayBuffer());
await writeFile("build/ScriptKiddies-modpack.mrpack", mrpack);

// The index sits in the .mrpack (a zip); PowerShell or unzip reads it out.
const index = JSON.parse(
  process.platform === "win32"
    ? execFileSync("powershell", [
        "-NoProfile",
        "-Command",
        "Add-Type -A System.IO.Compression.FileSystem; $z=[IO.Compression.ZipFile]::OpenRead('build/ScriptKiddies-modpack.mrpack'); $e=$z.GetEntry('modrinth.index.json'); $r=New-Object IO.StreamReader($e.Open()); $r.ReadToEnd(); $z.Dispose()",
      ]).toString()
    : execFileSync("unzip", ["-p", "build/ScriptKiddies-modpack.mrpack", "modrinth.index.json"]).toString(),
);

for (const file of index.files) {
  if (file.env?.client === "unsupported") continue;
  const name = file.path.split("/").pop();
  if (!name || name.includes("..")) throw new Error(`bad path ${file.path}`);
  const bytes = Buffer.from(await (await get(file.downloads[0])).arrayBuffer());
  const sha512 = createHash("sha512").update(bytes).digest("hex");
  if (sha512 !== file.hashes.sha512) throw new Error(`${name}: hash mismatch`);
  await writeFile(join("build/mods", name), bytes);
}

await writeFile("build/version.txt", latest.version_number);
process.stdout.write(latest.version_number);
