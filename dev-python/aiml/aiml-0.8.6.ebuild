# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="3.*"

MY_PN="PyAIML"

inherit distutils python

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
	python_set_active_version 2
	python_pkg_setup
}

pkg_postinst() {
	python_mod_optimize aiml
}

pkg_postrm() {
	python_mod_cleanup aiml
}
