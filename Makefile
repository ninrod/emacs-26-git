build:
	makepkg

repack:
	makepkg --force --repackage

install:
	makepkg --install

test:
	namcap PKGBUILD && namcap emacs*.pkg.tar.xz

srcinfo:
	makepkg --printsrcinfo > .SRCINFO

clean:
	rm -r pkg/
	rm -r src/
	rm *.xz
	rm *.gz
