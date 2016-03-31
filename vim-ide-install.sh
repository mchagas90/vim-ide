#!/bin/bash
rm -rf ~/vim-ide

#install dependencies
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install exuberant-ctags vim vim-nox -y
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install ctags-exuberant vim --with-lua --override-system-vi
fi

git clone https://github.com/mchagas90/vim-ide.git ~/vim-ide

mkdir -p ~/vim-ide/vim/bundle

ln -snf ~/vim-ide/.vimrc ~/.vimrc
ln -snf ~/vim-ide/vim ~/.vim

# install vundle
git clone --depth 1 https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install fonts for airline
git clone --depth 1 https://github.com/powerline/fonts.git ~/vim-ide/powerline_fonts
source ~/vim-ide/powerline_fonts/install.sh
rm -rf ~/vim-ide/powerline_fonts/

vim +PluginInstall +qa

if [[ "$SHELL" == "/bin/zsh" ]]; then
    rehash
elif [[ "$SHELL" == "/bin/bash" ]]; then
    hash -r
fi

echo "Change your terminal font to Meslo LG S DZ for Powerline (or any other of your preference)"
