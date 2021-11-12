;; TRAMP
;; Set default connection mode to SSH
(setq tramp-default-method "ssh")

;; Emacs as External Editor
(defun dw/show-server-edit-buffer (buffer)
  ;; TODO: Set a transient keymap to close with 'C-c C-c'
  (split-window-vertically -15)
  (other-window 1)
  (set-buffer buffer))

(setq server-window #'dw/show-server-edit-buffer)
