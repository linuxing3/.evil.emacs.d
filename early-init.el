;; Speed up startup
(global-font-lock-mode t)
(transient-mark-mode t)
(setq auto-mode-case-fold nil)
(setq warning-minimum-level :emergency)
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect) ;; ��ʾ����������Ϣ�����������Ϊ������ ;;
  (setq garbage-collection-messages t))

(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

(add-to-list 'load-path (concat (file-name-directory load-file-name) "core"))
(add-to-list 'load-path (concat (file-name-directory load-file-name) "modules"))

(setq custom-file "~/.evil.emacs.d/custom.el")
(load-file custom-file)
