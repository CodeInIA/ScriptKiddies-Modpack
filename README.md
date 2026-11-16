<div align="center">

<img src="https://cdn.modrinth.com/data/MBjTGvhh/4450e562ea4b71ccc8717f7a20bea92d2625e426_96.webp" width="96" alt="ScriptKiddies">

# ScriptKiddies Modpack

**The client modpack of the ScriptKiddies Minecraft server**<br>
Fabric · Minecraft 26.3

[![Modrinth](https://img.shields.io/modrinth/v/scriptkiddies-modpack?logo=modrinth&label=Modrinth&color=1bd96a)](https://modrinth.com/modpack/scriptkiddies-modpack)
[![Installer](https://img.shields.io/github/v/release/CodeInIA/ScriptKiddies-Modpack?label=installer&logo=windows)](https://github.com/CodeInIA/ScriptKiddies-Modpack/releases/latest)
[![Website](https://img.shields.io/badge/web-scriptkiddies.netlify.app-8a2be2)](https://scriptkiddies.netlify.app)

</div>

## Install it

| You play with | Download | What to do |
|---|---|---|
| **Prism Launcher, Modrinth App or [Brinejar](https://brinejar.tech)** | [On Modrinth](https://modrinth.com/modpack/scriptkiddies-modpack) | Import the modpack. Your launcher keeps it up to date. |
| **The official launcher, the easy way** | [Installer (.exe)](https://github.com/CodeInIA/ScriptKiddies-Modpack/releases/latest/download/ScriptKiddies-modpack-installer.exe) | Install [Fabric Loader](https://fabricmc.net/use/installer/) for 26.3, run the installer, start the Fabric profile. |
| **The official launcher, by hand** | [Mods (.zip)](https://github.com/CodeInIA/ScriptKiddies-Modpack/releases/latest/download/ScriptKiddies-modpack.zip) | Install Fabric Loader and unzip the jars into `.minecraft\mods`. |

Then join the server and have fun.

## What is inside

- **Performance:** Sodium, Sodium Extra, ImmediatelyFast, FerriteCore, Entity Culling, BadOptimizations, Nvidium, Debugify
- **Visuals:** Iris Shaders, Distant Horizons, LambDynamicLights, 3D Skin Layers, Not Enough Animations, Chat Animation
- **Social:** Simple Voice Chat, Emotecraft, Chat Heads, Sound Physics Remastered
- **Utilities:** Litematica, MiniHUD, Tweakeroo, Jade, AppleSkin, Zoomify, Better Stats, Mod Menu

The full list of each version is on [Modrinth](https://modrinth.com/modpack/scriptkiddies-modpack/versions).

## How the downloads stay fresh

```
 new version on Modrinth ──► workflow, every 3 hours ──► GitHub release
                                     │                        │
                        downloads every mod and        .zip, .exe and .mrpack;
                        checks its SHA-512             the website links to
                                                       the latest one
```

Modrinth is the only place the pack is edited. Every three hours, or when run by hand from the
Actions tab, [the workflow](.github/workflows/release.yml) looks for a version it has not
released yet, builds the downloads with [`scripts/build-modpack.mjs`](scripts/build-modpack.mjs)
and the [Inno Setup script](installer.iss), and publishes them.

## Releasing a new version

1. Update the mods (with [Brinejar](https://brinejar.tech) it is one click) and export the
   profile as a `.mrpack`.
2. Upload it as a new version on Modrinth.
3. Done. The installer and the zip follow within a few hours.

---

<div align="center">

### 🇪🇸 En español

</div>

Modpack oficial de cliente del servidor **ScriptKiddies**. Si juegas con Prism, la Modrinth App o
Brinejar, impórtalo [desde Modrinth](https://modrinth.com/modpack/scriptkiddies-modpack) y se
mantendrá al día solo. Si usas el launcher oficial, instala Fabric Loader para la 26.3 y descarga
el [instalador](https://github.com/CodeInIA/ScriptKiddies-Modpack/releases/latest/download/ScriptKiddies-modpack-installer.exe)
o el [.zip con los mods](https://github.com/CodeInIA/ScriptKiddies-Modpack/releases/latest/download/ScriptKiddies-modpack.zip).
