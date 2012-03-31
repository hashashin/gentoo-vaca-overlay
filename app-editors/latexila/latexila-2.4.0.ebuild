# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
CMAKE_MIN_VERSION="2.6.4"
CMAKE_IN_SOURCE_BUILD="yes" # for gnome2.eclass compat
GCONF_DEBUG="no"

inherit cmake-utils gnome2

DESCRIPTION="Integrated LaTeX environment for GNOME"
HOMEPAGE="http://projects.gnome.org/latexila/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome +latexmk rubber"

COMMON_DEPEND="
	>=dev-libs/glib-2.28:2
	dev-libs/libgee:0
	dev-libs/libunique:1
	>=x11-libs/gtk+-2.16:2
	>=x11-libs/gtksourceview-2.10:2.0
	x11-libs/gdk-pixbuf:2
	x11-libs/libX11
	x11-libs/pango
	app-text/gtkspell
	gnome? ( gnome-base/gsettings-desktop-schemas )
"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	x11-themes/hicolor-icon-theme
	latexmk? ( dev-tex/latexmk )
	rubber? ( dev-tex/rubber )
"
DEPEND="${COMMON_DEPEND}
	dev-util/itstool
	dev-util/pkgconfig
	sys-devel/gettext
"

pkg_setup() {
	DOCS="AUTHORS HACKING NEWS README"
}

src_prepare() {
	if [[ -n ${LINGUAS+set} ]]; then
		# LINGUAS is set, let's try to respect it.
		pushd po > /dev/null
		local po_file
		for po_file in *.po; do
			has "${po_file%.po}" ${LINGUAS} || rm -v "${po_file}"
		done
		popd > /dev/null
	fi
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_with gnome GNOME)
		-DCOMPILE_SCHEMA=OFF"
	cmake-utils_src_configure
}
