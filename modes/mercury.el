(setq auto-mode-alist (cons
                       '("\\.m\\'" . mercury-mode)
                       auto-mode-alist))

;; These 2 lines just load gud.el (the Grand Unified Debugger with added Mercury support).
(add-to-list 'load-path
             "~/mercury/lib/mercury/elisp")
(autoload 'mdb "gud" "Invoke the Mercury debugger" t)

(use-package flycheck-mercury
  :after flycheck)
