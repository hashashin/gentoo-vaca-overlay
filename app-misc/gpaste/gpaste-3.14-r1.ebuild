# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit autotools bash-completion-r1 gnome2

MY_PN="GPaste"

DESCRIPTION="Clipboard management system"
HOMEPAGE="http://github.com/Keruspe/GPaste"
SRC_URI="https://github.com/Keruspe/${MY_PN}/archive/v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="applet bash-completion gnome-shell"

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND="dev-libs/glib:2
	>=sys-devel/gettext-0.17
	>=dev-util/intltool-0.40
	>=x11-libs/gtk+-3.0.0:3
	dev-lang/vala"
RDEPEND="${DEPEND}
	bash-completion? ( app-shells/bash )
	gnome-shell? ( >=gnome-base/gnome-shell-3.9.90 )"

DOCS="AUTHORS NEWS ChangeLog"

src_prepare() {
	epatch "${S}/ubuntu-patches/0001-ubuntu-disable-appdata-stuff.patch"
	eautoreconf -i -Wall
}

src_configure() {
	econf \
		--disable-schemas-compile \
		$(use_enable applet) \
		$(use_enable gnome-shell gnome-shell-extension)
}

src_install() {
	use bash-completion && BASHCOMPLETION_NAME="gpaste" dobashcompletion data/completions/"${PN}"
	gnome2_src_install
}
