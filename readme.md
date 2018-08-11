# How to go back home again
* git clone --separate-git-dir=$HOME/.config.git https://github.com/bessonm/dotfiles.git $HOME/DELETE-ME-RIGHT-AFTER
* rm -r $HOME/DELETE-ME-RIGHT-AFTER
* alias config='/var/run/current-system/sw/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
* config config --local status.showUntrackedFiles no
* config checkout

# How to setup a new home
git clone --bare https://github.com/bessonm/dotfiles.git $HOME/.config.git

# Acknowledgments
* https://news.ycombinator.com/item?id=11071754
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

# Other
* https://developer.atlassian.com/blog/2016/01/totw-copying-a-full-git-repo/
* https://developer.atlassian.com/blog/2017/06/aliasing-authors-in-git/
