# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/savage2-bin/savage2-bin-2.1.0.1-r1.ebuild,v 1.4 2010/03/10 19:36:49 ssuominen Exp $

EAPI=3
inherit eutils games

DESCRIPTION="Unique mix of strategy and FPS"
HOMEPAGE="http://savage2.s2games.com/"
if use x86 ; then
	SRC_URI="Savage2Install-${PV}-i686.bin"
elif use amd64 ; then
	SRC_URI="Savage2Install-${PV}-x86_64.bin"
fi

LICENSE="savage2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip fetch"
PROPERTIES="interactive"
QA_TEXTRELS_x86="
	${GAMES_PREFIX_OPT:1}/savage2/vid_gl2.so
	${GAMES_PREFIX_OPT:1}/savage2/editor/cgame.so
	${GAMES_PREFIX_OPT:1}/savage2/game/libgame_shared.so
	${GAMES_PREFIX_OPT:1}/savage2/game/game.so
	${GAMES_PREFIX_OPT:1}/savage2/game/cgame.so
	${GAMES_PREFIX_OPT:1}/savage2/modelviewer/cgame.so
	${GAMES_PREFIX_OPT:1}/savage2/libk2.so"
QA_EXECSTACK_x86="
	${GAMES_PREFIX_OPT:1}/savage2/savage2.bin
	${GAMES_PREFIX_OPT:1}/savage2/savage2_update.bin"
QA_EXECSTACK_amd64="
	${GAMES_PREFIX_OPT:1}/savage2/savage2.bin
	${GAMES_PREFIX_OPT:1}/savage2/savage2_update.bin"

RDEPEND="virtual/opengl
	virtual/glu
	dev-libs/libxml2
	net-misc/curl
	x11-libs/libX11
	x11-libs/libXrandr
	media-libs/alsa-lib
	media-libs/speex
	media-libs/freetype:2
	media-libs/fmod:1
	sys-libs/glibc
	=media-libs/jpeg-6*"
DEPEND="app-arch/unzip"

S=${WORKDIR}/data

GAMES_CHECK_LICENSE="yes"

pkg_nofetch() {
	einfo "Since there is no direct download link for the latest version, you must download the binary yourself from "
	if use x86; then
		einfo "http://www.fileplanet.com/186623/180000/fileinfo/"
	elif use amd64; then
		einfo 'http://www.fileplanet.com/186624/180000/fileinfo/'
	fi
	einfo " and save it to ${DISTDIR}."
}

src_unpack() {
	if use x86 ; then
		unzip "${DISTDIR}"/Savage2Install-${PV}-i686.bin
	elif use amd64 ; then
		unzip "${DISTDIR}"/Savage2Install-${PV}-x86_64.bin
	else
		die "Unsupported arch"
	fi
}

src_prepare() {
	rm -f dedicated_server.sh editor.sh modelviewer.sh
	mv -f libs/libpng12.so.0 . || die
	rm -rf libs
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/savage2

	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms g+x "${dir}"/savage2{,_update}.bin || die "fperms failed"
	newicon s2icon.png ${PN}.png

	games_make_wrapper savage2 "./savage2.bin" "${dir}" "${dir}:${dir}/game"
	make_desktop_entry savage2 "Savage 2: A Tortured Soul"

	games_make_wrapper savage2-editor \
		"./savage2.bin \"PushMod editor; Set host_autoExec StartClient\"" \
		"${dir}" "${dir}"
	make_desktop_entry savage2-editor "Savage 2: Editor"

	games_make_wrapper savage2-modelviewer \
		"./savage2.bin \"PushMod modelviewer; Set host_autoExec StartClient\"" \
		"${dir}" "${dir}"
	make_desktop_entry savage2-modelviewer "Savage 2: Model Viewer"

	games_make_wrapper savage2-ded \
		"./savage2.bin \"Set host_dedicatedServer true\"" "${dir}" \
		"${dir}:${dir}/game"

	prepgamesdirs
}
