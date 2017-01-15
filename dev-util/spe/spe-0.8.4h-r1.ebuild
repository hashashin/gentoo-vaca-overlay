# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_6 python2_7 )
PYTHON_SINGLE_TARGET=( python2_6 python2_7 )

inherit distutils-r1 eutils

MY_PV="0.8.4.h"

DESCRIPTION="Python IDE with Blender support"
HOMEPAGE="http://pythonide.stani.be/"
SRC_URI="mirror://berlios/python/spe-${MY_PV}-wx2.6.1.0.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND=""
RDEPEND=">=dev-python/pychecker-0.8.18
	dev-python/wxpython:2.9
	>=dev-util/wxglade-0.3.2"

S="${WORKDIR}/spe-${MY_PV}"

PYTHON_MODNAME="_spe"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-with-pychecker-0.8.19.patch
}

src_install() {
	distutils-r1_src_install

	doicon _spe/images/spe.png

	domenu spe.desktop
}
