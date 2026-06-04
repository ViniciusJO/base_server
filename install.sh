#!/usr/bin/env sh

GREEN="\033[32m"
BLUE="\033[34m"
RESET="\033[0m"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo -e "${BLUE}Operating on $SCRIPT_DIR${RESET}\n"

PACKAGES="base-devel cups curl exa fzf git openssh tmux vim wget zsh"

if command -v pacman &> /dev/null; then
  sudo pacman -Syy --needed --noconfirm $PACKAGES
  echo -e "${GREEN}\n- packages installed${RESET}"
fi

sudo systemctl enable --now sshd cups

# TMUX
if ! [[ -f "$HOME/.tmux.conf" ]]; then
  cp $SCRIPT_DIR/tmux/.tmux.conf $HOME/

  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi

  tmux start-server
  tmux new-session -d -s __bootstrap_session

  # 3. Force source your config and trigger the headless installer
  tmux source-file "$HOME/.tmux.conf"
  "$HOME/.tmux/plugins/tpm/bin/install_plugins"

  # 4. Clean up the temporary server and exit cleanly
  tmux kill-session -t __bootstrap_session
  echo -e "${GREEN}\n- tmux configured${RESET}"
else
  echo -e "${GREEN}- tmux already configured${RESET}"
fi

# NVIM
if ! [[ -d "$HOME/.config/nvim" ]]; then
  mkdir -p $HOME/.config
  cp -r $SCRIPT_DIR/nvim/ $HOME/.config/nvim
  nvim --headless "+lua vim.pack.update(nil, { force = true })" +qa
  echo -e "${GREEN}\n- nvim configured${RESET}"
else
  echo -e "${GREEN}- nvim already configured${RESET}"
fi

# ZSH
if ! [[ -f "$HOME/.zshrc" ]]; then touch $HOME/.zshrc; fi
if ! [[ -d /etc/zsh/functions ]]; then
  sudo cp -r $SCRIPT_DIR/zsh/functions /etc/zsh/
  cat $SCRIPT_DIR/zsh/zshrc | sudo tee --append /etc/zsh/zshrc &> /dev/null
  chsh -s /usr/bin/zsh $USER
  echo -e "${GREEN}\n- zsh configured${RESET}"
else
  echo -e "${GREEN}- zsh already configured${RESET}"
fi


