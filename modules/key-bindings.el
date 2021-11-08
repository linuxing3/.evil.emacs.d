;; `general-define-key' is user-extensible and supports
;; defining multiple keys in multiple keymaps at once, implicitly wrapping key
;; strings with (kbd ...), using named prefix key sequences (like the leader key
;; in vim), and much more.

(use-package general)

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; `全局启动键'，绑定SPC
(general-create-definer global-definer
  :keymaps 'override
  :states  '(insert emacs normal hybrid motion visual operator)
  :prefix  "SPC"
  :non-normal-prefix "S-SPC")

;; `全局leader'键，使用SPC-m，获取特定major-mode的按键绑定
(general-create-definer global-leader
  :keymaps 'override
  :states '(emacs normal hybrid motion visual operator)
  :prefix "SPC m"
  "" '(:ignore t :which-key (lambda (arg)
                              `(,(cadr (split-string (car arg) " ")) .
                                ,(replace-regexp-in-string "-mode$" "" (symbol-name major-mode))))))

(general-define-key
 :states '(normal visual insert emacs)
 "<f2>"  #'previous-buffer
 "<f3>"  #'next-buffer
 "<f4>"  #'treemacs ;;explore
 "<f5>"  #'eval-buffer
 "<f6>"  #'kill-buffer-and-window
 "<f7>"  #'split-window-right
 "<f8>"  #'format-all-buffer
 "<f9>"  #'counsel-org-capture
 "<f10>"  #'org-agenda
 "<f11>"  #'make-frame
 "<f12>"  #'xref-find-definitions-other-window
 ;; Navigation
 "C-h"     #'evil-window-left
 "C-j"     #'evil-window-down
 "C-k"     #'evil-window-up
 "C-l"     #'evil-window-right
 "C-w"     #'ace-window
 "C-q"     #'delete-window
 "C-S-w"   #'ace-swap-window
 ;; Delete window
 "M-c"   #'evil-yank     ;; 粘贴
 "M-f"   #'swiper        ;; 查找
 "M-z"   #'fill-paragraph ;; 折行
 "M-s"   #'save-buffer   ;; 保存
 "M-r"   #'format-all-buffer
 "M-o"   #'ivy-occur-mode
 "C-S-p"   #'eshell
 ;; increase font size
 "M-="       #'text-scale-increase
 "M--"       #'text-scale-decrease
 "M-N"       #'make-frame ;;创建新的帧
 "M-n"       #'evil-buffer-new ;;创建新缓存区
 "M-q"       #'evil-delete-buffer  ;; 删除缓冲区
 "C-M-f"     #'toggle-frame-fullscreen ;;全屏切换
 "M-w"       #'delete-window ;; 删除窗口
 "M-2"       #'split-window-right ;; 垂直分割窗口
 "M-1"       #'delete-window ;; 删除窗口
 "M-W"   (if (daemonp) #'delete-frame #'evil-quit-all) ;; 删除帧
 )

(general-define-key
 :states '(normal visual insert emacs)
 "M-/" #'comment-or-uncomment-region
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
 "C-d" #'kill-this-buffer
 "C-p" #'counsel-buffer-or-recentf
 "C-f" #'counsel-buffer-or-recentf
 "C-z" #'evil-undo
 )

;; 以下快捷键需要先按SPC后出现
(global-definer
  "SPC" '(execute-extended-command :which-key "extended Command")
  "."   '(counsel-find-file :which-key "project find file")
  "/" '(swiper :which-key "swiper")
  "#"   '(bookmark-set :which-key "set bookmark") ;; 设置书签
  "RET" '(counsel-bookmark :which-key "search bookmark") ;; 搜索书签
  "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
  "<" '(switch-to-buffer :which-key "switch buffer")
  "!"    '(shell-command :which-key "shell command")
  "`"   '(eval-expression :which-key "eval expression")
  ":"   '(eval-expression :which-key "eval expression")
  "i" '(imenu :which-key "imenu")
  "I" '(imenu-anywhare :which-key "imenu across buffers")
  "t"   '(load-theme :which-key "load theme")
  "s"   '(save-buffer :which-key "save buffer")
  "q"  '(kill-emacs :which-key "kill emacs"))

;; 嵌套菜单宏:
(defmacro +general-global-menu! (name infix-key &rest body)
  "Create a definer named +general-global-NAME wrapping global-definer.
Create prefix map: +general-global-NAME. Prefix bindings in BODY with INFIX-KEY."
  (declare (indent 2))
  `(progn
     (general-create-definer ,(intern (concat "+general-global-" name))
       :wrapping global-definer
       :prefix-map (quote ,(intern (concat "+general-global-" name "-map")))
       :infix ,infix-key
       :wk-full-keys nil
       "" '(:ignore t :which-key ,name))
     (,(intern (concat "+general-global-" name))
      ,@body)))

;; 以下快捷键需要先按SPC-<KEY>后出现

;; Buffers
(+general-global-menu! "buffer" "b"
  "]" '(next-buffer :which-key "下一缓冲区")
  "[" '(switch-to-prev-buffer :which-key "上一缓冲区")
  "n" '(evil-buffer-new :which-key "新建缓冲区")
  "b" '(switch-to-buffer :which-key "切换缓冲区")
  "B" '(switch-to-buffer :which-key "切换缓冲区")
  "k" '(kill-this-buffer :which-key "杀死缓冲区")
  "k" '(kill-current-buffer :which-key "杀死缓冲区")
  "s" '(save-buffer :which-key "保存缓冲区")
  "r"  '(rename-buffer :which-key "重命名缓冲")
  "M" '((lambda () (interactive) (switch-to-buffer "*Messages*"))
        :which-key "消息缓冲区")
  "s" '((lambda () (interactive) (switch-to-buffer "*scratch*"))
        :which-key "涂鸦缓冲区")
  "o" '((lambda () (interactive) (switch-to-buffer nil))
        :which-key "其他缓冲区")
  "TAB" '((lambda () (interactive) (switch-to-buffer nil))
          :which-key "其他缓冲区"))

(+general-global-menu! "file" "f"
  "f" '(counsel-find-file :which-key "找到打开文件")
  "." '(counsel-find-file :which-key "找到打开文件")
  "/" '(projectile-find-file :which-key "找到项目文件")
  "?" '(counsel-file-jump :which-key "查找本地文件")
  "d" '(dired :which-key "文件目录浏览")
  "r" '(counsel-buffer-or-recentf :which-key "最近使用文件"))

(+general-global-menu! "window" "w"
  "l"  '(windmove-right :which-key "move right")
  "h"  '(windmove-left :which-key "move left")
  "k"  '(windmove-up :which-key "move up")
  "j"  '(windmove-down :which-key "move bottom")
  "m"  '(maximize-window :which-key "move bottom")
  "/"  '(split-window-right :which-key "split right")
  "."  '(split-window-right :which-key "split right")
  "v"  '(split-window-right :which-key "split right")
  "-"  '(split-window-below :which-key "split bottom")
  "x"  '(delete-window :which-key "delete window")
  "d"  '(delete-window :which-key "delete window")
  "q"  '(delete-frame :which-key "delete frame"))

(+general-global-menu! "org" "o"
  "b" '((lambda () (interactive) (org-publish-project "emacs-config"))
        :which-key "Publish emacs config")
  "d" '(org-publish-project :which-key "Org Publish")
  "p" '(org-hugo-export-to-md :which-key "Org export Hugo")
  "c"  '(org-capture :which-key "Org Capture")
  "a"  '(org-agenda :which-key "Org agenda"))

;; 向前的键
(general-define-key
 :states '(normal emacs)
 :prefix "["
 "[" '(text-scale-decrease :which-key "decrease text scale")
 "t" '(hl-todo-previous :which-key "highlight previous todo")
 "h" '(smart-backward :which-key "jump backward")
 "b" '(switch-to-prev-buffer :which-key "previous buffer"))

;; 向后的键
(general-define-key
 :states '(normal emacs)
 :prefix "]"
 "]" '(text-scale-increase :which-key "increase text scale")
 "t" '(hl-todo-next :which-key "highlight next todo")
 "l" '(smart-forward :which-key "jump forward")
 "b" '(switch-to-next-buffer :which-key "next buffer"))

;; ∵ 快速快捷键
(general-define-key
 :states '(normal visual)
 "gc" '(evilnc-comment-operator :which-key "切换注释")
 "g0" '(imenu :which-key "互动菜单")
 "gx" '(evil-exchange-point-and-mark :which-key "互换文字")
 "g="  #'evil-numbers/inc-at-pt
 "g-"  #'evil-numbers/dec-at-pt
 "zx" '(kill-this-buffer :which-key "杀死缓冲区")
 "zX" '(bury-buffer :which-key "去除缓冲区")
 "eR" '(eval-buffer :which-key "运行缓冲区")
 :states '(visual)
 "er" '(eval-region :which-key "运行选定区域")
 "g="  #'evil-numbers/inc-at-pt-incremental
 "g-"  #'evil-numbers/dec-at-pt-incremental
 )

(+general-global-menu! "search" "s"
  "b" '(counsel-bookmark :which-key "bookmark")
  "r" '(counsel-rg :which-key "ripgrep")
  "s" '(counsel-fonts :which-key "fonts")
  "c" '(counsel-colors-emacs :which-key "colors")
  "u" '(counsel-unicode-char :which-key "unicode")
  "p" '(counsel-package :which-key "package")
  "v" '(counsel-describe-variable :which-key "variable")
  "F" '(counsel-describe-face :which-key "face")
  "f" '(counsel-describe-function :which-key "function")
  "t" '(counsel-load-theme :which-key "themes"))

(+general-global-menu! "project" "p"
  "/" '(projectile-find-file :which-key "打开项目文件")
  "." '(projectile-find-file :which-key "打开项目文件")
  "p" '(projectile-switch-project :which-key "切换项目文件")
  "r" '(projectile-recentf :which-key "切换项目文件")
  "d" '(projectile-dired :which-key "切换项目目录")
  "D" '(projectile-dired-other-window :which-key "切换项目目录")
  "q" '(evil-save-and-quit :which-key "保存并退出"))

(+general-global-menu! "code" "e"
  "b" '(eval-buffer :which-key "Eval buffer")
  "s" '(eval-last-sexp :which-key "Eval last expression")
  "p" '(pp-eval-last-sexp :which-key "PP Eval last expression")
  "r" '(eval-region :which-key "Eval region")
  "f" '(eval-defun :which-key "Eval funtion"))

(+general-global-menu! "app" "a"
  "b" '(browse-url-of-file :which-key "Default Browser")
  "n" '(neotree :which-key "Neotree Browser")
  )

;; Major-mode特定键
(use-package elisp-mode
  :ensure nil
  :general
  (global-leader
    ;;specify the major modes these should apply to:
    :major-modes
    '(emacs-lisp-mode lisp-interaction-mode t)
    ;;and the keymaps:
    :keymaps
    '(emacs-lisp-mode-map lisp-interaction-mode-map)
    "e" '(:ignore t :which-key "eval")
    "eb" 'eval-buffer
    "ed" 'eval-defun
    "ee" 'eval-expression
    "ep" 'pp-eval-last-sexp
    "es" 'eval-last-sexp
    "i" 'elisp-index-search))

(use-package org-mode
  :ensure nil
  :general
  (global-leader
    :major-modes '(org-mode t)
    :keymaps '(org-mode-map)
    "#" 'org-update-statistics-cookies
    "'" 'org-edit-special
    "*" 'org-ctrl-c-star
    "+" 'org-ctrl-c-minus
    "," 'org-switchb
    "." 'counsel-org-goto
    "/" 'counsel-org-goto-all
    "A" 'org-archive-subtree
    "e" 'org-export-dispatch
    "f" 'org-footnote-action
    "h" 'org-toggle-heading
    "i" 'org-toggle-item
    "I" 'org-id-get-create
    "n" 'org-store-link
    "o" 'org-set-property
    "q" 'org-set-tags-command
    "t" 'org-todo
    "T" 'org-todo-list
    "x" 'org-toggle-checkbox
    :prefix "c"
    "c" 'org-clock-cancel
    "d" 'org-clock-mark-default-task
    "e" 'org-clock-modify-effort-estimate
    "E" 'org-set-effort
    "g" 'org-clock-goto
    "i" 'org-clock-in
    "I" 'org-clock-in-last
    "o" 'org-clock-out
    "r" 'org-resolve-clocks
    "R" 'org-clock-report
    "t" 'org-evaluate-time-range
    "=" 'org-clock-timestamps-up
    "-" 'org-clock-timestamps-down
    ;; "l" '(:ignore t :which-key "link")
    :prefix "l"
    "c" 'org-cliplink
    "i" 'org-id-store-link
    "l" 'org-insert-link
    "L" 'org-insert-all-links
    "s" 'org-store-link
    "S" 'org-insert-last-stored-link
    "t" 'org-toggle-link-display
    :prefix "d"
    ;; "d" '(:ignore t :which-key "date")
    "d" #'org-deadline
    "s" #'org-schedule
    "t" #'org-time-stamp
    "T" #'org-time-stamp-inactive
    :prefix "s"
    ;; "t" '(:ignore t :which-key "tree/subtree")
    "a" #'org-toggle-archive-tag
    "b" #'org-tree-to-indirect-buffer
    "c" #'org-clone-subtree-with-time-shift
    "d" #'org-cut-subtree
    "h" #'org-promote-subtree
    "j" #'org-move-subtree-down
    "k" #'org-move-subtree-up
    "l" #'org-demote-subtree
    "n" #'org-narrow-to-subtree
    "r" #'org-refile
    "s" #'org-sparse-tree
    "A" #'org-archive-subtree
    "N" #'widen
    "S" #'org-sort
    :prefix "p"
    ;; "p" '(:ignore t :which-key "priority")
    "d" #'org-priority-down
    "p" #'org-priority
    "u" #'org-priority-up
    ))

(defun +ivy-bindings-h()
  ;; `Ivy-based' interface to shell and system tools
  (global-set-key (kbd "C-c c") 'counsel-compile)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c L") 'counsel-git-log)
  (global-set-key (kbd "C-c k") 'counsel-rg)
  (global-set-key (kbd "C-c m") 'counsel-linux-app)
  (global-set-key (kbd "C-c n") 'counsel-fzf)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-c J") 'counsel-file-jump)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (global-set-key (kbd "C-c w") 'counsel-wmctrl)
  ;; `Ivy-resume' and other commands
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "C-c b") 'counsel-bookmark)
  (global-set-key (kbd "C-c d") 'counsel-descbinds)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c o") 'counsel-outline)
  (global-set-key (kbd "C-c t") 'counsel-load-theme)
  (global-set-key (kbd "C-c F") 'counsel-org-file)
  )

(provide 'linuxing3-key-bindings)
