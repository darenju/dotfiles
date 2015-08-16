if [ "$(id -u)" != "0" ] ; then
  echo 'Must be ran as root.'
  exit 1
fi
# You should change this of course.
USER='julien'

echo 'Starting setup…'

echo 'Installing brew… (You will have to download OS X Developer Tools, so stay in front of the computer!)'
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'brew installed.'

echo 'Setting up git…'
git config --global user.name "Julien Fradin"
git config --global user.email "julien@frad.in"
echo 'git set up.'

echo

echo 'Installing wget and node…'
sudo -u ${USER} brew install wget node
echo 'wget and node installed.'

echo 'Installing oh-my-zsh...'
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo 'oh-my-zsh installed.'

echo

echo 'Installing auto-completions…'
mkdir ~/.oh-my-zsh/completions
cp _z ~/.oh-my-zsh/completions
echo 'Auto-completions installed.'

echo

echo 'Installing pure…'
git clone https://github.com/sindresorhus/pure.git --quiet
mv pure/pure.zsh ~/.oh-my-zsh/custom/pure.zsh-theme
mv pure/async.zsh ~/.oh-my-zsh/custom/
rm -rf pure
echo 'pure installed.'

echo 'Creating ~/.hushlogin…'
touch ~/.hushlogin
echo '~/.hushlogin created.'

if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] ; then
  echo 'Installing zsh-syntax-highlighting…'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins --quiet
  echo 'zsh-syntax-highlighting installed.'
else
  echo 'zsh-syntax-highlighting already installed.'
fi

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

echo

echo 'Downloading apps…'

if [ ! -d "./Applications" ] ; then
  sudo -u ${USER} mkdir "./Applications"
fi

while read url
do
  sudo -u ${USER} wget $url -P "./Applications"
done < apps.url

echo 'Apps downloaded.'

sudo -u ${USER} open "./Applications"
echo 'Setup completed!'

osascript -e 'display notification "Setup completed!" with title "dotfiles"'
