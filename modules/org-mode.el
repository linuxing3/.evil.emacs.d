(defun +xing-org-config()
  (interactive)
  (defvar org-directory-default nil
    "whether use org directory in default location")
  (if org-directory-default
      (setq org-directory (expand-file-name "org" home-directory))
    (setq org-directory (dropbox-path "org")))

  (setq org-todo-keywords '((sequence "[学习](s!/@)" "[待办](t!/@)" "[等待](w!))" "|" "[完成](d!/@)" "[取消](c!@)")
                       (sequence "[BUG](b!/@)" "[新事件](i/@)" "[已知问题](k!/@)" "[修改中](W!/@)" "|" "[已修复](f!)"))) 
  (with-eval-after-load 'org
    (setq diary-file (dropbox-path "org/diary"))
    (setq
     org-agenda-diary-file (dropbox-path "org/diary")
     org-agenda-files (directory-files org-directory t "\\.agenda\\.org$" t))
    (setq org-archive-location (dropbox-path "org/archived/%s_archive::"))))

(defun +xing-enable-babel()
  (interactive)
  (with-eval-after-load 'org
    (org-babel-do-load-languages
     (quote org-babel-load-languages)
     (quote ((emacs-lisp . t)
	     (java . t)
	     (dot . t)
	     (ditaa . t)
	     (python . t)
	     (gnuplot . t)
	     (org . t)
	     (plantuml . t)
	     (latex . t))))))

;; Bootstrap Org
(+xing-org-config)
(+xing-enable-babel)

(org-babel-load-file "~/EnvSetup/config/evil-emacs/modules/+fancy-org-mode.org")
