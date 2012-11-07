# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils unpacker

DESCRIPTION="Valve's Steam client for Linux"
HOMEPAGE="https://steampowered.com"
SRC_URI="http://media.steampowered.com/client/installer/steam.deb"
LICENSE="steam"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="	sys-devel/gcc:4.6
		amd64? (
			=app-emulation/emul-linux-x86-baselibs-20120520
			=app-emulation/emul-linux-x86-xlibs-20120520
			=app-emulation/emul-linux-x86-soundlibs-20120520
			)
		x86? (
			media-libs/libjpeg-turbo
			net-misc/curl
			media-libs/libogg
			>=x11-libs/pixman-0.24.4
			media-libs/libsdl
			media-libs/libtheora
			media-libs/libvorbis
			media-libs/alsa-lib
			x11-libs/cairo
			sys-apps/dbus
			media-libs/fontconfig
			media-libs/freetype:2
			dev-libs/libgcrypt
			x11-libs/gdk-pixbuf
			dev-libs/glib:2
			x11-libs/gtk+:2
			dev-libs/nspr
			dev-libs/nss
			media-libs/openal
			x11-libs/pango
			media-libs/libpng:1.2
			media-sound/pulseaudio
			>=x11-libs/libX11-1.5
			x11-libs/libXext
			x11-libs/libXfixes
			x11-libs/libXi
			x11-libs/libXrandr
			x11-libs/libXrender
			>=sys-libs/zlib-1.2.4
		)"

S="${WORKDIR}/"

src_unpack() {
	unpack_deb ${A}
	# fix QA notice
	sed -r -i "s/^(MimeType=.*)/\1;/" usr/share/applications/steam.desktop
	sed -r -i "s/^(Actions=.*)/\1;/" usr/share/applications/steam.desktop
}

src_install() {
	exeinto "/usr/bin"
	doexe "usr/bin/${PN}"
	insinto "/usr/lib/"
	doins -r usr/lib/steam
	dodoc usr/share/doc/steam/{changelog.gz,copyright}
	doman usr/share/man/man6/steam.6.gz
	insinto /usr/share/applications/
	doins usr/share/applications/steam.desktop
	insinto /usr/share/icons/
	doins -r usr/share/icons/
	doicon usr/share/pixmaps/steam.xpm
}
