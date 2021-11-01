;; ---------------------------------------------------------
;; 安装语言模式
;; ---------------------------------------------------------

(use-package go-mode
  :ensure t)

(use-package go-eldoc
  :ensure t
  :config
  (set-face-attribute 'eldoc-highlight-function-argument nil
                      :underline t :foreground "green"
                      :weight 'bold)
  :hook
  go-mode 'go-eldoc-setup)

(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (go-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred)
  :config
  (require 'dap-go)
  (dap-register-debug-template
   "Launch Unoptimized Debug Package"
   (list :type "go"
	 :request "launch"
	 :name "Launch Unoptimized Debug Package"
	 :mode "debug"
	 :program "${workspacefolder}/main.exe"
	 :buildFlags "-gcflags '-N -l'"
	 :args nil
	 :env nil
	 :envFile nil))
  (yas-global-mode))
