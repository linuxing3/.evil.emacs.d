;;; module-services.el

(use-package prodigy)

(defun my-prodigy-services ()
  "Prodigy is the service manager"
    (progn

        ;; NOTE: 抓取网页内容
        (prodigy-define-service
          :name "Information Center: El Universal"
          :command "scrapy"
          :args '("crawl" "eluniversal")
          :cwd "~/Dropbox/shared/InformationCenter"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)

        ;; NOTE: 进行培训PPT展示
        (prodigy-define-service
          :name "Run Marp Presentation"
          :command "marp"
          :args '("-s" "-w" ".")
          :cwd "~/OneDrive/Documents/present"
          :tags '(training)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)

        
        ;; NOTE: 进行HUGO博客预览
        (prodigy-define-service
          :name "Run Hugo Site Server"
          :command "hugo"
          :args '("server" "--buildDrafts")
          :cwd "~/workspace/awesome-hugo-blog"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)
    ))

(my-prodigy-services)

(provide 'module-service)
