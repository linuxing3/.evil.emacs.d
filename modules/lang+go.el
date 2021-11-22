;; ---------------------------------------------------------
;; 安装语言模式
;; ---------------------------------------------------------

(use-package go-mode
  
  :hook ((go-mode . lsp-deferred))
  :config
  (require 'dap-go)
  (dap-go-setup)
  (if IS-WINDOWS (dap-register-debug-template
   "Launch Unoptimized Debug Package"
   (list :type "go"
	 :request "launch"
	 :name "Launch Unoptimized Debug Package"
	 :mode "debug"
	 :program "${workspacefolder}/main.exe"
	 :buildFlags "-gcflags '-N -l'"
	 :args nil
	 :env nil
	 :envFile nil))))

(use-package go-eldoc
  
  :hook ((go-mode . go-eldoc-setup))
  :config
  (set-face-attribute 'eldoc-highlight-function-argument nil
                      :underline t :foreground "green"
                      :weight 'bold))
