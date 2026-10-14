# configs
ootterbear's tui config files

macOS 터미널 환경(zsh · tmux · vim · Ghostty) 설정 모음.

## 파일 위치

| 레포 경로 | 설치 위치 | 비고 |
|---|---|---|
| `zsh/.zshrc` | `~/.zshrc` | 머신별 설정(AWS/EKS 프로필 등)은 `~/.zshrc.local`에 두면 자동 source |
| `zsh/.zprofile` | `~/.zprofile` | |
| `zsh/.profile` | `~/.profile` | |
| `zsh/.claude-launcher.zsh` | `~/.claude-launcher.zsh` | `cla` — Claude Code 권한 모드 선택 런처 |
| `tmux/.tmux.conf` | `~/.tmux.conf` | |
| `vim/.vimrc` | `~/.vimrc` | colorscheme `habamax` (Vim 9 기본 내장) |
| `ghostty/config` | `~/.config/ghostty/config` | **클라이언트**(화면을 띄우는 머신)에 설치 |
| `ghostty/themes/*` | `~/.config/ghostty/themes/` | `habamax`(기본), `Allen-01`, `Allen-01-sel-brown` |

심볼릭 링크 예시:

```sh
ln -sf ~/configs/zsh/.zshrc ~/.zshrc
mkdir -p ~/.config/ghostty && ln -sfn ~/configs/ghostty/themes ~/.config/ghostty/themes
```

## 설치해야 할 것

### Homebrew
[brew.sh](https://brew.sh) 설치 스크립트로 먼저 설치.

```sh
brew install tmux kubectx awscli docker
```

- `tmux` — 터미널 멀티플렉서
- `kubectx`, `awscli`, `docker` — `.zshrc`가 참조 (docker zsh completion, `~/.zshrc.local`의 AWS/EKS 함수)

### 셸
- **Oh My Zsh** — [ohmyz.sh](https://ohmyz.sh) 설치 스크립트 (테마 `af-magic`, 플러그인 `git`; 커스텀 플러그인 없음)
- **uv** — `curl -LsSf https://astral.sh/uv/install.sh | sh` (`~/.local/bin/env` 생성, `.zshrc`/`.profile`이 source)
- **bun** — `curl -fsSL https://bun.sh/install | bash`

### Vim 플러그인
- **markdown-preview.nvim** — vim 내장 패키지 방식으로 설치:
  ```sh
  git clone https://github.com/iamcco/markdown-preview.nvim ~/.vim/pack/markdown/start/markdown-preview.nvim
  ```

### 터미널 앱 (클라이언트)
- **Ghostty** — [ghostty.org](https://ghostty.org) 에서 다운로드
- **폰트** — Homebrew cask:
  ```sh
  brew install --cask font-hack-nerd-font font-noto-sans-mono-cjk-kr
  ```

### `.zshrc`가 참조하는 CLI (선택)
- `claude` (Claude Code), `codex` — 각 공식 설치 스크립트 (`~/.local/bin`)
- `hermes` — `hermes`, `hermes-noobs` 래퍼 함수용
