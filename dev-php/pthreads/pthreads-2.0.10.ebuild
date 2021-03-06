# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

# PHP_EXT_S="${WORKDIR}/${P}"

USE_PHP="php5-4 php5-5 php5-6"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

HOMEPAGE="http://pecl.php.net/package/pthreads"
DESCRIPTION="Threading API"
LICENSE="PHP License"
SLOT="0"
IUSE=""
