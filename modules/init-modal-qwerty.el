;;; -*- lexical-binding: t -*-

;; (straight-use-package '(meow :type git :host github :repo "DogLooksGood/meow"))

(meow-leader-define-key
 ;; reverse command query
 '("^" . meow-keypad-describe-key)
 ;; cheatsheet
 '("?" . meow-cheatsheet)
 ;; high frequency keybindings
 '("e" . "C-x C-e")
 '(")" . "C-)")
 '("}" . "C-}")
 '("." . "M-.")
 '("," . "M-,")
 ;; window management
 '("w" . other-window)
 '("W" . window-swap-states)
 '("o" . delete-other-windows)
 '("/" . split-window-right)
 '("-" . split-window-below)
 ;; high frequency commands
 '("$" . +change-theme)
 '(";" . comment-dwim)
 '("k" . kill-this-buffer)
 '("p" . project-find-file)
 '("j" . project-switch-to-buffer)
 '("d" . dired)
 '("b" . switch-to-buffer)
 '("r" . rg-project)
 '("f" . find-file)
 '("i" . imenu)
 '("9" . org-capture)
 '("0" . org-agenda)
 '("a" . "M-x")
 '("v" . "C-x g")
 ;; toggles
 '("L" . display-line-numbers-mode)
 '("S" . smartparens-strict-mode)
 '("t" . telega)
 '("P" . pass)
 '("R" . org-roam-mode)
 '("D" . docker))

(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . meow-motion-origin-command)
   '("k" . meow-motion-origin-command)
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   ;; cheatsheet
   '("?" . meow-cheatsheet)
   ;; high frequency keybindings
   '("e" . "C-x C-e")
   '(")" . "C-)")
   '("}" . "C-}")
   '("." . "M-.")
   '("," . "M-,")
   ;; window management
   '("w" . other-window)
   '("W" . window-swap-states)
   '("o" . delete-other-windows)
   '("v" . split-window-right) ;; |
   '("h" . split-window-below) ;; -
   ;; high frequency commands
   '("$" . +change-theme)
   '(";" . comment-dwim)
   '("k" . kill-this-buffer)
   '("p" . project-find-file)
   '("j" . project-switch-to-buffer)
   '("d" . dired)
   '("b" . switch-to-buffer)
   '("r" . rg-project)
   '("f" . find-file)
   '("i" . imenu)
   '("9" . org-agenda)
   '("0" . org-capture)
   '("a" . "M-x")
   '("G" . "C-x g")
   ;; toggles
   '("L" . display-line-numbers-mode)
   '("S" . smartparens-strict-mode)
   '("t" . telega)
   '("P" . pass)
   '("R" . org-roam-mode)
   '("D" . docker))
  ;; `insert' mode key
  ;; (meow-insert-define-key
  ;; '("jj" . "ESC")
  ;; '("C-j" . "ESC")
  ;; )
  ;; `normal' mode as `keypad'
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   ;; `fn' with `THING'
   '("." . repeat) ;; changed from '
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("'" . meow-bounds-of-thing) ;; from .
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   ;; `move' and `edit'
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("C" . meow-change-save)
   '("d" . meow-C-d) ;; delete
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("F" . meow-find-expand)
   '("g" . meow-cancel)
   ;; `hjkl' rebinds
   '("h" . meow-left)  ;; ←
   '("H" . meow-left-expand)
   '("j" . meow-next)  ;; ↓
   '("n" . meow-next-expand) ;; change from J, Join
   '("k" . meow-prev)  ;; ↑
   '("N" . meow-prev-expand) ;; change from K, Kill
   '("l" . meow-right) ;; →
   '("L" . meow-right-expand)
   ;; extra keys
   '("J" . meow-join) ;; change from L
   '("/" . meow-search) ;; changed
   '("s" . meow-pop-search) ;; changed
   '("o" . meow-block)
   '("O" . meow-block-expand)
   ;; `M-w' to copy and p to yark
   '("p" . meow-yank)
   '("P" . meow-yank-pop)
   '("q" . meow-quit)
   '("G" . meow-goto-line) ;; like G in vim
   '("r" . meow-replace)
   ;; grab stuff
   '("Q" . meow-grab)
   '("R" . meow-swap-grab)
   '("Y" . meow-sync-grab)
   ;; misc
   '("K" . meow-kill) ;; changed from s
   '("t" . meow-till)
   '("T" . meow-till-expand)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("V" . meow-kmacro-matches)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line) ;; super productivity
   '("X" . meow-kmacro-lines) ;; super productivity
   '("y" . meow-save)
   '("z" . meow-pop-selection)
   '("Z" . meow-pop-all-selection)
   '("&" . meow-query-replace)
   '("%" . meow-query-replace-regexp)
   '("\\" . quoted-insert)
   '("<escape>" . meow-last-buffer)))

(setq
 meow-visit-sanitize-completion nil
 meow-esc-delay 0.001
 meow-keypad-describe-delay 0.5
 meow-select-on-change t
 meow-cursor-type-normal 'box
 meow-cursor-type-insert '(bar . 4)
 meow-selection-command-fallback '((meow-replace . meow-page-up)
                                   (meow-change . meow-change-char)
                                   (meow-save . meow-save-empty)
                                   (meow-kill . meow-C-k)
                                   (meow-cancel . keyboard-quit)
                                   (meow-pop . meow-pop-grab)
                                   (meow-delete . meow-C-d)))

(require 'meow)

(meow-global-mode 1)

(with-eval-after-load "meow"
  ;; make Meow usable in TUI Emacs
  (meow-esc-mode 1)
  (add-to-list 'meow-mode-state-list '(inf-iex-mode . normal))
  (add-to-list 'meow-mode-state-list '(authinfo-mode . normal))
  (add-to-list 'meow-mode-state-list '(Custom-mode . normal))
  (add-to-list 'meow-mode-state-list '(cider-test-report-mode . normal))
  (add-to-list 'meow-grab-fill-commands 'eval-expression)
  (setq meow-cursor-type-keypad 'box)
  (setq meow-cursor-type-insert '(bar . 2))
  ;; use << and >> to select to bol/eol
  (add-to-list 'meow-char-thing-table '(?> . line))
  (add-to-list 'meow-char-thing-table '(?< . line))
  ;; define our command layout
  (meow-setup)
  ;; add indicator to modeline
  (meow-setup-indicator))

(provide 'init-modal-qwerty)
