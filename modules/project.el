;; ---------------------------------------------------------
;; 项目管理
;; ---------------------------------------------------------
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;; ---------------------------------------------------------
;; 自动补全 
;; ---------------------------------------------------------
(use-package company :ensure t)
(add-hook 'after-init-hook 'global-company-mode)

(use-package flycheck :ensure t)
