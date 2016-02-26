if [ -z "$(vim --version | grep +python)" ]; then
    echo Installing VIM with python support
     sudo apt-get remove -y vim

     echo Installing dependency packages
     installPackage python-dev 2.7.9-1
     sudo apt-get install -y ncurses-dev

     echo Downloading Vim
     git clone https://github.com/vim/vim.git /tmp/vimSrc

     echo Compiling Vim with python support
     curDir=${PWD}
     cd /tmp/vimSrc
     ./configure --with-features=huge --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu
     make

     echo Installing Vim
     sudo make install
     cd $curDir

     rm -fr /tmp/vimSrc

     sudo update-alternatives --install "/usr/bin/vim" "vim" "/usr/local/bin/vim" 1
     sudo update-alternatives --install "/usr/bin/vi" "vi" "/usr/local/bin/vim" 1
else
    echo Vim already installed
fi

echo Installing Plugins
git clone http://gitlab.tss/front-end/vim.git /tmp/vim
yes | cp /tmp/vim/vimrc ~/.vimrc && rm -fr /tmp/vim

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim -E -s -c "source ~/.vimrc" -c PluginInstall -c qa
