;; Fixes "Bad request" package download issues.
(if (and (version< emacs-version "26.3") (>= libgnutls-version 30604))
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(load "~/.emacs.d/geoff-init-packages.el")
(load "~/.emacs.d/geoff-init-appearance.el")
(load "~/.emacs.d/geoff-init-misc.el")
(load "~/.emacs.d/modes/modes.el")
