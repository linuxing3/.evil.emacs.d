;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; ☀ 美化配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(use-package org-superstar
  :ensure t
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (set-face-attribute 'org-superstar-header-bullet nil :inherit 'fixed-pitched :height 180)
  :custom
  (org-superstar-headline-bullets-list '("☀" "☪" "☯" "✿" "→"))
  (setq org-ellipsis " ▼ "))

(use-package org-bullets
  :ensure t
  :init (add-hook 'org-mode-hook 'org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☀" "☪"  "☯"  "✿" "→"))
  )

(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "↑" "↓")))

(use-package org
  :config
  ;; 标签组
  (setq org-tag-alist (quote ((:startgroup)
                              ("@office" . ?o)
                              ("@home" . ?h)
                              ("@travel" . ?t)
                              ("@errand" . ?e)
                              ("PERSONAL" . ?p)
                              ("ME" . ?m)
                              ("KID" . ?k)
                              ("DANIEL" . ?d)
                              ("LULU" . ?l)
                              ("WORK" . ?w)
                              ("PROJECT" . ?p)
                              ("COMPUTER" . ?c)
                              ("PHONE" . ?P)
                              ("HABIT" . ?H)
                              (:endgroup)
                              ("party" . ?1)
                              ("internal" . ?2)
                              ("hr" . ?3)
                              ("finance" . ?4)
                              ("security" . ?5)
                              ("foreign" . ?6)
                              ("study" . ?7)
                              ("public" . ?8)
                              ("protocol" . ?9)
                              )))
  (setq org-tag-faces
        '(
          ("@home" . (:foreground "MediumBlue" :weight bold))
          ("@office" . (:foreground "Red" :weight bold))
          ("@travel" . (:foreground "ForestGreen" :weight bold))
          ("@erranda" . (:foreground "OrangeRed" :weight bold))
          ("DANIEL" . (:foreground "MediumBlue" :weight bold))
          ("LULU" . (:foreground "DeepPink" :weight bold))
          ("WORK" . (:foreground "OrangeRed" :weight bold))
          ("PROJECT" . (:foreground "OrangeRed" :weight bold))
          ("HABIT" . (:foreground "DarkGreen" :weight bold))
          ("COMPUTER" . (:foreground "ForestGreen" :weight bold))
          ("internal" . (:foreground "ForestGreen" :weight bold))
          ("party" . (:foreground "ForestGreen" :weight bold))
          ("hr" . (:foreground "ForestGreen" :weight bold))
          ("finance" . (:foreground "LimeGreen" :weight bold))
          ("study" . (:foreground "LimeGreen" :weight bold))
          ("public" . (:foreground "LimeGreen" :weight bold))
          ("protocol" . (:foreground "LimeGreen" :weight bold))))

  (set-face-attribute 'org-link nil
		              :weight 'normal
		              :background nil)
  (set-face-attribute 'org-code nil
		              :foreground "#a9a1e1"
		              :background nil)
  (set-face-attribute 'org-date nil
		              :foreground "#5B6268"
		              :background nil)
  (set-face-attribute 'org-level-1 nil
		              :foreground "steelblue2"
		              :background nil
		              :height 1.1
		              :weight 'normal)
  (set-face-attribute 'org-level-2 nil
		              :foreground "slategray2"
		              :background nil
		              :height 1.0
		              :weight 'normal)
  (set-face-attribute 'org-level-3 nil
		              :foreground "SkyBlue2"
		              :background nil
		              :height 1.0
		              :weight 'normal)
  (set-face-attribute 'org-level-4 nil
		              :foreground "DodgerBlue2"
		              :background nil
		              :height 1.0
		              :weight 'normal)
  (set-face-attribute 'org-level-5 nil
		              :weight 'normal)
  (set-face-attribute 'org-level-6 nil
		              :weight 'normal)
  (set-face-attribute 'org-document-title nil
		              :foreground "SlateGray1"
		              :background nil
		              :height 1.25
		              :weight 'bold)

  (setq org-list-demote-modify-bullet (quote (("+" . "-")
					                          ("*" . "-")
					                          ("1." . "-")
					                          ("1)" . "-")
					                          ("A)" . "-")
					                          ("B)" . "-")
					                          ("a)" . "-")
					                          ("b)" . "-")
					                          ("A." . "-")
					                          ("B." . "-")
					                          ("a." . "-")
					                          ("b." . "-"))))
  ) ;; tag config ends here

(provide 'org+pretty)
