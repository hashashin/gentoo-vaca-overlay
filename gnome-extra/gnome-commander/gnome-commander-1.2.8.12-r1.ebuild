# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"

inherit eutils gnome2 versionator

MM_PV=$(get_version_component_range '1-2')

DESCRIPTION="two-pane graphical file manager for the GNOME desktop environment."
HOMEPAGE="http://www.nongnu.org/gcmd"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${MM_PV}/${PN}-${PV}.tar.bz2"
IUSE="vfs python taglib exiv gsf pdf chm keybind"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/glib-2.6.0
	>=x11-libs/gtk+-2.8.0
	gnome-base/libgnomeui
	>=gnome-base/libgnome-2.4.0
	vfs? ( >=gnome-base/gnome-vfs-2.0.0[fam] )
	python? ( >=dev-lang/python-2.4 )
	taglib? ( >=media-libs/taglib-1.4 )
	exiv? ( >=media-gfx/exiv2-0.14 )
	gsf? ( >=gnome-extra/libgsf-1.12.0 )
	pdf? ( >=app-text/poppler-0.6 )
	chm? ( dev-libs/chmlib )
	keybind? ( dev-libs/keybinder[python] )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV}"

pkg_setup() {
	DOCS="INSTALL AUTHORS BUGS ChangeLog README NEWS"
}
