# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Wuala, your free online hard-disk"
HOMEPAGE="http://wuala.com/"
SRC_URI="http://cdn.wuala.com/repo/other/wuala.tar.gz"
LICENSE="wuala"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.6.0"

S="${WORKDIR}"/"${PN}"

src_install() {
	dodir /opt/"${PN}"
	insinto /opt/"${PN}"
	doins loader3.jar
	exeinto /opt/"${PN}"
	doexe wuala wualacmd
	dosym /opt/${PN}/wuala /opt/bin/wuala
	dosym /opt/${PN}/wualacmd /opt/bin/wualacmd
	dodoc readme.txt
	dodoc copyright
}
