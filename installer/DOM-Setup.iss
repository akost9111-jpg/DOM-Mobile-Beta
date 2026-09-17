; DOM Messenger branded Windows installer
#define MyAppName "DOM Messenger"
#define MyAppVersion "1.3.0"
#define MyAppPublisher "DOM"
#define MyAppExeName "dom_messenger.exe"

[Setup]
AppId={{B6B2C7D7-2D0B-4D47-9D56-DOM000000001}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\DOM Messenger
DefaultGroupName=DOM Messenger
DisableProgramGroupPage=yes
OutputDir=..\dist
OutputBaseFilename=DOM-Messenger-Setup
Compression=lzma2
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
WizardStyle=modern
WizardImageFile=assets\DOM-wizard.bmp
WizardSmallImageFile=assets\DOM-logo.bmp
SetupIconFile=assets\DOM-logo.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
PrivilegesRequired=lowest
ChangesAssociations=no
CloseApplications=yes
RestartApplications=no
AllowNoIcons=yes
ShowLanguageDialog=no

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Создать ярлык DOM на рабочем столе"; GroupDescription: "Дополнительные ярлыки:"; Flags: unchecked
Name: "startup"; Description: "Запускать DOM вместе с Windows"; GroupDescription: "Дополнительные параметры:"; Flags: unchecked

[Files]
Source: "..\app\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{autoprograms}\DOM Messenger"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"
Name: "{autodesktop}\DOM Messenger"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: desktopicon
Name: "{userstartup}\DOM Messenger"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: startup

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Запустить DOM Messenger"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssDone then
  begin
    { The [Run] entry above starts DOM when the user leaves the final page. }
  end;
end;
