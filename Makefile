install: $(shell find -name "*.go")
	go install

debian: $(shell find -name "*.go")
	go build
	cd build
	rm gopacked/usr/local/bin/gopacked
	mv ../gopacked gopacked/usr/local/
	nano DEBIAN/control
	dpkg-deb --build gopacked

linux: $(shell find -name "*.go")
	go build
	zip -9r gopacked_linux.zip gopacked LICENSE GABS_LICENSE PFLAG_LICENSE README.md
	rm -f gopacked
	mv gopacked_linux.zip build/

windows: $(shell find -name "*.go")
	env GOOS=windows go build
	zip -9r gopacked_windows.zip gopacked.exe LICENSE GABS_LICENSE PFLAG_LICENSE README.md
	rm -f gopacked.exe
	mv gopacked_windows.zip build/

clean:
	rm -f gopacked gopacked.exe gopacked.zip
