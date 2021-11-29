(use-package pandoc-mode
  :config
  (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings))

;; (use-package org
;;   :ensure org-plus-contrib
;;   :config (require 'ox-extra)
;;           (ox-extras-activate '(ignore-headlines)))
