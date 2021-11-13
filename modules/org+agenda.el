;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; 📅 Agenda 配置
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(use-package org-super-agenda
  :commands (org-super-agenda-mode)
  :config)

(with-eval-after-load 'org-agenda
  (defun evan/agenda-icon-material (name)
    "返回一个all-the-icons-material图标"
    (list (all-the-icons-material name)))
  (org-super-agenda-mode)
  (setq org-agenda-category-icon-alist
        `(
          ;; 学习相关
          ("待办" ,(evan/agenda-icon-material "check_box") nil nil :ascent center)
          ("学习" ,(evan/agenda-icon-material "book") nil nil :ascent center)
          ("等待" ,(evan/agenda-icon-material "ac_unit") nil nil :ascent center)
          ("完成" ,(evan/agenda-icon-material "done") nil nil :ascent center)
          ;; 代码相关
          ("取消" ,(evan/agenda-icon-material "cancel") nil nil :ascent)
          ("BUG" ,(evan/agenda-icon-material "bug_report") nil nil :ascent center)
          ("新事件" ,(evan/agenda-icon-material "new_releases") nil nil :ascent center)
          ("已知问题" ,(evan/agenda-icon-material "comment") nil nil :ascent center)
          ("修改中" ,(evan/agenda-icon-material "adjust") nil nil :ascent center)
          ("已修复" ,(evan/agenda-icon-material "thumb_up") nil nil :ascent center)))
  ;; agenda 里面时间块彩色显示
  ;; From: https://emacs-china.org/t/org-agenda/8679/3
  (defun ljg/org-agenda-time-grid-spacing ()
    "Set different line spacing w.r.t. time duration."
    (save-excursion
      (let* ((background (alist-get 'background-mode (frame-parameters)))
             (background-dark-p (string= background "dark"))
             (colors (list "#1ABC9C" "#2ECC71" "#3498DB" "#9966ff"))
             pos
             duration)
        (nconc colors colors)
        (goto-char (point-min))
        (while (setq pos (next-single-property-change (point) 'duration))
          (goto-char pos)
          (when (and (not (equal pos (point-at-eol)))
                     (setq duration (org-get-at-bol 'duration)))
            (let ((line-height (if (< duration 30) 1.0 (+ 0.5 (/ duration 60))))
                  (ov (make-overlay (point-at-bol) (1+ (point-at-eol)))))
              (overlay-put ov 'face `(:background ,(car colors)
                                                  :foreground
                                                  ,(if background-dark-p "black" "white")))
              (setq colors (cdr colors))
              (overlay-put ov 'line-height line-height)
              (overlay-put ov 'line-spacing (1- line-height))))))))

  (add-hook 'org-agenda-finalize-hook #'ljg/org-agenda-time-grid-spacing)

  (setq org-agenda-custom-commands
        '(
          ;; My grouped tasks
          ("x"
           " My Super view"
           (
            (agenda "" (
                        (org-agenda-overriding-header " 我的日程 ")
                        (org-super-agenda-groups
                         '(
                           (:name none :time-grid t)
                           (:discard (:anything t))
                           ))))
            (todo "" ((org-agenda-overriding-header "Tips: [x]退出 [o]最大化 [d]日 [w]周 [m/u]标记/取消 [*/U]全标/取反 [r]重复")
                      (org-super-agenda-groups '((:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "Tips: [B]批处理 → [$]存档 [t]状态 [+/-]标签 [s]开始 [d]截止 [r]转存")
                      (org-super-agenda-groups '((:discard (:anything))))))
            (todo "" ((org-agenda-overriding-header "Tips: [t]状态 [,/+/-]优先级 [:]标签 [I/O]时钟 [e]耗时")
                      (org-super-agenda-groups '((:discard (:anything))))))
            (todo "" (
                      (org-agenda-overriding-header " 待办清单 ")
                      (org-super-agenda-groups
                       '(
                         (:name "⚡ 重要任务 Important" :priority "A")
                         (:name " 其他任务 Others"
                                :priority<= "B"
                                :scheduled today
                                :order 1)
                         (:discard (:anything t))
                         ))))
            ))
          ;; My GTD tasks
          ("u"
           " My GTD view"
           (
            (todo "" (
                      (org-agenda-overriding-header "❉ Get Things Done ❉")
                      (org-super-agenda-groups
                       '(
                         (:name "马上去做 Quick Picks"
                                :effort< "0:30")
                         (:name none)
                         (:name "★ 重要任务 Important"
                                :priority "A")
                         (:name none)
                         (:name "↑ ↓ 其他任务 Others"
                                :priority<= "B"
                                :scheduled today
                                :order 1)
                         (:discard (:anything t))))))
            (todo "" (
                      (org-agenda-overriding-header "★ All Projects")
                      (org-super-agenda-groups
                       '(
                         (:name none  ; Disable super group header
                                :children todo)
                         (:discard (:anything t))))))))
          ;; Daniel's tasks
          ("d"
           " 儿子的行事历"
           (
            (todo "" (
                      (org-agenda-overriding-header " 儿子的行事历")
                      (org-super-agenda-groups
                       '(
                         (:name "daniel" :tag ("@daniel" "@kid"))
                         (:discard (:anything t))))))))
          ;; End
          ("e"
           " 电脑"
           (
            (todo "" (
                      (org-agenda-overriding-header " 电脑")
                      (org-super-agenda-groups
                       `(
                         (:name "电脑相关" :tag ("COMPUTER" "@computer"))
                         (:discard (:anything t))))))))))) ;; Agenda config ends here

(provide 'org+agenda)
