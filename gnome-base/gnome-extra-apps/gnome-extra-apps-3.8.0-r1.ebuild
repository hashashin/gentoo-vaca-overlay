# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-extra-apps/gnome-extra-apps-3.8.0.ebuild,v 1.1 2013/04/11 19:15:20 pacho Exp $

EAPI="5"

DESCRIPTION="Sub-meta package for the applications of GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+shotwell +tracker evolution browser juicer webcam"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# Note to developers:
# This is a wrapper for the extra apps integrated with GNOME 3
# New package
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}

	>=app-admin/gnome-system-log-${PV}
	>=app-arch/file-roller-${PV}
	>=app-dicts/gnome-dictionary-3.6.0
	>=games-board/aisleriot-3.2.3.2
	>=gnome-extra/gconf-editor-3
	>=gnome-extra/gnome-calculator-${PV}
	>=gnome-extra/gnome-games-3.6.1
	>=gnome-extra/gnome-search-tool-3.6
	>=gnome-extra/gnome-system-monitor-${PV}
	>=gnome-extra/gnome-tweak-tool-3.7.4
	>=gnome-extra/gucharmap-${PV}:2.90
	>=gnome-extra/sushi-${PV}
	evolution? ( >=mail-client/evolution-${PV} )
	>=media-gfx/gnome-font-viewer-${PV}
	>=media-gfx/gnome-screenshot-${PV}
	juicer? ( >=media-sound/sound-juicer-3.5.0 )
	webcam? ( >=media-video/cheese-${PV} )
	>=net-analyzer/gnome-nettool-3.2
	>=sys-apps/baobab-${PV}
	browser? ( >=www-client/epiphany-${PV} )

	shotwell? ( >=media-gfx/shotwell-0.14 )
	tracker? (
		>=app-misc/tracker-0.16
		>=gnome-extra/gnome-documents-${PV} )
"
# Note: bug-buddy is broken with GNOME 3
# Note: aisleriot-3.4 is masked for guile-2
DEPEND=""
S=${WORKDIR}
