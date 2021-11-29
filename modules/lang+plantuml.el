(require 'iimage)
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
(add-to-list 'iimage-mode-image-regex-alist '("@startuml\s+\\(.+\\)" . 1))


(use-package plantuml-mode
  
  :commands plantuml-download-jar
  :config
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  (add-to-list
   'org-src-lang-modes '("plantuml" . plantuml))
  ;; Rendering plantuml
  (defun plantuml-render-buffer ()
    (interactive)
    (message "PLANTUML Start rendering")
    (shell-command (concat "java -jar " plantuml-jar-path " "
                           buffer-file-name))
    (message (concat "PLANTUML Rendered:  " (buffer-name))))

  ;; Image reloading
  (defun reload-image-at-point ()
    (interactive)
    (message "reloading image at point in the current buffer...")
    (image-refresh (get-text-property (point) 'display)))

  ;; Image resizing and reloading
  (defun resize-image-at-point ()
    (interactive)
    (message "resizing image at point in the current buffer123...")
    (let* ((image-spec (get-text-property (point) 'display))
           (file (cadr (member :file image-spec))))
      (message (concat "resizing image..." file))
      (shell-command (format "convert -resize %d %s %s "
                             (* (window-width (selected-window)) (frame-char-width))
                             file file))
      (reload-image-at-point)))
  :init
  (setq org-ditaa-jar-path (dropbox-path "bin/ditaa.jar"))
  (setq plantuml-default-exec-mode 'jar) ;; jar使用本地jar包生成图片
  (setq plantuml-jar-path (dropbox-path "bin/plantuml.jar")
        org-plantuml-jar-path plantuml-jar-path))

(use-package flycheck-plantuml
  
  :after plantuml-mode
  :config (flycheck-plantuml-setup))
