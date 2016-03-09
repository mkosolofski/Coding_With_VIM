echo --------------------------------------------------------------
echo Installing dependency packages for vim
echo --------------------------------------------------------------
sudo apt-get install -y python-dev
sudo apt-get install -y ncurses-dev

if [ -z "$(vim --version | grep +python)" ]; then
     echo --------------------------------------------------------------
     echo "Removing current version of vim (not compiled with python)"
     echo --------------------------------------------------------------
     sudo apt-get remove -y vim

     echo --------------------------------------------------------------
     echo Downloading vim source
     echo --------------------------------------------------------------
     rm -fr /tmp/vimSrc
     git clone https://github.com/vim/vim.git /tmp/vimSrc

     echo --------------------------------------------------------------
     echo Compiling vim with python support
     echo --------------------------------------------------------------
     curDir=${PWD}
     cd /tmp/vimSrc
     ./configure --with-features=huge --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python*/config-*
     make

     echo --------------------------------------------------------------
     echo Installing vim
     echo --------------------------------------------------------------
     sudo make install
     cd $curDir
     
     sudo update-alternatives --install "/usr/bin/vim" "vim" "/usr/local/bin/vim" 1
     sudo update-alternatives --install "/usr/bin/vi" "vi" "/usr/local/bin/vim" 1

     echo --------------------------------------------------------------
     echo Cleaning up install files
     echo --------------------------------------------------------------
     rm -fr /tmp/vimSrc

else
    echo Vim already installed with Python support. Skipping vim install.
fi

echo --------------------------------------------------------------
echo Installing CTags to support vim plugins
echo --------------------------------------------------------------
sudo apt-get install -y ctags

echo --------------------------------------------------------------
echo Placing .vimrc
echo --------------------------------------------------------------
cp "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/.vimrc ~/.

echo --------------------------------------------------------------
echo Installing Vundle vim plugin
echo --------------------------------------------------------------
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo --------------------------------------------------------------
echo Installing vim plugins with Vundle
echo --------------------------------------------------------------
vim -E -s -c "source ~/.vimrc" -c PluginInstall -c qa

echo ""
echo Done!!!
