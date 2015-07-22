# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils vcs-snapshot

DESCRIPTION="Configures the behaviour of the F-keys on the Logitech K290"
HOMEPAGE="https://github.com/milgner/k290-fnkeyctl"
SRC_URI="https://github.com/milgner/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="dev-libs/libusb:1"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-install.sh.patch"
}

src_compile() {
	./build.sh || die
}

src_install() {
	./install.sh || die
}

