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

### Version managed development languages

I use [`asdf`](http://asdf-vm.com) for installing languages and environments. Because setup can take a long time, this command is separate from `dotfiles bootstrap everything`:

```sh
dotfiles bootstrap developer languages # install all lanuages
dotfiles bootstrap developer languages --deno --nodejs # flags to install only specific languages
```

## Development

### Building `dotfiles` from source

```sh
git clone git@github.com:hallee/dotfiles.git
cd dotfiles
swift build -c release --arch arm64 --arch x86_64
cp .build/apple/Products/Release/dotfiles .
./dotfiles
```
