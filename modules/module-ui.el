;;; module-ui.el -*- lexical-binding: t; -*-

;;; Code:
;;;===========================================
;;;					模块介绍
;;; 用户交互界面模块
;;;===========================================
;; ---------------------------------------------------------
;;
;;; General UX

;; Don't prompt for confirmation when we create a new file or buffer (assume the
;; user knows what they're doing).
(setq confirm-nonexistent-file-or-buffer nil)

(setq uniquify-buffer-name-style 'forward
      ;; no beeping or blinking please
      ring-bell-function #'ignore
      visible-bell nil)

;; middle-click paste at point, not at click
(setq mouse-yank-at-point t)

;; 为上层提供 init-ui 模块
(provide 'module-ui)
