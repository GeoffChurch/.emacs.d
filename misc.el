(desktop-save-mode 1)

(use-package company)
(global-company-mode)
(setq company-idle-delay 0)

(use-package flycheck)
(global-flycheck-mode)

(setq-default indent-tabs-mode nil)

;; (use-package magit)

;; (use-package yasnippet)

;; optionally
;; (use-package helm)
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-l"))
(use-package lsp-ui :commands lsp-ui-mode)
;; TODO make sure this works:
;; (use-package helm-lsp
;;   :commands helm-lsp-workspace-symbol
;;   :bind ([remap xref-find-apropos] . helm-lsp-workspace-symbol))
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; Use same PATH as shell.
(use-package exec-path-from-shell)
(exec-path-from-shell-initialize)
