export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export C_FLAGS="-std=c11 -Wall"
export CXX_FLAGS="-std=c++21 -Wall"

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

# cross compile
export CC_x86_64_pc_windows_msvc="clang-cl"
export CXX_x86_64_pc_windows_msvc="clang-cl"
export AR_x86_64_pc_windows_msvc="llvm-lib"
export CL_FLAGS="-Wno-unused-command-line-argument -fuse-ld=lld-link -I /windows/windows_kits/10/Include/10.0.22621.0/ucrt -I /windows/windows_kits/10/Include/10.0.22621.0/um -I /windows/msvc/include -I /windows/windows_kits/10/include/10.0.22621.0/shared/"
export RUSTFLAGS="-Lnative=/windows/windows_kits/10/Lib/10.0.22621.0/ucrt/x64 -Lnative=/windows/windows_kits/10/Lib/10.0.22621.0/um/x64 -Lnative=/windows/msvc/lib/x64"
export CFLAGS_x86_64_pc_windows_msvc="$CL_FLAGS"
export CXXFLAGS_x86_64_pc_windows_msvc="$CL_FLAGS"
