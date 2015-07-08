EAPI="4"
inherit eutils
DESCRIPTION="Clion C++ IDE"
HOMEPAGE="www.jetbrains.com/clion/"
SRC_URI="http://download.jetbrains.com/cpp/clion-${PV}.tar.gz"
KEYWORDS="~x86 ~amd64"
DEPEND="virtual/jdk"
RDEPEND="${DEPEND}"
SLOT="1"
S=${WORKDIR}

src_install() {
	dodir /opt/${PN}

	cd clion*/
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/clion.sh || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/cmake/bin/cmake || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/cmake/bin/cpack || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/cmake/bin/ctest || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/gdb/bin/gdb || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/inspect.sh || die "Chmod failed"
	dosym /opt/${PN}/bin/clion.sh /usr/bin/clion

	doicon "bin/${PN}.svg"
	make_desktop_entry ${PN} "CLion" "${PN}"
}
pkg_postinst() {
    elog "Run /usr/bin/clion"
}
