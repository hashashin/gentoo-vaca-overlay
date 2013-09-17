# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

MY_PN="PyAIML"

inherit eutils distutils-r1 python-r1

DESCRIPTION="Python interpreter for AIML, the Artificial Intelligence Markup Language."
HOMEPAGE="http://pyaiml.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/pyaiml/${MY_PN}%20%28unstable%29/${PV}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	python-r1_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/cleanup.patch
}

src_install() {
	dodoc CHANGES.txt SUPPORTED_TAGS.txt TODO.txt aiml/self-test.aiml aiml/personalidad.aiml
	distutils-r1_src_install
}

pkg_postinst() {
	python-r1_mod_optimize aiml
}

pkg_postrm() {
	python-r1_mod_cleanup aiml
}
