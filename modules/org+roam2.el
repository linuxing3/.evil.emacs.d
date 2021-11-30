;; Org-Roam basic configuration
(use-package org-roam
    :after org)

(setq
 org-roam-v2-ack t
 org-roam-directory
 (let ((p (expand-file-name "~/org/roam")))
   (unless (file-directory-p p) (make-directory p))
   p))

(with-eval-after-load "org-roam"
  ;; https://www.orgroam.com/manual.html#Roam-Protocol
  (global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
  (global-set-key (kbd "C-c n f") 'org-roam-node-find)
  (global-set-key (kbd "C-c n g") 'org-roam-graph)
  (global-set-key (kbd "C-c n i") 'org-roam-node-insert)
  (global-set-key (kbd "C-c n c") 'org-roam-capture)
  (global-set-key (kbd "C-c n t") 'org-roam-dailies-capture-today)
  (global-set-key (kbd "C-c n m") 'org-roam-dailies-capture-tomorrow)
  (global-set-key (kbd "C-c n y") 'org-roam-dailies-capture-yesterday)
  (global-set-key (kbd "C-c n T") 'org-roam-dailies-goto-today)
  (global-set-key (kbd "C-c n d") 'org-roam-dailies-goto-date)
  (global-set-key (kbd "C-c n s") 'org-roam-db-sync)

  (org-roam-setup)
  (require 'org-roam-protocol))

;;; templates
(with-eval-after-load "org-roam"
  ;; `file' 自定义笔记模板 - 2021-11-10.org
  (setq org-roam-dailies-capture-templates
        '(("d" "default" plain "* %?"
           :target (file+head "%<%Y-%m-%d>.org" "#+title: \n#+date: %<%Y-%m-%d>")
           :unnarrowed t
           :empty-lines 1
           :time-prompt t
           :kill-buffer t)))
  ;; `file' 自定义笔记模板 - 2021-11-10-file-title.org
  (setq org-roam-capture-templates
        '(("d" "default" plain "* %?"
           :target (file+head "%<%Y-%m-%d>-${slug}.org" "#+title: ${title}\n#+date: %<%Y-%m-%d>")
           :unnarrowed t)))
  ;; `ref' 抓取网页书签到一个用网页标题命名的文件中
  (setq org-roam-capture-ref-templates
        '(("pb" "ref" plain ""
           :target (file+head "${slug}.org" "\n#+title: ${title}\n#+roam_key: ${ref}\n")
           :unnarrowed t)
          ;; `content'  抓取一个网页中的内容，多次分别插入到用网页标题命名的文件中
          ("pa" "Annotation" plain "** %U \n${body}\n"
           :target (file+head "${slug}.org" "\n#+title: ${title}\n#+roam_key: ${ref}\n")
           :immediate-finish t
           :unnarrowed t))))

(use-package websocket
    :after org-roam)

(use-package org-roam-ui
    :load-path "./localelpa/org-roam-ui"
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))


(provide 'org+roam2)
