;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; ---------------------------------------------------------
;; 项目管理
;; ---------------------------------------------------------
(use-package projectile
  
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;;
;;; 工作区
(use-package perspective
  :demand t
  :bind (("C-M-k" . persp-switch)
         ("C-M-n" . persp-next)
         ("C-x k" . persp-kill-buffer*))
  :custom
  (persp-initial-frame-name "Main")
  :config
  ;; Running `persp-mode' multiple times resets the perspective list...
  (unless (equal persp-mode t)
    (persp-mode)))

(use-package super-save
  :defer 1
  :diminish super-save-mode
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

;; (use-package magit
;;   :bind ("C-M-;" . magit-status)
;;   :commands (magit-status magit-get-current-branch)
;;   :custom
;;   (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(provide 'module-project)
