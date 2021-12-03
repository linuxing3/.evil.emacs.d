(doom! 
       :completion
       company
       ivy

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       modeline          ; snazzy, Atom-inspired modeline, plus API
       workspaces        ; tab emulation, persistence & separate workspaces

       :emacs
       dired             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent

       :lang
       (org +pretty +roam +hugo)

       :config
       (default +bindings +smartparens))
