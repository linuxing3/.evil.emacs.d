
(use-package 'clojure-mode :ensure t)

(use-package 'cider :ensure t)

(use-package 'lsp
  :commands (lsp lsp-deferred) 
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (clojure-mode . lsp-deferred)
         (clojurescript-mode . lsp-deferred)
         (clojurec-mode . lsp-deferred))


(setq lsp-lens-enable t
    lsp-signature-auto-activate nil
    ; lsp-enable-indentation nil 
    ; lsp-enable-completion-at-point nil ; use cider
    )
