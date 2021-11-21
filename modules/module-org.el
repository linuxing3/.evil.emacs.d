;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `现代基本配置'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂

(setq
 org-modules (quote (org-habit
		     org-protocol
		     org-man
                     org-bibtex
                     org-crypt
                     org-id
                     org-info
                     org-crypt
		     org-toc
		     org-bookmark)))
;; For capture from web browser
(require 'org-protocol)

(defun linuxing3/org-gh-pull ()
  "Pull org files from github."
  (interactive)
  (+git-push org-directory))

(defun linuxing3/org-gh-push ()
  "Push org files to github"
  (interactive)
  (+git-pull org-directory))

(defun linuxing3/enable-ido-everywhere-h ()
					; Use IDO for both buffer and file completion and ido-everywhere to t
  (setq org-completion-use-ido t)
  (setq ido-everywhere t)
  (setq ido-max-directory-size 100000)
  (ido-mode (quote both))
					; Use the current window when visiting files and buffers with ido
  (setq ido-default-file-method 'selected-window)
  (setq ido-default-buffer-method 'selected-window)
					; Use the current window for indirect buffer display
  (setq org-indirect-buffer-display 'current-window)
  )

(defun linuxing3/org-config-h()
  ;; 设定`org的目录'
  (setq org-directory "~/org")
  ;; 设定`journal的目录'
  (defvar org-journal-base-dir nil
    "Netlify gridsome base directory")
  (setq org-journal-base-dir (workspace-path "awesome-hugo-blog/contents/journal"))
  ;; 设定`todo关键字'
  (setq org-todo-keywords '((sequence "[学习](s)" "[待办](t)" "[等待](w)" "|" "[完成](d)" "[取消](c)")
                            (sequence "[BUG](b)" "[新事件](i)" "[已知问题](k)" "[修改中](W)" "|" "[已修复](f)")))

  ;; 设定`hugo的目录'
  (setq org-hugo-base-dir (workspace-path "awesome-hugo-blog"))

  ;; 设定`agenda相关目录'
  (setq diary-file "~/org/diary")
  (setq org-agenda-diary-file "~/org/diary")

  (setq org-agenda-files (directory-files org-directory t "\\.agenda\\.org$" t))

  (setq org-archive-location "~/org/archived/%s_archive::")
  (setq org-return-follows-link t)
  (global-auto-revert-mode t)
  ;; onekey trigger state
  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  (setq org-timer-default-timer 25)
  (setq org-clock-sound "~/.evil.emacs.d/assets/music/music-box.wav"))

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `现代Babel配置'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defun linuxing3/babel-config-h()
  (setq org-src-preserve-indentation t  ; use native major-mode indentation
        org-src-tab-acts-natively t     ; we do this ourselves
        ;; You don't need my permission (just be careful, mkay?)
        org-confirm-babel-evaluate nil
        org-link-elisp-confirm-function nil
        ;; Show src buffer in popup, and don't monopolize the frame
        org-src-window-setup 'other-window
        ;; Our :lang common-lisp module uses sly, so...
        org-babel-lisp-eval-fn #'sly-eval)

  ;; I prefer C-c C-c over C-c ' (more consistent)
  ;; (define-key org-src-mode-map (kbd "C-c C-c") #'org-edit-src-exit)

  (with-eval-after-load 'org
    (org-babel-do-load-languages
     (quote org-babel-load-languages)
     (quote ((emacs-lisp . t)
	     (java . t)
	     (dot . t)
	     (ditaa . t)
	     (plantuml . t)
	     (python . t)
	     (sed . t)
	     (awk . t)
	     (ledger . t)
             (C . t)
             (shell . t)
             ;;(go . t)
             ;;(rust . t)
             ;;(deno . t)
	     (gnuplot . t)
	     (org . t)
	     (latex . t))))))

(defun linuxing3/appearance-config-h ()
  "Configures the UI for `org-mode'."

  (setq org-ellipsis " ▼ "
        org-bullets-bullet-list '(" ○ " " ◆ ")
        org-tags-column -80)

  (setq org-todo-keyword-faces
        '(
          ("[学习]" . (:foreground "GoldenRod" :weight bold))
          ("[待办]" . (:foreground "IndianRed1" :weight bold))
          ("[等待]" . (:foreground "OrangeRed" :weight bold))
          ("[完成]" . (:foreground "coral" :weight bold))
          ("[取消]" . (:foreground "LimeGreen" :weight bold))
          ("[BUG]" . (:foreground "GoldenRod" :weight bold))
          ("[新事件]" . (:foreground "IndianRed1" :weight bold))
          ("[已知问题]" . (:foreground "OrangeRed" :weight bold))
          ("[修改中]" . (:foreground "coral" :weight bold))
          ("[已修复]" . (:foreground "LimeGreen" :weight bold))
          ))

  ;; FIXME: 如果启用自定义时间格式，将无法在时间内部进行修改
  ;; (setq-default org-display-custom-times t)
  ;; (setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))
  (setq org-indirect-buffer-display 'current-window
        org-eldoc-breadcrumb-separator " → "
        org-enforce-todo-dependencies t
        org-entities-user
        '(("flat"  "\\flat" nil "" "" "266D" "♭")
          ("sharp" "\\sharp" nil "" "" "266F" "♯"))
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-fontify-whole-heading-line t
        org-hide-leading-stars t
        org-image-actual-width nil
        org-imenu-depth 6
        org-priority-faces
        '((?A . error)
          (?B . warning)
          (?C . success))
        org-startup-indented t
        org-tags-column 0
        org-use-sub-superscripts '{}
        org-startup-folded nil)
  (setq org-reverse-note-order t))


(defun linuxing3/refile-config-h ()
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-refile-use-cache nil)
  (setq org-blank-before-new-entry nil)
  (setq org-refile-targets
        '((nil :maxlevel . 3)
          (org-agenda-files :maxlevel . 3))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil)
					; Allow refile to create parent tasks with confirmation
  (defun linuxing3/verify-refile-target ()
    "Exclude todo keywords with a done state from refile targets"
    (not (member (nth 2 (org-heading-components)) org-done-keywords)))

  (setq org-refile-target-verify-function 'linuxing3/verify-refile-target))


;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `启动配置'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(linuxing3/org-config-h)
(linuxing3/refile-config-h)
(linuxing3/appearance-config-h)
(linuxing3/babel-config-h)

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `加载其他功能'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(setq package-selected-packages '(simple-httpd
				  evil-org
				  ox-hugo
				  org-journal
				  org-pomodoro
				  elfeed-org
				  ox-reveal
				  org-brain
				  org-download
				  htmlize))

(+ensure-package package-selected-packages)

;; essential
(require 'org+capture)
(require 'org+agenda)
(require 'org+pretty)

;; Enhance
(require 'org+block)
(require 'org+estimate)
(require 'org+project)
(require 'org+reminder)
(require 'org+speedcommands)

;; Application
(require 'org+hugo)
(require 'org+journal)
(require 'org+publish)
(require 'org+brain)
(require 'org+present)
(require 'org+roam)
(require 'org+elfeed)

;; keybinds 
(require 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)

;; Setup saves all org buffers at 1 minute before the hour using
;; the following code in my =.emacs=
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

(provide 'module-org)
