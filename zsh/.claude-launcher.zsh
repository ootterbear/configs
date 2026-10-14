cla() {
  local -a labels=(
    "default              기본 모드 (권한 확인 있음)"
    "acceptEdits          파일 편집 자동 수락"
    "dontAsk              권한 확인 생략"
    "bypassPermissions    모든 권한 우회"
    "plan                 Plan 모드로 시작"
    "dangerously-skip     모든 권한 완전 무시 ⚠️"
  )
  local -a flags=(
    "--permission-mode default"
    "--permission-mode acceptEdits"
    "--permission-mode dontAsk"
    "--permission-mode bypassPermissions"
    "--permission-mode plan"
    "--dangerously-skip-permissions"
  )
  local n=${#labels[@]}

  # Direct mode: cla <number> [extra args...]
  if [[ -n "$1" && "$1" =~ ^[0-9]+$ ]]; then
    local idx=$(( $1 - 1 ))
    if (( idx >= 0 && idx < n )); then
      echo "▶ ${labels[$((idx + 1))]}"
      eval "claude ${flags[$((idx + 1))]} ${@:2}"
    else
      echo "❌ 1~$n 사이 숫자를 입력하세요."
    fi
    return
  fi

  # Interactive selection
  local sel=0
  local status_line=""

  _cla_draw() {
    for (( i = 0; i < n; i++ )); do
      if (( i == sel )); then
        printf "\033[2K  \033[1;32m▶ $(( i + 1 )). ${labels[$((i + 1))]}\033[0m\n"
      else
        printf "\033[2K    $(( i + 1 )). ${labels[$((i + 1))]}\n"
      fi
    done
    if [[ -n "$status_line" ]]; then
      printf "\033[2K  \033[1;33m숫자 %s 선택됨 → Enter로 확인, ↑↓으로 변경\033[0m\n" "$status_line"
    else
      printf "\033[2K\n"
    fi
  }

  # Draw header (header lines are fixed, not redrawn)
  printf "\n  Claude 실행 모드 선택  (↑↓ 또는 숫자, Enter 확인)\n"
  printf "  ────────────────────────────────────────────────\n"
  # Save cursor at the top of menu items
  printf "\033[s"
  # Hide cursor to reduce visual noise
  printf "\033[?25l"
  _cla_draw

  # Use zsh/system's sysread to bypass ZLE entirely (direct syscall, no echo side-effects)
  zmodload zsh/system 2>/dev/null

  # Use -icanon -echo instead of raw to preserve output \n→\r\n translation
  local saved_stty
  saved_stty=$(stty -g)
  stty -icanon -echo min 1 time 0

  while true; do
    local c1 c2 c3
    sysread -s 1 c1 2>/dev/null || c1=""

    # Number key: jump to that item
    if [[ "$c1" =~ [1-9] ]]; then
      local num=$(( c1 - 1 ))
      if (( num < n )); then
        sel=$num
        status_line="$c1"
      fi
      printf "\033[u"
      _cla_draw
      continue
    fi

    # Arrow keys: ESC [ A/B
    if [[ "$c1" == $'\x1b' ]]; then
      sysread -s 1 -t 0.1 c2 2>/dev/null || c2=""
      sysread -s 1 -t 0.1 c3 2>/dev/null || c3=""
      if [[ "$c2" == "[" ]]; then
        if [[ "$c3" == "A" ]]; then
          (( sel = (sel - 1 + n) % n ))
        elif [[ "$c3" == "B" ]]; then
          (( sel = (sel + 1) % n ))
        fi
        status_line=""
        printf "\033[u"
        _cla_draw
        continue
      fi
    fi

    # Enter key (CR or LF)
    if [[ "$c1" == $'\r' || "$c1" == $'\n' ]]; then
      stty "$saved_stty"
      printf "\033[?25h"
      printf "\033[u\033[J"
      printf "  \033[1;32m▶ ${labels[$((sel + 1))]}\033[0m\n\n"
      eval "claude ${flags[$((sel + 1))]} $@"
      return
    fi

    # q: quit
    if [[ "$c1" == "q" ]]; then
      stty "$saved_stty"
      printf "\033[?25h"
      printf "\033[u\033[J"
      printf "  취소됨\n"
      return 1
    fi
  done
}
