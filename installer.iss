; Script generado con Inno Setup
; Script Kiddies Modpack Installer para Minecraft 26.3

#define MyAppName "Script Kiddies Modpack"
#ifndef MyAppVersion
  #define MyAppVersion "1.0"
#endif
#define MyAppPublisher "Script Kiddies"
#define MyAppURL "https://scriptkiddies.netlify.app"
#define MyAppExeName "minecraft.exe"

[Setup]
; NOTA: El valor de AppId identifica de manera única esta aplicación.
; No uses el mismo valor de AppId en otros instaladores.
AppId={{E8F4A2D1-5B3C-4E9A-8F7D-1A2B3C4D5E6F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} version {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={userappdata}\.minecraft\mods
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=
InfoBeforeFile=
OutputDir=build
OutputBaseFilename=ScriptKiddies-modpack-installer
SetupIconFile=server-icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
DisableProgramGroupPage=yes
DisableDirPage=no
PrivilegesRequired=lowest
UninstallDisplayIcon={uninstallexe}
UninstallFilesDir={localappdata}\ScriptKiddies\Uninstall
ShowLanguageDialog=yes
DisableWelcomePage=no

[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Messages]
spanish.WelcomeLabel2=Bienvenido al instalador de Script Kiddies Modpack para Minecraft 26.3%n%nAsegúrate de tener Fabric Loader instalado antes de continuar.
english.WelcomeLabel2=Welcome to Script Kiddies Modpack installer for Minecraft 26.3%n%nMake sure you have Fabric Loader installed before continuing.

[Files]
Source: "build\ScriptKiddies-modpack.zip"; DestDir: "{tmp}"; Flags: ignoreversion deleteafterinstall

[Dirs]
Name: "{userappdata}\.minecraft\mods"; Permissions: users-full

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  ZipFile: String;
  DestFolder: String;
  TempExtractFolder: String;
  ResultCode: Integer;
  InstalledFilesList: String;
  UninstallDir: String;
begin
  if CurStep = ssPostInstall then
  begin
    // Descomprimir el archivo ZIP
    ZipFile := ExpandConstant('{tmp}\ScriptKiddies-modpack.zip');
    DestFolder := ExpandConstant('{app}');
    TempExtractFolder := ExpandConstant('{tmp}\modpack_extract');
    UninstallDir := ExpandConstant('{localappdata}\ScriptKiddies\Uninstall');
    InstalledFilesList := UninstallDir + '\installed_files.txt';
    
    // Crear directorio del desinstalador si no existe
    if not DirExists(UninstallDir) then
      CreateDir(UninstallDir);
    
    // Usar PowerShell para descomprimir y copiar solo archivos .jar
    if FileExists(ZipFile) then
    begin
      // Primero extraer a carpeta temporal y crear lista de archivos instalados
      Exec('powershell.exe', 
        '-NoProfile -Command "& {' +
        'Expand-Archive -Path ''' + ZipFile + ''' -DestinationPath ''' + TempExtractFolder + ''' -Force; ' +
        '$files = Get-ChildItem -Path ''' + TempExtractFolder + ''' -Filter *.jar -Recurse; ' +
        '$files | ForEach-Object { ' +
        '  Copy-Item $_.FullName -Destination ''' + DestFolder + ''' -Force; ' +
        '  $_.Name | Out-File -FilePath ''' + InstalledFilesList + ''' -Append -Encoding UTF8 ' +
        '}; ' +
        'Remove-Item -Path ''' + TempExtractFolder + ''' -Recurse -Force' +
        '}"',
        '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  DestFolder: String;
  InstalledFilesList: String;
  UninstallDir: String;
  ResultCode: Integer;
begin
  if CurUninstallStep = usUninstall then
  begin
    DestFolder := ExpandConstant('{app}');
    UninstallDir := ExpandConstant('{localappdata}\ScriptKiddies\Uninstall');
    InstalledFilesList := UninstallDir + '\installed_files.txt';
    
    // Eliminar los archivos .jar usando PowerShell
    if FileExists(InstalledFilesList) then
    begin
      Exec('powershell.exe',
        '-NoProfile -Command "& {' +
        'if (Test-Path ''' + InstalledFilesList + ''') { ' +
        '  Get-Content ''' + InstalledFilesList + ''' | ForEach-Object { ' +
        '    $filePath = Join-Path ''' + DestFolder + ''' $_; ' +
        '    if (Test-Path $filePath) { Remove-Item $filePath -Force } ' +
        '  }; ' +
        '  Remove-Item ''' + InstalledFilesList + ''' -Force ' +
        '}' +
        '}"',
        '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    end
    else
    begin
      // Si no existe la lista, eliminar todos los .jar (método alternativo)
      Exec('powershell.exe',
        '-NoProfile -Command "& {' +
        'Get-ChildItem -Path ''' + DestFolder + ''' -Filter *.jar | Remove-Item -Force' +
        '}"',
        '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    end;
  end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  MinecraftDir: String;
  FabricCheck: String;
begin
  Result := True;
  
  // Verificar en la página de selección de directorio
  if CurPageID = wpSelectDir then
  begin
    MinecraftDir := ExpandConstant('{userappdata}\.minecraft');
    
    // Verificar si existe la carpeta de Minecraft
    if not DirExists(MinecraftDir) then
    begin
      if MsgBox('No se ha detectado Minecraft instalado. ¿Deseas continuar de todos modos?', 
                mbConfirmation, MB_YESNO) = IDNO then
      begin
        Result := False;
      end;
    end;
  end;
end;

[Icons]
Name: "{group}\Carpeta de Mods"; Filename: "{app}"
Name: "{group}\Desinstalar {#MyAppName}"; Filename: "{uninstallexe}"

[UninstallDelete]
Type: files; Name: "{app}\*.jar"

[Run]
Filename: "{app}"; Description: "Abrir carpeta de instalación"; Flags: postinstall shellexec skipifsilent
