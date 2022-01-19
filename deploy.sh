#+!/bin/zsh

# Create backup of previous configuration in .emacs.d
mkdir ~/.emacs.d_bak
cp -r ~/.emacs.d/* ~/.emacs.d_bak

read -p 'This will overwrite your current Emacs configuration, are you sure you want to continue? [y/N] ' prompt
absolute_pwd=$(pwd)

# works in both bash and zsh
if [ "$prompt" = "y" ] || [ "$prompt" = "Y" ]; then
   mkdir $HOME/.emacs.d # if not already made
   ln -s $absolute_pwd/doom $HOME/.emacs.d # should learn how to ignore errors or to have exceptions in bash
   echo "A symlink has been created at $HOME/.emacs.d, enjoy!"
else
    echo "Aborting..."
fi
