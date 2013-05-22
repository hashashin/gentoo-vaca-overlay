# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Programs for accessing Mega service from a command line of your desktop or server."
HOMEPAGE="http://megatools.megous.com/"
SRC_URI="http://megatools.megous.com/builds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fuse"

DEPEND="dev-libs/gobject-introspection
	dev-libs/glib
	fuse? ( sys-fs/fuse )"
