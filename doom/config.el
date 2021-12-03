;; ---------------------------------------------------------
;; Basic configuration
;; ---------------------------------------------------------
(setq user-full-name "Xing Wenju"
      user-mail-address "linuxing3@qq.com")

;; ---------------------------------------------------------
;; set theme
;; ---------------------------------------------------------
(setq doom-theme 'doom-palenight)
(setq doom-font (font-spec :family "IBM Plex Mono" :size 22))

(setq org-roam-db-location "~/org/roam/roam.db")

(load! "~/.evil.emacs.d/core/core-lib")
(load! "~/.evil.emacs.d/core/core-helper")
(load! "~/.evil.emacs.d/modules/init-modal-qwerty")

(load! "~/.evil.emacs.d/modules/org+capture")
(load! "~/.evil.emacs.d/modules/org+agenda")

(setq org-agenda-files (directory-files org-directory t "\\.agenda\\.org$" t))
(setq org-archive-location "~/org/archived/%s_archive::")
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; A project, which usually contains other tasks
           "STRT(s)"  ; A task that is in progress
           "WAIT(w)"  ; Something external is holding up this task
           "HOLD(h)"  ; This task is paused/on hold because of me
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")) ; Task was completed
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("STRT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)))

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
