#!/bin/bash

clear

ls ~/.zshrc > /dev/null 2>&1
# zsh ps > /dev/null 2>&1
OHMY_ZSH_INSTALLED=$?
if [ $OHMY_ZSH_INSTALLED -eq 0 ]; then
    echo "Zsh Already Installed"
else

    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

    wget https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases ~
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

    # sed  $'/ZSH_THEME="robbyrussell"/r zshrcinsert\n /ZSH_THEME="robbyrussell"/,/ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )/d' ~/.zshrc
    #sed -i -e "/ZSH_THEME=\"robbyrussell\"/r zshrcinsert"  -e "//d"  ~/.zshrc
    sed -i -e "/ZSH_THEME=\"robbyrussell\"/c ZSH_THEME=\"bira\""  -e "//d"  ~/.zshrc
    sed  -i $'/  git/c  git helm docker docker-compose docker-machine kubectl kube-ps1 zsh-autosuggestions zsh-syntax-highlighting vagrant vagrant-prompt' ~/.zshrc
    echo source ~/.kubectl_aliases >> ~/.zshrc
fi
