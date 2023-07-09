#!/bin/bash

# Function to install packages on Debian
install_on_debian() {
    echo "Detected Debian-based OS..."
    echo "Updating repositories..."
    sudo apt update -y
    sudo apt install wget -y

    echo "Installing Git..."
    if ! command -v git > /dev/null 2>&1; then
        sudo apt install git -y
    else
        echo "Git already installed"
    fi

    echo "Installing Lazygit..."
    if ! command -v lazygit > /dev/null 2>&1; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit
        rm lazygit.tar.gz
    else
        echo "Lazygit already installed"
    fi

    echo "Installing Mono..."
    if ! command -v mono --version > /dev/null 2>&1; then
	sudo apt install dirmngr ca-certificates gnupg
	sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/debian stable-buster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
	sudo apt update
	sudo apt install mono-complete
    else
        echo "Mono already installed"
    fi

    echo "Installing Dotnet..."
    if ! command -v dotnet --version > /dev/null 2>&1; then
        wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb
        sudo apt update
        sudo apt-get install -y dotnet-sdk-7.0
    else
        echo "Dotnet already installed"
    fi

    echo "Installing OmniSharp..."
    if [[ ! -d ~/.OmniSharp ]] ; then
	wget "https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.39.7/omnisharp-linux-x64-net6.0.tar.gz" -P ~/.OmniSharp
	tar xzvf ~/.OmniSharp/omnisharp-linux-x64-net6.0.tar.gz -C ~/.OmniSharp
    else
        echo "Omnisharp already installed"
    fi

    echo "Installing Unity debugger..."
    if [[ ! -d ~/.UnityDbg ]] ; then
	wget "https://github.com/PhantomCloak/nvim-config/releases/download/v1.0/unity.unity-debug-3.0.2.tar.gz" -P ~/.UnityDbg
	tar xzvf ~/.UnityDbg/unity.unity-debug-3.0.2.tar.gz -C ~/.UnityDbg/
    else
        echo "Unity debugger already installed"
    fi
    echo "Installing Bear..."
    if ! command -v bear > /dev/null 2>&1; then
        sudo apt-get install bear -y
    else
        echo "Bear already installed"
    fi

    echo "Installing Clangd..."
    if ! command -v clangd --version > /dev/null 2>&1; then
        sudo apt-get install clangd -y
    else
        echo "Clangd already installed"
    fi

    echo "Installing Fzf..."
    if ! command -v fzf > /dev/null 2>&1; then
        sudo apt-get install fzf -y
    else
        echo "Fzf already installed"
    fi

    echo "Installing Bat..."
    if ! command -v batcat --version > /dev/null 2>&1; then
        sudo apt-get install bat -y
    else
        echo "Bat already installed"
    fi

    echo "Installing Ripgrep..."
    if ! command -v rg > /dev/null 2>&1; then
        sudo apt-get install ripgrep -y
    else
        echo "Ripgrep already installed"
    fi

    echo "Installing Neovim..."
    if ! command -v nvim > /dev/null 2>&1; then
        wget "https://github.com/neovim/neovim/releases/download/v0.8.3/nvim.appimage"
        sudo install nvim.appimage /usr/bin/nvim
	rm nvim.appimage
    else
        echo "Neovim already installed"
    fi
    echo "All packages installed successfully on Debian-based OS!"
}

# Function to install packages on MacOS
install_on_macos() {
    echo "Detected MacOS..."
    echo "Checking for Homebrew installation..."
    if ! command -v brew > /dev/null 2>&1; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Updating Homebrew..."
        brew update
    fi
    echo "Installing Git..."
    if ! command -v git > /dev/null 2>&1; then
        brew install git
    else
        echo "Git already installed"
    fi
    echo "Installing Lazygit..."
    if ! command -v lazygit > /dev/null 2>&1; then
        brew install jesseduffield/lazygit/lazygit
    else
        echo "Lazygit already installed"
    fi
    echo "Installing Fzf..."
    if ! command -v fzf > /dev/null 2>&1; then
        brew install fzf
    else
        echo "Fzf already installed"
    fi
    echo "Installing Neovim..."
    if ! command -v nvim > /dev/null 2>&1; then
        brew install neovim
    else
        echo "Neovim already installed"
    fi
    echo "All packages installed successfully on MacOS!"
}

setup_nvim(){
    if [[ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]] ; then
        git clone --depth 1 https://github.com/wbthomason/packer.nvim\
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    else
        echo "Packer already setup"
    fi
}

# Detect the OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    . /etc/os-release
    if [[ "$ID" == "debian" ]] || [[ "$ID_LIKE" == "debian" ]]; then
        install_on_debian
    else
        echo "Script currently supports Debian-based OS and MacOS only."
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_on_macos
else
    echo "Script currently supports Debian-based OS and MacOS only."
    exit 1
fi

setup_nvim
