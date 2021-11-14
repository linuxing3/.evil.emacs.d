;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 博客 blog
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defvar blog-hugo-process "Hugo Server"
  "Name of 'gridsome develop' process process")

(defun linuxing3/blog-hugo-find-dir ()
  "Open hugo blog files"
  (interactive)
  (find-file (workspace-path "awesome-hugo-blog/content/posts")))

(defun linuxing3/blog-hugo-deploy ()
  "Run gridsome cli and push changes upstream."
  (interactive)
  (+git-push org-hugo-base-dir))

(defun linuxing3/blog-hugo-start-server ()
  "Run gridsome server if not already running and open its webpage."
  (interactive)
  (with-dir org-hugo-base-dir
            (shell-command "cd " org-hugo-base-dir)
            (unless (get-process blog-hugo-process)
              (start-process blog-hugo-process nil "hugo" "server"))))

(defun linuxing3/blog-hugo-end-server ()
  "End gridsome server process if running."
  (interactive)
  (--when-let (get-process blog-hugo-process)
    (delete-process it)))

(provide 'org+hugo)
