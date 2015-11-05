# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils versionator

SLOT="15"
PV_STRING="$(get_version_component_range 3-5)" # Always name EAP-versions with '_pre' for clarity!
MY_PV="$(get_version_component_range 1-2)"
MY_PN="idea"

DESCRIPTION="A complete toolset for web, mobile and enterprise development"
HOMEPAGE="http://www.jetbrains.com/idea"
SRC_URI="https://download.jetbrains.com/idea/${MY_PN}IU-${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="IDEA IDEA_Academic IDEA_Classroom IDEA_OpenSource IDEA_Personal"
IUSE=""
KEYWORDS="amd64 x86" # No keywords for EAP versions. Code quality sucks.

DEPEND="!dev-util/${PN}:14
	!dev-util/${PN}:15"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.7"
S="${WORKDIR}/${MY_PN}-IU-${PV_STRING}"

QA_TEXTRELS="opt/${PN}-${MY_PV}/bin/libbreakgen.so"
QA_PRESTRIPPED="opt/${PN}-${MY_PV}/lib/libpty/linux/x86/libpty.so
	opt/${PN}-${MY_PV}/lib/libpty/linux/x86_64/libpty.so
	opt/${PN}-${MY_PV}/bin/libyjpagent-linux.so
	opt/${PN}-${MY_PV}/bin/libyjpagent-linux64.so"

CHECKREQS_DISK_BUILD="1G"

src_prepare() {
	if ! use amd64; then
		rm -rf plugins/tfsIntegration/lib/native/linux/x86_64
	fi
	if ! use arm; then
		rm bin/fsnotifier-arm
		rm -rf plugins/tfsIntegration/lib/native/linux/arm
	fi
	if ! use ppc; then
		rm -rf plugins/tfsIntegration/lib/native/linux/ppc
	fi
	if ! use x86; then
		rm -rf plugins/tfsIntegration/lib/native/linux/x86
	fi
	rm -rf plugins/tfsIntegration/lib/native/solaris
	rm -rf plugins/tfsIntegration/lib/native/hpux
}

src_install() {
	local dir="/opt/${PN}-${MY_PV}"
	local exe="${PN}-${SLOT}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}"/bin/{idea.sh,fsnotifier{,64}}

	make_wrapper "${exe}" "${dir}/bin/${MY_PN}.sh"
	make_desktop_entry ${exe} "IntelliJ IDEA ${MY_PV}" "${exe}" "Development;IDE"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/"
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-idea-inotify-watches.conf"
}

pkg_postinst() {
	if [[ "$(get_version_component_range 7)x" = "prex" ]]
	then
		ewarn "Be aware, this is a release from their EAP. According to JetBrains, the code"
		ewarn "quality of such releases may be considerably below of what you might usually"
		ewarn "be used to from beta releases."
		ewarn "Don't use it for critical tasks. You have been warned."
	fi
}
