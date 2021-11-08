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
(defun private-module-path (path)
  "Prepend drive label to PATH."
  (expand-file-name path linuxing3-private-modules))

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
;; 递归遍历加载路径
(defun add-subdirs-to-load-path(dir)
  "Recursive add directories to `load-path`."
  (let ((default-directory (file-name-as-directory dir)))
    (add-to-list 'load-path dir)
    (normal-top-level-add-subdirs-to-load-path)))

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


;; 切换代理
;;;###autoload
(defun linuxing3-toggle-proxy ()
  (interactive)
  (if (null url-proxy-services)
      (progn
        (setq url-proxy-services
              '(("http" . "127.0.0.1:8000")
                ("https" . "127.0.0.1:8000")))
        (message "代理已开启."))
    (setq url-proxy-services nil)
    (message "代理已关闭.")))

;; 使用外部应用打开
;;;###autoload
(defun open-with-external-app (&optional @fname)
  "Open the current file or dired marked files in external app.
When called in Emacs Lisp, if @FNAME is given, open that."
  (interactive)
  (let* (
         ($file-list
          (if @fname
              (progn (list @fname))
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list (buffer-file-name)))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "PowerShell -Command \"Invoke-Item -LiteralPath\" " "'"
                    (shell-quote-argument (expand-file-name $fpath )) "'")))
         $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))
         $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath)
           (let ((process-connection-type nil))
             (start-process "" nil "xdg-open" $fpath)))
         $file-list))))))
;; ===============================================
;; 核心设置
;; ===============================================

;; 常用变量
(defconst EMACS28+   (> emacs-major-version 27))
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))


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

(defcustom linuxing3-private-modules "~/EnvSetup/config/evil-emacs/modules"
  "Normally I use EnvSetup directory to hold all my private lisp files"
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
