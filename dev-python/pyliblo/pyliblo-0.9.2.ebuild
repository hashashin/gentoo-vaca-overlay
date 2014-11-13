# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="A Python wrapper for the liblo OSC library"
HOMEPAGE="http://das.nasophon.de/${PN}"
SRC_URI="http://das.nasophon.de/download/${P}.tar.gz"

RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/liblo-0.26
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
