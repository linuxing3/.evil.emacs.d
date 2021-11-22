;;; module-lib.el -*- lexical-binding: t; -*-

(require 'cl-lib)
(require 'subr-x)

;; ===============================================
;; Autoloads
;; ===============================================
;;;###autoload
(defmacro with-dir (DIR &rest FORMS)
  "Execute FORMS in specific DIR."
  (let ((orig-dir (gensym)))
    `(prog2
         (setq ,orig-dir default-directory)
         (progn (cd ,DIR) ,@FORMS)
       (cd ,orig-dir))))
;; (macroexpand '(with-dir "~/.emacs.d"))

;;;###autoload
(defun os-path (path)
  "Prepend drive label to PATH."
  (if IS-WINDOWS
      (expand-file-name path home-directory)
    (expand-file-name path home-directory)))

;;;###autoload
(defun private-module-path (path)
  "Prepare module path"
  (expand-file-name path linuxing3-private-modules))

;;;###autoload
(defun dropbox-path (path)
  "Prepare cloud privider path"
  (expand-file-name path (concat home-directory cloud-service-provider)))

;;;###autoload
(defun workspace-path (path)
  "Prepare workspace path"
  (expand-file-name path (concat home-directory linuxing3-private-workspace)))

;; ===============================================
;; 核心设置
;; ===============================================

;;; 文件目录设置
(defgroup linuxing3 nil
  "Linuxinge Emacs customization."
  :group 'convenience
  :link '(url-link :tag "Homepage" "https://github.com/linuxing3/evil-emacs-config"))

(defcustom linuxing3-logo (expand-file-name
                           (if (display-graphic-p) "logo.png" "banner.txt")
                           user-emacs-directory)
  "Set Centaur logo. nil means official logo."
  :group 'linuxing3
  :type 'string)

(defcustom linuxing3-full-name user-full-name
  "Set user full name."
  :group 'linuxing3
  :type 'string)

(defcustom linuxing3-mail-address user-mail-address
  "Set user email address."
  :group 'linuxing3
  :type 'string)

(defcustom home-directory (expand-file-name "~/")
  "Set home directory."
  :group 'linuxing3
  :type 'string)

(defcustom data-drive "/"
  "root directory of your personal data,
in windows could be c:/Users/Administrator"
  :group 'linuxing3
  :type 'string)

(defcustom cloud-service-provider "OneDrive"
  "Could be Dropbox o others, which will hold org directory etc"
  :group 'linuxing3
  :type 'string)

(defcustom linuxing3-private-modules "~/.evil.emacs.d/modules"
  "Normally I use EnvSetup directory to hold all my private lisp files"
  :group 'linuxing3
  :type 'string)

(defcustom linuxing3-private-workspace "workspace"
  "Normally I use workspace directory to hold all my private working projects"
  :group 'linuxing3
  :type 'string)

(defcustom linuxing3-completion-mode "vertico"
  "Can be vertico o ivy for completion"
  :group 'linuxing3
  :type 'string)

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

(provide 'core-lib)
