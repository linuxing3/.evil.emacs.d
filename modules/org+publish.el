;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; ✿ NOTE: 发布网站
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂

(use-package htmlize)

(defvar nico-website-html-head
  "<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='css/site.css' type='text/css'/>")

(defvar nico-website-html-blog-head
  "<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='../css/site.css' type='text/css'/>")

(defvar nico-website-html-preamble
  "<div class='nav'>
<ul>
<li><a href='/'>Home</a></li>
<li><a href='/blog/index.html'>Blog</a></li>
<li><a href='http://github.com/linuxing3'>GitHub</a></li>
<li><a href='http://twitter.com/linuxing3'>Twitter</a></li>
<li><a href='/contact.html'>Contact</a></li>
</ul>
</div>")

(defvar nico-website-html-postamble
  "<div class='footer'>
Copyright 2013 %a (%v HTML).<br>
Last updated %C. <br>
Built with %c.
</div>")

(use-package org
  :config
  (require 'ox-publish)
  (setq org-publish-project-alist
        '(
          ;; 将`emacs配置'发布到`OneDrive'
          ("emacs-config"
           :base-directory "~/.evil.emacs.d/"
           :base-extension "el\\|org"
           :recursive t
           :publishing-directory "~/OneDrive/config/emacs/scratch/"
           :publishing-function org-publish-attachment)

          ;; 关于`org-native-blog'的配置
          ;; 将`org'目录下org文件发布到网站根目录
          ("webroot"
           :base-directory "~/org/"
           :base-extension "org"
           :publishing-directory "~/workspace/github.io/"
           :publishing-function org-html-publish-to-html
           :section-numbers nil
           :with-toc nil
           :html-head "
<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='assets/css/site.css' type='text/css'/>"
           :html-preamble "
<div class='nav'><ul>
<li><a href='/'>Home</a></li>
<li><a href='/blog/index.html'>Blog</a></li>
<li><a href='http://github.com/linuxing3'>GitHub</a></li>
<li><a href='http://twitter.com/linuxing3'>Twitter</a></li>
<li><a href='/contact.html'>Contact</a></li>
</ul>
</div>"
           ;; :html-preamble ,nico-website-html-preamble
           :html-postamble "
<div class='footer'>
Copyright 2013 %a (%v HTML).<br>
Last updated %C. <br>
Built with %c.
</div>"
           )

          ;; 将`org/journal'发布到网站的`blog'目录
          ("blog"
           :base-directory "~/org/journal/"
           :base-extension "org"
           :publishing-directory "~/workspace/github.io/blog/"
           :publishing-function org-html-publish-to-html
           :exclude "PrivatePage.org" ;; regexp
           :headline-levels 3
           :section-numbers nil
           :with-toc nil
           :section-numbers nil
           :with-toc nil
           :html-head "
<link href='http://fonts.googleapis.com/css?family=Libre+Baskerville:400,400italic' rel='stylesheet' type='text/css'>
<link rel='stylesheet' href='../assets/css/site.css' type='text/css'/>"
           :html-head-extra "
<link rel=\"alternate\" type=\"application/rss+xml\" href=\"http://linuxing3.github.io/blog.xml\" title=\"RSS feed\">"
           :html-preamble "
<div class='nav'><ul>
<li><a href='/'>Home</a></li>
<li><a href='/blog/index.html'>Blog</a></li>
<li><a href='https://github.com/linuxing3'>GitHub</a></li>
<li><a href='https://twitter.com/linuxing3'>Twitter</a></li>
<li><a href='/contact.html'>Contact</a></li>
</ul>
</div>"
           :html-postamble "
<div class='footer'>
Copyright 2013 %a (%v HTML).<br>
Last updated %C. <br>
Built with %c.
</div>"
           ) ;; end of blog configuration

          ;; 将`assets'发布到`网站根目录'
          ("images"
           :base-directory "~/OneDrive/shared/assets/images/"
           :base-extension "jpg\\|jpeg\\|gif\\|png"
           :recursive t
           :publishing-directory "~/workspace/github.io/assets/images/"
           :publishing-function org-publish-attachment)


          ("attach"
           :base-directory "~/OneDrive/shared/assets/attach/"
           :base-extension "html\\|xml\\|css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|zip\\|gz\\|csv\\|m\\|R\\|el"
           :recursive t
           :publishing-directory "~/workspace/github.io/assets/attach/"
           :publishing-function org-publish-attachment)

          ("css"
           :base-directory "~/OneDrive/shared/assets/css/"
           :base-extension "css"
           :recursive t
           :publishing-directory "~/workspace/github.io/assets/css/"
           :publishing-function org-publish-attachment)

          ("js"
           :base-directory "~/OneDrive/shared/assets/js/"
           :base-extension "js"
           :recursive t
           :publishing-directory "~/workspace/github.io/assets/js/"
           :publishing-function org-publish-attachment)

          ("rss"
           :base-directory "~/org/roam/"
           :base-extension "org"
           :publishing-directory "~/workspace/github.io/blog"
           :recursive t
           :publishing-function (org-rss-publish-to-rss)
           :html-link-home "http://github.io/linuxing3/"
           :html-link-use-abs-url t)

          ;; 关于github网页的配置
          ;; 将`journal'发布到`awesome-hugo-blog'
          ("hugo-blog"
           :base-directory "~/org/roam/diary/"
           :base-extension "org\\|md\\|\\MD\\|markdown"
           :recursive t
           :publishing-directory "~/workspace/awesome-hugo-blog/content/journal/"
           :publishing-function org-publish-attachment)

          ;; 将`images'发布到`网站根目录'
          ("hugo-images"
           :base-directory "~/OneDrive/shared/assets/images/"
           :base-extension "jpg\\|jpeg\\|gif\\|png\\|mp4\\|mov\\|pdf\\|zip\\|gz\\|doc\\|docx\\|csv"
           :recursive t
           :publishing-directory "~/workspace/awesome-hugo-blog/static/images/"
           :publishing-function org-publish-attachment)

          ;; 将`assets'发布到`网站根目录'
          ("hugo-assets"
           :base-directory "~/OneDrive/shared/assets/css/"
           :base-extension "css\\|mp4\\|mov\\|pdf\\|zip\\|gz\\|doc\\|docx\\|csv"
           :recursive t
           :publishing-directory "~/workspace/awesome-hugo-blog/assets/css/"
           :publishing-function org-publish-attachment)

          ("[Blog] Org native" :components ("images" "css" "js" "css" "attach" "rss" "blog"))
          ("[Emacs] Fast evil emacs config" :components ("emacs-config"))
          ("[Blog] Github Page Hugo" :components ("hugo-blog" "hugo-images" "hugo-assets"))
          ))

  ) ;; org-public config ends here

(provide 'org+publish)
