install: $(shell find -name "*.go")
	go install maunium.net/go/gopacked/cmd/gopacked
	go install maunium.net/go/gopacked/cmd/twitchparse

build-all: build-linux build-win

build-linux: $(shell find -name "*.go")
	env GOOS=linux go build maunium.net/go/gopacked/cmd/gopacked -o gopacked
	env GOOS=linux go build maunium.net/go/gopacked/cmd/twitchparse -o twitchparse

build-win: $(shell find -name "*.go")
	env GOOS=windows go build maunium.net/go/gopacked/cmd/gopacked -o gopacked.exe
	env GOOS=windows go build maunium.net/go/gopacked/cmd/twitchparse -o twitchparse.exe

build-macos: $(shell find -name "*.go")
	env GOOS=darwin go build maunium.net/go/gopacked/cmd/gopacked -o gopacked
	env GOOS=darwin go build maunium.net/go/gopacked/cmd/twitchparse -o twitchparse

debian: build-linux
	mkdir -p build
	mkdir -p package/usr/bin/
	cp gopacked package/usr/bin/
	cp twitchparse package/usr/bin/
	dpkg-deb --build package gopacked.deb
	mv gopacked.deb build/

linux: build-linux
	mkdir -p build
	tar cvfJ gopacked_linux.tar.xz gopacked twitchparse LICENSE README.md
	mv gopacked_linux.tar.xz build/

windows: build-win
	mkdir -p build
	zip -9r gopacked_windows.zip gopacked.exe twitchparse.exe LICENSE README.md
	mv gopacked_windows.zip build/

macos: build-macos
	mkdir -p build
	zip -9r gopacked_macos.zip gopacked twitchparse LICENSE README.md
	mv gopacked_macos.zip build/

package: debian linux macos windows

clean-exes:
	rm -f gopacked twitchparse gopacked.exe twitchparse.exe

clean:
	rm -rf build package/usr
