# dotfiles

My `dotfiles`. For setting up preferences, utilities, fonts, and apps on a new macOS computer.

This is a Swift CLI program; see [`Package.swift`](Package.swift).

![51438](https://user-images.githubusercontent.com/739304/151281254-ec7eea48-a3f3-4ae8-a91b-025d8efbbba3.gif)


## Setup

1. [Install Homebrew](https://brew.sh)
2. Install this CLI:
```sh
brew tap hallee/tap
brew install dotfiles
dotfiles bootstrap # initial setup
```

### Apps

By default, `dotfiles` installs a number of apps I use frequently via Homebrew Cask. Specific apps can be selected instead using flags, like:

```sh
dotfiles bootstrap apps --battery-buddy --raycast
```

### Version managed development languages

I use [`asdf`](http://asdf-vm.com) for installing languages and environments. Because setup can take a long time, this command is separate from `dotfiles bootstrap everything`:

```sh
dotfiles bootstrap developer languages # install all languages
dotfiles bootstrap developer languages --deno --nodejs # flags to install only specific languages
```

## Development

### Building `dotfiles` from source

```sh
make
```
