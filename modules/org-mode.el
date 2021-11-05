;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 现代基本配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defun +modern-org-config()
  (interactive)
  ;; 设定org的目录
  (defvar org-directory-default nil
    "whether use org directory in default location")
  (if org-directory-default
      (setq org-directory (expand-file-name "org" home-directory))
    (setq org-directory (dropbox-path "org")))
  ;; 设定journal的目录
  (defvar org-journal-base-dir nil
    "Netlify gridsome base directory")
  (setq org-journal-base-dir (dropbox-path "org/journal"))
  ;; 设定todo关键字
  (setq org-todo-keywords '((sequence "[学习](s!/@)" "[待办](t!/@)" "[等待](w!))" "|" "[完成](d!/@)" "[取消](c!@)")
                            (sequence "[BUG](b!/@)" "[新事件](i/@)" "[已知问题](k!/@)" "[修改中](W!/@)" "|" "[已修复](f!)")))
  ;; 设定agenda相关目录
  (with-eval-after-load 'org
    (setq diary-file (dropbox-path "org/diary"))
    (setq
     org-agenda-diary-file (dropbox-path "org/diary")
     org-agenda-files (directory-files org-directory t "\\.agenda\\.org$" t))
    (setq org-archive-location (dropbox-path "org/archived/%s_archive::"))))

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 现代Babel配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defun +modern-babel-config()
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

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 启动配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(+modern-org-config)
(+modern-babel-config)

;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 加载现代美化配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(load-file "~/EnvSetup/config/evil-emacs/modules/+fancy-org-mode.el")
