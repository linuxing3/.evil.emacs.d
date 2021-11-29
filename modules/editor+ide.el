(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  ;;:load-path "./localelpa/lsp-mode"
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  ;;:load-path "./localelpa/lsp-ui"
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  ;;:load-path "./localelpa/lsp-treemacs"
  :after lsp)

(use-package dap-mode
  ;;:load-path "./localelpa/dap-mode"
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (require 'dap-python)
  (require 'dap-pwsh)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed

  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
   :keymaps 'lsp-mode-map
   :prefix lsp-keymap-prefix
   "d" '(dap-hydra t :wk "debugger")))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred))
  :config
  (require 'dap-go)
  (dap-go-setup)
  (if IS-WINDOWS (dap-register-debug-template
                  "Launch Unoptimized Debug Package"
                  (list :type "go"
	                    :request "launch"
	                    :name "Launch Unoptimized Debug Package"
	                    :mode "debug"
	                    :program "${workspacefolder}/main.exe"
	                    :buildFlags "-gcflags '-N -l'"
	                    :args nil
	                    :env nil
	                    :envFile nil))))

(use-package go-eldoc
  :ensure t
  :hook ((go-mode . go-eldoc-setup))
  :config
  (set-face-attribute 'eldoc-highlight-function-argument nil
                      :underline t :foreground "green"
                      :weight 'bold))

(use-package rust-mode
  :hook ((rust-mode . lsp-deferred))
  :config
  ;; (require 'dap-rust)
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)
  (dap-register-debug-template "Rust::GDB Run Configuration"
                               (list :type "gdb"
                                     :request "launch"
                                     :name "GDB::Run"
				                     :gdbpath "rust-gdb"
                                     :target nil
                                     :cwd nil)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  ;; :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(require 'project)
(use-package project-x
  :after project
  :load-path "~/.evil.emacs.d/modules/project-x.el"
  :config
  (setq project-x-save-interval 600)    ;Save project state every 10 min
  (project-x-mode 1))

(use-package evil-nerd-commenter
  :bind ("C-/" . evilnc-comment-or-uncomment-lines))

(use-package prodigy
  ;;:load-path "./localelpa/prodigy"
  :config
  (prodigy-define-service
    :name "Information Center: El Universal"
    :command "scrapy"
    :args '("crawl" "eluniversal")
    :cwd "~/OneDrive/shared/InformationCenter"
    :tags '(work)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  ;; NOTE: 进行培训PPT展示
  (prodigy-define-service
    :name "Run Marp Presentation"
    :command "marp"
    :args '("-s" "-w" ".")
    :cwd "~/OneDrive/Documents/present"
    :tags '(training)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)


  ;; NOTE: 进行HUGO博客预览
  (prodigy-define-service
    :name "Run Hugo Site Server"
    :command "hugo"
    :args '("server")
    :cwd "~/workspace/awesome-hugo-blog"
    :tags '(work)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t))

(use-package hl-todo
  ;;:load-path "./localelpa/hl-todo"
  :hook (prog-mode . hl-todo-mode)
  :commands hl-todo-mode
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"  . ,(face-foreground 'warning))
          ("FIXME" . ,(face-foreground 'error))
          ("HACK"  . ,(face-foreground 'font-lock-constant-face))
          ("REVIEW"  . ,(face-foreground 'font-lock-keyword-face))
          ("NOTE"  . ,(face-foreground 'success))
          ("DEPRECATED" . ,(face-foreground 'font-lock-doc-face))))
  (when hl-todo-mode
    (hl-todo-mode -1)
    (hl-todo-mode +1)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package format-all
  :hook
  (prog-mode . format-all-mode))

;; yasnippet mode
(defvar +snippets-dir "~/.dotfiles/custom/emacs/snippets"
  "Directory where `yasnippet' will search for your private snippets.")

(defun +snippet--ensure-dir (dir)
  (unless (file-directory-p dir)
    (if (y-or-n-p (format "%S doesn't exist. Create it?" (abbreviate-file-name dir)))
        (make-directory dir t)
      (error "%S doesn't exist" (abbreviate-file-name dir)))))

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
  :load-path "./assets/doom-snippets"
  :after yasnippet
  :config
  (add-to-list 'yas-snippet-dirs 'doom-snippets-dir))

(provide 'editor+ide)
