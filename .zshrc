HISTFILE=~/.histfile
HISTSIZE=65536
SAVEHIST=4294967296
setopt HIST_FCNTL_LOCK # Use modern file-locking mechanisms, for better safety & performance.
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY # Auto-sync history between concurrent sessions.
setopt HIST_IGNORE_ALL_DUPS # Keep only the most recent copy of each duplicate entry in history.
setopt HIST_REDUCE_BLANKS
setopt hist_ignore_space

setopt EXTENDED_GLOB

if_color() {
  [[ "$TERM" =~ ".*-256color$" || "$TERM" =~ "kitty" ]]
}

if_256() {
  [[ "$TERM" =~ ".*-256color$" ]]
}

if_kitty() {
  [[ "$TERM" =~ "kitty" ]]
}

if_darwin() {
  [[ "$(uname)" =~ 'Darwin' ]]
}

if_wsl() {
  [[ "$(uname -r)" =~ 'Microsoft' ]]
}

if_wsl2() {
  [[ "$(uname -r)" =~ 'microsoft-standard' ]]
}

if_vbox() {
  dmesg 2>&1 | rg vboxguest >/dev/null 2>&1
}

if_ArchLinux() {
  [[ $(sed -rn 's|^ID=(.+)$|\1|p' /etc/os-release) =~ ^arch ]]
}

if_openSUSE() {
  [[ $(sed -rn 's|^ID="(.+)"$|\1|p' /etc/os-release) =~ ^opensuse ]]
}

if_NixOS() {
  [[ $(sed -rn 's|^ID=(.+)$|\1|p' /etc/os-release) =~ ^nixos ]]
}

load_if_exist() {
  [[ "$1" ]] && [[ -s "$1" ]] && source "$1"
}

if_command() {
  command -v "$1" >/dev/null
}

if if_wsl; then
  umask 022
  export GPG_TTY=$(tty)
fi

if if_wsl2; then
  export GPG_TTY=$(tty)
  export HOST_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')

  HOST=WINDOWS-HOST
  IP_HOST=$(grep -m 1 $HOST /etc/hosts)
  if [[ -z $IP_HOST ]]; then
    echo "Creating IP Address-hostname mapping"
    echo "host has the IP Address $HOST_IP"
    sudo zsh -c "echo '$HOST_IP\t$HOST.localdomain\t$HOST' >> /etc/hosts"
  else
    OLD_IP=$(echo "$IP_HOST" | awk '{print $1}')

    if [[ "$HOST_IP" != "$OLD_IP" ]]; then
      echo "Updating IP Address-hostname mapping"
      echo "host has the IP Address $HOST_IP"
      sudo sed -i "s|$IP_HOST|$HOST_IP\t$HOST.localdomain\t$HOST|" /etc/hosts
    fi
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if_openSUSE && command_not_found_handler () {
  if [ -x /usr/bin/python3 ] && [ -x /usr/bin/command-not-found ]
  then
    /usr/bin/python3 /usr/bin/command-not-found "${(Q)1}" zypp
  fi
  exit 1
}

if ! if_ArchLinux && ! if_NixOS
then
  load_if_exist ~/.grml-zshrc || echo "wget -O ~/.grml-zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc"
fi

# load_if_exist "$HOME/opt/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
# bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
# zstyle ':autocomplete:*complete*:*' insert-unambiguous yes


if_darwin && export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/bin:$PATH"
if_command yarn && export PATH="$(yarn global bin):$PATH"
if_command cargo && export PATH="$HOME/.cargo/bin:$PATH"
if_command ruby && export PATH="$(ruby -e "puts Gem.user_dir")/bin:$PATH"
if_command go && export PATH="$(go env GOPATH)/bin:$PATH"
if_command ccache && export PATH="$(dirname $(which ccache))/../lib/ccache/bin/:$PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
[[ -d "$HOME/.rbenv" ]] && export PATH="$HOME/.rbenv/bin:$PATH"
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

if_command rbenv && eval "$(rbenv init -)"
if_command direnv && eval "$(direnv hook zsh)"

if_darwin && share='/usr/local/share' || if_ArchLinux && share='/usr/share' || share="$HOME/opt"
if_ArchLinux && plugins="$share/zsh/plugins" || plugins="$share"
if_darwin && export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

if_color && load_if_exist ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh && if_color ]] || source ~/.p10k.zsh

if_ArchLinux && load_if_exist $share/doc/pkgfile/command-not-found.zsh
load_if_exist $plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load_if_exist $plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
load_if_exist $plugins/zsh-completions/zsh-completions.plugin.zsh
if_256 && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
if_kitty && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
load_if_exist "$HOME/opt/zsh-sudo/sudo.plugin.zsh"

export LESS="-R -F"
load_if_exist "$HOME/opt/zcolors/zcolors.plugin.zsh"
[[ -s "$HOME/.zcolors" ]] || zcolors >| "$HOME/.zcolors"
load_if_exist "$HOME/.zcolors"

REPORTTIME=5

() { # TIMEFMT {{{3
  local white_b=$'\e[1;97m' blue=$'\e[94m' green=$'\e[0;38;5;154m' rst=$'\e[0m'
  TIMEFMT=("$green== TIME REPORT FOR $white_b%J$green ==$rst"$'\n'
    "  User: $blue%U$rst"$'\t'"System: $blue%S$rst  Total: $blue%*Es${rst}"$'\n'
    "  CPU:  $blue%P$rst"$'\t'"Mem:    $blue%M MiB$rst")
}

# zstyle :compinstall filename "$HOME/.zshrc"
# autoload -Uz compinit
# compinit
# zstyle ':completion:*' rehash true

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

bindkey "\eq" push-line-or-edit

# alias
alias rm='rm -vi'

alias sudo='sudo '
alias sudp='sudo '

alias mkdir='mkdir -p -v'

alias bat='bat -P'

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

alias chinese='export LANG="zh_CN.UTF-8"'
alias english='export LANG="en_US.UTF-8"'
alias c='LC_ALL="C"'

alias g='git'
alias gci='git add . && git commit -m'
alias gcz='git add . && git cz'

alias mv='mv -v'
alias cp='cp -v --reflink=auto'

alias vim='nvim'
alias vo,='vim'

alias checknet='ping 114.114.114.114 -c 2'

alias https='http --default-scheme=https'
alias :q='exit'

alias yay='yay --diffmenu=false --editmenu --cleanmenu --removemake --devel'

alias be='bundle exec'
alias ber='bundle exec rake'

if if_wsl2; then
  alias with_proxy="http_proxy=http://$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):8099 https_proxy=\$http_proxy HTTP_PROXY=\$http_proxy HTTPS_PROXY=\$http_proxy "
elif if_vbox; then
  alias with_proxy='http_proxy=http://192.168.1.200:8099 https_proxy=$http_proxy HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy ALL_PROXY=$http_proxy '
else
  alias with_proxy='http_proxy=http://localhost:8099 https_proxy=$http_proxy HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy ALL_PROXY=$http_proxy '
fi

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

  sudo pacman -Su --noconfirm 2>&1 | tee -a $log_file
  PACMAN=pacman yay -Sua --noconfirm --answerclean N --removemake --editmenu=false --diffmenu=false --devel 2>&1 | tee -a $log_file
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

new_gitlab_project()
{
  name=$1
  [[ "$name" ]] || name=$(git rev-parse --show-toplevel | xargs basename)
  (
    set -xe
    git push --set-upstream git@gitlab.com:71e6fd52/$name.git $(git rev-parse --abbrev-ref HEAD)
    git remote add origin git@gitlab.com:71e6fd52/$name.git
    git push --set-upstream origin
  )
}

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

