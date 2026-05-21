$DotfilesDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Mode = $args[0]

if ($Mode -notin @("to-system", "to-repo"))
{
  Write-Error "Bitte Modus angeben: .\bootstrap.ps1 [to-system | to-repo]"
  exit 1
}

$AppDataLocal = "$env:USERPROFILE\AppData\Local"
$AppDataRoaming = "$env:USERPROFILE\AppData\Roaming"
$UserProfile = $env:USERPROFILE
$VsCodeTarget = "$AppDataRoaming\Code\User"

function Sync-ToSystem
{
  Write-Host "🔄 Kopiere Dotfiles auf das Windows-System..." -ForegroundColor Cyan
    
  # Home Files
  Copy-Item "$DotfilesDir\home\.ideavimrc" "$UserProfile\.ideavimrc" -Force

  # CLI Tools (AppData\Local)
  foreach ($app in @("nvim", "wezterm"))
  {
    $Target = "$AppDataLocal\$app"
    if (Test-Path "$DotfilesDir\apps\$app")
    {
      if (Test-Path $Target)
      { Remove-Item "$Target\*" -Recurse -Force 
      } else
      { New-Item -Type Directory -Path $Target | Out-Null 
      }
      Copy-Item "$DotfilesDir\apps\$app\*" $Target -Recurse -Force
    }
  }

  # Yazi (AppData\Roaming\yazi\config)
  $YaziTarget = "$AppDataRoaming\yazi\config"
  if (Test-Path "$DotfilesDir\apps\yazi")
  {
    if (Test-Path $YaziTarget)
    { Remove-Item "$YaziTarget\*" -Recurse -Force 
    } else
    { New-Item -Type Directory -Path $YaziTarget | Out-Null 
    }
    Copy-Item "$DotfilesDir\apps\yazi\*" $YaziTarget -Recurse -Force
  }

  # VS Code
  if (-not (Test-Path $VsCodeTarget))
  { New-Item -Type Directory -Path $VsCodeTarget | Out-Null 
  }
  Copy-Item "$DotfilesDir\apps\vscode\settings.json" "$VsCodeTarget\settings.json" -Force
  Copy-Item "$DotfilesDir\apps\vscode\keybindings.json" "$VsCodeTarget\keybindings.json" -Force
    
  Write-Host "✅ Fertig! Windows ist up to date." -ForegroundColor Green
}

function Sync-ToRepo
{
  Write-Host "📥 Hole aktuelle Files vom Windows-System ins Repo..." -ForegroundColor Cyan
    
  # Home Files
  if (Test-Path "$UserProfile\.ideavimrc")
  { Copy-Item "$UserProfile\.ideavimrc" "$DotfilesDir\home\.ideavimrc" -Force 
  }

  # AppData Local Tools
  foreach ($app in @("nvim", "wezterm"))
  {
    if (Test-Path "$AppDataLocal\$app")
    {
      Remove-Item "$DotfilesDir\apps\$app\*" -Recurse -Force -ErrorAction SilentlyContinue
      Copy-Item "$AppDataLocal\$app\*" "$DotfilesDir\apps\$app" -Recurse -Force
    }
  }

  # Yazi
  if (Test-Path "$AppDataRoaming\yazi\config")
  {
    Remove-Item "$DotfilesDir\apps\yazi\*" -Recurse -Force -ErrorAction SilentlyContinue
    Copy-Item "$AppDataRoaming\yazi\config\*" "$DotfilesDir\apps\yazi" -Recurse -Force
  }

  # VS Code
  if (Test-Path $VsCodeTarget)
  {
    if (Test-Path "$VsCodeTarget\settings.json")
    { Copy-Item "$VsCodeTarget\settings.json" "$DotfilesDir\apps\vscode\settings.json" -Force 
    }
    if (Test-Path "$VsCodeTarget\keybindings.json")
    { Copy-Item "$VsCodeTarget\keybindings.json" "$DotfilesDir\apps\vscode\keybindings.json" -Force 
    }
  }

  Write-Host "✅ Fertig! Repo hat die aktuellen Windows-Daten." -ForegroundColor Green
}

if ($Mode -eq "to-system")
{ Sync-ToSystem 
} else
{ Sync-ToRepo 
}
