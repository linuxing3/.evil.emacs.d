(defun linuxing3/org-todo (arg)
  (interactive "p")
  (if (equal arg 4)
      (save-restriction
        (linuxing3/narrow-to-org-subtree)
        (org-show-todo-tree nil))
    (linuxing3/narrow-to-org-subtree)
    (org-show-todo-tree nil)))

(global-set-key (kbd "<S-f5>") 'linuxing3/widen)

(defun linuxing3/widen ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-agenda-remove-restriction-lock)
        (when org-agenda-sticky
          (org-agenda-redo)))
    (widen)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "W" (lambda () (interactive) (setq linuxing3/hide-scheduled-and-waiting-next-tasks t) (linuxing3/widen))))
          'append)

(defun linuxing3/restrict-to-file-or-follow (arg)
  "Set agenda restriction to 'file or with argument invoke follow mode.
I don't use follow mode very often but I restrict to file all the time
so change the default 'F' binding in the agenda to allow both"
  (interactive "p")
  (if (equal arg 4)
      (org-agenda-follow-mode)
    (widen)
    (linuxing3/set-agenda-restriction-lock 4)
    (org-agenda-redo)
    (beginning-of-buffer)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "F" 'linuxing3/restrict-to-file-or-follow))
          'append)

(defun linuxing3/narrow-to-org-subtree ()
  (widen)
  (org-narrow-to-subtree)
  (save-restriction
    (org-agenda-set-restriction-lock)))

(defun linuxing3/narrow-to-subtree ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (org-get-at-bol 'org-hd-marker)
          (linuxing3/narrow-to-org-subtree))
        (when org-agenda-sticky
          (org-agenda-redo)))
    (linuxing3/narrow-to-org-subtree)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "N" 'linuxing3/narrow-to-subtree))
          'append)

(defun linuxing3/narrow-up-one-org-level ()
  (widen)
  (save-excursion
    (outline-up-heading 1 'invisible-ok)
    (linuxing3/narrow-to-org-subtree)))

(defun linuxing3/get-pom-from-agenda-restriction-or-point ()
  (or (and (marker-position org-agenda-restrict-begin) org-agenda-restrict-begin)
      (org-get-at-bol 'org-hd-marker)
      (and (equal major-mode 'org-mode) (point))
      org-clock-marker))

(defun linuxing3/narrow-up-one-level ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (linuxing3/get-pom-from-agenda-restriction-or-point)
          (linuxing3/narrow-up-one-org-level))
        (org-agenda-redo))
    (linuxing3/narrow-up-one-org-level)))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "U" 'linuxing3/narrow-up-one-level))
          'append)

(defun linuxing3/narrow-to-org-project ()
  (widen)
  (save-excursion
    (linuxing3/find-project-task)
    (linuxing3/narrow-to-org-subtree)))

(defun linuxing3/narrow-to-project ()
  (interactive)
  (if (equal major-mode 'org-agenda-mode)
      (progn
        (org-with-point-at (linuxing3/get-pom-from-agenda-restriction-or-point)
          (linuxing3/narrow-to-org-project)
          (save-excursion
            (linuxing3/find-project-task)
            (org-agenda-set-restriction-lock)))
        (org-agenda-redo)
        (beginning-of-buffer))
    (linuxing3/narrow-to-org-project)
    (save-restriction
      (org-agenda-set-restriction-lock))))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "P" 'linuxing3/narrow-to-project))
          'append)

(defvar linuxing3/project-list nil)

(defun linuxing3/view-next-project ()
  (interactive)
  (let (num-project-left current-project)
    (unless (marker-position org-agenda-restrict-begin)
      (goto-char (point-min))
					; Clear all of the existing markers on the list
      (while linuxing3/project-list
        (set-marker (pop linuxing3/project-list) nil))
      (re-search-forward "Tasks to Refile")
      (forward-visible-line 1))

					; Build a new project marker list
    (unless linuxing3/project-list
      (while (< (point) (point-max))
        (while (and (< (point) (point-max))
                    (or (not (org-get-at-bol 'org-hd-marker))
                        (org-with-point-at (org-get-at-bol 'org-hd-marker)
                          (or (not (linuxing3/is-project-p))
                              (linuxing3/is-project-subtree-p)))))
          (forward-visible-line 1))
        (when (< (point) (point-max))
          (add-to-list 'linuxing3/project-list (copy-marker (org-get-at-bol 'org-hd-marker)) 'append))
        (forward-visible-line 1)))

					; Pop off the first marker on the list and display
    (setq current-project (pop linuxing3/project-list))
    (when current-project
      (org-with-point-at current-project
        (setq linuxing3/hide-scheduled-and-waiting-next-tasks nil)
        (linuxing3/narrow-to-project))
					; Remove the marker
      (setq current-project nil)
      (org-agenda-redo)
      (beginning-of-buffer)
      (setq num-projects-left (length linuxing3/project-list))
      (if (> num-projects-left 0)
          (message "%s projects left to view" num-projects-left)
        (beginning-of-buffer)
        (setq linuxing3/hide-scheduled-and-waiting-next-tasks t)
        (error "All projects viewed.")))))

(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "V" 'linuxing3/view-next-project))
          'append)

;; - T (tasks) for C-c / t on the current buffer
;; - N (narrow) narrows to this task subtree
;; - U (up) narrows to the immediate parent task subtree without moving
;; - P (project) narrows to the parent project subtree without moving
;; - F (file) narrows to the current file or file of the existing restriction
(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("0" . ignore)
                                      ("1" . ignore)
                                      ("2" . ignore)
                                      ("3" . ignore)
                                      ("4" . ignore)
                                      ("5" . ignore)
                                      ("6" . ignore)
                                      ("7" . ignore)
                                      ("8" . ignore)
                                      ("9" . ignore)

                                      ("a" . ignore)
                                      ("d" . ignore)
                                      ("h" . linuxing3/hide-other)
                                      ("i" progn
                                       (forward-char 1)
                                       (call-interactively 'org-insert-heading-respect-content))
                                      ("k" . org-kill-note-or-show-branches)
                                      ("l" . ignore)
                                      ("m" . ignore)
                                      ("q" . linuxing3/show-org-agenda)
                                      ("r" . ignore)
                                      ("s" . org-save-all-org-buffers)
                                      ("w" . org-refile)
                                      ("x" . ignore)
                                      ("y" . ignore)
                                      ("z" . org-add-note)

                                      ("A" . ignore)
                                      ("B" . ignore)
                                      ("E" . ignore)
                                      ("F" . linuxing3/restrict-to-file-or-follow)
                                      ("G" . ignore)
                                      ("H" . ignore)
                                      ("J" . org-clock-goto)
                                      ("K" . ignore)
                                      ("L" . ignore)
                                      ("M" . ignore)
                                      ("N" . linuxing3/narrow-to-org-subtree)
                                      ("P" . linuxing3/narrow-to-org-project)
                                      ("Q" . ignore)
                                      ("R" . ignore)
                                      ("S" . ignore)
                                      ("T" . linuxing3/org-todo)
                                      ("U" . linuxing3/narrow-up-one-org-level)
                                      ("V" . ignore)
                                      ("W" . linuxing3/widen)
                                      ("X" . ignore)
                                      ("Y" . ignore)
                                      ("Z" . ignore))))

(defun linuxing3/show-org-agenda ()
  (interactive)
  (if org-agenda-sticky
      (switch-to-buffer "*Org Agenda( )*")
    (switch-to-buffer "*Org Agenda*"))
  (delete-other-windows))

;; =C-c C-x <= turns on the agenda restriction lock for the current
;; subtree.  This keeps your agenda focused on only this subtree.  Alarms
;; and notifications are still active outside the agenda restriction.
;; =C-c C-x >= turns off the agenda restriction lock returning your
;; agenda view back to normal.
(add-hook 'org-agenda-mode-hook
          '(lambda () (org-defkey org-agenda-mode-map "\C-c\C-x<" 'linuxing3/set-agenda-restriction-lock))
          'append)

(defun linuxing3/set-agenda-restriction-lock (arg)
  "Set restriction lock to current task subtree or file if prefix is specified"
  (interactive "p")
  (let* ((pom (linuxing3/get-pom-from-agenda-restriction-or-point))
         (tags (org-with-point-at pom (org-get-tags-at))))
    (let ((restriction-type (if (equal arg 4) 'file 'subtree)))
      (save-restriction
        (cond
         ((and (equal major-mode 'org-agenda-mode) pom)
          (org-with-point-at pom
            (org-agenda-set-restriction-lock restriction-type))
          (org-agenda-redo))
         ((and (equal major-mode 'org-mode) (org-before-first-heading-p))
          (org-agenda-set-restriction-lock 'file))
         (pom
          (org-with-point-at pom
            (org-agenda-set-restriction-lock restriction-type))))))))

(provide 'org+speedcommands)
