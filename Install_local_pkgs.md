# 로컬 설치 프로그램 목록

패키지 매니저(설치 경로)별 분류. 의존성으로 함께 설치된 것은 제외.

## 1. Homebrew (`brew`)

**Tap:** `derailed/k9s`, `hashicorp/tap`, `ivan-digital/speech`

**Formula**

| 분야 | 패키지 |
|---|---|
| 터미널 | `tmux`, `aoe`, `jq`, `wget`, `grip` |
| 클라우드 / k8s | `awscli`, `eksctl`, `kubectx`, `kubernetes-cli`, `helm`, `k9s`, `hashicorp/tap/terraform` |
| 컨테이너 | `colima`, `docker`, `docker-buildx`, `docker-compose`, `e2fsprogs` |
| 언어 / 런타임 | `python@3.12`, `rust`, `openjdk@21`, `uv` |
| 문서 변환 | `pandoc`, `typst`, `poppler`, `pango` |
| AI | `gemini-cli`, `llmfit`, `speech` |
| 기타 | `gh`, `scrcpy` |

**Cask**

- 앱: `codex`, `stats`, `android-commandlinetools`
- 폰트: `font-hack-nerd-font`, `font-noto-sans-kr`, `font-noto-sans-mono-cjk-kr`

## 2. npm (전역)

- `oh-my-codex` (`omx`)

## 3. uv

- `uv tool`: `md2pdf`, `weasyprint`
- `uv python`: `cpython 3.11.6`

## 4. pip (`--user`, 시스템 python 3.9)

- `python-pptx`, `xlsxwriter`, `pillow`, `lxml`

## 5. 공식 설치 스크립트 (`~/.local/bin` 등)

| 프로그램 | 설치 위치 |
|---|---|
| `claude` (Claude Code) | `~/.local/share/claude` |
| `codex` (standalone) | `~/.codex/packages` |
| `uv` | `~/.local/bin/uv` |
| `hermes` | `~/.hermes/hermes-agent` |
| `bun` | `~/.bun` |
| Oh My Zsh | `~/.oh-my-zsh` |

## 6. git clone (수동)

- `markdown-preview.nvim` → `~/.vim/pack/markdown/start/`

## 7. Mac App Store

- WireGuard, CotEditor, Hancom Office HWP Viewer
- Apple: Keynote, Numbers, Pages, iMovie, GarageBand

## 8. 직접 다운로드 (dmg/pkg)

| 분야 | 앱 |
|---|---|
| 터미널 / 개발 | Ghostty, iTerm2, cmux, Visual Studio Code, Cursor, DataGrip |
| AI | Claude, Codex |
| 협업 | Slack, Notion, Microsoft 365 (Word · Excel · PowerPoint · Outlook · Teams · OneNote · OneDrive · Copilot), Google Drive · Docs · Sheets · Slides |
| 브라우저 | Google Chrome, Whale |
| 네트워크 | Tailscale |
| 기타 | Hancom Office HWP, BlueStacks, MuMuPlayer Pro, Steam |

폰트: D2Coding, Freesentation (`~/Library/Fonts`에 직접 설치)

## 참고

- `uv`(brew와 설치 스크립트), `codex`(cask와 standalone)는 두 경로로 중복 설치되어 있음.
- 직접 다운로드한 앱 중 Ghostty, iTerm2, VS Code, Cursor, DataGrip, Chrome, Slack, Notion, Tailscale, Claude, Steam은 brew cask로도 설치 가능.
