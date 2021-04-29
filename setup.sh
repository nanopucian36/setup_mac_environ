#!/bin/shs

# catch error
set -e

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 3600; kill -0 "$$" || exit; done 2>/dev/null &

# System Appearance
defaults write NSGlobalDomain "AppleInterfaceStyle" -string "Dark"

# バッテリー残量のパーセンテージ表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# .DS_Storeを作成しない
# defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Finder
# OSの言語が日本語の場合にFinderのデフォルトディレクトリを英語表記にする
rm ~/Downloads/.localized | rm ~/Documents/.localized | rm ~/Applications/.localized | rm ~/Desktop/.localized | rm ~/Library/.localized | rm ~/Movies/.localized | rm ~/Pictures/.localized | rm ~/Music/.localized | rm ~/Public/.localized
# Finderの表示をカラムビューにする。「Nlsv」(リストビュー)「icnv」(アイコンビュー)、「clmv」(カラムビュー)、「Flwv」(カバーフロービュー)から選択
defaults write com.apple.Finder FXPreferredViewStyle clmv
# Finder のタイトルバーにフルパスを表示する
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true    
# 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Desktopにファイルを表示させない
# defaults write com.apple.finder CreateDesktop -boolean false
# 新規ウィンドウをホームディレクトリで開く
defaults write com.apple.finder NewWindowTarget -string "PfLo"
# 最近の項目を非表示に
defaults write com.apple.finder ShowRecentTags -bool false

# Launchpad
# change columns and rows
defaults write com.apple.dock springboard-columns -int 10
defaults write com.apple.dock springboard-rows -int 8

# Dock
# 現在のサイズ確認（デフォルト[delete]にしている場合はdoes not exist）
# defaults read com.apple.dock tilesize
# Dockのサイズ変更(min:1, max:128)
defaults write com.apple.dock tilesize -int 70
# Dockの位置変更("down", "right", "left")
defaults write com.apple.dock orientation -string "down"
# Dockを常に表示(自動的に表示/非表示にさせない)
defaults write com.apple.dock autohide -bool false

# 設定の反映
killall Dock
killall Finder
killall SystemUIServer
killall Dock


# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Installing Homebrew: Complete"

# Install Homebrew Package
echo "Installing Homebrew Package..."
brew install cask
brew install brew-cask-completion
brew install mas
brew install git
brew install pyenv
brew install pipenv
brew install postgresql
# brew install nodenv
# brew install npm
brew install mecab
brew install mecab-ipadic
brew install opencv
brew install openssl
# brew install nginx
# brew install Speedtest-cli
echo "Installing Homebrew Package: Complete"

echo "Tapping for Fonts..."
brew tap homebrew/cask-fonts
echo "Tapping for Fonts: Complete"

# Install Apps using Homebrew Cask
echo "Installing Apps using Homebrew Cask..."
brew install --cask appcleaner
brew install --cask cheatsheet
brew install --cask chromedriver
brew install --cask discord
brew install --cask docker
brew install --cask font-jetbrains-mono
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask google-drive-file-stream
brew install --cask visual-studio-code
# brew install --cask firefox
brew install --cask iterm2
# brew install --cask manico
brew install --cask slack
brew install --cask zoom
# brew install --cask sublime-text
# brew install --cask kite
brew install --cask microsoft-excel
brew install --cask microsoft-powerpoint
brew install --cask microsoft-word
# brew install --cask notion
# brew install --cask kindle
# brew install --cask processing
# brew install --cask pycharm
# brew install --cask skype
# brew install --cask visual-studio-code
# brew install --cask xit
# brew install --cask eclipse-java

echo "Installing Apps using Homebrew Cask: Complete"

# Setup pyhton
echo "Install python..."
pyenv install 3.7.9
pyenv install 3.8.6
pyenv global 3.9.4

# Setup .zprofile
echo "Setting up .zshrc..."
echo '# Pyenv environment settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"
# alias for warning of brew
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"

# Pipenv environment settings
eval "$(pipenv --completion)"

# Path for brews sbin
export PATH="/usr/local/sbin:$PATH"

# Path for openssl
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

# Erase beep
setopt no_beep

' >> ~/.zprofile
echo "Setting up .zshrc: Complete"

# Install Apps from AppStore using mas
echo "Installing Apps from AppStore using mas command..."
echo "Please login with your Apple ID."
open -a "App Store"
read -p "Press [Enter] key to resume setup..."
# mas install 408981434  # imovie
# mas install 409183694  # keynote
# mas install 409201541  # pages
# mas install 409203825  # numbers
# mas install 441258766  # Magnet
# mas install 485812721  # TweetDeck
# mas install 497799835  # Xcode
# mas install 508368068  # GetPlainText
mas install 539883307  # LINE
# mas install 411643860 # DaisyDisk
# mas install 549083868  # display-menu
# mas install 634148309  # Logic Pro
# mas install 634159523  # MainStage
# mas install 682658836  # GarageBand
# mas install 1153157709 # Speedtest by Ookla
# mas install 1413777550 # launch-bar
# mas install 1414457383 # quickmovefile
# mas install 1444383602 # GoodNotes
echo "Installing Apps from AppStore using mas command: Complete"

# End & Reboot
echo "<<< macOS Environment Configurator for tyl >>>"
echo "END....."
echo "Rebooting machine..."
sudo shutdown -r now
