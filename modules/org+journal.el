;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; NOTE: 日志 Journal  ---- 已迁移到hugo
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defun +modern-org-journal-new-journal ()
  "Create the journal in a specific directory, then your can export ..."
  (interactive)
  (progn
    (setq journal-file-path (concat org-journal-base-dir "/" (format-time-string "%Y%m%d") ".org"))
    (if (file-exists-p journal-file-path)
        (find-file-other-window journal-file-path)
      (progn
        (find-file-other-window journal-file-path)
        (goto-char (point-min))
        (insert "---\n")
        (insert (concat "#+TITLE: Journal Entry\n"))
        (insert "#+AUTHOR: Xing Wenju\n")
        (insert (concat "#+DATE: " (format-time-string "%Y-%m-%d") "\n"))
        (insert "#+EXCERPT: org journal \n")
        (insert "---\n")))))

(defun commom--org-headers (file)
  "Return a draft org mode header string for a new article as FILE."
  (let ((datetimezone
         (concat
          (format-time-string "%Y-%m-%d"))))
    (concat
     "#+TITLE: " file
     "\n#+AUTHOR: "
     "\n#+DATE: " datetimezone
     "\n#+PUBLISHDATE: " datetimezone
     "\n#+EXCERPT: nil"
     "\n#+DRAFT: nil"
     "\n#+TAGS: nil, nil"
     "\n#+DESCRIPTION: Short description"
     "\n\n")))

(use-package org-journal
  :ensure t
  :defer t
  :init
  (add-to-list 'magic-mode-alist '(+org-journal-p . org-journal-mode))

  (defun +org-journal-p ()
    "Wrapper around `org-journal-is-journal' to lazy load `org-journal'."
    (when-let (buffer-file-name (buffer-file-name (buffer-base-buffer)))
      (if (or (featurep 'org-journal)
              (and (file-in-directory-p
                    buffer-file-name (expand-file-name org-journal-dir org-directory))
                   (require 'org-journal nil t)))
          (org-journal-is-journal))))

  (setq org-journal-dir (workspace-path "awesome-hugo-blog/content/journal/")
        org-journal-cache-file (dropbox-path "org/journal/"))

  :config
  (setq magic-mode-alist (assq-delete-all 'org-journal-is-journal magic-mode-alist))

  (setq org-journal-carryover-items  "TODO=\"TODO\"|TODO=\"PROJ\"|TODO=\"STRT\"|TODO=\"WAIT\"|TODO=\"HOLD\""))

(provide 'org+journal)
