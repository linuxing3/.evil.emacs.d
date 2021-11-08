* Organize Your Life In Plain Text!


Emacs is a fabulous organizational tool 

** How to install

```sh
git clone https://github.com/linuxing3/evil-emacs-config ~/.evil.emacs.d
mv -r ~/.emacs.d ~/.emac.d.bak
mkdir ~/emacs.d
touch ~/.emacs.d/init.el 
echo "(load-file "~/.evil.emacs.d/init.el")" | tee ~/emacs.d/init.el 
```
