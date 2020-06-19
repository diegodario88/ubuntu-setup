echo "Let's start setting up your system"
echo "First Let's Update your system..."
sudo dnf upgrade --refresh -y

echo 'Installing Free and Nonfree Repositories'
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo 'Installing Google Cloud SDK Repository'
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

echo ' Installing VSCODE repository'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' -y

echo 'Updating after repositories...'
sudo dnf check-update -y

echo 'Installing Visual Studio Code'
sudo dnf install code

echo 'Installing GCloud SDK'
sudo dnf install google-cloud-sdk -y

echo 'installing Nodejs' 
sudo dnf install nodejs.x86_64 -y

echo 'installing firebase'
sudo npm install -g firebase-tools

echo 'installing Tilix Terminal'
sudo dnf install tilix

echo 'installing colors grc'
sudo dnf install grc -y  

echo 'installing stremio'
sudo dnf install https://dl.strem.io/linux/v4.4.106/stremio-4.4.106-1.fc31.x86_64.rpm -y

echo 'installing multimidia'
sudo dnf install ffmpeg audacious peek youtube-dl -y

echo 'installing backup tools' 
sudo dnf install timeshift -y

echo 'installing vim'
sudo dnf install vim -y

echo "Setting GIT user.name"
git config --global user.name "Diego Dario"

echo "Setting GIT user.email"
git config --global user.email "diegodario88@gmail.com"

echo "Setting VIM as your default GIT editor"
git config --global core.editor vim

echo 'installing tool to handle clipboard via CLI'
sudo dnf install xclip -y

echo "Generating a SSH Key"
ssh-keygen -t rsa -b 4096 -C "diegodario88@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

echo 'installing zsh'
sudo apt-get install zsh -y
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh


export alias pbcopy='xclip -selection clipboard'
export alias pbpaste='xclip -selection clipboard -o'
source ~/.zshrc

echo 'installing extensions'
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension EditorConfig.EditorConfig
code --install-extension dbaeumer.vscode-eslint
code --install-extension PKief.material-icon-theme
code --install-extension AndrsDC.base16-themes

echo 'installing chrome' 
sudo dnf install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

echo 'installing nvm' 
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash)"

export NVM_DIR="$HOME/.nvm" && (
git clone https://github.com/creationix/nvm.git "$NVM_DIR"
cd "$NVM_DIR"
git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.zshrc
nvm --version

echo 'installing Typescript'
npm install -g typescript

echo 'installing autosuggestions' 
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo 'installing syntax highlighting'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source ~/.zshrc

echo 'installing podman-compose' 
sudo dnf install podman-compose -y
podman-compose --version

echo 'installing Mongodb Compass'
sudo dnf install mongodb-compass.x86_64

clear 

echo 'All setup, enjoy!'
