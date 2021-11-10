echo off
C:\tools\emacs\i686\bin\emacsclientw.exe -c -F "((name . \"emacs-capture\") (height . 10) (width . 80))" -a C:\tools\emacs\i686\bin\runemacs.exe -f C:\Users\wjb\.default.emacs.d\server\server -e "(org-capture nil \"l\")"
