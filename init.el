;; -*- lexical-binding: t; -*-

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 128 1024 1024))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Setup use-package to use straight.el
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-ensure t)

;; Start emacs server
(server-start)

(setf user-full-name "Geoffrey Churchill"
      user-mail-address "geoffrey.a.churchill@gmail.com")

(use-package magit)

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package org
  :config
  (setq org-hide-emphasis-markers t
	org-fontify-done-headline t
	org-hide-leading-stars t
	org-pretty-entities t
	;; org-odd-levels-only t
	;; org-html-validation-link nil
	org-default-notes-file "~/notes/notes.org"
        org-capture-templates '(("n" "Note" entry (file+olp+datetree "")
				 "* %?\n:PROPERTIES:\n:SPACE: %l\n:TIME: %U\n:END:")))
  :bind
  ("C-c C-c" . (lambda () (interactive) (org-capture nil "n")))
  )

(use-package pdf-tools
  :config
  (pdf-tools-install))

(use-package org-noter)

;; (use-package org-roam
;;   :after org
;;   :config
;;   (let ((my-dir (file-truename (concat (getenv "HOME") "/notes/"))))
;;     (unless (file-exists-p my-dir) (make-directory my-dir))
;;     (setq org-roam-directory my-dir))
;;   (org-roam-db-autosync-mode)
;;   :bind
;;   (("C-c n l" . org-roam-buffer-toggle)
;;    ("C-c n f" . org-roam-node-find)
;;    ("C-c n g" . org-roam-graph)
;;    ("C-c n i" . org-roam-node-insert)
;;    ;; ("C-c n c" . org-roam-capture)
;;    ("C-c n c" . (lambda () (interactive) (org-roam-capture- :node (org-roam-node-create :title ""))))
;;    ;; Dailies
;;    ;; ("C-c n j" . org-roam-dailies-capture-today)
;;    ))

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package lsp-mode
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection
    (lsp-stdio-connection (list "swipl"
				"-g" "use_module(library(lsp_server))."
				"-g" "lsp_server:main"
				"-t" "halt"
				"--" "stdio"))
    :major-modes '(prolog-mode)
    :priority 1
    :multi-root t
    :server-id 'prolog-ls))
  :hook
  ((prolog-mode . lsp))
  )

(use-package lsp-ui)

(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client
    :new-connection
    (lsp-stdio-connection (list "swipl"
				"-g" "use_module(library(lsp_server))."
				"-g" "lsp_server:main"
				"-t" "halt"
				"--" "stdio"))
    :major-modes '(prolog-mode)
    :priority 1
    :multi-root t
    :server-id 'prolog-ls)))

(use-package company
  :custom
  ((company-idle-delay 0.2))
  :config
  (global-company-mode))

(use-package visual-regexp-steroids
  :init
  (bind-key "C-s" 'vr/isearch-forward)
  (bind-key "C-r" 'vr/isearch-backward)
  (bind-key "C-S-s" 'vr/replace))

(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))

(desktop-save-mode)
(savehist-mode)

(setq auto-save-default nil)
(setq make-backup-files nil)

(setq inhibit-startup-screen t)
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message "")
(fringe-mode 0)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(set-face-attribute 'default nil :height 160)

;; ;; Use same PATH as shell.
;; (use-package exec-path-from-shell)
;; (exec-path-from-shell-initialize)
