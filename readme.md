Gentoo overlay: GJDWebserver

This is a personal overlay I use for my PinePhone and other computers.

**Setup**
Add the following content to /etc/portage/repos.conf/gjdwebserver.conf

[gjdwebserver]
location = /var/db/repos/gjdwebserver
sync-type = git
sync-uri = https://github.com/stealthgun/gjdwebserver-overlay.git
auto-sync = yes
