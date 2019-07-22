HISTFILE=~/.histfile
HISTSIZE=65536
SAVEHIST=4294967296
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

if_color()
{
  [[ "$TERM" =~ ".*-256color$" || "$TERM" =~ "kitty" ]]
}

if_256()
{
  [[ "$TERM" =~ ".*-256color$" ]]
}

if_kitty()
{
  [[ "$TERM" =~ "kitty" ]]
}

if_darwin()
{
  [[ "$(uname)" =~ 'Darwin' ]]
}

if_wsl()
{
  [[ "$(uname -r)" =~ 'Microsoft' ]]
}

if_ArchLinux()
{
  [[ $(sed -rn 's|^ID=(.+)$|\1|p' /etc/os-release) =~ ^arch ]]
}

if_openSUSE()
{
  [[ $(sed -rn 's|^ID="(.+)"$|\1|p' /etc/os-release) =~ ^opensuse ]]
}

load_if_exist()
{
  [[ "$1" ]] && [[ -s "$1" ]] && source "$1"
}

if_openSUSE && command_not_found_handler () {
  if [ -x /usr/bin/python3 ] && [ -x /usr/bin/command-not-found ]
  then
    /usr/bin/python3 /usr/bin/command-not-found "${(Q)1}" zypp
  fi
  exit 1
}

if [[ $(if_ArchLinux; echo $?) -ne 0 ]]
then
  load_if_exist ~/.grml-zshrc || echo "wget -O ~/.grml-zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc"
fi

if if_wsl
then
  umask 022
  export GPG_TTY=$(tty)
fi

if_darwin && export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/bin:$PATH"
which yarn >/dev/null 2>&1 && export PATH="$(yarn global bin):$PATH"
which cargo >/dev/null 2>&1 && export PATH="$HOME/.cargo/bin:$PATH"
which ruby >/dev/null 2>&1 && export PATH="$(ruby -e "puts Gem.user_dir")/bin:$PATH"
which go >/dev/null 2>&1 && export PATH="$(go env GOPATH)/bin:$PATH"
which ccache >/dev/null 2>&1 && export PATH="$(dirname $(which ccache))/../lib/ccache/bin/:$PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
[[ -d "$HOME/.rbenv" ]] && export PATH="$HOME/.rbenv/bin:$PATH"
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

which rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"
which thefuck >/dev/null 2>&1 && eval $(thefuck --alias)
which sccache >/dev/null 2>&1 && export RUSTC_WRAPPER=sccache

if_darwin && share='/usr/local/share' || if_ArchLinux && share='/usr/share' || share="$HOME/opt"
if_ArchLinux && plugins="$share/zsh/plugins" || plugins="$share"
if_darwin && export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

if if_wsl
then
  # POWERLEVEL9K_MODE='nerdfont-complete'
  POWERLEVEL9K_SHOW_CHANGESET=true
  POWERLEVEL9K_USER_ICON="\uF415"
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500"
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{normal}  "
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user rbenv background_jobs vcs status dir_writable dir)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
else
  POWERLEVEL9K_MODE='nerdfont-complete'
  POWERLEVEL9K_SHOW_CHANGESET=true
  POWERLEVEL9K_USER_ICON="\uF415"
  POWERLEVEL9K_TIME_FORMAT="%D{\uF017 %H:%M \uF073 %Y.%m.%d}"
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=3
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=black
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=blue
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500"
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{normal} "
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh user rbenv background_jobs vcs dir_writable dir)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status time)
fi
if_color && load_if_exist $share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

if_ArchLinux && load_if_exist $share/doc/pkgfile/command-not-found.zsh
load_if_exist $plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load_if_exist $plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
load_if_exist $plugins/zsh-completions/zsh-completions.plugin.zsh
if_256 && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
if_kitty && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
load_if_exist "$HOME/opt/zsh-sudo/sudo.plugin.zsh"

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
zstyle ':completion:*' rehash true

bindkey '^[l' forward-word
bindkey '^[h' backward-word

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

bindkey "\eq" push-line-or-edit

# alias
which very_safe_rm >/dev/null 2>&1 && alias rm='very_safe_rm' || alias rm='rm -vi'

alias su='sudo $SHELL'
alias sudo='sudo '
alias sudp='sudo '

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias mkdir='mkdir -p -v'

alias ls='exa'
alias la='ls -a'
alias ll='la -lg --time-style long-iso'
alias l='ls'
alias s='ls'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ,,=".."
alias ,,,="..."
alias ...="../.."
alias ....="../../.."
alias .....="../../../.."
alias .4='../../../..'
alias .5='../../../../..'

alias fuse='find -name ".fuse_hidden*"; find -name ".fuse_hidden*" | xargs rm -f'

alias chinese='export LANG="zh_CN.UTF-8"'
alias english='export LANG="en_US.UTF-8"'
alias c='LC_ALL="C"'

alias g='git'
alias gci='git add . && git commit -m'

alias sl='sl -Feal'

alias mv='mv -v'
alias cp='cp -v --reflink=auto'

alias vim=nvim
alias vo,='vim '

alias checknet='ping 114.114.114.114 -c 2'

alias https='http --default-scheme=https'
alias :q='exit'

alias yay='yay --nodiffmenu --editmenu --cleanmenu --removemake --devel'

alias be='bundle exec'
alias ber='bundle exec rake'

alias with_proxy='http_proxy=http://localhost:8099 https_proxy=$http_proxy HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy '

if if_wsl
then
  alias wsldm='yadm --yadm-dir $HOME/.wsldm'
fi

if_ArchLinux && upgrade()
{(
  set -e
  local DATE=$(date "+%Y%m%dT%H%MZ" --utc)
  local old_log_file=~/.log/upgrade/$DATE.log
  mkdir -p ~/.log/upgrade

  sudo pacman -Sy 2>&1 | tee $old_log_file

  local packages=$(pacman -Quq | wc -l)
  local log_file=~/.log/upgrade/${DATE}_${packages}.log
  mv $old_log_file $log_file
  ln -srf $log_file ~/.log/upgrade.log

  local kernel=$(uname -r | cut -d- -f4 | sed -e 's|^|linux-|' -e 's|-arch$||')

  sudo powerpill -Suw --noconfirm
  sudo pacman -Su --noconfirm --ignore $kernel --ignore $kernel-headers 2>&1 | tee -a $log_file
  PACMAN=pacman yay -Sua --noconfirm --answerclean A --removemake --noeditmenu --nodiffmenu --devel 2>&1 | tee -a $log_file
  pacman -Qtdq | ifne sudo pacman -Rcs - --noconfirm 2>&1 | tee -a $log_file
  rg '警告' $log_file
  rg '错误' $log_file
  rg '警告：.+ 已被安装为 .+' $log_file
)}

dict()
{
  head /usr/share/dict/american-english -n$1 | tail -n1
}

dictnow()
{
  dict $dict_number
}

dictnext()
{
  [[ "$dict_number" ]] || dict_number=1
  let dict_number+=1
  dict $dict_number
}

dictset()
{
  dict_number=$(rg "^$1$" /usr/share/dict/american-english -n | cut -d: -f1)
}

wine64()
{
  export WINEARCH=win64
  export WINEPREFIX=$HOME/.wine
}

wine32()
{
  export WINEARCH=win32
  export WINEPREFIX=$HOME/.wine32
}

download()
{
  uri=$1
  [[ "$uri" ]] || read 'uri?URI: '
  axel -a "$uri" -n 8 $@
}

blur()
{
  for wid in $(xdotool search --pid $PPID)
  do
    xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid
  done
}

help()
{
  bash -c "help $@"
}

alias fitbit='while ! galileo --bluetooth PyDBUS --database RemoteRESTDatabase --no-https-only --debug | grep "Synchronisation successful" ; do : ; done'

alias cqhttp='systemd-run --user --unit=cqhttp docker run --rm --name cqhttp -p 9000:9000 -p 5700:5700 -e CQHTTP_VERSION=2.1.3 -e CQHTTP_POST_MESSAGE_FORMAT=array -e CQHTTP_POST_URL=http://a.lan:9455 -v /home/datsd/_normal/coolq:/home/user/coolq richardchien/cqhttp'

alias upgrade_times='echo "从" $(head /var/log/pacman.log -n1 | cut -c1-18) "起，滚了" $(rg -c "full system upgrade" /var/log/pacman.log) "次"'

#alias for cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"

# if [[ $(ps --no-header -p $PPID -o comm | grep -E '^(yakuake|konsole)$' ) ]]
# then
  # blur
# fi

if_wsl && [[ ! -d "/run/tmux" ]] && {
  [[ -s /usr/local/bin/fix_tmux ]] && sudo /usr/local/bin/fix_tmux
}
if_wsl && [[ -z "$TMUX" && -n "$USE_TMUX" ]] && {
  [[ -n "$ATTACH_ONLY" ]] && {
    tmux a 2>/dev/null || {
      cd && exec tmux
    }
    exit
  }

  cd
  tmux new-window -c "$PWD" 2>/dev/null && exec tmux a
  exec tmux
}
true
