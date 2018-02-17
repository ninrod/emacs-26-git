# Maintainer:  ninrod <filipe.silva at gmail at com>

# ----BEGIN Credits---
# I have based this PKGBUILD from these sources:

# 1) standard emacs PKGBUILD:
# Juergen Hoetzel <juergen@archlinux.org> and Renchi Raju <renchi@green.tam.uiuc.edu:
# https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/emacs

# 2) opinionated emacs from git HEAD:
# A. López-Valencia: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=emacs-git

# 3) lucid emacs PKGBUILD from AUR:
# # Maintainer: Jonathan Kotta <jpkotta AT gmail DOT com>
# Contributor: megadriver <megadriver at gmx dot com>
# Contributor: Juergen Hoetzel <juergen@archlinux.org>
# Contributor: Renchi Raju <renchi@green.tam.uiuc.edu>
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=emacs-lucid
# ----END Credits---

pkgname=emacs-26-git
pkgver=26.0.91
pkgrel=1
pkgdesc="The extensible, customizable, self-documenting real-time display editor, compiled with the lucid toolkit"
arch=('x86_64')
url="http://www.gnu.org/software/emacs/emacs.html"
license=('GPL3')
depends=('alsa-lib' 'desktop-file-utils' 'gconf' 'giflib' 'gnutls' 'gpm' 'gtk3' 'hicolor-icon-theme' 'libmagick6' 'libotf' 'libxpm' 'm17n-lib' 'librsvg')
conflicts=('emacs' 'emacs-lucid-pre-test')
source=(https://github.com/emacs-mirror/emacs/archive/emacs-$pkgver.tar.gz)
sha1sums=('be49ce6c4c42bdb663f8066aba1c4079a6e1bb17')

build() {
  cd "$srcdir"/emacs-emacs-$pkgver

  ./autogen.sh

  # For the hardening-wrapper package.  Emacs doesn't support building
  # with PIE (https://debbugs.gnu.org/cgi/bugreport.cgi?bug=18784).
  export HARDENING_PIE=0

  # with tip from: https://lists.nongnu.org/archive/html/emacs-devel/2017-06/msg00544.html
  PKG_CONFIG_PATH="/usr/lib/imagemagick6/pkgconfig"                                             \
                 ac_cv_lib_gif_EGifPutExtensionLast=yes                                         \
                 ./configure                                                                    \
                 --prefix=/usr --sysconfdir=/etc --libexecdir=/usr/lib --localstatedir=/var     \
                 --with-x-toolkit=gtk3 --with-xft --with-modules
  make
}

package() {
  cd "$srcdir"/emacs-emacs-$pkgver
  make DESTDIR="$pkgdir" install

  # remove conflict with ctags package
  mv "$pkgdir"/usr/bin/{ctags,ctags.emacs}
  mv "$pkgdir"/usr/share/man/man1/{ctags.1.gz,ctags.emacs.1}

  # fix user/root permissions on usr/share files
  find "$pkgdir"/usr/share/emacs/$pkgver -exec chown root:root {} \;
}
