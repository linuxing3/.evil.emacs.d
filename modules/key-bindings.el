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

;; ---------------------------------------------------------
;; Custom keybinding
;; ---------------------------------------------------------
(use-package general
  :config
  (general-define-key
   :states '(normal visual)
   "M-q" (if (daemonp) #'delete-frame #'evil-quit-all)
   "M-a" #'mark-whole-buffer
   "M-c" #'evil-yank
   "M-v" #'evil-paste-after
   "M-f" #'swiper
   "M-s" #'save-buffer
   "M-z" #'fill-paragraph)
  (general-define-key
   :states '(normal visual insert emacs)
   "C-o" #'open-with-external-app
   "C-s" #'save-buffer
   "C-w" #'kill-this-buffer
   "C-p" #'counsel-buffer-or-recentf
   "C-f" #'counsel-buffer-or-recentf
   "C-z" #'undo
   ))

;; ---------------------------------------------------------
;; Custom keybinding
;; ---------------------------------------------------------
(use-package general
  :ensure t
  :config
  (general-define-key
   :states '(normal emacs)
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
   :states '(normal emacs)
   :prefix "["
   "[" '(text-scale-decrease :which-key "decrease text")
   "t" '(hl-todo-previous :which-key "highlight previous todo")
   "h" '(smart-backward :which-key "jump backward")
   "b" '(prev-buffer :which-key "previous buffer"))
  (general-define-key
   :states '(normal emacs)
   :prefix "]"
   "[" '(text-scale-increase :which-key "next buffer")
   "t" '(hl-todo-next :which-key "highlight next todo")
   "l" '(smart-forward :which-key "jump forward")
   "b" '(switch-to-next-buffer :which-key "next buffer"))
  (general-define-key
   :states '(normal emacs)
   :prefix "SPC"
   "/" '(swiper :which-key "swiper")
   "I" '(imenu-anywhare :which-key "Imenu across buffers")
   "i" '(imenu :which-key "imenu"))
  )

;; ---------------------------------------------------------
;; Custom buffer keybinding
;; ---------------------------------------------------------
(use-package general
  :config
  (general-define-key
   :states '(normal emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "bn" '(evil-buffer-new :which-key "新建缓冲区")
   "bb" '(switch-to-buffer :which-key "切换缓冲区")
   "bB" '(switch-to-buffer :which-key "切换缓冲区")
   "bk" '(kill-this-buffer :which-key "杀死缓冲区")
   "bo" '(kill-this-buffer :which-key "杀死它缓冲")
   "bs" '(save-buffer :which-key "保存缓冲区")
   "b]" '(next-buffer :which-key "下一缓冲区")
   "b[" '(previous-buffer :which-key "上一缓冲区")
   ))

(use-package general
  :config
  (general-define-key
   :states '(normal)
   "zx" '(kill-this-buffer :which-key "杀死缓冲区")
   "zX" '(bury-buffer :which-key "去除缓冲区")
   "gR" '(eval-buffer :which-key "去除缓冲区")
   :states '(visual)
   "gr" '(eval-region :which-key "去除缓冲区")
   "gc" '(comment-or-uncomment-region :which-key "去除缓冲区")
   ))

;; ---------------------------------------------------------
;; Custom file keybinding
;; ---------------------------------------------------------
(use-package general
  :config
  (general-define-key
   :states '(normal emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "ff" '(find-file :which-key "找到打开文件")
   "f." '(find-file :which-key "找到打开文件")
   "f/" '(projectile-find-file :which-key "找到项目文件")
   "f?" '(counsel-file-jump :which-key "查找本地文件")
   "fd" '(dired :which-key "文件目录浏览")
   "fr" '(counsel-buffer-or-recentf :which-key "最近使用文件")
   "p/" '(projectile-find-file :which-key "打开项目文件")
   "pp" '(projectile-switch-project :which-key "切换项目文件")
   "pr" '(projectile-recentf :which-key "切换项目文件")
   "qq" '(evil-save-and-quit :which-key "保存并退出")
   ))

;; ---------------------------------------------------------
;; Custom yank keybinding
;; ---------------------------------------------------------
(use-package general
  :config
  (general-define-key
   :states '(normal emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "iy" '(yank-pop :which-key "From kill ring")
   "is" '(insert-snippets :which-key "From snippets")
   ))

;; ---------------------------------------------------------
;; Custom yank keybinding
;; ---------------------------------------------------------
(use-package general
  :config
  (general-define-key
   :states '(normal emacs)
   :prefix "SPC"
   :non-normal-prefix "M-SPC"
   "ab" '(browse-url-of-file :which-key "Default Browser")
   "an" '(neotree :which-key "Neotree Browser")
   ))

(use-package general
  :config
  (general-define-key
   :keymaps '(neotree-mode-map)
   :states '(normal)
   "c" '(neotree-create-node :which-key "创建")
   "r" '(neotree-rename-node :which-key "更名")
   "d" '(neotree-delete-node :which-key "删除")
   ))
