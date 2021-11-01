;; ---------------------------------------------------------
;; 包管理器
;; ---------------------------------------------------------
(load-file "~/OneDrive/config/emacs/scratch/modules/packages.el")

;; ---------------------------------------------------------
;; 自动加载帮助器
;; ---------------------------------------------------------
(load-file "~/OneDrive/config/emacs/scratch/modules/autoloads.el")

;; ---------------------------------------------------------
;; 功能模块
;; ---------------------------------------------------------

(load-file (dropbox-path "config/emacs/scratch/modules/base.el"))
(load-file (dropbox-path "config/emacs/scratch/modules/ivy.el"))
(load-file (dropbox-path "config/emacs/scratch/modules/ui.el"))
(load-file (dropbox-path "config/emacs/scratch/modules/evil-mode.el"))

;; ---------------------------------------------------------
;; Org功能模块
;; ---------------------------------------------------------

(load-file (dropbox-path "config/emacs/scratch/modules/org-mode.el"))

;; ---------------------------------------------------------
;; 编程模块
;; ---------------------------------------------------------
(load-file (dropbox-path "config/emacs/scratch/modules/project.el"))
(load-file (dropbox-path "config/emacs/scratch/modules/completion.el"))
(load-file (dropbox-path "config/emacs/scratch/modules/format.el"))
(load-file (dropbox-path "config/emacs/scratch/modules/coding-mode.el"))

;; ---------------------------------------------------------
;; 快捷键绑定
;; ---------------------------------------------------------
(load-file (dropbox-path "config/emacs/scratch/modules/key-bindings.el"))
