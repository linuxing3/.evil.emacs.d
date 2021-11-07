 ;;;===========================================
;;;					模块介绍
;;; 用户交互界面模块
;;;===========================================
;; ---------------------------------------------------------
(global-hl-line-mode 1)

;;; Code:

(defun +modern-ui-emojify-h ()
  "Set Font for Emoji and symbol"
  (set-fontset-font
   t
   '(#x1f300 . #x1fad0)
   (cond
    ((member "Symbola" (font-family-list)) "Symbola")
    ((member "Noto Color Emoji" (font-family-list)) "Noto Color Emoji")
    ((member "Noto Emoji" (font-family-list)) "Noto Emoji")
    ((member "Segoe UI Emoji" (font-family-list)) "Segoe UI Emoji")
    ((member "Apple Color Emoji" (font-family-list)) "Apple Color Emoji"))
   )
  (set-fontset-font
   t
   'symbol
   (cond
    ((string-equal system-type "windows-nt")
     (cond
      ((member "Symbola" (font-family-list)) "Symbola")))
    ((string-equal system-type "darwin")
     (cond
      ((member "Apple Symbols" (font-family-list)) "Apple Symbols")))
    ((string-equal system-type "gnu/linux")
     (cond
      ((member "Symbola" (font-family-list)) "Symbola")))))
  )

(defun +modern-ui-chinese-h ()
  "Set Font for chinese language"
  (set-fontset-font
   t
   'han
   (cond
    ((string-equal system-type "windows-nt")
     (cond
      ((member "Microsoft YaHei UI" (font-family-list)) "Microsoft YaHei UI")
      ;;((member "SimHei" (font-family-list)) "SimHei")
      ;;((member "Microsoft JhengHei" (font-family-list)) "Microsoft JhengHei")
      ))
    ((string-equal system-type "darwin")
     (cond
      ((member "Hei" (font-family-list)) "Hei")
      ((member "Heiti SC" (font-family-list)) "Heiti SC")
      ((member "Heiti TC" (font-family-list)) "Heiti TC")))
    ((string-equal system-type "gnu/linux")
     (cond
      ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei"))))))
;; (set-fontset-font "fontset-default" 'han "Microsoft YaHei UI")

;; 切换buffer焦点时高亮动画
(use-package beacon
  :disabled
  :ensure t
  :hook (after-init . beacon-mode))

;; 表情符号
(use-package emojify
  :ensure t
  :custom (emojify-emojis-dir (dropbox-path "config/emacs/emojis")))

;; 浮动窗口支持
(use-package posframe
  :ensure t
  :custom
  (posframe-mouse-banish nil))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-dracula t))

(use-package spacemacs-theme)

;; All The Icons
(use-package all-the-icons :ensure t)

;; dired模式图标支持
(use-package all-the-icons-dired
  :ensure t
  :hook ('dired-mode . 'all-the-icons-dired-mode))

;; 让info帮助信息中关键字有高亮
(use-package info-colors
  :ensure t
  :hook ('Info-selection-hook . 'info-colors-fontify-node))

;; 缩进线
(use-package highlight-indent-guides
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'bitmap))

;; 彩虹猫进度条
(use-package nyan-mode
  :if (not (boundp 'awesome-tray-mode))
  :ensure t
  :hook (after-init . nyan-mode)
  :config
  (setq nyan-wavy-trail t
		nyan-animate-nyancat t))
;; 竖线
(use-package page-break-lines
  :ensure t
  :hook (after-init . global-page-break-lines-mode)
  :config
  (set-fontset-font "fontset-default"
                    (cons page-break-lines-char page-break-lines-char)
                    (face-attribute 'default :family))
  (let ((table (make-char-table nil)))                   ;; make a new empty table
    (set-char-table-parent table char-width-table)       ;; make it inherit from the current char-width-table
    (set-char-table-range table page-break-lines-char 1) ;; let the width of page-break-lines-char be 1
    (setq char-width-table table)))
;; Powerline
(use-package spaceline
  :ensure t
  :init
  (setq powerline-default-separator 'slant)
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-evil-state-on))


;; bootstrap
(+modern-ui-emojify-h)
(+modern-ui-chinese-h)

;; 为上层提供 init-ui 模块
(provide 'linuxing3-init-ui)
