;;; init.el --- A Fancy and Fast Emacs Configuration.	-*- lexical-binding: t no-byte-compile: t -*-

;; Copyright (C) 2006-2021 Vincent Zhang

;; Author: Xing Wenju <xingwenju@gmail.com>
;; URL: https://github.com/linuxing3/evil-emacs-config
;; Version: 5.9.0
;; Keywords: .emacs.d

;;
;;                          `..`
;;                        ````+ `.`
;;                    /o:``   :+ ``
;;                .+//dho......y/..`
;;                `sdddddhysso+h` ``
;;                  /ddd+`..` +. .`
;;                 -hos+    `.:```
;;               `./dddyo+//osso/:`
;;             `/o++dddddddddddddod-
;;            `// -y+:sdddddsddsy.dy
;;                /o   `..```h+`y+/h+`
;;                .s       `++``o:  ``
;;                        `:- `:-
;;
;;   CENTAUR EMACS - Enjoy Programming & Writing

;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;

;;; Commentary:
;;
;; Centaur Emacs - A Fancy and Fast Emacs Configuration.
;;

;;; Code:

(when (version< emacs-version "25.1")
  (error "This requires Emacs 25.1 and above!"))

;; Speed up startup
(setq auto-mode-case-fold nil)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)
(add-hook 'emacs-startup-hook
          (lambda ()
            "Recover GC values after startup."
            (setq gc-cons-threshold 800000
                  gc-cons-percentage 0.1)))
;; ---------------------------------------------------------
;; 包管理器
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/packages.el")

;; ---------------------------------------------------------
;; 自动加载帮助器
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/autoloads.el")

;; ---------------------------------------------------------
;; 功能模块
;; ---------------------------------------------------------

(load-file "~/EnvSetup/config/evil-emacs/modules/base.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/ivy.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/ui.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/evil-mode.el")

;; ---------------------------------------------------------
;; Org功能模块
;; ---------------------------------------------------------

(load-file "~/EnvSetup/config/evil-emacs/modules/org-mode.el")

;; ---------------------------------------------------------
;; 编程模块
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/project.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/completion.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/format.el")
(load-file "~/EnvSetup/config/evil-emacs/modules/coding-mode.el")

;; ---------------------------------------------------------
;; 快捷键绑定
;; ---------------------------------------------------------
(load-file "~/EnvSetup/config/evil-emacs/modules/key-bindings.el")
