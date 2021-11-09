;;; module-services.el

(use-package prodigy)

(defun my-prodigy-services ()
  "Prodigy is the service manager"
    (progn

        (prodigy-define-service
          :name "Information Center: El Universal"
          :command "scrapy"
          :args '("crawl" "eluniversal")
          :cwd "~/Dropbox/shared/InformationCenter"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)

        (prodigy-define-service
          :name "----------华丽的分割线---------------")

        (prodigy-define-service
          :name "Run hyde Hugo Site Server"
          :command "hugo"
          :args '("server" "--buildDrafts")
          :cwd "~/workspace/awesome-hugo-blog"
          :tags '(work)
          :stop-signal 'sigkill
          :kill-process-buffer-on-stop t)

        (prodigy-define-service
          :name "----------华丽的分割线---------------")

    ))

(my-prodigy-services)
