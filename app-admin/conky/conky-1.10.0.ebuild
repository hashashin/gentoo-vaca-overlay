# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conky/conky-1.9.0-r3.ebuild,v 1.12 2015/01/30 10:45:56 billie Exp $

EAPI=5

inherit eutils libtool cmake-utils

DESCRIPTION="An advanced, highly configurable system monitor for X"
HOMEPAGE="http://conky.sourceforge.net/"
SRC_URI="https://github.com/brndnmtthws/${PN}/archive/v${PV}.tar.gz"
LICENSE="GPL-3 BSD LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="apcupsd audacious curl debug eve hddtemp imlib iostats lua lua-cairo lua-imlib math moc mpd nano-syntax ncurses nvidia +portmon rss thinkpad truetype vim-syntax weather-metar weather-xoap wifi X xmms2"

DEPEND_COMMON="
	X? (
		imlib? ( media-libs/imlib2[X] )
		lua-cairo? (
			>=dev-lua/toluapp-1.0.93
			>=dev-lang/lua-5.1.4-r8:0
			x11-libs/cairo[X] )
		lua-imlib? (
			>=dev-lua/toluapp-1.0.93
			>=dev-lang/lua-5.1.4-r8:0
			media-libs/imlib2[X] )
		nvidia? ( media-video/nvidia-settings )
		truetype? ( x11-libs/libXft >=media-libs/freetype-2 )
		x11-libs/libX11
		x11-libs/libXdamage
		x11-libs/libXext
		audacious? ( >=media-sound/audacious-1.5 dev-libs/glib:2 )
		xmms2? ( media-sound/xmms2 )
	)
	curl? ( net-misc/curl )
	eve? ( net-misc/curl dev-libs/libxml2 )
	portmon? ( dev-libs/glib:2 )
	lua? ( >=dev-lang/lua-5.1.4-r8:0 )
	ncurses? ( sys-libs/ncurses:0 )
	rss? ( dev-libs/libxml2 net-misc/curl dev-libs/glib:2 )
	wifi? ( net-wireless/wireless-tools )
	weather-metar? ( net-misc/curl )
	weather-xoap? ( dev-libs/libxml2 net-misc/curl )
	virtual/libiconv
	"
RDEPEND="
	${DEPEND_COMMON}
	apcupsd? ( sys-power/apcupsd )
	hddtemp? ( app-admin/hddtemp )
	moc? ( media-sound/moc )
	nano-syntax? ( app-editors/nano )
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
	"
DEPEND="
	${DEPEND_COMMON}
	virtual/pkgconfig
	"
S="${WORKDIR}"/"${P}"

src_prepare() {
	# Allow user patches #478482
	epatch_user

#	eautoreconf
}

src_install() {
	cmake-utils_src_install

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${S}"/extras/vim/ftdetect/conkyrc.vim

		insinto /usr/share/vim/vimfiles/syntax
		doins "${S}"/extras/vim/syntax/conkyrc.vim
	fi

	if use nano-syntax; then
		insinto /usr/share/nano/
		doins "${S}"/extras/nano/conky.nanorc
	fi
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "You can find sample configurations at ${ROOT%/}/etc/conky."
		elog "To customize, copy to ~/.conkyrc and edit it to your liking."
		elog
		elog "There are pretty html docs available at the conky homepage"
		elog "or in ${ROOT%/}/usr/share/doc/${PF}/html."
		elog
		elog "Also see https://wiki.gentoo.org/wiki/Conky/HOWTO"
		elog
	fi
}
