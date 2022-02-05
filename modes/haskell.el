(use-package lsp-mode)
(use-package lsp-ui)
(use-package lsp-haskell)

;; ;; Hooks so haskell and literate haskell major modes trigger LSP setup
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
