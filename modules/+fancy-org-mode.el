;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; +fancy-org-model.el
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂


;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 📷 Capture配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(use-package org
  :config
  (defun +modern-org-html-quote2 (block backend info)
    (when (org-export-derived-backend-p backend 'html)
      (when (string-match "\\`<div class=\"quote2\">" block)
        (setq block (replace-match "<blockquote>" t nil block))
        (string-match "</div>\n\\'" block)
        (setq block (replace-match "</blockquote>\n" t nil block))
        block)))
  (eval-after-load 'ox
    '(add-to-list 'org-export-filter-special-block-functions '+modern-org-html-quote2))
  (defun get-year-and-month ()
    (list (format-time-string "%Y") (format-time-string "%m")))
  (defun find-month-tree ()
    (let* ((path (get-year-and-month))
           (level 1)
           end)
      (unless (derived-mode-p 'org-mode)
        (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
      (goto-char (point-min))           ;移动到 buffer 的开始位置
      ;; 先定位表示年份的 headline，再定位表示月份的 headline
      (dolist (heading path)
        (let ((re (format org-complex-heading-regexp-format
                          (regexp-quote heading)))
              (cnt 0))
          (if (re-search-forward re end t)
              (goto-char (point-at-bol)) ;如果找到了 headline 就移动到对应的位置
            (progn                       ;否则就新建一个 headline
              (or (bolp) (insert "\n"))
              (if (/= (point) (point-min)) (org-end-of-subtree t t))
              (insert (make-string level ?*) " " heading "\n"))))
        (setq level (1+ level))
        (setq end (save-excursion (org-end-of-subtree t t))))
      (org-end-of-subtree)))
  (defun random-alphanum ()
    (let* ((charset "abcdefghijklmnopqrstuvwxyz0123456789")
           (x (random 36)))
      (char-to-string (elt charset x))))
  (defun create-password ()
    (let ((value ""))
      (dotimes (number 16 value)
        (setq value (concat value (random-alphanum))))))
  (defun get-or-create-password ()
    (setq password (read-string "Password: "))
    (if (string= password "")
        (create-password)
      password))
  (defun org-capture-template-goto-link ()
    (org-capture-put :target (list 'file+headline
                                   (nth 1 (org-capture-get :target))
                                   (org-capture-get :annotation)))
    (org-capture-put-target-region-and-position)
    (widen)
    (let ((hd (nth 2 (org-capture-get :target))))
      (goto-char (point-min))
      (if (re-search-forward
           (format org-complex-heading-regexp-format (regexp-quote hd)) nil t)
          (org-end-of-subtree)
        (goto-char (point-max))
        (or (bolp) (insert "\n"))
        (insert "* " hd "\n"))))
  (defun generate-anki-note-body ()
    (interactive)
    (message "Fetching note types...")
    (let ((note-types
           (sort (anki-editor--anki-connect-invoke-result "modelNames" 5)
                 #'string-lessp))
          note-type fields)
      (setq note-type (completing-read "Choose a note type: " note-types))
      (message "Fetching note fields...")
      (setq fields (anki-editor--anki-connect-invoke-result
                    "modelFieldNames" 5
                    `((modelName . ,note-type))))
      (concat "  :PROPERTIES:\n"
              "  :ANKI_NOTE_TYPE: " note-type "\n"
              "  :END:\n\n"
              (mapconcat (lambda (str) (concat "** " str))
                         fields
                         "\n\n"))))
  ;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
  ;; Capture template 以下是抓取模板
  ;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
  (setq org-capture-templates nil)
  (add-to-list 'org-capture-templates '("x" "Extra → → → → → → → → → → →  → → → → "))

  ;; `生活学习相关模板'
  (setq anki-org-file (dropbox-path "org/anki.org"))
  (add-to-list 'org-capture-templates
               `("xv"
                 "🏁 Vocabulary"
                 entry
                 (file+headline anki-org-file "Vocabulary")
                 ,(concat "* %^{heading} :note:\n"
                          "%(generate-anki-note-body)\n")))
  (setq snippets-org-file (dropbox-path "org/snippets.org"))
  (add-to-list 'org-capture-templates
               '("xs"
                 "🐞 Snippets"
                 entry
                 (file snippets-org-file)
                 (file "~/EnvSetup/config/org/capture-template/snippet.template")
                 ;; "* %?\t%^g\n #+BEGIN_SRC %^{language}\n\n#+END_SRC"
                 :kill-buffer t))
  (setq billing-org-file (dropbox-path "org/billing.org"))
  (add-to-list 'org-capture-templates
               '("xb"
                 "💰 Billing"
                 plain
                 (file+function billing-org-file find-month-tree)
                 (file "~/EnvSetup/config/org/capture-template/billing.template")
                 ;; " | %U | %^{类别} | %^{描述} | %^{金额} |"
                 :kill-buffer t))

  (setq contacts-org-file (dropbox-path "org/contacts.org"))
  (add-to-list 'org-capture-templates
               '("xc"
                 "😂 Contacts"
                 entry
                 (file contacts-org-file)
                 (file "~/EnvSetup/config/org/capture-template/contact.template")
                 ;; "* %^{姓名} %^{手机号}p %^{邮箱}p %^{住址}p %^{微信}p %^{微博}p %^{whatsapp}p\n\n  %?"
                 :empty-lines 1 :kill-buffer t))

  (setq password-org-file (dropbox-path "org/password.cpt.org"))
  (add-to-list 'org-capture-templates
               '("xp"
                 "Passwords"
                 entry
                 (file password-org-file)
                 "* %U - %^{title} %^G\n\n  - 用户名: %^{用户名}\n  - 密码: %(get-or-create-password)"
                 :empty-lines 1 :kill-buffer t))

  ;; `发布博客和日志相关'
  (setq blog-org-dir (dropbox-path "org/journal/"))
  (add-to-list 'org-capture-templates
               `("xh"
                 "🏁 Hugo"
                 plain
                 (file ,(concat blog-org-dir (format-time-string "%Y%m%d.md"))) ;; Markdown file
                 ,(concat "---
title: %^{Title}
date: %U
author: %^{Author}
tags: %^{Tags | emacs | code | vim | study | life | misc }
---

** %?")))

  (add-to-list 'org-capture-templates
               `("xx"
                 "🏁 Blog"
                 plain
                 (file ,(concat blog-org-dir (format-time-string "%Y%m%d.org"))) ;; Org file
                 ,(concat "#+DATE: %U
#+TITLE: %^{Title}
#+AUTHOR: linuxing3
#+EMAIL: linuxing3@qq.com
#+DATE: %U
#+OPTIONS: ':t *:t -:t ::t <:t H:3 \\n:nil ^:t arch:headline author:t c:nil
#+OPTIONS: creator:comment d:(not LOGBOOK) date:t e:t email:nil f:t inline:t
#+OPTIONS: num:t p:nil pri:nil stat:t tags:t tasks:t tex:t timestamp:t toc:t
#+OPTIONS: todo:t |:t
#+CREATOR: Emacs 26.3.50.3 (Org mode 8.0.3)
#+DESCRIPTION:
#+EXCLUDE_TAGS: noexport
#+KEYWORDS:
#+LANGUAGE: en
#+SELECT_TAGS: export

%?")))

  ;; Protocol Group
  (setq links-org-file (dropbox-path "org/links.org"))
  (add-to-list 'org-capture-templates
               '("l"
                 "❉ Temp Links from the interwebs"
                 entry
                 (file+headline links-org-file "Bookmarks")
                 "* %t %:description\nlink: %l \n\n%i\n"
                 :kill-buffer nil))

  (add-to-list 'org-capture-templates
               '("a"
                 "❉ Protocol Annotation"
                 plain
                 (file+function links-org-file org-capture-template-goto-link)
                 " %^{Title}\n  %U - %?\n\n  %:initial"
                 :empty-lines 1))

  ;; `工作+个人+家人+行事历相关'
  (add-to-list 'org-capture-templates '("t" "Tasks → → → → → → → → → → → → → → →"))

  (setq daniel-org-file (dropbox-path "org/daniel.agenda.org"))
  (add-to-list 'org-capture-templates
               '("ts"                                              ; hotkey
                 "👦 Son's Task"                               ; title
                 entry                                             ; type
                 (file+headline daniel-org-file "Task") ; target
                 (file "~/EnvSetup/config/org/capture-template/todo.template")))
  (setq lulu-org-file (dropbox-path "org/lulu.agenda.org"))
  (add-to-list 'org-capture-templates
               '("tl"
                 "👩 Wife Lulu's Task"
                 entry
                 (file+headline lulu-org-file "Task")
                 (file "~/EnvSetup/config/org/capture-template/todo.template")))
  (setq my-org-file (dropbox-path "org/xingwenju.agenda.org"))
  (add-to-list 'org-capture-templates
               '("tr"
                 "☠ My Book Reading Task"
                 entry
                 (file+headline my-org-file "Reading")
                 "** TODO %^{书名}\n%u\n%a\n"
                 :immediate-finish t))
  (setq projects-org-file (dropbox-path "org/projects.agenda.org"))
  (add-to-list 'org-capture-templates
               '("tp"
                 "📓 My Work Projects"
                 entry
                 (file projects-org-file)
                 (file "~/EnvSetup/config/org/capture-template/project.template")
                 :empty-line 1))
  (setq works-org-file (dropbox-path "org/works.agenda.org"))
  (add-to-list 'org-capture-templates
               '("tw"
                 "⏰ My Work Task"
                 entry
                 (file+headline works-org-file "Work")
                 (file "~/EnvSetup/config/org/capture-template/basic.template")
                 :immediate-finish t))

  ;; `常用快捷抓取模板'
  (setq phone-org-file (dropbox-path "org/phone.org"))
  (add-to-list 'org-capture-templates
               '("P"
                 "📱 My Phone calls"
                 entry
                 (file+headline phone-org-file "Phone Calls")
                 (file "~/EnvSetup/config/org/capture-template/phone.template")
                 :immediate-finish t
                 :new-line 1))

  (setq habit-org-file (dropbox-path "org/habit.agenda.org"))
  (add-to-list 'org-capture-templates
               '("h"
                 "🎶 My Habit"
                 entry
                 (file habit-org-file)
                 (file "~/EnvSetup/config/org/capture-template/habit.template")
                 ;; "* %^{Habit cards|music|balls|games}\n  %?"
                 :immediate-finish t
                 :new-line 1))

  (setq notes-org-file (dropbox-path "org/notes.agenda.org"))
  (add-to-list 'org-capture-templates
               '("n"
                 "❉ My Notes"
                 entry
                 (file notes-org-file)
                 (file "~/EnvSetup/config/org/capture-template/notes.template")
                 ;; "* %^{Loggings For...} %t %^g\n  %?"
                 :immediate-finish t
                 :new-line 1))

  (setq inbox-org-file (dropbox-path "org/inbox.agenda.org"))
  (add-to-list 'org-capture-templates
               '("i"
                 "⏰ My GTD Inbox"
                 entry
                 (file inbox-org-file)
                 (file "~/EnvSetup/config/org/capture-template/inbox.template")
                 ;; "* [#%^{Priority}] %^{Title} %^g\n SCHEDULED:%U %?\n"
                 :immediate-finish t
                 :new-line 1))
  ;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
  )

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 📅 Agenda 配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(use-package org-super-agenda
  :commands (org-super-agenda-mode)
  :config)

(with-eval-after-load 'org-agenda
  (defun evan/agenda-icon-material (name)
    "返回一个all-the-icons-material图标"
    (list (all-the-icons-material name)))
  (org-super-agenda-mode)
  (setq org-agenda-category-icon-alist
        `(
          ;; 学习相关
          ("待办" ,(evan/agenda-icon-material "check_box") nil nil :ascent center)
          ("学习" ,(evan/agenda-icon-material "book") nil nil :ascent center)
          ("等待" ,(evan/agenda-icon-material "ac_unit") nil nil :ascent center)
          ("完成" ,(evan/agenda-icon-material "done") nil nil :ascent center)
          ;; 代码相关
          ("取消" ,(evan/agenda-icon-material "cancel") nil nil :ascent)
          ("BUG" ,(evan/agenda-icon-material "bug_report") nil nil :ascent center)
          ("新事件" ,(evan/agenda-icon-material "new_releases") nil nil :ascent center)
          ("已知问题" ,(evan/agenda-icon-material "comment") nil nil :ascent center)
          ("修改中" ,(evan/agenda-icon-material "adjust") nil nil :ascent center)
          ("已修复" ,(evan/agenda-icon-material "thumb_up") nil nil :ascent center)))
  ;; agenda 里面时间块彩色显示
  ;; From: https://emacs-china.org/t/org-agenda/8679/3
  (defun ljg/org-agenda-time-grid-spacing ()
    "Set different line spacing w.r.t. time duration."
    (save-excursion
      (let* ((background (alist-get 'background-mode (frame-parameters)))
             (background-dark-p (string= background "dark"))
             (colors (list "#1ABC9C" "#2ECC71" "#3498DB" "#9966ff"))
             pos
             duration)
        (nconc colors colors)
        (goto-char (point-min))
        (while (setq pos (next-single-property-change (point) 'duration))
          (goto-char pos)
          (when (and (not (equal pos (point-at-eol)))
                     (setq duration (org-get-at-bol 'duration)))
            (let ((line-height (if (< duration 30) 1.0 (+ 0.5 (/ duration 60))))
                  (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
              (overlay-put ov 'face `(:background ,(car colors)
                                                  :foreground
                                                  ,(if background-dark-p "black" "white")))
              (setq colors (cdr colors))
              (overlay-put ov 'line-height line-height)
              (overlay-put ov 'line-spacing (1- line-height))))))))

  (add-hook 'org-agenda-finalize-hook #'ljg/org-agenda-time-grid-spacing)

  (setq org-agenda-custom-commands
        '(
          ;; My grouped tasks
          ("x"
           "📅 My Super view"
           (
            (todo "" ((org-agenda-overriding-header "********** 📅 *********** 📅 ************** 📅 *********** 📅 **************")
                      (org-super-agenda-groups '((:discard (:anything))))))
            (agenda "" (
                        (org-agenda-overriding-header "📅 我的日程 ")
                        (org-super-agenda-groups
                         '(
                           (:name none :time-grid t)
                           (:discard (:anything t))
                           ))))
            (todo "" ((org-agenda-overriding-header "Tips: [x]退出 [o]最大化 [d]日 [w]周 [m/u]标记/取消 [*/U]全标/取反 [r]重复")
                      (org-super-agenda-groups '((:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "Tips: [B]批处理 → [$]存档 [t]状态 [+/-]标签 [s]开始 [d]截止 [r]转存")
                      (org-super-agenda-groups '((:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "Tips: [t]状态 [,/+/-]优先级 [:]标签 [I/O]时钟 [e]耗时")
                      (org-super-agenda-groups '((:discard (:anything))))))
            (todo "" (
                      (org-agenda-overriding-header "🐧 待办清单 ")
                      (org-super-agenda-groups
                       '(
                         (:name "⚡ 重要任务 Important" :priority "A")
                         (:name "🚀 其他任务 Others"
                                :priority<= "B"
                                :scheduled today
                                :order 1)
                         (:discard (:anything t))
                         ))))
            ))
          ;; My GTD tasks
          ("u"
           "📆 My GTD view"
           (
            (todo "" (
                      (org-agenda-overriding-header "❉ Get Things Done ❉")
                      (org-super-agenda-groups
                       '(
                         (:name "马上去做 Quick Picks"
                                :effort< "0:30")
                         (:name none)
                         (:name "★ 重要任务 Important"
                                :priority "A")
                         (:name none)
                         (:name "↑ ↓ 其他任务 Others"
                                :priority<= "B"
                                :scheduled today
                                :order 1)
                         (:discard (:anything t))))))
            (todo "" (
                      (org-agenda-overriding-header "★ All Projects")
                      (org-super-agenda-groups
                       '(
                         (:name none  ; Disable super group header
                                :children todo)
                         (:discard (:anything t))))))))
          ;; Daniel's tasks
          ("d"
           "👦 儿子的行事历"
           (
            (todo "" (
                      (org-agenda-overriding-header "👦 儿子的行事历")
                      (org-super-agenda-groups
                       '(
                         (:name "daniel" :tag ("@daniel" "@kid"))
                         (:discard (:anything t))))))))
          ;; End
          ("e"
           "💻 电脑"
           (
            (todo "" (
                      (org-agenda-overriding-header "💻 电脑")
                      (org-super-agenda-groups
                       `(
                         (:name "电脑相关" :tag ("COMPUTER" "@computer"))
                         (:discard (:anything t)))))))))))

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; ☀ 美化配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(use-package org-superstar
  :ensure t
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (set-face-attribute 'org-superstar-header-bullet nil :inherit 'fixed-pitched :height 180)
  :custom
  (org-superstar-headline-bullets-list '("☀" "☪" "☯" "✿" "→"))
  (setq org-ellipsis " ▼ "))

(use-package org-bullets
  :ensure t
  :init (add-hook 'org-mode-hook 'org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☀" "☪"  "☯"  "✿" "→"))
  )

(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "↑" "↓")))

(use-package org
  :config
  ;; 标签组
  (setq org-tag-alist (quote ((:startgroup)
                              ("@office" . ?o)
                              ("@home" . ?h)
                              ("@travel" . ?t)
                              ("@errand" . ?e)
                              ("PERSONAL" . ?p)
                              ("ME" . ?m)
                              ("KID" . ?k)
                              ("DANIEL" . ?d)
                              ("LULU" . ?l)
                              ("WORK" . ?w)
                              ("PROJECT" . ?p)
                              ("COMPUTER" . ?c)
                              ("PHONE" . ?P)
                              ("HABIT" . ?H)
                              (:endgroup)
                              ("party" . ?1)
                              ("internal" . ?2)
                              ("hr" . ?3)
                              ("finance" . ?4)
                              ("security" . ?5)
                              ("foreign" . ?6)
                              ("study" . ?7)
                              ("public" . ?8)
                              ("protocol" . ?9)
                              )))
  (setq org-tag-faces
        '(
          ("@home" . (:foreground "MediumBlue" :weight bold))
          ("@office" . (:foreground "Red" :weight bold))
          ("@travel" . (:foreground "ForestGreen" :weight bold))
          ("@erranda" . (:foreground "OrangeRed" :weight bold))
          ("DANIEL" . (:foreground "MediumBlue" :weight bold))
          ("LULU" . (:foreground "DeepPink" :weight bold))
          ("WORK" . (:foreground "OrangeRed" :weight bold))
          ("PROJECT" . (:foreground "OrangeRed" :weight bold))
          ("HABIT" . (:foreground "DarkGreen" :weight bold))
          ("COMPUTER" . (:foreground "ForestGreen" :weight bold))
          ("internal" . (:foreground "ForestGreen" :weight bold))
          ("party" . (:foreground "ForestGreen" :weight bold))
          ("hr" . (:foreground "ForestGreen" :weight bold))
          ("finance" . (:foreground "LimeGreen" :weight bold))
          ("study" . (:foreground "LimeGreen" :weight bold))
          ("public" . (:foreground "LimeGreen" :weight bold))
          ("protocol" . (:foreground "LimeGreen" :weight bold))))

  (set-face-attribute 'org-link nil
		              :weight 'normal
		              :background nil)
  (set-face-attribute 'org-code nil
		              :foreground "#a9a1e1"
		              :background nil)
  (set-face-attribute 'org-date nil
		              :foreground "#5B6268"
		              :background nil)
  (set-face-attribute 'org-level-1 nil
		              :foreground "steelblue2"
		              :background nil
		              :height 1.1
		              :weight 'normal)
  (set-face-attribute 'org-level-2 nil
		              :foreground "slategray2"
		              :background nil
		              :height 1.0
		              :weight 'normal)
  (set-face-attribute 'org-level-3 nil
		              :foreground "SkyBlue2"
		              :background nil
		              :height 1.0
		              :weight 'normal)
  (set-face-attribute 'org-level-4 nil
		              :foreground "DodgerBlue2"
		              :background nil
		              :height 1.0
		              :weight 'normal)
  (set-face-attribute 'org-level-5 nil
		              :weight 'normal)
  (set-face-attribute 'org-level-6 nil
		              :weight 'normal)
  (set-face-attribute 'org-document-title nil
		              :foreground "SlateGray1"
		              :background nil
		              :height 1.25
		              :weight 'bold)

  (setq org-list-demote-modify-bullet (quote (("+" . "-")
					                          ("*" . "-")
					                          ("1." . "-")
					                          ("1)" . "-")
					                          ("A)" . "-")
					                          ("B)" . "-")
					                          ("a)" . "-")
					                          ("b)" . "-")
					                          ("A." . "-")
					                          ("B." . "-")
					                          ("a." . "-")
					                          ("b." . "-"))))
  )
