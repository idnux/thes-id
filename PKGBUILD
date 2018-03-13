# Maintainer: Ali Ahmadi <idnux09@gmail.com>

pkgname='mythes-id'
_pkgname='thes-id'
pkgver=1.0.2
pkgrel=1
arch=('any')
url="https://idnux.wordpress.com/proyek/mythes-id/"
license=('LGPL')
pkgdesc="Indonesian thesaurus"
optdepends=('libmythes: offers thesaurus library functions')
source=("${pkgname}::git+https://github.com/idnux/${_pkgname}.git")
md5sums=('SKIP')


build() {
  cd ${srcdir}/${pkgname}
  make
}

package() {
  cd ${srcdir}/${pkgname}
  make DESTDIR=${pkgdir} install
}

