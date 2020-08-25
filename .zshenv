export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export PACMAN='powerpill'

export C_FLAGS="-std=c99 -Wall"
export CXX_FLAGS="-std=c++14 -Wall"

export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

if [ -n "$DISPLAY" ]; then
  export BROWSER='firefox-nightly.desktop'
else
  export BROWSER='elinks'
fi
