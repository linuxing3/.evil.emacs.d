;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; Capture
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂

(defun my-insert-chrome-current-tab-url()
  "Get the URL of the active tab of the first window only work in Mac"
  (interactive)
  (insert (my-retrieve-chrome-current-tab-url)))

(defun my-retrieve-chrome-current-tab-url()
  "Get the URL of the active tab of the first window"
  (interactive)
  (let ((result (do-applescript
                 (concat
                  "set frontmostApplication to path to frontmost application\n"
                  "tell application \"Google Chrome\"\n"
                  "	set theUrl to get URL of active tab of first window\n"
                  "	set theResult to (get theUrl) \n"
                  "end tell\n"
                  "activate application (frontmostApplication as text)\n"
                  "set links to {}\n"
                  "copy theResult to the end of links\n"
                  "return links as string\n"))))
    (format "%s" (s-chop-suffix "\"" (s-chop-prefix "\"" result)))))

;; Kill the frame if one was created for the capture
(defvar linuxing3/delete-frame-after-capture 0 "Whether to delete the last frame after the current capture")

(defun linuxing3/delete-frame-if-neccessary (&rest r)
  (cond
   ((= linuxing3/delete-frame-after-capture 0) nil)
   ((> linuxing3/delete-frame-after-capture 1)
    (setq linuxing3/delete-frame-after-capture (- linuxing3/delete-frame-after-capture 1)))
   (t
    (setq linuxing3/delete-frame-after-capture 0)
    (delete-frame))))

(advice-add 'org-capture-finalize :after 'linuxing3/delete-frame-if-neccessary)
(advice-add 'org-capture-kill :after 'linuxing3/delete-frame-if-neccessary)
(advice-add 'org-capture-refile :after 'linuxing3/delete-frame-if-neccessary)

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 📷 Capture配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(use-package org
  :config
  (defun linuxing3/org-html-quote2 (block backend info)
    (when (org-export-derived-backend-p backend 'html)
      (when (string-match "\\`<div class=\"quote2\">" block)
        (setq block (replace-match "<blockquote>" t nil block))
        (string-match "</div>\n\\'" block)
        (setq block (replace-match "</blockquote>\n" t nil block))
        block)))
  (eval-after-load 'ox
    '(add-to-list 'org-export-filter-special-block-functions 'linuxing3/org-html-quote2))
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

  ;; TODO:
  ;; 配合emacs-client进行网页抓取
  ;; 更新注册表
  ;; ~/.evil.emacs.d/assets/scripts/org-protocol-emacs-client.reg
  ;; 设置chrome书签, 使用 l 抓取器
  ;; javascript:location.href='org-protocol://capture://l/'+ encodeURIComponent(location.href)+'/'+ encodeURIComponent(document.title)+'/'+encodeURIComponent(window.getSelection())
  (defadvice org-capture
      (after make-full-window-frame activate)
    "Advise capture to be the only window when used as a popup"
    (if (equal "emacs-capture" (frame-parameter nil 'name))
        (delete-other-windows)))

  (defadvice org-capture-finalize
      (after delete-capture-frame activate)
    "Advise capture-finalize to close the frame"
    (if (equal "emacs-capture" (frame-parameter nil 'name))
        (delete-frame)))
  ;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
  ;; Capture template 以下是抓取模板
  ;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
  (setq org-capture-templates nil)

  ;; `生活学习相关模板'
  (add-to-list 'org-capture-templates '("x" "Extra"))
  (setq anki-org-file "~/org/anki.org")
  (add-to-list 'org-capture-templates
               `("xv"
                 "Vocabulary"
                 entry
                 (file+headline anki-org-file "Vocabulary")
                 ,(concat "* %^{heading} :note:\n"
                          "%(generate-anki-note-body)\n")))
  (setq snippets-org-file "~/org/snippets.org")
  (add-to-list 'org-capture-templates
               '("xs"
                 "Snippets"
                 entry
                 (file snippets-org-file)
                 (file "~/.evil.emacs.d/assets/capture-template/snippet.template")
                 ;; "* %?\t%^g\n #+BEGIN_SRC %^{language}\n\n#+END_SRC"
                 :jump-to-captured t))
  (setq billing-org-file "~/org/billing.org")
  (add-to-list 'org-capture-templates
               '("xb"
                 "Billing"
                 plain
                 (file+function billing-org-file find-month-tree)
                 (file "~/.evil.emacs.d/assets/capture-template/billing.template")
                 ;; " | %U | %^{类别} | %^{描述} | %^{金额} |"
                 :jump-to-captured t))

  (setq contacts-org-file "~/org/contacts.org")
  (add-to-list 'org-capture-templates
               '("xc"
                 "Contacts"
                 entry
                 (file contacts-org-file)
                 (file "~/.evil.emacs.d/assets/capture-template/contact.template")
                 ;; "* %^{姓名} %^{手机号}p %^{邮箱}p %^{住址}p %^{微信}p %^{微博}p %^{whatsapp}p\n\n  %?"
                 :empty-lines 1
                 :kill-buffer t))

  (setq password-org-file (dropbox-path "org/password.cpt.org"))
  (add-to-list 'org-capture-templates
               '("xp"
                 "Passwords"
                 entry
                 (file password-org-file)
                 "* %U - %^{title} %^G\n\n  - 用户名: %^{用户名}\n  - 密码: %(get-or-create-password)"
                 :empty-lines 1
                 :kill-buffer t))

  ;; `发布博客和日志相关'
  (setq blog-org-dir  "~/workspace/awesome-hugo-blog/content/blog")
  (add-to-list 'org-capture-templates
               `("xh"
                 "Hugo Markdown Blog"
                 plain
                 (file ,(concat blog-org-dir (format-time-string "%Y-%m-%d.md"))) ;; Markdown file
                 (file "~/.evil.emacs.d/assets/capture-template/blog.template")
		 ))

  (add-to-list 'org-capture-templates
               `("xx"
                 "Roam Daily Notes"
                 plain
                 (file ,(concat "~/org/roam/daily/" (format-time-string "%Y-%m-%d.org"))) ;; Org file
                 (file "~/.evil.emacs.d/assets/capture-template/roamdaily.template")
		 ))

  ;; `Protocol' 网页抓取
  ;; 参考: https://www.zmonster.me/2018/02/28/org-mode-capture.html
  ;; 当用 org-protocol 触发 org-capture 时，它会设置 org-store-link-plist , 属性有六个，分别如下:
  ;; `type'	         链接的类型，如 http/https/ftp 等，是靠正则 (string-match "^\\([a-z]+\\):" url) 解析出来的
  ;; `link'	         链接地址，在 org-protocol 里的 url 字段
  ;; `description' 	 链接的标题，在 org-protocol 里的 title 字段
  ;; `annotation'	 靠 link 和 description 完成的 org 格式的链接
  ;; `initial'	     链接上选中的文本，在 org-protocol 里的 body 字段
  ;; `query'	     org-protocol 上除掉开头和子协议部分的剩下部分
  ;; "* %^{Title}\n\n  Source: %u, %c\n\n  %i"
  ;; "* %t %:description\nlink: %l \n\n%i\n"
  ;; "* %U - %:annotation"
  (setq links-org-file "~/org/links.org")
  (add-to-list 'org-capture-templates '("p" "Protocol"))
  ;; 最简单的情况是用 org-capture 来做`网页书签管理'，记录下`网页的标题和链接'
  (add-to-list 'org-capture-templates
               '("pb"
                 "Bookmark interwebs"
                 entry
                 (file+headline links-org-file "Bookmarks")
                 "** %? [[%:link][%:description]] \nCaptured On: %U"
                 :immediate-finish t
                 :jump-to-captured t
                 :empty-line 1))

  ;; `选中网页上的内容'，通过 org-protocol 和 org-capture 快速记录到笔记中
  (add-to-list 'org-capture-templates
               '("pn"
                 "Protocol Annotation"
                 entry
                 (file+headline links-org-file "Bookmarks")
                 "** %U - %:annotation"
                 :immediate-finish t
                 :jump-to-captured t
                 :empty-line 1))

  ;; 一个网页上有多处内容都选中, `将同一个网页的内容都按顺序放置到同一个headline里面'
  (add-to-list 'org-capture-templates
               '("pa"
                 "Protocol initial"
                 plain
                 (file+function links-org-file org-capture-template-goto-link)
                 "** %? - Captured On:%U\n\n  %:initial"
                 :immediate-finish t
                 :jump-to-captured t
                 :empty-line 1))


  ;; `家人+行事历相关'
  ;; (add-to-list 'org-capture-templates '("t" "Tasks → → → → → → → → → → → → → → →"))
  (setq daniel-org-file "~/org/daniel.agenda.org")
  (add-to-list 'org-capture-templates
               '("s"                                              ; hotkey
                 "Son's Task"                               ; title
                 entry                                             ; type
                 (file+headline daniel-org-file "Tasks") ; target
                 (file "~/.evil.emacs.d/assets/capture-template/todo.template")
                 :jump-to-captured t))
  (setq lulu-org-file "~/org/lulu.agenda.org")
  (add-to-list 'org-capture-templates
               '("l"
                 "Wife Lulu's Task"
                 entry
                 (file+headline lulu-org-file "Tasks")
                 (file "~/.evil.emacs.d/assets/capture-template/todo.template")
                 :immediate-finish t
                 :jump-to-captured t))

  ;; `常用快捷抓取模板'
  (setq phone-org-file "~/org/phone.org")
  (add-to-list 'org-capture-templates
               '("P"
                 "My Phone calls"
                 entry
                 (file+headline phone-org-file "Phone Calls")
                 (file "~/.evil.emacs.d/assets/capture-template/phone.template")
                 :immediate-finish t
                 :jump-to-captured t
                 :new-line 1))
  (setq habit-org-file "~/org/habit.agenda.org")
  (add-to-list 'org-capture-templates
               '("h"
                 "My Habit"
                 entry
                 (file habit-org-file)
                 (file "~/.evil.emacs.d/assets/capture-template/habit.template")
                 :jump-to-captured t
                 :immediate-finish t
                 :new-line 1))
  (setq my-org-file "~/org/xingwenju.agenda.org")
  (add-to-list 'org-capture-templates
               '("r"
                 "My Reading"
                 entry
                 (file+headline my-org-file "Reading")
                 "** %^{书名}\n%u\n%a\n"
                 :jump-to-captured t
                 :immediate-finish t
                 :new-line t))
  (setq notes-org-file "~/org/notes.agenda.org")
  (add-to-list 'org-capture-templates
               '("n"
                 "My Notes"
                 entry
                 (file+datetree notes-org-file)
		 "* %^{Description} %^g %?\n Added: %U"
                 :jump-to-captured t
                 :immediate-finish t
                 :new-line 1))
  ;; `GTD' templates
  (setq works-org-file "~/org/works.agenda.org") ;; NOTE: 工作内容不得公开
  (add-to-list 'org-capture-templates
	       '("t"
		 "⏰ My Daily Task"
		 entry
		 (file+datetree "~/org/dailytasks.agenda.org")
                 (file "~/.evil.emacs.d/assets/capture-template/todo.template")
                 :immediate-finish t
		 ))
  (add-to-list 'org-capture-templates
               '("w"
                 "⏰ My Work Task"
                 entry
                 (file+headline works-org-file "Tasks")
                 (file "~/.evil.emacs.d/assets/capture-template/basic.template")
                 :immediate-finish t))
  (add-to-list 'org-capture-templates
	       '("a"
		 "⏰ My Appointment"
		 entry
		 (file+headline works-org-file "Appointment")
		 (file "~/.evil.emacs.d/assets/capture-template/appointment.template")
                 :immediate-finish t
		 ))
  (setq inbox-org-file  "~/org/inbox.agenda.org")
  (add-to-list 'org-capture-templates
               '("i"
                 "⏰ My Inbox"
                 entry
                 (file+headline inbox-org-file "Tasks")
                 (file "~/.evil.emacs.d/assets/capture-template/inbox.template")
                 :immediate-finish t
                 :new-line 1))
  )

(provide 'org+capture)
