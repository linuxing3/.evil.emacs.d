;; ---------------------------------------------------------
;; Vim mode
;; ---------------------------------------------------------
(use-package evil
  :commands (evil-mode)
  
  :config
  (evil-mode 1))

(use-package evil-leader
  :config
  (evil-leader/set-leader ",")
  (global-evil-leader-mode))

(use-package evil-escape
  )

(use-package evil-surround
  )


(use-package evil-snipe
  :commands evil-snipe-local-mode evil-snipe-override-local-mode
  :init
  (setq evil-snipe-smart-case t
        evil-snipe-scope 'line
        evil-snipe-repeat-scope 'visible
        evil-snipe-char-fold t))

(use-package evil-textobj-anyblock
  
  :config
  (setq evil-textobj-anyblock-blocks
        '(("(" . ")")
          ("{" . "}")
          ("\\[" . "\\]")
          ("<" . ">"))))

;; Allows you to use the selection for * and #
(use-package evil-visualstar
  :commands (evil-visualstar/begin-search
             evil-visualstar/begin-search-forward
             evil-visualstar/begin-search-backward)
  :init
  (evil-define-key* 'visual 'global
    "*" #'evil-visualstar/begin-search-forward
    "#" #'evil-visualstar/begin-search-backward))

;;
;;; Text object plugins

(use-package exato
  :commands evil-outer-xml-attr evil-inner-xml-attr)

(provide 'core-evil)
