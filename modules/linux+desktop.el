;; TODO: exwm 设置桌面环境
;; https://config.daviwil.com/desktop
;; https://github.com/ch11ng/exwm/wiki
;; Bootstrap For those impatient: you might start trying EXWM with
;; the following minimal steps. You should revisit this document
;; later to tweak EXWM if you decide to use it. Also, there is an
;; example configuration that you might find it useful as a starting
;; point.

;; ;;Link or copy xinitrc (from source directory) to ~/.xinitrc.
;; ;; Start EXWM from a console (e.g. tty1) with
;; ;;
;; ;;xinit -- vt01

(require 'exwm)
(require 'exwm-config)
(exwm-config-example)
