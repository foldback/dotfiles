## Introduction

These are my dotfiles, building on [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) his groundwork. Whilst his settings definitely are leaps ahead over the defaults in macOS, there was (and is!) still room for improvement.

## The scripts

The install scripts are sourced from my [Declarative Dotfiles](https://github.com/jorvi/declarativedotfiles) repo. They take care of most of the heavy lifting.
If you feel the need to run one of the scripts seperately, go ahead. I've made sure they can run indepedently of eachother, although Brew and the \`ddfunlib\` library are required for the majority of them.

## Installation

git clone "https://github.com/jorvi/dotfiles.git" "\~/dotfiles" && git checkout "mac" && "\~/dotfiles/scripts/systemsetup.sh"

If you want to use these dotfiles, you should first fork the repository, review the code, and remove things you don’t need or want. Don’t use these unless you know what they do. You have been warned!

## Updates

Updates happen as soon as you pull the latest commits from upstream, since everything is symlinked (if you ran setup.sh, that is). A restart may be required.

## Thanks to…
The internet. Yes, cliche.. but these dotfiles do come from snippets all over the web.
