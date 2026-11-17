#!/usr/bin/env bash
# Claude Code(~/.claude/skills)와 Codex(~/.codex/skills)에 이 저장소의 스킬을 설치/업데이트한다.
# 사용: ./install.sh            → 전부 설치
#       ./install.sh ui-indicator-names   → 하나만 설치
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
codex_home="${CODEX_HOME:-$HOME/.codex}"
targets=("$HOME/.claude/skills" "$codex_home/skills")

if [ "$#" -gt 0 ]; then names=("$@"); else
  names=(); for d in "$here"/skills/*/; do names+=("$(basename "$d")"); done
fi

for name in "${names[@]}"; do
  src="$here/skills/$name"
  [ -f "$src/SKILL.md" ] || { echo "skip: $name (SKILL.md 없음)"; continue; }
  for t in "${targets[@]}"; do
    mkdir -p "$t"
    rm -rf "${t:?}/${name:?}"
    cp -R "$src" "$t/$name"
    echo "ok: $t/$name"
  done
done
echo "끝. Claude Code는 /스킬이름, Codex는 \$스킬이름 으로 부르거나 그냥 요청하면 알아서 씁니다."
