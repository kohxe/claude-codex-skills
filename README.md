# claude-codex-skills

Claude Code와 Codex에서 같이 쓰는 UI 스킬 모음.

| 스킬 | 하는 일 |
|---|---|
| [`ai-motion-effects`](skills/ai-motion-effects/SKILL.md) | 웹 화면에 넣을 모션 효과 20가지(리퀴드, 홀로그램, 글리치, 텍스트 스크램블 등)를 상황에 맞게 1~2개 골라 실제 코드로 넣어 준다. 효과마다 바로 열어 볼 수 있는 데모가 `effects/`에 있다. |
| [`ui-indicator-names`](skills/ui-indicator-names/SKILL.md) | 진행 바·스토리 바·단계 표시·비밀번호 강도·배지·스피너 등 화면 표시 요소 9가지의 정확한 이름과 차이를 알려 주고, 디자이너 요청 문장이나 접근성까지 챙긴 코드를 만든다. |

## 설치

### macOS / Linux / Git Bash

```bash
git clone https://github.com/kohxe/claude-codex-skills.git
cd claude-codex-skills && ./install.sh
```

### Windows PowerShell

```powershell
git clone https://github.com/kohxe/claude-codex-skills.git
cd claude-codex-skills; .\install.ps1
```

PowerShell이 스크립트 실행을 막으면 `powershell -ExecutionPolicy Bypass -File .\install.ps1` 로 실행한다.

설치 위치:

- Claude Code: `~/.claude/skills/<스킬>`
- Codex: `~/.codex/skills/<스킬>` (`CODEX_HOME`을 바꿨다면 그 아래 `skills`)

하나만 설치하려면 이름을 붙인다: `./install.sh ui-indicator-names`

### 업데이트

```bash
cd claude-codex-skills && git pull && ./install.sh
```

## 쓰는 법

그냥 요청하면 알아서 쓴다("히어로가 밋밋해", "이 진행 바 이름이 뭐야?"). 직접 부르려면:

- Claude Code: `/ai-motion-effects`, `/ui-indicator-names`
- Codex: `$ai-motion-effects`, `$ui-indicator-names`

설치 후 새로 연 세션부터 보인다.

## 테스트

각 스킬의 `evals/` 폴더에 테스트 케이스(프롬프트, 입력 파일, 채점 기준)가 있다. 마지막 테스트에서 스킬을 쓴 쪽은 채점 기준 100%, 스킬 없이 한 쪽은 87%였다.
