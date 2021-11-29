;; `general-define-key' is user-extensible and supports
;; defining multiple keys in multiple keymaps at once, implicitly wrapping key
;; strings with (kbd ...), using named prefix key sequences (like the leader key
;; in vim), and much more.

(use-package general
  :config
  ;;(general-evil-setup t)
  )

(provide 'module-keybinds)
