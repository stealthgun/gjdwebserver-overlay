# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_MIN_API_VERSION="0.44"
VALA_MAX_API_VERSION="0.48" # fails tests with 0.50 in v3.36.3.1 - https://gitlab.gnome.org/GNOME/geary/-/issues/958

inherit gnome.org gnome2-utils meson vala virtualx xdg git-r3

DESCRIPTION="A lightweight, easy-to-use, feature-rich email client"
HOMEPAGE="https://wiki.gnome.org/Apps/Geary"

LICENSE="LGPL-2.1+ BSD-2 CC-BY-3.0 CC-BY-SA-3.0" # code is LGPL-2.1+, BSD-2 for bundled snowball-stemmer, CC licenses for some icons
SLOT="0"

IUSE=""

KEYWORDS="~amd64 ~x86 ~arm ~arm64"

SRC_URI=""

EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
if [[ ${PV} != 9999 ]]; then
    EGIT_COMMIT="tags/gnome-${PV}"
else
    KEYWORDS=""
fi

# for now both enchants work, but ensuring enchant:2

# >=webkit-gtk-2.26.4-r1 and >=gspell-1.7 dep to ensure all libraries used use enchant:2
DEPEND="
	>=dev-libs/glib-2.60.4:2
	>=x11-libs/gtk+-3.24.26:3
	>=net-libs/webkit-gtk-2.26.4-r1:4=
	>=dev-libs/gmime-3.2.4:3.0
	>=dev-db/sqlite-3.24:3

	app-text/enchant:2
	>=dev-libs/folks-0.11:0
	>=app-crypt/gcr-3.10.1:0=
	>=dev-libs/libgee-0.8.5:0.8=
	net-libs/gnome-online-accounts
	>=app-text/gspell-1.7:=
	app-text/iso-codes
	>=dev-libs/json-glib-1.0
	>=gui-libs/libhandy-0.0.10:0.0=
	>=dev-libs/libpeas-1.24.0
	>=app-crypt/libsecret-0.11
	>=net-libs/libsoup-2.48:2.4
	>=sys-libs/libunwind-1.1:0
	>=dev-libs/libxml2-2.7.8:2
	dev-libs/snowball-stemmer
	>=net-mail/ytnef-1.9.3
	>=app-text/hunspell-1.7.0
"
RDEPEND="${DEPEND}
	gnome-base/gsettings-desktop-schemas
"
BDEPEND="
	>=dev-libs/appstream-glib-0.7.10
	dev-libs/libxml2
	dev-util/itstool
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig

	$(vala_depend)
	x11-libs/gtk+:3[introspection]
	net-libs/webkit-gtk:4[introspection]
	dev-libs/gmime:3.0[vala]
	app-crypt/gcr:0[introspection,vala]
	dev-libs/libgee:0.8[introspection]
	app-text/gspell[vala]
	gui-libs/libhandy:0.0[vala]
	app-crypt/libsecret[introspection,vala]
	net-libs/libsoup:2.4[introspection,vala]
"

PATCHES="
	${FILESDIR}/Bump-client-test-timeout-to-300s.patch
"
#	${FILESDIR}/0001-Geary.Db.Context-Update-access-to-DatabaseConnection.patch
#	${FILESDIR}/0002-Geary.Db.Result-Log-large-elapsed-query-times-as-a-w.patch
#	${FILESDIR}/0003-Geary.Db.DatabaseConnection-Check-elapsed-time-for-e.patch
#	${FILESDIR}/0004-Geary.Db.Statement-Minor-code-cleanup.patch
#	${FILESDIR}/0005-Geary.Db.Context-Remove-separate-logging_parent-prop.patch
#	${FILESDIR}/0006-Geary.ImapEngine.GenericAccount-Set-database-logging.patch
#	${FILESDIR}/0007-Geary.Db-Update-SQL-logging.patch
#	${FILESDIR}/0008-Geary.ImapDb.Account-Slice-up-search-table-populatio.patch
#	${FILESDIR}/0009-Geary.ImapDB.Folder-Drop-create-merge-batch-size-dow.patch
#	${FILESDIR}/0010-Update-Friulian-translation.patch
#	${FILESDIR}/0011-Update-Friulian-translation.patch
#	${FILESDIR}/0012-Update-Friulian-translation.patch
#	${FILESDIR}/0013-Update-Friulian-translation.patch
#	${FILESDIR}/0014-Update-Croatian-translation.patch
#	${FILESDIR}/0015-Update-Croatian-translation.patch
#	${FILESDIR}/0016-Update-Slovak-translation.patch
#	${FILESDIR}/0017-Update-Slovak-translation.patch
#	${FILESDIR}/0018-Updated-Spanish-translation.patch
#	${FILESDIR}/0020-Application.CertificateManager-Fix-critical-when-no-.patch
#	${FILESDIR}/0021-Application.CertificateManager-Warn-when-GCR-not-abl.patch
#	${FILESDIR}/0022-Geary.Imap.Session-Avoid-critical-when-client-sessio.patch
#	${FILESDIR}/0023-Geary.Imap.SessionObject-Ensure-the-session-is-conne.patch
#	${FILESDIR}/0024-Geary.Imap.FolderSession-Ensure-client-session-is-se.patch
#	${FILESDIR}/0025-Geary.Imap.SessionObject-Rename-claim_session-to-get.patch
#	${FILESDIR}/0026-Geary.State.Machine-Support-GObject-notify-signal-fo.patch
#	${FILESDIR}/0027-Geary.Imap.ClientSession-Treat-logout-as-disconnect.patch
#	${FILESDIR}/0028-Composer.Widget-Fix-criticals-when-mailto-has-empty-.patch
#	${FILESDIR}/0029-Composer.Widget-Fix-critical-when-immediately-detach.patch
#	${FILESDIR}/0030-Geary.RFC822.Message-Fix-plain-text-file-attachment-.patch
#	${FILESDIR}/0031-build-Fix-build-failure-due-to-missing-client-API.patch
#	${FILESDIR}/0032-FormattedConversationData-Fix-font-settings-being-ig.patch
#	${FILESDIR}/0033-client-Fix-not-all-folders-being-displayed-in-additi.patch
#	${FILESDIR}/0034-Update-Hebrew-translation.patch
#	${FILESDIR}/0035-meson_options.txt-Update-to-use-meson-best-practices.patch
#	${FILESDIR}/0036-build-Update-how-build-profiles-are-handled.patch
#	${FILESDIR}/0037-Application.Client-Sort-external-const-alphabeticall.patch
#	${FILESDIR}/0038-Rename-INSTALLING-to-BUILDING.md.patch
#	${FILESDIR}/0039-README.md-Minor-improvements.patch
#	${FILESDIR}/0041-Update-Indonesian-translation.patch
#	${FILESDIR}/0043-Fix-accute-in-Catalan-translation.patch
#	${FILESDIR}/0044-Update-Greek-translation.patch
#	${FILESDIR}/0045-Drop-saving-the-paned-width.patch
#	${FILESDIR}/0046-Drop-the-2-panes-mode.patch
#	${FILESDIR}/0047-application-main-window-Move-the-conversations-searc.patch
#	${FILESDIR}/0048-main-toolbar-Split-the-folder-header.patch
#	${FILESDIR}/0049-main-toolbar-Add-add_to_size_groups.patch
#	${FILESDIR}/0050-application-main-window-Sync-the-pane-size-request.patch
#	${FILESDIR}/0051-Use-leaflets-in-the-UI.patch
#	${FILESDIR}/0052-main-toolbar-Add-add_to_swipe_groups.patch
#	${FILESDIR}/0053-application-main-window-Sync-the-leaflets-swipe-stat.patch
#	${FILESDIR}/0054-main-window-Add-leaflet-navigation-with-Alt-Arrow-ke.patch
#	${FILESDIR}/0055-main-toolbar-Add-back-buttons-for-leaflet-navigation.patch
#	${FILESDIR}/0056-application-main-window-add-navigation-via-signle-cl.patch
#	${FILESDIR}/0057-toolbar-header-group.patch
#	${FILESDIR}/0058-composer-Switch-leaflet-to-composer-when-folded.patch
#	${FILESDIR}/0059-conversation-list-use-shift-activate-to-open-convers.patch
#	${FILESDIR}/0060-composer-close-the-composer-when-navigating-back.patch
#	${FILESDIR}/0061-main-window-Block-forward-navigation-when-viewer-is-.patch
#	${FILESDIR}/0062-Update-Swedish-translation.patch
#	${FILESDIR}/0063-Util.Email-Use-a-single-unambiguous-date-format-for-.patch
#	${FILESDIR}/0064-Util.Date-Remove-now-unused-function.patch
#	${FILESDIR}/0065-main-toolbar-Create-object-containing-conversation-a.patch
#	${FILESDIR}/0066-action-bar-Add-an-action-bar-to-the-conversations-li.patch
#	${FILESDIR}/0067-Application.Client-Work-around-libhandy-bug-when-ope.patch
#	${FILESDIR}/0068-Revert-Revert-Merge-branch-mjog-558-webkit-shared-pr.patch
#	${FILESDIR}/0069-Util.JS-Support-converting-between-JSC.Value-and-GLi.patch
#	${FILESDIR}/0070-Components.WebView-Convert-to-using-messages-for-JS-.patch
#	${FILESDIR}/0071-Components.WebView-Check-for-pass-up-exceptions-when.patch
#	${FILESDIR}/0072-GearyWebExtension-Add-factory-method-for-error-user-.patch
#	${FILESDIR}/0073-GearyWebExtension-Add-support-for-sending-messages-f.patch
#	${FILESDIR}/0074-Util.Js-Improve-JSC-Value-to-GLib.Variant-conversion.patch
#	${FILESDIR}/0075-Components.WebView-Convert-to-using-messages-for-JS-.patch
#	${FILESDIR}/0076-Composer.WebView-Convert-to-using-messages-for-JS-cl.patch
#	${FILESDIR}/0077-Conversation.WebView-Convert-to-using-messages-for-J.patch
#	${FILESDIR}/0078-GearyWebExtension-Untangle-extension-and-JS-interact.patch
#	${FILESDIR}/0079-GearyWebExtension-Trivial-code-clean-up.patch
#	${FILESDIR}/0080-Components.WebView-Remove-now-unused-message-handler.patch
#	${FILESDIR}/0081-ConversationViewer.ConversationMessage-Fix-valadoc-w.patch
#	${FILESDIR}/0082-Util.JS-Remove-now-unused-code.patch
#	${FILESDIR}/0083-ComposerPageState-Use-CSS-for-managing-focus-with-co.patch
#	${FILESDIR}/0084-build-Bump-WebKitGTK-min-version-to-include-UserMess.patch
#	${FILESDIR}/0085-Update-Ukrainian-translation.patch
#	${FILESDIR}/0086-client-Remove-perf-relnote-it-s-not-really-that-note.patch
#	${FILESDIR}/0087-Update-Turkish-translation.patch
#	${FILESDIR}/0088-client-Move-Migrate-namespace-to-be-under-Util.patch
#	${FILESDIR}/0089-Application.Controller-Clean-up-config-data-vars-in-.patch
#	${FILESDIR}/0090-Application.Controller-Clean-up-invoking-XDG-config-.patch
#	${FILESDIR}/0091-Application.Client-Rename-app-user-dirs-to-home-dirs.patch
#	${FILESDIR}/0092-Geary.Controller-Migrate-release-config-if-needed.patch
#	${FILESDIR}/0093-org.gnome.Geary.yaml-Enable-copying-release-config-f.patch
#	${FILESDIR}/0094-Application.Client-Support-determining-if-running-un.patch
#	${FILESDIR}/0095-Application.Client-Introduce-and-use-consts-for-buil.patch
#	${FILESDIR}/0096-Application.Client-Ensure-non-release-builds-don-t-c.patch
#	${FILESDIR}/0097-build-Make-comment-about-system-libs-with-custom-VAP.patch
#	${FILESDIR}/0101-Updated-Czech-translation.patch
#	${FILESDIR}/0102-Updated-Czech-translation.patch
#	${FILESDIR}/0103-ui-components-web-view.js-Use-ResizeObserver-for-wat.patch
#	${FILESDIR}/0104-ui-components-web-view.js-Use-arrow-functions-for-be.patch
#	${FILESDIR}/0105-ui-conversation-web-view.css-Clean-up-HTML-BODY-elem.patch
#	${FILESDIR}/0106-ui-conversation-web-view.css-Work-around-oversized-e.patch
#	${FILESDIR}/0107-ConversationWebView-Fix-plain-text-emails-sometimes-.patch
#	${FILESDIR}/0108-Update-Polish-translation.patch
#	${FILESDIR}/0109-Update-Croatian-translation.patch
#	${FILESDIR}/0110-Update-Catalan-translation.patch
#	${FILESDIR}/0111-Geary.Imap.FolderSession-Fix-null-param-critical-wit.patch
#	${FILESDIR}/0112-Composer.Widget-Suppress-unsupported-draft-folder-me.patch
#	${FILESDIR}/0113-Geary.App.DraftManager-Wait-for-remote-to-be-open-in.patch
#	${FILESDIR}/0114-Composer.Widget-Rework-draft-manager-management.patch
#	${FILESDIR}/0115-Composer.Widget-Clean-up-set_save_to_override-method.patch
#	${FILESDIR}/0116-Composer.Widget-Hide-save-button-by-default.patch
#	${FILESDIR}/0117-org.gnome.Geary.yaml-Remove-libhandy-module-it-is-no.patch
#	${FILESDIR}/0118-Update-German-translation.patch
#	${FILESDIR}/0119-Update-Ukrainian-translation.patch
#	${FILESDIR}/0120-Update-Polish-translation.patch
#	${FILESDIR}/0121-Update-Catalan-translation.patch
#	${FILESDIR}/0122-Update-Indonesian-translation.patch
#	${FILESDIR}/0123-Add-Indonesian-translation.patch
#	${FILESDIR}/0124-Update-Swedish-translation.patch
#	
#	${FILESDIR}/0001-main-window-remove-shadow-from-folder-conversation-l.patch
#	${FILESDIR}/0002-conversation-viewer-move-actions-to-the-bottom-when-.patch
#	${FILESDIR}/0003-conversation-viewer-allow-one-email-per-line.patch
#	${FILESDIR}/0004-compnents-info-bar-use-custom-infobar-so-that-the-bu.patch
#	${FILESDIR}/0005-conversation-viewer-don-t-show-action-bar-when-in-co.patch
#	${FILESDIR}/0006-in-app-notification-wrap-text-and-add-start-end-marg.patch
#	
#	${FILESDIR}/0001-accounts-editor-Wrap-the-welcome-panel-labels.patch
#	${FILESDIR}/0002-accounts-editor-add-pane-Drop-the-useless-shadow.patch
#	${FILESDIR}/0003-accounts-editor-add-pane-Reduce-the-minimum-entry-wi.patch
#	${FILESDIR}/0004-accounts-editor-eit-pane-Ellipsize-the-account-row-l.patch
#	${FILESDIR}/0005-accounts-editor-make-window-usable-on-phones.patch
#	${FILESDIR}/0006-account-editor-use-HdyClamp-and-remove-padding.patch
#	${FILESDIR}/0007-account-editor-replace-remove-confirm-view-with-dial.patch
#	${FILESDIR}/0008-account-editor-don-t-show-close-button-for-edit-serv.patch
#	
#	${FILESDIR}/0001-conversation-email-row-use-is-expanded-to-add-remove.patch
#	${FILESDIR}/0002-conversation-list-box-remove-shadow-and-make-the-row.patch
#"
src_prepare() {
	vala_src_prepare
	xdg_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dcontractor=disabled
		-Dvaladoc=disabled
		-Dprofile=release
		-Drevno="${PR}"
	)

	meson_src_configure
}

src_test() {
	virtx meson_src_test
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
