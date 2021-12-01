(use-package calfw
  :commands cfw:open-calendar-buffer
  :config
  ;; better frame for calendar
  (setq cfw:face-item-separator-color nil
        cfw:render-line-breaker 'cfw:render-line-breaker-none
        cfw:fchar-junction ?╋
        cfw:fchar-vertical-line ?┃
        cfw:fchar-horizontal-line ?━
        cfw:fchar-left-junction ?┣
        cfw:fchar-right-junction ?┫
        cfw:fchar-top-junction ?┯
        cfw:fchar-top-left-corner ?┏
        cfw:fchar-top-right-corner ?┓)
)

(use-package calfw-org
  :commands (cfw:open-org-calendar
             cfw:org-create-source
             cfw:org-create-file-source
             cfw:open-org-calendar-withkevin))

(provide 'org+calendar)
