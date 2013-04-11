# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_P="${PN}2-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="vde2 is a virtual distributed ethernet emulator for emulators like qemu, bochs, and uml."
SRC_URI="mirror://sourceforge/vde/${MY_P}.tar.bz2"
HOMEPAGE="http://vde.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

IUSE="pcap ssl static-libs"

RDEPEND="pcap? ( net-libs/libpcap )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_enable pcap) \
		$(use_enable ssl cryptcab) \
		$(use_enable static-libs static) \
#dont use python as flags qa warnings
		--disable-python
}

src_compile() {
	emake -j1
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	use static-libs || find "${ED}" -name '*.la' -exec rm -f {} +

	newinitd "${FILESDIR}"/vde.init vde
	newconfd "${FILESDIR}"/vde.conf vde
}

pkg_postinst() {
	# default group already used in qemu
	enewgroup kvm
	einfo "To start vde automatically add it to the default runlevel:"
	einfo "# rc-update add vde default"
	einfo "You need to setup tap0 in /etc/conf.d/net"
	einfo "To use it as an user be sure to set a group in /etc/conf.d/vde"
}
