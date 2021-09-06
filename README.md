# dotfiles

My `dotfiles`. For setting up preferences, utilities, fonts, and apps on a new macOS computer.

This is a Swift CLI program; see [`Package.swift`](Package.swift).

## Setup

1. [Install Homebrew](https://brew.sh)
2. Install this CLI:
```sh
brew tap hallee/tap
brew install dotfiles
dotfiles bootstrap # initial setup
```

## Development

### Building `dotfiles` from source

```sh
git clone git@github.com:hallee/dotfiles.git
cd dotfiles
swift build -c release
cp .build/release/dotfiles .
./dotfiles
```
