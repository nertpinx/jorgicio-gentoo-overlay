# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://flameshot.org"
SRC_URI="https://github.com/${PN}-org/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="FreeArt GPL-3 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsingleapplication[qt5(+),X]
	dev-qt/qtwidgets:5
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5
	dev-qt/qtdbus:5
	sys-apps/dbus
"
BDEPEND="
	dev-qt/linguist-tools:5
	>=dev-util/cmake-3.13
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}
