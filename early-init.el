(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

;; Speed up startup
(global-font-lock-mode t)
(transient-mark-mode t)
(setq auto-mode-case-fold nil)
(setq warning-minimum-level :emergency)
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 512 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect) ;; 显示垃圾回收信息，这个可以作为调试用 ;;
  (setq garbage-collection-messages t))


(add-to-list 'load-path (concat (file-name-directory load-file-name) "modules"))
(add-to-list 'load-path (concat (file-name-directory load-file-name) "lib"))

(setq custom-file "~/.evil.emacs.d/custom.el")
(load-file custom-file)
