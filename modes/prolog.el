;; (use-package prolog-mode)
;; (autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;; (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;; (autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)

;; (setq prolog-system 'swi)
(setq auto-mode-alist (cons
                       '("\\.pl\\'" . prolog-mode)
                       auto-mode-alist))

;; Install the SWI LSP server first: ;; TODO should this be checked/executed programmatically?
;; swipl -g 'pack_install(lsp_server)'
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
(add-hook 'prolog-mode-hook #'lsp)
