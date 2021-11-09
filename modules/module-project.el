;; ---------------------------------------------------------
;; 项目管理
;; ---------------------------------------------------------
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

(provide 'module-project)
