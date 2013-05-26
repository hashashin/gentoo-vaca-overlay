# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Driver OpenDNIe para el DNI electronico"
HOMEPAGE="http://opendnie.cenatic.es"
SRC_URI="https://forja.cenatic.es/frs/download.php/1332/opensc-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch mirror"

DEPEND="sys-apps/pcsc-lite"
RDEPEND="${DEPEND}"

S="${WORKDIR}/opensc-${PV}"

pkg_nofetch() {
	einfo "Please download"
	einfo "  - opensc-${P}.tar.gz"
	einfo "from https://forja.cenatic.es/frs/?group_id=160"
	einfo "and place it in ${DISTDIR}"
}

src_configure() {
econf --prefix=/usr \
      --sysconfdir=/etc \
      --datadir=/usr/share \
      --infodir=/usr/share/info \
      --mandir=/usr/share/man || die "Could not configure"
}

src_install() {
emake DESTDIR="${D}" install || die "make failed"
}
