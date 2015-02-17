# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit autotools eutils git-2 libtool

DESCRIPTION="bind dyndb plugin LDAP database back-end"
HOMEPAGE="https://fedorahosted.org/bind-dyndb-ldap/"
#SRC_URI=""
EGIT_REPO_URI="git://git.fedorahosted.org/bind-dyndb-ldap.git"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
#IUSE=""

DEPEND="net-dns/bind[dyndb]
    net-nds/openldap
	dev-libs/cyrus-sasl"
RDEPEND="${DEPEND}"

#src_unpack() {
#	git_src_unpack
#}
src_prepare() {
	eautoreconf || die "autoreconf error"
#	eaclocal || die "aclocal error"
#	eautoconf || die "autoconf error"
#	eautomake || die "automake error"
}
src_configure() {
	econf || die "configure fail"
}
src_install() {
	make DESTDIR="${D}" install || die "Installation failed"
}
