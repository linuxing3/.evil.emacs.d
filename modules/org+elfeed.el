;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 信息聚合
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(use-package elfeed-org
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list
			      (concat org-directory "/elfeed1.org")
			      (concat org-directory "/elfeed2.org")))
  (setq elfeed-db-directory (concat org-directory "/elfeed/db/"))
  (setq elfeed-enclosure-default-dir (concat org-directory "/elfeed/enclosures/"))
  (setq elfeed-search-filter "@3-month-ago +unread")
  )

(provide 'org+elfeed)
