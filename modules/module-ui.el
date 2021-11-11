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

;; Enable mouse in terminal Emacs
(add-hook 'tty-setup-hook #'xterm-mouse-mode)

;; Global highlight current line
(global-hl-line-mode 1)


;;; Fringes
;; Reduce the clutter in the fringes; we'd like to reserve that space for more
;; useful information, like git-gutter and flycheck.
(setq indicate-buffer-boundaries nil
      indicate-empty-lines nil)

;; remove continuation arrow on right fringe
(delq! 'continuation fringe-indicator-alist 'assq)


;;; Windows
;; The native border "consumes" a pixel of the fringe on righter-most splits,
;; `window-divider' does not. Available since Emacs 25.1.
(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(add-hook 'prog-mode-hook #'window-divider-mode)

;; always avoid GUI
(setq use-dialog-box nil)
;; Don't display floating tooltips; display their contents in the echo-area,
;; because native tooltips are ugly.
(when (bound-and-true-p tooltip-mode)
  (tooltip-mode -1))
;; ...especially on linux
(when IS-LINUX
  (setq x-gtk-use-system-tooltips nil))

;; Favor vertical splits over horizontal ones. Screens are usually wide.
(setq split-width-threshold 160
      split-height-threshold nil)

;;
;;; Line numbers

;; Explicitly define a width to reduce computation
(setq-default display-line-numbers-width 3)

;; Show absolute line numbers for narrowed regions makes it easier to tell the
;; buffer is narrowed, and where you are, exactly.
(setq-default display-line-numbers-widen t)


;;
;;; Scrolling
(defun +modern-ui-scrolling-h ()
  "Help scrolling faster"
  (progn
    (setq frame-title-format '("%b –Evil Emacs")
          icon-title-format frame-title-format)
    (setq frame-resize-pixelwise t)
    (setq window-resize-pixelwise nil)
    (blink-cursor-mode -1)
    (setq hscroll-margin 2
          hscroll-step 1
          scroll-conservatively 101
          scroll-margin 0
          scroll-preserve-screen-position t
          auto-window-vscroll nil
          mouse-wheel-scroll-amount '(2 ((shift) . hscroll))
          mouse-wheel-scroll-amount-horizontal 2)))
;;
;;; Unicode

(defvar xing-unicode-font
  (if IS-MAC
      (font-spec :family "Apple Color Emoji")
    (font-spec :family "Symbola"))
  "Fallback font for unicode glyphs.")

;;
;;; Theme & font

;; Underline looks a bit better when drawn lower
(setq x-underline-at-descent-line t)
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
  ;; (load-theme 'doom-dracula t)
  )

(use-package spacemacs-theme
  :config
  (load-theme 'spacemacs-dark))

(use-package zerodark-theme
  :config
  (let ((class '((class color) (min-colors 89))))
    (custom-theme-set-faces
     'zerodark
     `(org-document-title
       ((,class (:height 1.3))))
     `(outline-1
       ((,class (:weight bold :height 1.2))))
     `(outline-2
       ((,class (:weight bold :height 1.1))))
     `(outline-3
       ((,class (:weight bold))))
     `(selectrum-current-candidate
       ((,class (:background "#48384c"
                             :weight bold
                             :foreground "#c678dd"))))
     `(selectrum-prescient-primary-highlight
       ((,class (:foreground "#da8548"))))
     `(selectrum-prescient-secondary-highlight
       ((,class (:foreground "#98be65"))))))
  (enable-theme 'zerodark)
  ;; (zerodark-setup-modeline-format)
  )

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

;;
;;; Powerline
(use-package spaceline
  :ensure t
  :init
  (setq powerline-default-separator 'slant)
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-evil-state-on))


(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :commands hl-todo-mode
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"  . ,(face-foreground 'warning))
          ("FIXME" . ,(face-foreground 'error))
          ("HACK"  . ,(face-foreground 'font-lock-constant-face))
          ("REVIEW"  . ,(face-foreground 'font-lock-keyword-face))
          ("NOTE"  . ,(face-foreground 'success))
          ("DEPRECATED" . ,(face-foreground 'font-lock-doc-face))))
  (when hl-todo-mode
        (hl-todo-mode -1)
        (hl-todo-mode +1)))


;; bootstrap
(+modern-ui-emojify-h)
(+modern-ui-chinese-h)

;; 为上层提供 init-ui 模块
(provide 'module-ui)
