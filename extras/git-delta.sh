#! /usr/bin/env bash

pacman -Syu --noconfirm git-delta
printf "\n# git-delta" >> ~/.gitconfig
printf "\n[core]\n    pager = delta --line-numbers" >> ~/.gitconfig
printf "\n[delta]\n    syntax-theme = Dracula" >> ~/.gitconfig
