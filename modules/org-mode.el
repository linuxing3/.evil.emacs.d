;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `现代基本配置'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defun +modern-org-config-h()
  (interactive)
  ;; 设定`org的目录'
  (defvar org-directory-default nil
    "whether use org directory in default location")
  (if org-directory-default
      (setq org-directory (expand-file-name "org" home-directory))
    (setq org-directory (dropbox-path "org")))
  ;; 设定`journal的目录'
  (defvar org-journal-base-dir nil
    "Netlify gridsome base directory")
  (setq org-journal-base-dir (dropbox-path "org/journal"))
  ;; 设定`todo关键字'
  (setq org-todo-keywords '((sequence "[学习](s)" "[待办](t)" "[等待](w)" "|" "[完成](d)" "[取消](c)")
                            (sequence "[BUG](b)" "[新事件](i)" "[已知问题](k)" "[修改中](W)" "|" "[已修复](f)")))
  ;; 设定`agenda相关目录'
  (with-eval-after-load 'org
    (setq diary-file (dropbox-path "org/diary"))
    (setq
     org-agenda-diary-file (dropbox-path "org/diary")
     org-agenda-files (directory-files org-directory t "\\.agenda\\.org$" t))
    (setq org-archive-location (dropbox-path "org/archived/%s_archive::"))))

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `现代Babel配置'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defun +modern-babel-config-h()
  (interactive)
  (with-eval-after-load 'org
    (org-babel-do-load-languages
     (quote org-babel-load-languages)
     (quote ((emacs-lisp . t)
	         (java . t)
	         (dot . t)
	         (ditaa . t)
	         (plantuml . t)
	         (python . t)
	         (go . t)
	         (gnuplot . t)
	         (org . t)
	         (latex . t))))))

(defun +org-init-appearance-h ()
  "Configures the UI for `org-mode'."
  (setq
   org-modules (quote (org-habit org-protocol org-man org-toc org-bookmark)))

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

  (setq-default org-display-custom-times t)
  (setq org-time-stamp-custom-formats '("<%a %b %e %Y>" . "<%a %b %e %Y %H:%M>"))
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

  (setq org-reverse-note-order t)
  (setq org-refile-allow-creating-parent-nodes 'confirm)
  (setq org-refile-use-cache nil)
  (setq org-blank-before-new-entry nil)
  (setq org-refile-targets
        '((nil :maxlevel . 3)
          (org-agenda-files :maxlevel . 3))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil))

(defun +org-init-babel-h ()
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
  (define-key org-src-mode-map (kbd "C-c C-c") #'org-edit-src-exit))

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `启动配置'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(add-hook 'org-load-hook #'+org-init-appearance-h)
(add-hook 'org-load-hook #'+org-init-babel-h)
(add-hook 'org-load-hook #'+modern-org-config-h)
(add-hook 'org-load-hook #'+modern-babel-config-h)

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; `加载现代美化配置'
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(load-file "~/EnvSetup/config/evil-emacs/modules/+fancy-org-mode.el")
