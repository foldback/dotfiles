## Introduction

These are my the scripts for my Declarative Dotfiles. I was tired of having to manually update my dotfile scripts if I had found a way to improve on whatever I was using. These scripts aim to change that:
if you use 'ddfunlib' (Declarative Dotfiles Functions Library), you can largely just template one of the other scripts, replace the name, package name and paths, and 'ddfunlib' will take care of the rest.
Does an app or situation calls for a different approach? All you have to do is replace 'baklink' with 'cplinkDir' or tweak your declared path, easy as pie :)

## The scripts

So far, the only scripts this repo contains are the apps and binaries that I use (or have used) in the past. My hope is that as more people start using this, the library and quality of scripts increases.
A fun one to look at is apps/cloud.sh'. Its a good example of the power of making your dotfiles declarative. All you tell this script is the name of your cloud provider (Dropbox, Google Drive, Amazon Drive, etc.)
and the package name on Homebrew, and it'll take care of installation, checking initialization of the folder after login, and your symlinks of choice. Want to switch provider? Just copy your files over to the new folder,
tell the script your provider, and off it goes!

## Installation

git clone "https://github.com/jorvi/declarativedotfiles.git" "${HOME}/dotfiles/scripts" inside your dotfiles repo. Check which scripts you want to use, and what structure/paths are expected.
Most scripts already contain my personal configuration as a sort of template, so it should be pretty clear!

As the usual advice goes, forking this, studying it, and editing it to your specification is the way to. If you think of something nice, do make a pull request!

## Thanks to…
The internet, countless manpages and #zsh on freenode (note: this script is mostly sh compatible!)
