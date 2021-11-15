;;
;;; NOTE: `构建自己的知识网络'

(use-package emacsql-sqlite3)
;;
;;; `windows'下只能使用`v1'版本
(use-package org-roam
  :ensure nil
  :load-path "~/workspace/org-roam"
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/org/roam")
  :config
  ;; 实现网页抓取的协议
  (require 'org-roam-protocol)
  (setq org-roam-filename-noconfirm nil)

  (if IS-WINDOWS
      (progn
        (setq org-roam-graphviz-executable "B:/app/graphviz/bin/dot.exe")
        (setq org-roam-graph-viewer "C:/Program Files/Microsoft/Edge Beta/Application/msedge.exe")))
  (if IS-LINUX
      (progn
        (setq org-roama-graphviz-executble "dot")
        (setq org-roam-graph-viewer "chromium")))
  ;; 自定义私人笔记标题的处理方法
  (defun linuxing3/org-roam-title-private (title)
    (let ((timestamp (format-time-string "%Y-%m-%d" (current-time)))
          (slug (org-roam--title-to-slug title)))
      (format "%s-%s" timestamp slug)))
  ;; `file' 日记模板 - diaries/2021-11-10.org
  (setq org-roam-dailies-capture-templates
        '(("d" "默认" entry #'org-roam-capture--get-point "* %?"
           :file-name "daily/%<%Y-%m-%d>" ;; `headline1'
           :head "#+title: \n#+date: %<%Y-%m-%d-%Z>\n"
           :unnarrowed t)
          ("x" "个人" entry #'org-roam-capture--get-point "* %?"
           :file-name "daily/%<%Y-%m-%d>" ;; `headline1'
           :head "#+title: \n#+date: %<%Y-%m-%d-%Z>\n"
           :unnarrowed t)
          ("t" "任务" entry
           #'org-roam-capture--get-point
           "* [待办] %?\n  %U\n  %a\n  %i"
           :file-name "daily/%<%Y-%m-%d>"
           :olp ("Tasks") ;; under `Task' subtree
           :empty-lines 1
           :head "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
          ("j" "日记" entry
           #'org-roam-capture--get-point
           "* %<%I:%M %p> - Journal  :journal:\n\n%?\n\n"
           :file-name "daily/%<%Y-%m-%d>"
           :olp ("Log") ;; under `Log' subtree
           :head "#+title:  %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
          ("l" "日志" entry
           #'org-roam-capture--get-point
           "* %<%I:%M %p> - %?"
           :file-name "daily/%<%Y-%m-%d>"
           :olp ("Log") ;; under `Log' subtree
           :head "#+title:  %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")
          ("m" "会议" entry
           #'org-roam-capture--get-point
           "* %<%I:%M %p> - %^{Meeting Title}  :meetings:\n\n%?\n\n"
           :file-name "daily/%<%Y-%m-%d>"
           :olp ("Log") ;; under `Log' subtree
           :head "#+title: %<%Y-%m-%d %a>\n\n[[roam:%<%Y-%B>]]\n\n")))
  ;; `file' 自定义笔记模板 - 2021-11-10--file-title.org
  (setq org-roam-capture-templates
        '(("d" "default" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "%(format-time-string \"%Y-%m-%d--%H-%M-%SZ--${slug}\" (current-time) t)"
           :head "#+title: ${title}\n#+date: ${time} \n#+roam_alias: \n#+roam_tags: \n"
           :unnarrowed t)
          ))
  ;; `file' 专业术语模板 - 202111101000000-title.org
  (add-to-list 'org-roam-capture-templates
               '("t" "Term" plain (function org-roam-capture--get-point)
                 "- 领域: %^{术语所属领域}\n- 释义:"
                 :file-name "%<%Y%m%d%H%M%S>-${slug}"
                 :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
                 :unnarrowed t
                 ))
  ;; `file' 工作试验模板 - 202111101000000-title.org
  (add-to-list 'org-roam-capture-templates
               '("p" "Paper Note" plain (function org-roam-capture--get-point)
                 "* 相关工作\n\n%?\n* 观点\n\n* 模型和方法\n\n* 实验\n\n* 结论\n"
                 :file-name "%<%Y%m%d%H%M%S>-${slug}"
                 :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
                 :unnarrowed t
                 ))
  ;; `immediate' 即可输入标题和日期，生成一个笔记
  (setq org-roam-capture-immediate-template
        '("d" "default" plain (function org-roam-capture--get-point)
          "%?"
          :file-name "%<%Y%m%d%H%M%S>-${slug}"
          :head "#+title: ${title}\n#+date: ${date}"
          :unnarrowed t))
  ;; `ref' 抓取网页书签到一个用网页标题命名的文件中
  (setq org-roam-capture-ref-templates
        '(("r" "ref" plain (function org-roam-capture--get-point)
           ""
           :file-name "${slug}"
           :head "\n#+title: ${title}\n#+roam_key: ${ref}\n"
           :unnarrowed t)))
  ;; `content'  抓取一个网页中的内容，多次分别插入到用网页标题命名的文件中
  (add-to-list 'org-roam-capture-ref-templates
               '("a" "Annotation" plain (function org-roam-capture--get-point)
                 "** %U \n${body}\n"
                 :file-name "${slug}"
                 :head "\n#+title: ${title}\n#+roam_key: ${ref}\n#+roam_alias:\n"
                 :immediate-finish t
                 :unnarrowed t))
  :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n d"   . org-roam-dailies-find-date)
               ("C-c n c"   . org-roam-dailies-capture-today)
               ("C-c n C r" . org-roam-dailies-capture-tomorrow)
               ("C-c n t"   . org-roam-dailies-find-today)
               ("C-c n y"   . org-roam-dailies-find-yesterday)
               ("C-c n r"   . org-roam-dailies-find-tomorrow)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

;; TODO: 使用server进行roam网页互动
(use-package org-roam-server
  :load-path "~/workspace/org-roam-server"
  :ensure nil
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 10000
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20)) ;; org roam config ends here

(provide 'org+roam)
