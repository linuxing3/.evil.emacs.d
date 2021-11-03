(defun +xing-org-config()
  (interactive)
  (defvar org-directory-default nil
    "whether use org directory in default location")
  (if org-directory-default
      (setq org-directory (expand-file-name "org" home-directory))
    (setq org-directory (dropbox-path "org")))

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
