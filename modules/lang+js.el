;; Refer to:
;; https://emacs-lsp.github.io/lsp-mode/tutorials/reactjs-tutorial/#welcome-to-react

(use-package json-mode :ensure t)

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (js-mode . lsp-deferred)
         (ts-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (require 'dap-edge))

(with-eval-after-load 'js
  (define-key js-mode-map (kbd "M-.") nil))

(setq company-minimum-prefix-length 1
      create-lockfiles nil) ;; lock files will kill `npm start'
