export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export PACMAN='powerpill'

export C_FLAGS="-std=c99 -Wall"
export CXX_FLAGS="-std=c++14 -Wall"

export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

if [[ "$(uname -r)" =~ 'microsoft-standard' ]]; then
  export DISPLAY=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`:0
  export PULSE_SERVER=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`
  export BROWSER='/mnt/c/Windows/explorer.exe'
  export LANG=zh_CN.UTF-8
  export LANGUAGE=zh_CN:zh:en_US:en
else
  if [ -n "$DISPLAY" ]; then
    export BROWSER='firefox-nightly.desktop'
  else
    export BROWSER='elinks'
  fi
fi
