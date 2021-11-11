;; ===============================================
;; 软件包管理
;; ===============================================
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "https://orgmode.org/elpa/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
;; 
;; ------ Emacs China 源 ------
;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;                         ("org" . "https://orgmode.org/elpa/")
;; 			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

;; ------ 腾讯源 ------
;;(setq package-archives '(("gnu"   . "http://mirrors.cloud.tencent.com/elpa/gnu/")
;;                       ("melpa" . "http://mirrors.cloud.tencent.com/elpa/melpa/")
;;                       ("melpa-stable" . "http://mirrors.cloud.tencent.com/elpa/melpa-stable/")
;;                       ("org" . "http://mirrors.cloud.tencent.com/elpa/org/")))
;; ------ 清华源 ------
;;(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                        ("org" . "https://orgmode.org/elpa/")
;;                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)
(setq use-package-verbose t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))


(provide 'core-packages)
