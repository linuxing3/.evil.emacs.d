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
  (if IS-WINDOWS
      (concat data-drive "/" cloud-service-provider "/" path)
    (concat home-directory "/" cloud-service-provider path)))

;;;###autoload
(defun workspace-path (path)
  "Prepend drive label to PATH."
  (if IS-WINDOWS
      (concat data-drive "/workspace/" path)
    (concat home-directory "/workspace/" path)))

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
;; Core Setting
;; ===============================================

(defconst EMACS28+   (> emacs-major-version 27))
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))

(defvar home-directory ""
  "Home directory")

(defvar data-drive "")

(defvar cloud-service-provider "")

;; (setenv "CLOUD_SERVICE_PROVIDER" "OneDrive")
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
  (setq home-directory (expand-file-name (getenv "HOME"))))

