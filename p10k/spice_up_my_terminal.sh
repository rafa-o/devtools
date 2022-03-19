#!/bin/bash

#############################################################################################
#
# Script to spice up the terminal with Zsh, Oh My Zsh, Powerlevel10k, exa, bat and fzf.
# More details on accompanying article: https://linkedin.com/pulse/article-url
#
#
# Author: Rafa Oliveira
#
#############################################################################################

# install required software packages. If they're already installed, nothing will change.
brew install zsh exa bat fzf

# installs Oh My Zsh if oh-my-zsh folder doesn't exist under user's home
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # prevents oh my zsh's installer from interrupting the script by running zsh right after installing
  export RUNZSH=no
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# download and install MesloLGS NF font
(cd /Library/Fonts; curl -o "MesloLGS NF Regular.ttf" 'https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf' --compressed; curl -o "MesloLGS NF Bold.ttf" 'https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf' --compressed; curl -o "MesloLGS NF Italic.ttf" 'https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf' --compressed; curl -o "MesloLGS NF Bold Italic.ttf" 'https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf' --compressed;)

# clones Powerlevel10k if there's no powerlevel10k folder yet under ~/.oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# replaces the ZSH_THEME line of your ~/.zshrc file with: ZSH_THEME="powerlevel10k/powerlevel10k" 
sed -i '' '/^ZSH_THEME=/s/.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# copies my Powerlevel10k configuration
curl https://raw.githubusercontent.com/rafa-o/devtools/master/p10k/.p10k.zsh >| ~/.p10k.zsh

# sources ~/.p10k.zsh on ~/.zshrc
if ! grep -Fq -m 1 "source ~/.p10k.zsh" ~/.zshrc; then
  printf "\n\n# To customize prompt, run 'p10k configure' or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc
fi

# adds aliases for exa
if ! grep -Fq -m 1 "command -v exa" ~/.zshrc; then
  printf '\n\n# checks if exa command is available before setting the aliases
if [ -x "$(command -v exa)" ]; then
    alias ls="exa -1 --classify --group-directories-first"
    alias ll="exa --long --header --classify --icons --group-directories-first --no-permissions"
    alias lp="exa --long --header --classify --icons --group-directories-first"
    alias la="exa -a --long --header --classify --icons --group-directories-first"
    alias lt="exa --tree --long --header --classify --icons --group-directories-first"
    alias t="exa --tree --header --classify --icons --group-directories-first"
fi' >> ~/.zshrc
fi

# create bat config file
printf '# Set the theme to "OneHalfLight"
--theme="OneHalfLight"

# Remove paging by default
--paging=never
' >| ~/.bat.conf

# sets BAT_CONFIG_PATH on ~/.zshrc if it's not already there and set alias
if ! grep -Fq -m 1 "BAT_CONFIG_PATH" ~/.zshrc; then
  printf '\n\nexport BAT_CONFIG_PATH=~/.bat.conf' >> ~/.zshrc
  printf '\n\nalias cat="bat -n"' >> ~/.zshrc
fi

# finish setting up fzf
yes | $(brew --prefix)/opt/fzf/install

# done installing and setting up things
read -n 1 -s -r -p "

All done. 😎

NOTE: Make sure to select the 'MesloLGS NF' font family on your terminal settings!

Press any key to reload the terminal.."

# reload terminal with changes applied
clear
exec /bin/zsh

