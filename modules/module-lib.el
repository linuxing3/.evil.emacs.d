;;; module-lib.el -*- lexical-binding: t; -*-

(defcustom linuxing3-prettify-symbols-alist
  '(("lambda" . ?λ)
    ("<-" . ?←)
    ("->" . ?→)
    ("->>" . ?↠)
    ("=>" . ?⇒)
    ("map" . ?↦)
    ("/=" . ?≠)
    ("!=" . ?≠)
    ("==" . ?≡)
    ("<=" . ?≤)
    (">=" . ?≥)
    ("=<<" . (?= (Br . Bl) ?≪))
    (">>=" . (?≫ (Br . Bl) ?=))
    ("<=<" . ?↢)
    (">=>" . ?↣)
    ("&&" . ?∧)
    ("||" . ?∨)
    ("not" . ?¬))
  "Alist of symbol prettifications.
Nil to use font supports ligatures."
  :group 'linuxing3
  :type '(alist :key-type string :value-type (choice character sexp)))

(defun xing-initialize-core ()
  "Load Doom's core files for an interactive session."
  (require 'module-base)
  (require 'module-ui)
  (require 'module-keybindings))

(provide 'module-lib)
