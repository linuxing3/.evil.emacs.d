;; TRAMP
;; Emacs as External Editor
(defun dw/show-server-edit-buffer (buffer)
  ;; TODO: Set a transient keymap to close with 'C-c C-c'
  (split-window-vertically -15)
  (other-window 1)
  (set-buffer buffer))

(setq server-window #'dw/show-server-edit-buffer)

;; Set default connection mode to SSH
(defvar putty-directory "~/OneDrive/bin")
(setq putty-directory "~/OneDrive/bin")
(setq tramp-default-method "ssh")
(when IS-WINDOWS
  (setq tramp-default-method "plinkx")
  (setq tramp-terminal-type "xterm")
  (when (and (not (string-match putty-directory (getenv "PATH")))
	     (file-directory-p putty-directory))
    (setenv "PATH" (concat putty-directory ";" (getenv "PATH")))
    (add-to-list 'exec-path putty-directory)))

(provide 'module-remote)
