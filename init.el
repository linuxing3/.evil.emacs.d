;; ---------------------------------------------------------
;; 包管理器
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/packages.el")

;; ---------------------------------------------------------
;; 自动加载帮助器
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/autoloads.el")

;; ---------------------------------------------------------
;; 功能模块
;; ---------------------------------------------------------

(load-file "~/EnvSetup/config/evil-emacs/modules/base.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/ivy.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/ui.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/evil-mode.el")

;; ---------------------------------------------------------
;; Org功能模块
;; ---------------------------------------------------------

(load-file "~/EnvSetup/config/evil-emacs/modules/org-mode.el")

;; ---------------------------------------------------------
;; 编程模块
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/project.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/completion.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/format.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/coding-mode.el")

;; ---------------------------------------------------------
;; 快捷键绑定
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/key-bindings.el")
