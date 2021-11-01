(provide 'xing-key-bindings)

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; ---------------------------------------------------------
;; Custom keybinding
;; ---------------------------------------------------------
(use-package general
  :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   "<f2>"  #'previous-buffer
   "<f3>"  #'next-buffer
   "<f4>"  #'treemacs ;;explore
   "<f5>"  #'eval-buffer
   "<f6>"  #'kill-buffer-and-window
   "<f7>"  #'split-window-right
   "<f8>"  #'format-all-buffer
   "<f9>"  #'org-capture
   "<f10>"  #'org-agenda
   "<f11>"  #'make-frame
   "<f12>"  #'xref-find-definitions-other-window
   ;; Navigation
   "C-h"     #'evil-window-left
   "C-j"     #'evil-window-down
   "C-k"     #'evil-window-up
   "C-l"     #'evil-window-right
   "C-w"     #'ace-window
   "C-S-w"   #'ace-swap-window
   ;; Delete window
   "M-c"   #'evil-yank     ;; 粘贴
   "M-q"   (if (daemonp) #'delete-frame #'evil-quit-all)
   "M-f"   #'swiper        ;; 查找
   "M-z"   #'fill-paragraph ;; 折行
   "M-s"   #'save-buffer   ;; 保存
   "M-r"   #'format-all-buffer
   ))


(use-package general
  :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "SPC" #'execute-extended-command
   "."   '(find-file :which-key "project find file")
   "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
   "#"   #'bookmark-set  ;; 设置书签
   "RET" #'bookmark-jump-other-window ;; 跳到书
   ;; Window
   "wl"  '(windmove-right :which-key "move right")
   "wh"  '(windmove-left :which-key "move left")
   "wk"  '(windmove-up :which-key "move up")
   "wj"  '(windmove-down :which-key "move bottom")
   "w/"  '(split-window-right :which-key "split right")
   "w-"  '(split-window-below :which-key "split bottom")
   "wx"  '(delete-window :which-key "delete window")
   "qz"  '(delete-frame :which-key "delete frame")
   "qq"  '(kill-emacs :which-key "quit"))
  (general-define-key
   :states '(normal visual emacs)
   :prefix "["
   "b" '(switch-to-prev-buffer :which-key "previous buffer"))
  (general-define-key
   :states '(normal visual emacs)
   :prefix "]"
   "b" '(switch-to-next-buffer :which-key "next buffer"))
  )
