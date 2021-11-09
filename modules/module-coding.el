;; ---------------------------------------------------------
;; 安装必备软件包 
;; ---------------------------------------------------------

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs lsp-ui lsp-ivy
    projectile hydra flycheck company avy which-key dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; ---------------------------------------------------------
;; 语言服务器协议
;; ---------------------------------------------------------
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-enable-folding nil
        lsp-enable-text-document-color nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         ;; (prog-mode . lsp)
         (python-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp lsp-deferred lsp-install-server
  :config
  (defun +lsp-zen()
    (prog2
    (setq lsp-enable-symbol-highlighting nil)
    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-doc-show-with-cursor nil)
    (setq lsp-ui-doc-show-with-mouse nil)
    (setq lsp-lens-enable nil)
    (setq lsp-headerline-breadcrumb-enable nil)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-ui-sideline-show-code-actions nil)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-ui-sideline-show-hover nil)
    (setq lsp-modeline-code-actions-enable nil)
    (setq lsp-diagnostics-provider :none)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-ui-sideline-show-diagnostics nil)
    (setq lsp-eldoc-enable-hover nil)
    (setq lsp-modeline-diagnostics-enable nil)
    (setq lsp-signature-auto-activate nil) ;; you could manually request them via `lsp-signature-activate`
    (setq lsp-signature-render-documentation nil)
    (setq lsp-completion-provider :none)
    (setq lsp-completion-show-detail nil)
    (setq lsp-completion-show-kind nil)))
  (yas-global-mode))

;; 类Vscode界面
(use-package lsp-ui
  :config
  (setq lsp-ui-peek-enable t 
        lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 72         ; 150 (default) is too wide
        lsp-ui-doc-delay 0.75           ; 0.2 (default) is too naggy
        lsp-ui-doc-show-with-mouse nil  ; don't disappear on mouseover
        lsp-ui-doc-position 'at-point
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-actions-icon lsp-ui-sideline-actions-icon-default)
  :ensure t
  :commands lsp-ui-mode)

;; 搜索定义
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol)

;; 使用目录
(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)


;; ---------------------------------------------------------
;; 反汇编工具
;; ---------------------------------------------------------
(use-package dap-mode :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; ---------------------------------------------------------
;; 加载编程语言 
;; ---------------------------------------------------------
(load-file (private-module-path "lang+go.el"))

(load-file (private-module-path "lang+c.el"))

(load-file (private-module-path "lang+rust.el"))

(load-file (private-module-path "lang+js.el"))

(load-file (private-module-path "lang+python.el"))


;; ---------------------------------------------------------
;; 优化内存管理
;; ---------------------------------------------------------
(setq treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(provide 'module-coding)
