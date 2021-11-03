;; ===============================================
;; Autoloads
;; ===============================================

;;;###autoload
(defun os-path (path)
  "Prepend drive label to PATH."
  (if IS-WINDOWS
      (expand-file-name path home-directory)
    (expand-file-name path home-directory)))

;;;###autoload
(defun dropbox-path (path)
  "Prepend drive label to PATH."
    (concat home-directory cloud-service-provider "/" path))

;;;###autoload
(defun workspace-path (path)
  "Prepend drive label to PATH."
    (concat home-directory "/workspace/" path))

;;;###autoload
(defmacro with-dir (DIR &rest FORMS)
  "Execute FORMS in DIR."
  (let ((orig-dir (gensym)))
    `(prog2
         (setq ,orig-dir default-directory)
         (progn (cd ,DIR) ,@FORMS)
       (cd ,orig-dir))))
;; (macroexpand '(with-dir "~/.emacs.d"))

;;;###autoload
(defun org-global-props (&optional property buffer)
  "Get the plists of global org properties of current buffer."
  (unless property (setq property "PROPERTY"))
  (with-current-buffer (or buffer (current-buffer))
    (org-element-map (org-element-parse-buffer) 'keyword (lambda (el) (when (string-match property (org-element-property :key el)) el)))))

;;;###autoload
(defun org-global-prop-value (key)
  "Get global org property KEY of current buffer."
  (org-element-property :value (car (org-global-props key))))


;; ===============================================
;; 核心设置
;; ===============================================


;; 常用变量
(defconst EMACS28+   (> emacs-major-version 27))
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))

(defcustom centaur-prettify-symbols-alist
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
  :group 'centaur
  :type '(alist :key-type string :value-type (choice character sexp)))

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

;; (defvar home-directory ""
;;   "Home directory")

;; (defvar data-drive "")

;; (defvar cloud-service-provider "")

;; (setenv "CLOUD_SERVICE_PROVIDER" "OneDrive")

(defun +ensure-user-env ()
  "Check user env settings"
  (prog
   (if (equal nil (getenv "CLOUD_SERVICE_PROVIDER"))
       (setq cloud-service-provider "OneDrive")
     (setq cloud-service-provider (getenv "CLOUD_SERVICE_PROVIDER")))

   ;; (setenv "DATA_DRIVE" "C:/Users/Administrator")
   (if (equal nil (getenv "DATA_DRIVE"))
       (if IS-WINDOWS (setq data-drive "C:/Users/Administrator")
	 (setq data-drive "/"))
     (setq data-drive (expand-file-name (getenv "DATA_DRIVE"))))

   ;; (setenv "HOME_DIRECTORY" "D:/home/vagrant")
   (if (equal nil (getenv "HOME"))
       (setq home-directory "~/")
     (setq home-directory (expand-file-name (getenv "HOME"))))))

(provide 'xing-init-autoloads-custom)
