;; yasnippet mode
(defvar +snippets-dir (dropbox-path "config/emacs/snippets")
  "Directory where `yasnippet' will search for your private snippets.")

;;;###autoload
(defun +snippet--ensure-dir (dir)
  (unless (file-directory-p dir)
    (if (y-or-n-p (format "%S doesn't exist. Create it?" (abbreviate-file-name dir)))
        (make-directory dir t)
      (error "%S doesn't exist" (abbreviate-file-name dir)))))

;;;###autoload
(defun +snippets/new ()
  "Create a new snippet in `+snippets-dir'."
  (interactive)
  (let ((default-directory
          (expand-file-name (symbol-name major-mode)
                            +snippets-dir)))
    (+snippet--ensure-dir default-directory)
    (with-current-buffer (switch-to-buffer "untitled-snippet")
      (snippet-mode)
      (erase-buffer)
      (yas-expand-snippet (concat "# -*- mode: snippet -*-\n"
                                  "# name: $1\n"
                                  "# uuid: $2\n"
                                  "# key: ${3:trigger-key}${4:\n"
                                  "# condition: t}\n"
                                  "# --\n"
                                  "$0"))
      (when (bound-and-true-p evil-local-mode)
        (evil-insert-state)))))

(use-package yasnippet
  :ensure t
  :commands (yas-minor-mode-on
             yas-expand
             yas-expand-snippet
             yas-lookup-snippet
             yas-insert-snippet
             yas-new-snippet
             yas-visit-snippet-file
             yas-activate-extra-mode
             yas-deactivate-extra-mode
             yas-maybe-expand-abbrev-key-filter)
  :init
  :config
  (setq yas-snippet-dirs '(yas-installed-snippets-dir))
  (add-to-list 'yas-snippet-dirs '+snippets-dir)
  (yas-global-mode 1)
  (yas-reload-all)
  (setq yas-prompt-functions '(yas-dropdown-prompt
			                   yas-maybe-ido-prompt
			                   yas-completing-prompt)))

(use-package auto-yasnippet
  :ensure t
  :config
  ;; (global-set-key (kbd "C-S-w") #'aya-create)
  ;; (global-set-key (kbd "C-S-y") #'aya-expand)
  (setq aya-persist-snippets-dir +snippets-dir))

(use-package doom-snippets
  :load-path "~/.evil.emacs.d/assets/doom-snippets"
  :after yasnippet
  :config
  (add-to-list 'yas-snippet-dirs 'doom-snippets-dir))

(provide 'module-snippets)
