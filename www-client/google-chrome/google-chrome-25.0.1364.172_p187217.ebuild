# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/google-chrome/google-chrome-25.0.1364.160_p186726.ebuild,v 1.1 2013/03/08 15:21:34 floppym Exp $

EAPI="4"

CHROMIUM_LANGS="am ar bg bn ca cs da de el en_GB es es_LA et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt_BR pt_PT ro ru sk sl sr
	sv sw ta te th tr uk vi zh_CN zh_TW"

inherit chromium eutils multilib pax-utils unpacker

DESCRIPTION="The web browser from Google"
HOMEPAGE="http://www.google.com/chrome"

case ${PV} in
	*_alpha*)
		SLOT="unstable"
		MY_PV=${PV/_alpha/-r}
		;;
	*_beta*)
		SLOT="beta"
		MY_PV=${PV/_beta/-r}
		;;
	*_p*)
		SLOT="stable"
		MY_PV=${PV/_p/-r}
		;;
	*)
		die "Invalid value for \${PV}: ${PV}"
		;;
esac

MY_PN="${PN}-${SLOT}"
MY_P="${MY_PN}_${MY_PV}"

SRC_URI="
	amd64? (
		http://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_amd64.deb
		mirror://gentoo/google-chrome-libudev-0.13.1-amd64.tar.xz
	)
	x86? (
		http://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_i386.deb
		mirror://gentoo/google-chrome-libudev-0.13.1-x86.tar.xz
	)
"

LICENSE="google-chrome"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+plugins"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-arch/bzip2
	app-misc/ca-certificates
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libgcrypt
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	net-print/cups
	sys-apps/dbus
	|| ( >=sys-devel/gcc-4.4.0[-nocxx] >=sys-devel/gcc-4.4.0[cxx] )
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/pango
	x11-misc/xdg-utils
"

# Add blockers for the other slots.
for x in 0 beta stable unstable; do
	if [[ ${SLOT} != ${x} ]]; then
		RDEPEND+=" !${CATEGORY}/${PN}:${x}"
	fi
done

QA_PREBUILT="*"
S=${WORKDIR}

pkg_nofetch() {
	eerror "Please wait 24 hours before reporting a bug for google-chrome fetch failures."
}

pkg_setup() {
	CHROME_HOME="opt/google/chrome/"
	chromium_suid_sandbox_check_kernel_config
}

src_install() {
	pax-mark m ${CHROME_HOME}chrome || die
	rm -rf usr/share/menu || die
	mv usr/share/doc/${PN} usr/share/doc/${PF} || die

	pushd "${CHROME_HOME}locales" > /dev/null || die
	chromium_remove_language_paks
	popd

	mv opt usr "${D}" || die

	fperms u+s "/${CHROME_HOME}chrome-sandbox" || die

	if use plugins ; then
		local plugins="--extra-plugin-dir=/usr/$(get_libdir)/nsbrowser/plugins"
		sed -e "/^exec/ i set -- \"${plugins}\" \"\$@\"" \
			-i "${D}${CHROME_HOME}google-chrome" || die
	fi

	domenu "${D}${CHROME_HOME}google-chrome.desktop" || die
	local size
	for size in 16 22 24 32 48 64 128 256 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		newins "${D}${CHROME_HOME}product_logo_${size}.png" google-chrome.png
	done
}

any_cpu_missing_flag() {
	local value=$1
	grep '^flags' /proc/cpuinfo | grep -qv "$value"
}

pkg_preinst() {
	chromium_pkg_preinst
	if any_cpu_missing_flag sse2; then
		ewarn "The bundled PepperFlash plugin requires a CPU that supports the"
		ewarn "SSE2 instruction set, and at least one of your CPUs does not"
		ewarn "support this feature. Disabling PepperFlash."
		sed -e "/^exec/ i set -- --disable-bundled-ppapi-flash \"\$@\"" \
			-i "${D}${CHROME_HOME}google-chrome" || die
	fi
}

pkg_postinst() {
	chromium_pkg_postinst

	einfo
	elog "Please notice the bundled flash player (PepperFlash)."
	elog "You can (de)activate all flash plugins via chrome://plugins"
	einfo
}
