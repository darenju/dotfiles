if [ "$(id -u)" != "0" ] ; then
  echo 'Must be ran as root.'
  exit 1
fi
USER='julien'
echo 'Starting setup…'
echo 'Installing brew… (You will have to download OS X Developer Tools, so stay in front of the computer!)'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'brew installed.'
echo 'Installing wget and node…'
sudo -u ${USER} brew install wget node
echo 'wget and node installed.'
echo 'Installing oh-my-zsh...'
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo 'oh-my-zsh installed.'
echo
echo 'Installing pure…'
git clone https://github.com/sindresorhus/pure.git
mv pure/pure.zsh ~/.oh-my-zsh/custom/pure.zsh-theme
mv pure/async.zsh ~/.oh-my-zsh/custom/
rm -rf pure
echo 'pure installed.'
echo 'Installing zsh-syntax-highlighting…'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins
echo 'zsh-syntax-highlighting installed.'
echo
echo 'Setting up .dotfiles…'
echo '.zshrc…'
cp .zshrc ~/.zshrc
echo '.vimrc…'
cp .vimrc ~/.vimrc
echo 'Done.'
echo
echo 'Setting up hosts…'
cp hosts /etc
echo 'Setup completed!'
