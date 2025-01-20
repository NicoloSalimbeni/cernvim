FROM archlinux:base-devel

LABEL org.opencontainers.image.source https://github.com/nicolosalimbeni/cernvim

# Accept USER as a build-time argument
ARG USER=nicolo

# Define dependencies
ARG DEPS="unzip gdb neovim git curl python3 python-pip bash ripgrep fzf gcc make cmake cppcheck npm bash-language-server openssh clang shellcheck shfmt starship lazygit"

# Install dependencies and create the user
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm --needed $DEPS \
    && useradd -m $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && su $USER -c 'git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin && cd /tmp/yay-bin && makepkg -si --noconfirm' \
    && rm -rf /tmp/yay-bin \
    && pacman -Sc --noconfirm

# Install additional AUR packages as the user
RUN su $USER -c 'yay -S --noconfirm cmake-language-server'

# Set up Neovim configuration directories for both root and the user
RUN mkdir -p /home/$USER/.config/nvim /home/$USER/.local/share/nvim

# Copy Neovim configuration to both root and the user
COPY ./nvim /home/$USER/.config/nvim

# Set ownership of the user's Neovim configuration
RUN chown -R $USER:$USER /home/$USER

# Install Neovim plugins for the user
USER $USER
RUN nvim --headless "+Lazy! sync" +qall
RUN nvim --headless "+MasonUpdate" +qall
RUN nvim --headless "+TSUpdateSync" +qall

# Set the working directory
WORKDIR /home/$USER/workspace

# Set up SSH keys for the user
RUN mkdir -p /home/$USER/.ssh

RUN echo 'eval "$(starship init bash)"' >> /home/$USER/.bashrc
RUN starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Default command
CMD ["nvim"]
