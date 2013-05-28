# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="Wine-doors is a package manager for wine."
HOMEPAGE="http://www.wine-doors.org"
SRC_URI="http://sourceforge.net/projects/winedoors/files/${PN}-0.1.4a2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pycairo
	dev-python/pygtk
	dev-python/librsvg-python
	gnome-base/libglade
	dev-libs/libxml2[python]
	app-arch/cabextract
	app-pda/orange
	app-emulation/wine"
RDEPEND="${DEPEND}
	dev-python/gconf-python"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/desktop-qa.patch
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	USER="root" distutils_src_install --temp="${D}"
	keepdir /etc/wine-doors
}

pkg_postinst() {
	python_mod_optimize /usr/share/wine-doors
}

pkg_postrm() {
	python_mod_cleanup /usr/share/wine-doors
}
