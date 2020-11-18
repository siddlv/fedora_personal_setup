#!/bin/bash
# 
# Shell script to automate Fedora Workstation setup for personal use.
#

echo Starting Script

sleep 1

# Functions

essential_packages()
{
    # Essential packages
    echo Installing essential packages
    
    sudo dnf group install "C Development Tools and Libraries" -y

    sleep 3

    sudo dnf install zsh vim git neofetch nnn kitty util-linux-user kernel-devel gnome-tweaks -y
}

change_shell()
{
    # Change shell to zsh
    echo Changing shell to zsh
    
    chsh -s $(which zsh)
}

install_font()
{
    # Install Hack Nerd Font
    echo Installing Nerd Font
    
    wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
    
    mv 'Hack Regular Nerd Font Complete.ttf' $HOME/.local/share/fonts
}

ohmyzsh()
{
    # Oh My Zsh and Plugins
    echo Installing Oh My Zsh and plugins
    
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

powerlevel10k()
{
    # Powerlevel10k
    echo Installing Powerlevel10k
    
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

zshrc_vimrc_vimplug()
{
    # Confiure .zshrc
    echo Writing .zshrc
    
    rm .zshrc ; wget https://raw.githubusercontent.com/siddlv/dotfiles/master/.zshrc

    # Configure .vimrc and install vim-plug
    echo Writing .vimrc and installing vim-plug
    
    rm .vimrc ; wget https://raw.githubusercontent.com/siddlv/dotfiles/master/.vimrc

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

kitty()
{
    # Configure kitty.conf and install kitty themes
    echo Installing Kitty theme and writing kitty.conf
    THEME=https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/gruvbox_dark.conf 

    wget "$THEME" -P ~/.config/kitty/kitty-themes/themes

    cd ~/.config/kitty

    ln -s ./kitty-themes/themes/gruvbox_dark.conf ~/.config/kitty/theme.conf

    wget https://raw.githubusercontent.com/siddlv/dotfiles/master/kitty.conf
}

error()
{
	# Error message
	echo ERROR! Run Script Again. && exit 0
}

cleanup()
{	
	# Delete script, close terminal and exit
	rm -r personal_setup.sh ; kill -9 $PPID ; exit 0
}

# Script

essential_packages && kitty && change_shell && install_font && ohmyzsh && powerlevel10k && zshrc_vimrc_vimplug && cleanup || error

