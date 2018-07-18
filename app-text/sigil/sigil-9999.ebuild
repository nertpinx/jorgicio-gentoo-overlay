# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit cmake-utils python-single-r1

my_pn="Sigil"

DESCRIPTION="Sigil is a multi-platform WYSIWYG ebook editor for ePub format"
HOMEPAGE="http://sigil-ebook.com/"
if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/Sigil-Ebook/${my_pn}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Sigil-Ebook/${my_pn}/releases/download/${PV}/${my_pn}-${PV}-Code.zip"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE=""

RDEPEND="
	app-text/hunspell
	dev-libs/boost[threads]
	dev-libs/libpcre[pcre16]
	dev-libs/xerces-c[icu]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/cssutils[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-qt/qtconcurrent-5.4:5
	>=dev-qt/qtcore-5.4:5
	>=dev-qt/qtgui-5.4:5
	>=dev-qt/qtprintsupport-5.4:5
	>=dev-qt/qtwebkit-5.4:5
	>=dev-qt/qtwidgets-5.4:5
	>=dev-qt/qtxmlpatterns-5.4:5
	sys-libs/zlib[minizip]
"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.8
	virtual/pkgconfig
	>=dev-qt/linguist-tools-5.4:5
	app-arch/unzip
"


DOCS=( ChangeLog.txt README.md )

src_prepare() {
	# sigil tries to copy non-needed qt libs for deb package, safe to ignore this completely
	eapply "${FILESDIR}/${P}-proper-gumbo-install.patch"

	eapply_user
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_LIBS=1
		-DSYSTEM_LIBS_REQUIRED=1
		-DLIBDIR="$(get_libdir)"
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	elog "From Sigil's release notes:"
	elog "When you fire up Sigil for the very first time:"
	elog "navigate to the new General Preferences and select the default"
	elog "epub version you plan to work with (epub 2 or epub3) so that new"
	elog "empty ebooks start with the correct code."
	elog "if you plan to work with epub3 epubs, you should change your"
	elog "PreserveEntities setting to use ONLY NUMERIC entities."
	elog ""
	elog "For example use & # 1 6 0 ; for non-breaking spaces and etc."
	elog ""
	elog "We strongly recommend enabling Mend On Open in your settings"
	elog "for best performance with Sigil."
}
