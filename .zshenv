export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export PACMAN='powerpill'

export LANG='zh_CN.UTF-8'
export PATH="${HOME}/.gem/ruby/2.4.0/bin:/usr/lib/ccache/bin/:${PATH}"

export C_FLAGS="-std=c99 -Wall"
export CXX_FLAGS="-std=c++14 -Wall"

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

if [ -n "$DISPLAY" ]; then
  export BROWSER='chromium.desktop'
else
  export BROWSER='elinks'
fi
