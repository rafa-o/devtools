# 5min guide to an awesome terminal + better file listing
If you spend some time using your terminal, I'm sure that at least once you have wished for a better experience when working with the terminal, and that's what we'll achieve today.

For this terminal configuration we'll be using [Zsh](https://www.zsh.org/), [Oh My Zsh](https://ohmyz.sh/), [Powerlevel10k](https://github.com/romkatv/powerlevel10k), [exa](https://the.exa.website/features), and a custom font to have access to unicode icons on the terminal.

# TL;DR
In a rush? No problem! I've made a script to automatically install and setup the tools mentioned in this article, simply run the following command and you should be good to go:
```bash
 sh -c "$(curl -fsSL https://raw.githubusercontent.com/rafa-o/devtools/master/p10k/spice_up_my_terminal.sh)"
```

⚠️ _Note:_ you'll still need to manually select the `MesloLGS NF` font family in your terminal's settings.

# Installing & setting up the required software
Use homebrew to install `zsh` and `exa`:
```bash
brew install zsh exa
```

Install `Oh My Zsh`:
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Download `Powerlevel10k` theme:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Set Powerlevel10k as your zsh theme by changing the `ZSH_THEME` line in `~/.zshrc` file to:
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```

# Download & install the custom font
Download these font files:
- [MesloLGS NF Regular](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
- [MesloLGS NF Bold](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
- [MesloLGS NF Italic](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
- [MesloLGS NF Bold Italic](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)

Install the font files by double clicking each one and then clicking on "Install Font".

Configure your terminal to use the downloaded font by going into your terminal settings and choosing the "MesloLGS NF" font family. If you're not sure about how to set up downloaded font in your terminal, take a look on [the official Powerlevel10k guide](https://github.com/romkatv/powerlevel10k#manual-font-installation) for how to set it up.

With these steps done, you can [copy my Powerlevel 10k configuration](https://raw.githubusercontent.com/rafa-o/devtools/master/p10k/.p10k.zsh) into your `~/.p10k.zsh` file to have the same settings as I do. (create the file in case it doesn't exist yet.)

If you copied my settings file with the link above, make sure to also add these lines to your `~/.zshrc` file in order make p10k's configuration wizard not show up every time you start your terminal:
```bash
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
```

Alternatively, you can start p10k's configuration wizard with the `p10k configure` command in your terminal and follow the prompts to try out different configuration options.

Now your terminal should already look something like this:
![Powerlevel10k](https://github.com/rafa-o/devtools/blob/img/img/p10k-preview.png)
_Note: restart your terminal if the changes are not applied._


# Making file listing nicer
We'll use exa to bring some colors and better sorting options when listing files on the terminal. I've set it to sort alphabetically and with folders on top. To do the same, you'll need to add a few aliases to your `~/.zshrc` configuration file:
```bash
# checks if exa command is available before setting the aliases
if [ -x "$(command -v exa)" ]; then
    alias ls="exa -1 --classify --group-directories-first"
    alias ll="exa --long --header --classify --icons --group-directories-first --no-permissions"
    alias lp="exa --long --header --classify --icons --group-directories-first"
    alias la="exa -a --long --header --classify --icons --group-directories-first"
    alias lt="exa --tree --long --header --classify --icons --group-directories-first"
    alias t="exa --tree --header --classify --icons --group-directories-first"
fi
```

Feel free to change these configurations based on exa's [documentation](https://the.exa.website/features).
This is how file listing should look like with above settings:
![File listing with exa](https://github.com/rafa-o/devtools/blob/img/img/exa-examples.png)



# Done!
That's all you need to have an improved terminal experience. 👩🏻‍💻 
_Keep reading for a few extra things._

# Extras
## Use bat 🦇 instead of cat 🐈
[Bat](https://github.com/sharkdp/bat) adds syntax highlighting when listing the contents of a file.
This is how it looks like:
![Using bat to see file contents](https://github.com/rafa-o/devtools/blob/img/img/bat-example.png)


Install it with homebrew:
```bash
brew install bat
```

You can add an alias in your `~/.zshrc` file to replace the `cat` command with `bat`:
```bash
alias cat="bat -n"
```
To customize it further, you can create a `.bat.conf` config file and export a `BAT_CONFIG_PATH` variable pointing to it in your `~/.zshrc` file:
```bash
export BAT_CONFIG_PATH=path/to/.bat.conf
```
This is what I have in my `.bat.conf` file:
```bash
# Set the theme to "OneHalfLight"
--theme="OneHalfLight"

# Remove paging by default
--paging=never
```

## fzf
You **_know_** you ran a command before, and now you need it again, but can't recall what the exact command was? Well, `fzf` let's you easily search for it when you hit `ctrl+r` and start typing your search term. Once you find what you want, just press `enter` to insert it on the terminal.

Zsh already brings some of this functionality, but I feel that `fzf` delivers a better experience.

Install `fzf` with homebrew:
```bash
brew install fzf
```

Finish setting it up with this command (answer 'y' for the questions that show up):
```bash
$(brew --prefix)/opt/fzf/install
```

That's it, this is how `fzf` search looks like:
![fzf example](https://github.com/rafa-o/devtools/blob/img/img/fzf-example.png)

## Changing Powerlevel10k colors
If you'd like to change the colors used for Powerlevel10k, you can do so by changing them in your `~/.p10k.zsh` configuration file.

These are the lines I have changed to achieve my current color settings:
```bash
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=039
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=214
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=039
typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=214
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=039
typeset -g POWERLEVEL9K_RAM_BACKGROUND=202
typeset -g POWERLEVEL9K_DIR_BACKGROUND=171
typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=040
```

To check out how each of the available colors look like in your terminal, you can run this command:
```bash
for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
```

For reference, this is the output of the command in my terminal:
![Colors available to use with Powerlevel10k](https://github.com/rafa-o/devtools/blob/img/img/p10k-colors.png)

## Hyperterm summon
If you're also using [Hyper.is](https://hyper.is/) as your terminal, I highly recommend installing [hyperterm-summon](https://github.com/soutar/hyperterm-summon), it enables you to summon the terminal from anywhere with a keyboard shortcut.
Install it with:
```bash
hyper i hyperterm-summon
```

I have changed the default shortcut to be `cmd+.`, for that you'll need to add a `summon` block to your `~/.hyper.js` configuration file:
```javascript
module.exports = {
    config: {
        // other configuration omitted
        summon: {
          hideDock: false,
          hideOnBlur: false,
          hotkey: 'Super+.',
        }
    }
}
```
_Note: you need to have Hyper running before being able to summon it from anywhere._

# Thank you 💖
Thank you for reading through this article.  If you found it helpful, make sure to share it so that more people can improve their terminal experience.

For more customization options, don't forget to check out the official documentation of the tools we installed:

- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [exa](https://the.exa.website/features)
- [bat](https://github.com/sharkdp/bat)
- [fzf](https://github.com/junegunn/fzf)