# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-1.1.2-r2.ebuild,v 1.2 2012/10/28 09:27:24 zmedico Exp $

EAPI="4"

MY_PN="qemu-kvm"
MY_P=${MY_PN}-${PV}

PYTHON_DEPEND="2"
inherit eutils flag-o-matic linux-info toolchain-funcs multilib python user
BACKPORTS=6cee76f0

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/virt/kvm/qemu-kvm.git"
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/kvm/${MY_PN}/${MY_P}.tar.gz
	${BACKPORTS:+
		http://dev.gentoo.org/~cardoe/distfiles/${MY_P}-${BACKPORTS}.tar.xz}"
	KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
fi

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.linux-kvm.org"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
IUSE="+aio alsa bluetooth brltty +caps +curl debug doc fdt +jpeg kernel_linux \
kernel_FreeBSD mixemu ncurses opengl +png pulseaudio python rbd sasl sdl \
smartcard spice static systemtap tci +threads tls usbredir +uuid vde +vhost-net \
virtfs +vnc xattr xen xfs"

COMMON_TARGETS="i386 x86_64 alpha arm cris m68k microblaze microblazeel mips mipsel ppc ppc64 sh4 sh4eb sparc sparc64 s390x"
IUSE_SOFTMMU_TARGETS="${COMMON_TARGETS} lm32 mips64 mips64el ppcemb xtensa xtensaeb"
IUSE_USER_TARGETS="${COMMON_TARGETS} armeb ppc64abi32 sparc32plus unicore32"

# Setup the default SoftMMU targets, while using the loops
# below to setup the other targets.
IUSE="${IUSE}"
REQUIRED_USE="|| ("

for target in ${IUSE_SOFTMMU_TARGETS}; do
	IUSE="${IUSE} qemu_softmmu_targets_${target}"
	REQUIRED_USE="${REQUIRED_USE} qemu_softmmu_targets_${target}"
done
REQUIRED_USE="${REQUIRED_USE} )"

for target in ${IUSE_USER_TARGETS}; do
	IUSE="${IUSE} qemu_user_targets_${target}"
done

REQUIRED_USE="${REQUIRED_USE}
	static? ( !alsa !pulseaudio )
	virtfs? ( xattr )"

# Yep, you need both libcap and libcap-ng since virtfs only uses libcap.
LIB_DEPEND=">=dev-libs/glib-2.0[static-libs(+)]
	sys-apps/pciutils[static-libs(+)]
	sys-libs/zlib[static-libs(+)]
	aio? ( dev-libs/libaio[static-libs(+)] )
	caps? ( sys-libs/libcap-ng[static-libs(+)] )
	curl? ( >=net-misc/curl-7.15.4[static-libs(+)] )
	fdt? ( >=sys-apps/dtc-1.2.0[static-libs(+)] )
	jpeg? ( virtual/jpeg[static-libs(+)] )
	ncurses? ( sys-libs/ncurses[static-libs(+)] )
	png? ( media-libs/libpng[static-libs(+)] )
	rbd? ( sys-cluster/ceph[static-libs(+)] )
	sasl? ( dev-libs/cyrus-sasl[static-libs(+)] )
	sdl? ( >=media-libs/libsdl-1.2.11[static-libs(+)] )
	spice? ( >=app-emulation/spice-0.9.0[static-libs(+)] )
	tls? ( net-libs/gnutls[static-libs(+)] )
	uuid? ( >=sys-apps/util-linux-2.16.0[static-libs(+)] )
	vde? ( net-misc/vde[static-libs(+)] )
	xattr? ( sys-apps/attr[static-libs(+)] )
	xfs? ( sys-fs/xfsprogs[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	!app-emulation/kqemu
	!app-emulation/qemu
	!<app-emulation/qemu-1.0
	>=sys-firmware/seabios-1.7.0
	sys-firmware/sgabios
	sys-firmware/vgabios
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	bluetooth? ( net-wireless/bluez )
	brltty? ( app-accessibility/brltty )
	opengl? ( virtual/opengl )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( =dev-lang/python-2*[ncurses] )
	sdl? ( media-libs/libsdl[X] )
	smartcard? ( dev-libs/nss )
	spice? ( >=app-emulation/spice-protocol-0.8.1 )
	systemtap? ( dev-util/systemtap )
	usbredir? ( sys-apps/usbredir )
	virtfs? ( sys-libs/libcap )
	xen? ( app-emulation/xen-tools )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/texi2html )
	kernel_linux? ( >=sys-kernel/linux-headers-2.6.35 )
	static? ( ${LIB_DEPEND} )"

S="${WORKDIR}/${MY_P}"

STRIP_MASK="/usr/share/qemu/palcode-clipper"

QA_PREBUILT="
	usr/share/qemu/openbios-ppc
	usr/share/qemu/openbios-sparc64
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/palcode-clipper"

QA_WX_LOAD="${QA_PRESTRIPPED}
	usr/bin/qemu-i386
	usr/bin/qemu-x86_64
	usr/bin/qemu-alpha
	usr/bin/qemu-arm
	usr/bin/qemu-cris
	usr/bin/qemu-m68k
	usr/bin/qemu-microblaze
	usr/bin/qemu-mips
	usr/bin/qemu-mipsel
	usr/bin/qemu-ppc
	usr/bin/qemu-ppc64
	usr/bin/qemu-ppc64abi32
	usr/bin/qemu-sh4
	usr/bin/qemu-sh4eb
	usr/bin/qemu-sparc
	usr/bin/qemu-sparc64
	usr/bin/qemu-armeb
	usr/bin/qemu-sparc32plus"

pkg_pretend() {
	if use kernel_linux && kernel_is lt 2 6 25; then
		eerror "This version of KVM requres a host kernel of 2.6.25 or higher."
	elif use kernel_linux; then
		if ! linux_config_exists; then
			eerror "Unable to check your kernel for KVM support"
		else
			CONFIG_CHECK="~KVM ~TUN ~BRIDGE"
			ERROR_KVM="You must enable KVM in your kernel to continue"
			ERROR_KVM_AMD="If you have an AMD CPU, you must enable KVM_AMD in"
			ERROR_KVM_AMD+=" your kernel configuration."
			ERROR_KVM_INTEL="If you have an Intel CPU, you must enable"
			ERROR_KVM_INTEL+=" KVM_INTEL in your kernel configuration."
			ERROR_TUN="You will need the Universal TUN/TAP driver compiled"
			ERROR_TUN+=" into your kernel or loaded as a module to use the"
			ERROR_TUN+=" virtual network device if using -net tap."
			ERROR_BRIDGE="You will also need support for 802.1d"
			ERROR_BRIDGE+=" Ethernet Bridging for some network configurations."
			use vhost-net && CONFIG_CHECK+=" ~VHOST_NET"
			ERROR_VHOST_NET="You must enable VHOST_NET to have vhost-net"
			ERROR_VHOST_NET+=" support"

			if use amd64 || use x86 || use amd64-linux || use x86-linux; then
				CONFIG_CHECK+=" ~KVM_AMD ~KVM_INTEL"
			fi

			use python && CONFIG_CHECK+=" ~DEBUG_FS"
			ERROR_DEBUG_FS="debugFS support required for kvm_stat"

			# Now do the actual checks setup above
			check_extra_config
		fi
	fi

	if use static; then
		ewarn "USE=static is very much a moving target because of the packages"
		ewarn "we depend on will have their static libs ripped out or wrapped"
		ewarn "with USE=static-libs or USE=static due to continued dicsussion"
		ewarn "on the mailing list about USE=static's place in Gentoo. As a"
		ewarn "result what worked today may not work tomorrow."
	fi
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	enewgroup kvm 78
}

src_prepare() {
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target || die

	python_convert_shebangs -r 2 "${S}/scripts/kvm/kvm_stat"

	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	epatch_user
	epatch "${FILESDIR}"/transparent_hugepages.patch
}

src_configure() {
	local conf_opts audio_opts user_targets

	for target in ${IUSE_SOFTMMU_TARGETS} ; do
		use "qemu_softmmu_targets_${target}" && \
		softmmu_targets="${softmmu_targets} ${target}-softmmu"
	done

	for target in ${IUSE_USER_TARGETS} ; do
		use "qemu_user_targets_${target}" && \
		user_targets="${user_targets} ${target}-linux-user"
	done

	einfo "Building the following softmmu targets: ${softmmu_targets}"

	if [[ -n ${user_targets} ]]; then
		einfo "Building the following user targets: ${user_targets}"
		conf_opts="${conf_opts} --enable-linux-user"
	else
		conf_opts="${conf_opts} --disable-linux-user"
	fi

	# Add support for SystemTAP
	use systemtap && conf_opts="${conf_opts} --enable-trace-backend=dtrace"

	# Fix QA issues. QEMU needs executable heaps and we need to mark it as such
	#conf_opts="${conf_opts} --extra-ldflags=-Wl,-z,execheap"

	# Add support for static builds
	use static && conf_opts="${conf_opts} --static --disable-pie"

	# We always want to attempt to build with PIE support as it results
	# in a more secure binary. But it doesn't work with static or if
	# the current GCC doesn't have PIE support.
	if ! use static && gcc-specs-pie; then
		conf_opts="${conf_opts} --enable-pie"
	fi

	# audio options
	audio_opts="oss"
	use alsa && audio_opts="alsa,${audio_opts}"
	use sdl && audio_opts="sdl,${audio_opts}"
	use pulseaudio && audio_opts="pa,${audio_opts}"
	use mixemu && conf_opts="${conf_opts} --enable-mixemu"

	# --enable-vnc-thread will go away in 1.2
	# $(use_enable xen xen-pci-passthrough) for 1.2
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--disable-bsd-user \
		--disable-guest-agent \
		--disable-libiscsi \
		--disable-strip \
		--disable-werror \
		--python=python2 \
		$(use_enable aio linux-aio) \
		$(use_enable bluetooth bluez) \
		$(use_enable brltty brlapi) \
		$(use_enable caps cap-ng) \
		$(use_enable curl) \
		$(use_enable debug debug-info) \
		$(use_enable debug debug-mon) \
		$(use_enable debug debug-tcg) \
		$(use_enable doc docs) \
		$(use_enable fdt) \
		$(use_enable jpeg vnc-jpeg) \
		$(use_enable kernel_linux kvm) \
		$(use_enable kernel_linux kvm-device-assignment) \
		$(use_enable kernel_linux nptl) \
		$(use_enable ncurses curses) \
		$(use_enable opengl) \
		$(use_enable png vnc-png) \
		$(use_enable rbd) \
		$(use_enable sasl vnc-sasl) \
		$(use_enable sdl) \
		$(use_enable smartcard smartcard) \
		$(use_enable smartcard smartcard-nss) \
		$(use_enable spice) \
		$(use_enable tci tcg-interpreter) \
		$(use_enable threads vnc-thread) \
		$(use_enable tls vnc-tls) \
		$(use_enable usbredir usb-redir) \
		$(use_enable uuid) \
		$(use_enable vde) \
		$(use_enable vhost-net) \
		$(use_enable virtfs) \
		$(use_enable vnc) \
		$(use_enable xattr attr) \
		$(use_enable xen) \
		$(use_enable xfs xfsctl) \
		--audio-drv-list=${audio_opts} \
		--target-list="${softmmu_targets} ${user_targets}" \
		--cc="$(tc-getCC)" \
		--host-cc="$(tc-getBUILD_CC)" \
		${conf_opts} \
		|| die "configure failed"

		# FreeBSD's kernel does not support QEMU assigning/grabbing
		# host USB devices yet
		use kernel_FreeBSD && \
			sed -E -e "s|^(HOST_USB=)bsd|\1stub|" -i "${S}"/config-host.mak
}

src_install() {
	emake DESTDIR="${ED}" install

	if [[ -n ${softmmu_targets} ]]; then
		if use kernel_linux; then
			insinto /lib/udev/rules.d/
			doins "${FILESDIR}"/65-kvm.rules
		fi

		if use qemu_softmmu_targets_x86_64 ; then
			dobin "${FILESDIR}"/qemu-kvm
			ewarn "The depreciated '/usr/bin/kvm' symlink is no longer installed"
			ewarn "You should use '/usr/bin/qemu-kvm', you may need to edit"
			ewarn "your libvirt configs or other wrappers for ${PN}"
		else
			elog "You disabled QEMU_SOFTMMU_TARGETS=x86_64, this disables install"
			elog "of /usr/bin/qemu-kvm"
		fi
	fi

	dodoc Changelog MAINTAINERS TODO pci-ids.txt
	newdoc pc-bios/README README.pc-bios

	if use doc; then
		dohtml qemu-doc.html qemu-tech.html || die
	fi

	use python & dobin scripts/kvm/kvm_stat

	# Remove SeaBIOS since we're using the SeaBIOS packaged one
	rm "${ED}/usr/share/qemu/bios.bin"
	dosym ../seabios/bios.bin /usr/share/qemu/bios.bin

	# Remove vgabios since we're using the vgabios packaged one
	rm "${ED}/usr/share/qemu/vgabios.bin"
	rm "${ED}/usr/share/qemu/vgabios-cirrus.bin"
	rm "${ED}/usr/share/qemu/vgabios-qxl.bin"
	rm "${ED}/usr/share/qemu/vgabios-stdvga.bin"
	rm "${ED}/usr/share/qemu/vgabios-vmware.bin"
	dosym ../vgabios/vgabios.bin /usr/share/qemu/vgabios.bin
	dosym ../vgabios/vgabios-cirrus.bin /usr/share/qemu/vgabios-cirrus.bin
	dosym ../vgabios/vgabios-qxl.bin /usr/share/qemu/vgabios-qxl.bin
	dosym ../vgabios/vgabios-stdvga.bin /usr/share/qemu/vgabios-stdvga.bin
	dosym ../vgabios/vgabios-vmware.bin /usr/share/qemu/vgabios-vmware.bin

	# Remove sgabios since we're using the sgabios packaged one
	rm "${ED}/usr/share/qemu/sgabios.bin"
	dosym ../sgabios/sgabios.bin /usr/share/qemu/sgabios.bin
}

pkg_postinst() {
	if [[ -n ${softmmu_targets} ]]; then
		elog "If you don't have kvm compiled into the kernel, make sure you have"
		elog "the kernel module loaded before running kvm. The easiest way to"
		elog "ensure that the kernel module is loaded is to load it on boot."
		elog "For AMD CPUs the module is called 'kvm-amd'"
		elog "For Intel CPUs the module is called 'kvm-intel'"
		elog "Please review /etc/conf.d/modules for how to load these"
		elog
		elog "Make sure your user is in the 'kvm' group"
		elog "Just run 'gpasswd -a <USER> kvm', then have <USER> re-login."
		elog
		elog "The ssl USE flag was renamed to tls, so adjust your USE flags."
		elog "The nss USE flag was renamed to smartcard, so adjust your USE flags."
	fi
}
