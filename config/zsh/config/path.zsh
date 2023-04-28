if [[ "$(uname)" == "Linux" ]]; then
  return
fi
export UID=$(id -u)
export GID=$(id -g)

export PATH=$PATH:/bin:/usr/sbin:/sbin
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/local/bin
export PATH=$PATH:$HOME/npm/bin

export PATH=$(pyenv root)/shims:$PATH
export PYENV_ROOT=$(pyenv root)

export ANDROID=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID:$ANDROID/platform-tools
export PATH=$PATH:$ANDROID/tools

export PATH=$PATH:node_modules/.bin

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python

export GOROOT=/usr/local/go/
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GOARCH=amd64
export GOOS=darwin
export GO15VENDOREXPERIMENT=1
export GOPROXY=https://goproxy.cn

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH

export PATH=$PATH:/usr/local/opt/gettext/bin

export EVERNOTE_DEV_TOKEN="S=s442:U=4873e9a:E=16b77592d54:C=1641fa7ff88:P=1cd:A=en-devtoken:V=2:H=52ac1633d6df14e2e08c1aea0a295dc7"
export GEEKNOTE_BASE=yinxiang

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

export GUILE_LOAD_PATH="/usr/local/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/usr/local/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/usr/local/lib/guile/3.0/extensions"

export PATH=$PATH:/usr/local/opt/icu4c/bin
export PATH=$PATH:/usr/local/opt/icu4c/sbin
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/texlive/2020/bin/x86_64-darwin
export PATH=/usr/local/opt/python@3.9/bin/:$PATH

export RANGER_ZLUA=$ZSH_CUSTOM/plugins/z.lua/z.lua

function j() {
    if [[ "$argv[1]" == "-"* ]]; then
        z "$@"
    else
        cd "$@" 2> /dev/null || z "$@"
    fi
}
