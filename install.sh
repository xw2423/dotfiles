#!/bin/bash
PRO_NAME='dotfiles'
REQUIRE="git"
SYMLINKS="vimrc screenrc gitconfig bash_profile wgetrc curlrc"
[ -z "$PRO_PATH" ] && PRO_PATH="$HOME/.$PRO_NAME"
[ -z "$REPO_URI" ] && REPO_URI='https://github.com/xw2423/dotfiles.git'

# help functions
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "\33[32m[O]\33[0m ${1}${2}"
}

error() {
    msg "\33[31m[X]\33[0m ${1}${2}"
    exit 1
}

warn() {
    msg "\33[33m[!]\33[0m ${1}${2}"
}

info() {
    msg "\33[32m[>]\33[0m ${1}${2}"
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
}

# check if node & npm are installed
for i in $REQUIRE
do
    command -v $i >/dev/null && continue || { error "$i command not found. Please Make sure you have $i installed"; }
done

if [ ! -e "$PRO_PATH" ]; then
    info "clone $PRO_NAME to $PRO_PATH"
    mkdir -p "$PRO_PATH"
    git clone -c http.sslversion=tlsv1 "$REPO_URI" "$PRO_PATH"
    ret="$?"
    success "Successfully cloned $PRO_NAME"
else
    info "update $PRO_NAME in $PRO_PATH"
    cd "$PRO_PATH" && git pull origin
    ret="$?"
    success "Successfully updated $PRO_NAME"
fi

#info "backing up current vim config"
#today=`date +%Y%m%d`
#for i in $HOME/.vim $HOME/.vimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done
#for i in $HOME/.vim $HOME/.vimrc; do [ -L $i ] && unlink $i ; done
#success "Successfully backed up your vim configuration"

info "setting up symlinks"
lnif $PRO_PATH/ $HOME/.vim
for i in $SYMLINKS
do
    lnif $HOME/.vim/$i $HOME/.$i
done
if [[ $OSTYPE =~ "cygwin" ]]; then
    lnif $HOME/.vim/minttyrc $HOME/.minttyrc
fi
success "Successfully created symbol links"

[ ! -z $1 ] && exit
# install vim-plug
if [ ! -e $PRO_PATH/autoload/plug.vim ]; then
    info "Installing Vim-Plug"
    curl -fLo "$PRO_PATH/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    success "Successfully installed vim-plug"
fi

info "update/install plugins using vim-plug"
system_shell=$SHELL
export SHELL="/bin/sh"
vim +PlugInstall! +PlugClean +qall
export SHELL=$system_shell

# command -v eslint >/dev/null || warn "eslint is not found from global installation, you may want to run: npm i -g eslint"
# command -v jsctags >/dev/null || warn "for better javascript tags support, it's recommend to install jstags, npm i -g git+https://github.com/ramitos/jsctags.git"
# command -v js-beautify >/dev/null || warn "you may also want to install js-beautify, npm i js-beautify -g"
