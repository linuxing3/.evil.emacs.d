;; `general-define-key' is user-extensible and supports
;; defining multiple keys in multiple keymaps at once, implicitly wrapping key
;; strings with (kbd ...), using named prefix key sequences (like the leader key
;; in vim), and much more.

;; Since I let evil-mode take over `C-u' for buffer scrolling, I need to re-bind
;; the universal-argument command to another key sequence. I'm choosing `C-M-u'
;; for this purpose.
(global-set-key (kbd "C-M-u") 'universal-argument)

(use-package general
  :config
  ;;(general-evil-setup t)
  )

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " |> ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; `全局启动键'，绑定SPC
(general-create-definer global-space-definer
  :keymaps 'override
  :states  '(emacs normal hybrid motion visual operator)
  :prefix  "SPC"
  :non-normal-prefix "S-SPC")

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
 "C-w"     #'evil-window-next
 "C-q"     #'evil-window-delete
 "C-S-w"   #'evil-window-mru
 ;; Delete window
 "M-c"   #'evil-yank     ;; 粘贴
 "M-v"   #'evil-paste-after ;; 粘贴
 "M-f"   #'swiper        ;; 查找
 "M-z"   #'fill-paragraph ;; 折行
 "M-s"   #'save-buffer   ;; 保存
 "M-r"   #'format-all-buffer
 "M-u"   #'ivy-occur-mode
 "M-o"   #'ace-window
 "C-S-p"   #'eshell
 "C-S-s"   #'server-start
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
 :states '(normal visual emacs)
 "C-o" #'open-with-external-app
 "C-p" #'counsel-buffer-or-recentf
 "C-f" #'counsel-buffer-or-recentf
 "C-z" #'evil-undo
 "C-n" #'tab-bar-new-tab
 "C-w" #'tab-bar-close-tab
 "C-m" #'tab-bar-close-tab
 "C-S-z" #'evil-redo
 )

;; 以下快捷键需要先按SPC后出现
(global-space-definer
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
  "1"   '((lambda () (interactive) (tab-bar-select-tab 1)) :which-key "tab 1")
  "2"   '((lambda () (interactive) (tab-bar-select-tab 2)) :which-key "tab 2")
  "3"   '((lambda () (interactive) (tab-bar-select-tab 3)) :which-key "tab 3")
  "i" '(imenu :which-key "imenu")
  "r" '(counsel-linux-app :which-key "counsel app")
  "qq"  '(kill-emacs :which-key "kill emacs"))

(global-space-definer
  :states '(normal visual emacs)
  "j"   '(:ignore t :which-key "jump")
  "jj"  '(avy-goto-char :which-key "jump to char")
  "jw"  '(avy-goto-word-0 :which-key "jump to word")
  "jl"  '(avy-goto-line :which-key "jump to line"))

;; 嵌套菜单宏:
(defmacro +general-global-menu! (name infix-key &rest body)
  "Create a definer named +general-global-NAME wrapping global-space-definer.
Create prefix map: +general-global-NAME. Prefix bindings in BODY with INFIX-KEY."
  (declare (indent 2))
  `(progn
     (general-create-definer ,(intern (concat "+general-global-" name))
       :wrapping global-space-definer
       :prefix-map (quote ,(intern (concat "+general-global-" name "-map")))
       :infix ,infix-key
       :wk-full-keys nil
       "" '(:ignore t :which-key ,name))
     (,(intern (concat "+general-global-" name))
      ,@body)))


;; * Prefix Keybindings
;; :prefix can be used to prevent redundant specification of prefix keys
(general-define-key
 :prefix "C-c"
 ;; bind "C-c a" to 'org-agenda
 "a" 'org-agenda
 "b" 'counsel-bookmark
 "c" 'org-capture)

;; 以下快捷键需要先按SPC-<KEY>后出现

;; `buffers'
(+general-global-menu! "buffer" "b"
  "]" '(next-buffer :which-key "下一缓冲区")
  "[" '(switch-to-prev-buffer :which-key "上一缓冲区")
  "n" '(evil-buffer-new :which-key "新建缓冲区")
  "b" '(switch-to-buffer :which-key "切换缓冲区")
  "B" '(switch-to-buffer :which-key "切换缓冲区")
  "k" '(kill-this-buffer :which-key "杀死缓冲区")
  "K" '(kill-current-buffer :which-key "杀死缓冲区")
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

;; `tabs'
;; built-in keys:
;; gn -> next tab
;; gN -> pre tab
;; C-` -> switch tab
(+general-global-menu! "tab/magit" "g"
  "n" '(tab-bar-new-tab :which-key "New tab")
  "x" '(tab-bar-close-tab :which-key "Close tab")
  "w" '(tab-bar-close-tab :which-key "Close tab")
  "s" '(magit-status :which-key "Status"))

;; `files'
(+general-global-menu! "file" "f"
  "f" '(:ignore t :which-key "find file")
  "S" '((lambda () (interactive)
	  (progn
	    (+git-push "~/EnvSetup")
	    (+git-push "~/.scratch.emacs.d")
	    (+git-push "~/.evil.emacs.d")
	    (+git-push "~/org")
	    )) :which-key "push fundamental repos")
  "s" '((lambda () (interactive)
	  (progn
	    (+git-pull "~/EnvSetup")
	    (+git-pull "~/.scratch.emacs.d")
	    (+git-pull "~/.evil.emacs.d")
	    (+git-pull "~/org")
	    )) :which-key "pull fundamental repos")
  "v" '((lambda () (interactive) (find-file "~/VirtualBox VMs/coder")) :which-key "Virtualbox dir")
  "e" '((lambda () (interactive) (find-file "~/EnvSetup")) :which-key "EnvSetup dir")
  "o" '((lambda () (interactive) (find-file "~/org")) :which-key "org dir")
  "O" '((lambda () (interactive) (find-file "~/OneDrive")) :which-key "OneDrive dir")
  "w" '((lambda () (interactive) (find-file "~/workspace")) :which-key "workspace dir")
  "D" '((lambda () (interactive) (find-file "~/.doom.d")) :which-key "doom.d Dir")
  "M" '((lambda () (interactive) (find-file "~/.doom.emacs.d")) :which-key "doom.emacs.d Dir")
  "I" '((lambda () (interactive) (find-file "~/.emacs.d/init.el")) :which-key "emacs.d/init.el")
  "i" '((lambda () (interactive) (find-file "~/.evil.emacs.d/init.el")) :which-key "evil.emacs.d/init.el")
  "e" '((lambda () (interactive)
	  (if IS-WINDOWS
	      (find-file "~/emacs-repos/emacs-from-scratch/Emacs.org")
	    (find-file "~/.scratch.emacs.d/Emacs.org")))
	:which-key "scratch.emacs.d/Emacs.org")
  "." '(counsel-find-file :which-key "找到打开文件")
  "/" '(projectile-find-file :which-key "找到项目文件")
  "?" '(counsel-file-jump :which-key "查找本地文件")
  "d" '(dired :which-key "文件目录浏览")
  "r" '(counsel-buffer-or-recentf :which-key "最近使用文件"))

;; `windows'
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


;; NOTE: `org'功能模块
(+general-global-menu! "org" "o"
  "b" '((lambda () (interactive) (org-publish-project "emacs-config"))
        :which-key "Publish emacs config")
  "ip"  '(:ignore t :which-key "insert")
  "il" '(org-insert-link :which-key "insert link")
  "n"  '(org-toggle-narrow-to-subtree :which-key "toggle narrow")
  "s"  '(dw/counsel-rg-org-files :which-key "search notes")
  "a"  '(org-agenda :which-key "status")
  "t"  '(org-todo-list :which-key "todos")
  "c"  '(org-capture t :which-key "capture")
  "x"  '(org-export-dispatch t :which-key "export")
  "d" '(org-publish-project :which-key "Org Publish")
  "p" '(org-hugo-export-to-md :which-key "Org export Hugo")
  "c"  '(org-capture :which-key "Org Capture")
  "a"  '(org-agenda :which-key "Org agenda"))

;; NOTE: 向前的键
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
 "gc" '(comment-or-uncomment-region :which-key "切换注释")
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

;; `search'
(+general-global-menu! "search" "s"
  "a" '(counsel-fonts :which-key "fonts")
  "b" '(counsel-bookmark :which-key "bookmark")
  "c" '(counsel-colors-emacs :which-key "colors")
  "f" '(counsel-describe-function :which-key "function")
  "F" '(counsel-describe-face :which-key "face")
  "p" '(counsel-package :which-key "package")
  "r" '(counsel-rg :which-key "ripgrep")
  "s" '(save-buffer :which-key "save buffer")
  "u" '(counsel-unicode-char :which-key "unicode")
  "v" '(counsel-describe-variable :which-key "variable")
  "t" '(counsel-load-theme :which-key "themes"))

;; `project'
(+general-global-menu! "project" "p"
  "/" '(projectile-find-file :which-key "打开项目文件")
  "." '(projectile-find-file :which-key "打开项目文件")
  "p" '(projectile-switch-project :which-key "切换项目文件")
  "r" '(projectile-recentf :which-key "切换项目文件")
  "d" '(projectile-dired :which-key "切换项目目录")
  "D" '(projectile-dired-other-window :which-key "切换项目目录")
  "q" '(evil-save-and-quit :which-key "保存并退出"))

;; `code'
(+general-global-menu! "code" "e"
  "b" '(eval-buffer :which-key "Eval buffer")
  "e" '(eval-expression :which-key "Eval expression")
  "l" '(eval-last-sexp :which-key "Eval last expression")
  "s" '(+snippets/new :which-key "New Snippet")
  "i" '(yas-insert-snippet :which-key "Insert Snippet")
  "x" '(yas-expand-snippet :which-key "Expand Snippet")
  "p" '(pp-eval-last-sexp :which-key "PP Eval last expression")
  "r" '(eval-region :which-key "Eval region")
  "f" '(eval-defun :which-key "Eval funtion"))

;; `app'
(+general-global-menu! "app" "a"
  "b" '(browse-url-of-file :which-key "Default Browser")
  "n" '(toggle-neotree :which-key "Neotree Browser")
  ;; timer en place of pomodoro
  "t" '(:ignore t :which-key "Timer")
  "tt" '(org-timer-set-timer :which-key "Set timer")
  "ts" '(org-timer-start :which-key "Start timer")
  "tS" '(org-timer-stop :which-key "Stop timer")
  "tp" '(org-timer-pause-or-continue :which-key "Pause or continue timer")
  ;; hugo blog
  "h" '(:ignore t :which-key "Hugo blog")
  "hd" '(+modern-blog-hugo-deploy :which-key "Hugo deploy")
  "hs" '(+modern-blog-hugo-start-server :which-key "Hugo serer")
  "hk" '(+modern-blog-hugo-end-server :which-key "Hugo kill server")
  "hx" '(org-hugo-export-to-md :which-key "Export markdown")
  "ho" '((lambda () (interactive)
	   (progn (org-hugo-export-to-md) (+modern-blog-hugo-deploy))) :which-key "Export and deploy")
  ;; Prodiy service
  "p" '(:ignore t :which-key "Prodigy")
  "pb" '(prodigy :which-key "Prodigy Browse")
  "ps" '(prodigy-start :which-key "Prodigy start")
  "pS" '(prodigy-stop :which-key "Prodigy stop")
  ;; translate
  "y" '(youdao-dictionary-search-at-point :which-key "Seach youdao")
  )

;; `全局leader'键，使用SPC-m，获取特定major-mode的按键绑定
;; (general-create-definer global-space-m-leader
;;   :keymaps 'override
;;   :states '(emacs normal hybrid motion visual operator)
;;   :prefix "SPC m"
;;   "" '(:ignore t :which-key (lambda (arg)
;;                               `(,(cadr (split-string (car arg) " ")) .
;;                                 ,(replace-regexp-in-string "-mode$" "" (symbol-name major-mode))))))

;; `模式状态键'
(defconst my-leader "SPC m")

(general-create-definer space-m-leader-def
  :keymaps 'override
  :states '(normal)
  :prefix "SPC m")

;; Major-mode特定键
(space-m-leader-def
  :keymaps 'emacs-lisp-mode-map
  "e" '(:ignore t :which-key "eval")
  "eb" 'eval-buffer
  "ed" 'eval-defun
  "ee" 'eval-expression
  "ep" 'pp-eval-last-sexp
  "es" 'eval-last-sexp
  "i" 'elisp-index-search)

(space-m-leader-def
  :keymaps 'org-mode-map
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
  ;;:prefix "c"
  "c" '(:ignore t :which-key "clock")
  "cc" 'org-clock-cancel
  "cd" 'org-clock-mark-default-task
  "ce" 'org-clock-modify-effort-estimate
  "cE" 'org-set-effort
  "cg" 'org-clock-goto
  "ci" 'org-clock-in
  "cI" 'org-clock-in-last
  "co" 'org-clock-out
  "cr" 'org-resolve-clocks
  "cR" 'org-clock-report
  "ct" 'org-evaluate-time-range
  "c=" 'org-clock-timestamps-up
  "c-" 'org-clock-timestamps-down
  ;;:prefix "l"
  "l" '(:ignore t :which-key "link")
  "lc" 'org-cliplink
  "li" 'org-id-store-link
  "ll" 'org-insert-link
  "lL" 'org-insert-all-links
  "ls" 'org-store-link
  "lS" 'org-insert-last-stored-link
  "lt" 'org-toggle-link-display
  ;;:prefix "d"
  "d" '(:ignore t :which-key "date")
  "dd" #'org-deadline
  "ds" #'org-schedule
  "dt" #'org-time-stamp
  "dT" #'org-time-stamp-inactive
  ;;:prefix "s"
  "s" '(:ignore t :which-key "tree/subtree")
  "sa" #'org-toggle-archive-tag
  "sb" #'org-tree-to-indirect-buffer
  "sc" #'org-clone-subtree-with-time-shift
  "sd" #'org-cut-subtree
  "sh" #'org-promote-subtree
  "sj" #'org-move-subtree-down
  "sk" #'org-move-subtree-up
  "sl" #'org-demote-subtree
  "sn" #'org-narrow-to-subtree
  "sr" #'org-refile
  "ss" #'org-sparse-tree
  "sA" #'org-archive-subtree
  "sN" #'widen
  "sS" #'org-sort
  ;;:prefix "p"
  "p" '(:ignore t :which-key "priority")
  "pd" #'org-priority-down
  "pp" #'org-priority
  "pu" #'org-priority-up
  )

(defun +ivy-keybinds-h()
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
  (global-set-key (kbd "C-c F") 'counsel-org-file))

(+ivy-keybinds-h)

(provide 'core-keybinds)
