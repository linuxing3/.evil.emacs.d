(use-package 0x0)

;; `Enhance'
(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("M-." . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (embark-define-keymap embark-file-map
    ("d" delete-file)
    ("r" rename-file)
    ("c" copy-file))

  (eval-when-compile
    (defmacro my/embark-ace-action (fn)
      `(defun ,(intern (concat "my/embark-ace-" (symbol-name fn))) ()
         (interactive)
         (with-demoted-errors "%s"
           (require 'ace-window)
           (let ((aw-dispatch-always t))
             (aw-switch-to-window (aw-select nil))
             (call-interactively (symbol-function ',fn)))))))

  (eval-when-compile
    (defmacro my/embark-split-action (fn split-type)
      `(defun ,(intern (concat "my/embark-"
                               (symbol-name fn)
                               "-"
                               (car (last  (split-string
                                            (symbol-name split-type) "-"))))) ()
	 (interactive)
	 (funcall #',split-type)
	 (call-interactively #',fn))))

  (define-key embark-file-map     (kbd "2") (my/embark-split-action find-file split-window-below))
  (define-key embark-buffer-map   (kbd "2") (my/embark-split-action switch-to-buffer split-window-below))
  (define-key embark-bookmark-map (kbd "2") (my/embark-split-action bookmark-jump split-window-below))

  (define-key embark-file-map     (kbd "3") (my/embark-split-action find-file split-window-right))
  (define-key embark-buffer-map   (kbd "3") (my/embark-split-action switch-to-buffer split-window-right))
  (define-key embark-bookmark-map (kbd "3") (my/embark-split-action bookmark-jump split-window-right))

  (define-key embark-file-map     (kbd "o") (my/embark-ace-action find-file))
  (define-key embark-buffer-map   (kbd "o") (my/embark-ace-action switch-to-buffer))
  (define-key embark-bookmark-map (kbd "o") (my/embark-ace-action bookmark-jump))
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; `tab' manipulation
(use-package embark
  :config
  (add-to-list 'marginalia-prompt-categories '("tab by name" . tab))
  ;; 启动命令
  (defun my-select-tab-by-name (tab)
    (interactive
     (list
      (let ((tab-list (or (mapcar #'(lambda (tab) (cdr (assq 'name tab)))
                                  (tab-bar-tabs))
                          (user-error "No tabs found"))))
        (consult--read tab-list
                       :prompt "Tabs: "
                       :category 'tab))))
    (tab-bar-select-tab-by-name tab))

  ;; 添加标签行为
  (embark-define-keymap embark-tab-actions
    "Keymap for actions for tab-bar tabs (when mentioned by name)."
    ("s" tab-bar-select-tab-by-name)
    ("r" tab-bar-rename-tab-by-name)
    ("k" tab-bar-close-tab-by-name))

  (add-to-list 'embark-keymap-alist '(tab . embark-tab-actions))

  ;; 关闭前提醒
  (add-to-list 'embark-allow-edit-actions 'tab-bar-close-tab-by-name)
  (defun my-confirm-close-tab-by-name (tab)
    (interactive "sTab to close: ")
    (when (y-or-n-p (format "Close tab '%s'? " tab))
      (tab-bar-close-tab-by-name tab))))

;; `customize'
(defun my-short-wikipedia-link ()
  "Target a link at point of the form wikipedia:Page_Name."
  (save-excursion
    (let* ((beg (progn (skip-chars-backward "[:alnum:]_:") (point)))
           (end (progn (skip-chars-forward "[:alnum:]_:") (point)))
           (str (buffer-substring-no-properties beg end)))
      (save-match-data
        (when (string-match "wikipedia:\\([[:alnum:]_]+\\)" str)
          `(url
            (format "https://en.wikipedia.org/wiki/%s" (match-string 1 str))
            ,beg . ,end))))))

(add-to-list 'embark-target-finders 'my-short-wikipedia-link)

(use-package embark
  :config
  ;; switch back and forth between the list of actions and the list of
  ;; candidates (like in Helm) with `C-<tab>'. In the actions list you
  ;; can either type the action (matched with completing-read), or
  ;; call the action directly by prepending its keybinding with `@'.
  (defun with-minibuffer-keymap (keymap)
    (lambda (fn &rest args)
      (minibuffer-with-setup-hook
          (lambda ()
            (use-local-map
             (make-composed-keymap keymap (current-local-map))))
	(apply fn args))))

  (defvar embark-completing-read-prompter-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "<tab>") 'abort-recursive-edit)
      map))

  (advice-add 'embark-completing-read-prompter :around
              (with-minibuffer-keymap embark-completing-read-prompter-map))

  (defun embark-act-with-completing-read (&optional arg)
    (interactive "P")
    (let* ((embark-prompter 'embark-completing-read-prompter)
           (act (propertize "Act" 'face 'highlight))
           (embark-indicator (lambda (_keymap targets) nil)))
      (embark-act arg)))

  ;; `sudo' find file
  (defun sudo-find-file (file)
    "Open FILE as root."
    (interactive "FOpen file as root: ")
    (when (file-writable-p file)
      (user-error "File is user writeable, aborting sudo"))
    (find-file (if (file-remote-p file)
                   (concat "/" (file-remote-p file 'method) ":"
                           (file-remote-p file 'user) "@" (file-remote-p file 'host)
                           "|sudo:root@"
                           (file-remote-p file 'host) ":" (file-remote-p file 'localname))
		 (concat "/sudo:root@localhost:" file))))

  (define-key embark-file-map (kbd "S") 'sudo-find-file))



(provide 'editor+embark)
