build:
	swift build -c release --arch x86_64 --arch arm64
	cp .build/apple/Products/Release/dotfiles Release
	cp -r .build/apple/Products/Release/dotfiles_Dotfiles.bundle Release
