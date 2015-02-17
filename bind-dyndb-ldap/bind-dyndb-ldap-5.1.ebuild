# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit autotools eutils libtool

DESCRIPTION="bind dyndb plugin LDAP database back-end"
HOMEPAGE="https://fedorahosted.org/bind-dyndb-ldap/"
SRC_URI="https://fedorahosted.org/released/bind-dyndb-ldap/bind-dyndb-ldap-${PV}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64"
#IUSE=""

DEPEND="net-dns/bind[dyndb,threads]
    net-nds/openldap
	dev-libs/cyrus-sasl
	virtual/krb5"
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
