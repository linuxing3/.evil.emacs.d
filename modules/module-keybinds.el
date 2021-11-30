;; `general-define-key' is user-extensible and supports
;; defining multiple keys in multiple keymaps at once, implicitly wrapping key
;; strings with (kbd ...), using named prefix key sequences (like the leader key
;; in vim), and much more.

(use-package general
  :config
  ;; FIXED: 在moew模式下，general不能使用states参数
  (general-define-key
   "<f5>"  #'eval-buffer
   "<f8>"  #'format-all-buffer
   "<f9>"  #'org-capture
   "<f10>"  #'org-agenda
   "<f11>"  #'make-frame
   "<f12>"  #'xref-find-definitions)

  ;; `全局启动键'，绑定SPC
  (general-create-definer global-space-definer
    :prefix  "<f7>"
    :non-normal-prefix "<f7>")

  (general-define-key
   "M-/" #'comment-or-uncomment-region
   "M-a" #'mark-whole-buffer
   "M-z" #'fill-paragraph)

  (general-define-key
   "C-\\" #'toggle-input-method
   "C-o" #'open-with-external-app
   "C-w" #'tab-bar-close-tab
   )
  )

(provide 'module-keybinds)
