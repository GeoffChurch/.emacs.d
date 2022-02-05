(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)
(setq auto-save-default nil)
(setq make-backup-files nil)
(add-to-list 'default-frame-alist
	     '(font . "DejaVu Sans Mono-15"))

(use-package color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-bright t)

;; Uncomment the following only if autodetection fails for some reason.
;; (setq frame-background-mode "dark")
