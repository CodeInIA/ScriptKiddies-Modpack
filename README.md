# ScriptKiddies Modpack downloads

Every few hours a workflow looks at the [ScriptKiddies Modpack on Modrinth](https://modrinth.com/modpack/scriptkiddies-modpack).
When there is a new version it builds and publishes, as the latest release:

- `ScriptKiddies-modpack.mrpack`, to import in Prism, the Modrinth App or Brinejar
- `ScriptKiddies-modpack.zip`, every mod jar for the official launcher
- `ScriptKiddies-modpack-installer.exe`, which copies them into `.minecraft\mods`

The website links to `releases/latest/download/<file>`, so it always serves the newest version.
To publish a new version, upload it to Modrinth; the release follows on its own (or run the
workflow by hand from the Actions tab).
