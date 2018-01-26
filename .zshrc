HISTFILE=~/.histfile
HISTSIZE=65536
SAVEHIST=4294967296
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

bindkey -v
zstyle :compinstall filename '/home/datsd/.zshrc'
autoload -Uz compinit
compinit
zstyle ':completion:*' rehash true

load_if_exist()
{
  [[ "$1" ]] && [[ -s "$1" ]] && source "$1"
}

eval "$(rbenv init -)"

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
[[ "$TERM" =~ ".*-256color$" ]] && load_if_exist /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

load_if_exist /usr/share/doc/pkgfile/command-not-found.zsh
load_if_exist /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load_if_exist /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ "$TERM" =~ ".*-256color$" ]] && ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
load_if_exist "$HOME/opt/zsh-sudo/sudo.plugin.zsh"

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$(ruby -e "puts Gem.user_dir")/bin:/usr/lib/ccache/bin/:${PATH}"
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

bindkey '^[l' forward-word
bindkey '^[h' backward-word

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

bindkey "\eq" push-line-or-edit

# alias
which very_safe_rm >/dev/null 2>&1 && alias rm='very_safe_rm' || alias rm='sleep 5 && rm -vi'

alias su='sudo $SHELL'
alias sudo='sudo '
alias sudp='sudo '

alias ls='exa'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias mkdir='mkdir -p -v'

alias ls='ls -F'
alias la='ls -a'
alias ll='la -l'
alias l='ls'
alias s='ls'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias sdcv='sdcv -01 -2 ~/.stardict -c'

alias ,,=".."
alias ,,,="..."
alias ...="../.."
alias ....="../../.."
alias .....="../../../.."
alias .4='../../../..'
alias .5='../../../../..'

alias fin='find . '
alias fcc=' -name "*.c"'
alias fh=' -name "*.h"'
alias fcpp='-name "*.cpp"'
alias fhpp='-name "*.hpp"'
alias fch='-name "*.[ch]"'
alias fchpp='-name "*.[ch]pp"'
alias fca='\( -name "*.[ch]pp" -o -name "*.[ch]" \)'

alias fuse='find -name ".fuse_hidden*";find -name ".fuse_hidden*"|xargs rm -f'

alias sty='fin fca -exec astyle {} \;'
alias check='cppcheck --inconclusive -f --enable=warning,style,performance,portability,unusedFunction -i ./build .'

alias chinese='export LANG="zh_CN.UTF-8"'
alias english='export LANG="en_US.UTF-8"'
alias c='LANG="C"'

alias g='git'
alias gci='g add . && g ci'
alias gitinfo='g lg ;read;g log|lolcat;read;g st|lolcat;read;ls -la|lolcat'

alias lc='lolcat'

alias sl='sl -Feal'

alias mv='mv -v'
alias cp='cp -v --reflink=auto'

alias vim=nvim
alias emacs='emacs --insecure'

alias g++utf='g++ test.cpp $CXX_FLAGS -lboost_unit_test_framework -o test && ./test'
alias dal='cd ~/+program/DAlib/build && ../tool/build cmake && sudo make install | lolcat'
alias cddal='cd ~/+program/DAlib/include'

alias checknet='ping 114.114.114.114 -c 2'

alias https='http --default-scheme=https'
alias :q='exit'


upgrade()
{
  local DATE=$(date "+%Y%m%dT%H%MZ" --utc)
  local log_file=~/.log/upgrade/$DATE.log
  mkdir -p ~/.log/upgrade
  ln -srf $log_file ~/.log/upgrade.log
  pacaur -Syu --needed --noconfirm --noedit --ignore linux-lily --ignore linux-lily-headers 2>&1 | tee $log_file
  rg '警告' $log_file
  rg '警告：.+ 已被安装为 .+' $log_file
}

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
  read 'uri?URI: '
  axel -a "$uri" -n 8 $@
}

alias fitbit='while ! galileo --bluetooth PyDBUS --database RemoteRESTDatabase --no-https-only --debug | grep "Synchronisation successful" ; do : ; done'

alias cqhttp='systemd-run --user --unit=cqhttp docker run --rm --name cqhttp -p 9000:9000 -p 5700:5700 -e CQHTTP_VERSION=2.1.3 -e CQHTTP_POST_MESSAGE_FORMAT=array -e CQHTTP_POST_URL=http://a.lan:9455 -v /home/datsd/_normal/coolq:/home/user/coolq richardchien/cqhttp'

alias upgrade_times='echo "从" $(head /var/log/pacman.log -n1 | cut -c1-18) "起，滚了" $(rg -c "full system upgrade" /var/log/pacman.log) "次"'

#alias for cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"
