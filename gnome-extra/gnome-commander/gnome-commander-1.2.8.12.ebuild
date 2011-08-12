# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"

inherit eutils gnome2 autotools versionator

MM_PV=$(get_version_component_range '1-2')

DESCRIPTION="two-pane graphical file manager for the GNOME desktop environment."
HOMEPAGE="http://www.nongnu.org/gcmd/index.html"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${MM_PV}/${PN}-${PV}.tar.bz2"
IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	gnome-base/libgnomeui
	gnome-base/libgnome:2
	gnome-base/gnome-vfs:2
	dev-lang/python:2.4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV}"

pkg_setup() {
	DOCS="INSTALL AUTHORS BUGS ChangeLog README NEWS"
}

src_prepare() {
	gnome2_src_prepare
}

pkg_preinst() {
        gnome2_pkg_preinst
}

pkg_postinst() {
        gnome2_pkg_postinst
}
