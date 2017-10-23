.emacs.d
========

My Emacs configuration.

Install
-------

The easiest way to install is to clone directly into `~/.emacs.d` or to link the
repository directory to `~/.emacs.d`. This makes it easy to track any local
changes and to pull updates.

Alternatively, you can copy the files from this repository into your
`~/.emacs.d` directory. However, this makes maintenace more difficult.

Windows
-------

Perhaps unsurprisingly, Emacs requires a little extra work on Windows.

### HOME

Unlike POSIX, Windows does not set `HOME` in the environment by default. In the
absence of `HOME`, Emacs may look for `.emacs.d` in an unexpected location, e.g.
`C:\Users\JohnDoe\AppData\Roaming`.

I recommend defining `HOME` to `%HOMEDRIVE%%HOMEPATH%` which will expand to a
more intuitive location, e.g. `C:\Users\JohnDoe`. This is also consistent with
[Git for Windows](https://git-for-windows.github.io/)'s home directory.

### HTTPS Support

The official Windows build of Emacs from GNU does not include the GnuTLS
library which means it cannot download packages over HTTPS. HTTPS is a good
thing (and required by Marmalade).

Thankfully, GNU provides all the build dependencies for Emacs 25 in a separate
archive:

* 64-bit (x64): http://ftp.gnu.org/gnu/emacs/windows/emacs-25-x86_64-deps.zip
* 32-bit (x86): http://ftp.gnu.org/gnu/emacs/windows/emacs-25-i686-deps.zip

This includes a lot more than just GnuTLS. The following DLLs need to be
installed into Emacs's bin directory for HTTPS to work:

* libffi-6.dll
* libgmp-10.dll
* libgnutls-30.dll
* libhogweed-4-1.dll
* libiconv-2.dll
* libidn-11.dll
* libintl-8.dll
* libnettle-6-1.dll
* libp11-kit-0.dll
* libtasn1-6.dll
* libwinpthread-1.dll
* zlib1.dll

### Default Directory

Launching Emacs from the Start Menu may result in a strange starting directory
such as `C:\Windows\System32`. This can be changed by specifying the `Start in`
property of the shortcut. This property can reference environment variables, so
a sane multi-user friendly value is `%HOME%`, assuming it has been set.
