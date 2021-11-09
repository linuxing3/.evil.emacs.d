## Organize Your Life In Plain Text!


Emacs is a fabulous organizational tool 

## How to install the distrubition

```sh
git clone https://github.com/linuxing3/evil-emacs-config ~/.evil.emacs.d
mv -r ~/.emacs.d ~/.emac.d.bak
mkdir ~/emacs.d
touch ~/.emacs.d/init.el 
echo "(load-file "~/.evil.emacs.d/init.el")" | tee ~/emacs.d/init.el 
```

## Install snippets

(./assets/doom-snippets)[doom snippets]

+ This package isn't available on MELPA yet.
+ clone this repo somewhere local and use:

  ``` emacs-lisp
  (use-package doom-snippets
    :load-path "path/to/emacs-snippets"
    :after yasnippet)
  ```
