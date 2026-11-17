# Windows PowerShell용: Claude Code(~/.claude/skills)와 Codex(~/.codex/skills)에 스킬을 설치/업데이트한다.
# 사용: .\install.ps1            → 전부 설치
#       .\install.ps1 ui-indicator-names   → 하나만 설치
param([string[]]$Names)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
$targets = @((Join-Path $HOME '.claude\skills'), (Join-Path $codexHome 'skills'))

if (-not $Names) { $Names = Get-ChildItem (Join-Path $here 'skills') -Directory | ForEach-Object Name }

foreach ($name in $Names) {
  $src = Join-Path $here "skills\$name"
  if (-not (Test-Path (Join-Path $src 'SKILL.md'))) { Write-Host "skip: $name (SKILL.md 없음)"; continue }
  foreach ($t in $targets) {
    New-Item -ItemType Directory -Force $t | Out-Null
    $dest = Join-Path $t $name
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    Copy-Item -Recurse $src $dest
    Write-Host "ok: $dest"
  }
}
Write-Host '끝. Claude Code는 /스킬이름, Codex는 $스킬이름 으로 부르거나 그냥 요청하면 알아서 씁니다.'
