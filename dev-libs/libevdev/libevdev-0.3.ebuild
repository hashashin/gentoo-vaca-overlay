# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="evdev userspace library"
HOMEPAGE="http://cgit.freedesktop.org/libevdev/"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/libevdev.git"
	inherit git-2
	SRC_URI=""
else
	SRC_URI="http://cgit.freedesktop.org/${PN}/snapshot/${P}.tar.gz"
fi
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~arm"

LICENSE="BSD"
SLOT="0"
IUSE=""

src_prepare() {
	if [[ "$(eselect python show)" != "python2.7" || ! "$(eselect python show)" != "python2.6" ]]; then
		sed -i s/\ python/\ python2/ libevdev/make-event-names.py
	fi
	eautoreconf
}
