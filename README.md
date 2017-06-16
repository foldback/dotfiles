## Introduction

These are my dotfiles, building on [Mathias Bynens](https://mathiasbynens.be/) his groundwork. Whilst his settings definitely are an improvement over the defaults in macOS, there was (and is!) still room for improvement.

## The scripts

About half of what people name dotfiles are actually mostly shell scripts. Hence, I've changed their extension appropiately.
If you feel the need to run one of the scripts seperately, go ahead. I've made sure they can run indepedently of eachother, although Brew is required for the majority of them.

## Installation

git clone "https://github.com/jorvi/dotfiles.git" "\~/dotfiles" && git checkout "mac" && "\~/dotfiles/setup.sh"

If you want to use these dotfiles, you should first fork the repository, review the code, and remove things you don’t need or want. Don’t use these unless you know what they do. Use at your own risk!

## Updates

Updates happen as soon as you pull the latest commits from upstream, since everything is symlinked (if you ran setup.sh, that is). A restart may be required.

## Thanks to…
The internet. These dotfiles are combined from snippets all over the web, although major props goes to Mathias Bynens for the head start.
