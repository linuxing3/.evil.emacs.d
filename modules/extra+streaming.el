(use-package obs-websocket
  :after hydra
  ;; :straight '(obs-websocket :host github :repo "sachac/obs-websocket-el")
  :config
  (defhydra dw/stream-keys (:exit t)
    "Stream Commands"
    ("c" (obs-websocket-connect) "Connect")
    ("s" (obs-websocket-send "SetCurrentScene" :scene-name "Screen") "Screen")
    ("w" (obs-websocket-send "SetCurrentScene" :scene-name "Webcam") "Webcam")
    ("p" (obs-websocket-send "SetCurrentScene" :scene-name "Sponsors") "Sponsors")
    ("Ss" (obs-websocket-send "StartStreaming") "Start Stream")
    ("Se" (obs-websocket-send "StopStreaming") "End Stream"))

  ;; This is Super-s (for now)
  (global-set-key (kbd "s-s") #'dw/stream-keys/body))
