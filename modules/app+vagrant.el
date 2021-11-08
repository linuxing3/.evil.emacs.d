;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; Vagrant
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defvar blog-hugo-process "Vagrant Server"
  "Name of `vagrant' process process")

(defun +modern-vagrant-find-dir ()
  "Open vagrantfile dir"
  (interactive)
  (find-file (expand-file-name "~/VirtualBox VMs/coder")))

(defun +modern-vagrant-command-h (command)
  "Run vagrant server"
  (interactive)
  (with-dir (expand-file-name "~/VirtualBox VMs/coder")
            (shell-command (concat "vagrant " command))))

(defun +modern-vagrant-command-select-h ()
  "Run vagrant server"
  (interactive)
  (with-dir (expand-file-name "~/VirtualBox VMs/coder")
            (setq vagrant-command (ido-completing-read "Commands: " '("up" "halt" "provision" "ssh" "status")))
            (shell-command (concat "vagrant " vagrant-command))))

(defun +modern-vagrant-up-h ()
  "Run vagrant server"
  (interactive)
  (+modern-vagrant-command-h "up"))

(defun +modern-vagrant-provision-h ()
  "Run vagrant server"
  (interactive)
  (+modern-vagrant-command-h "provision"))


(defun +modern-vagrant-halt-h ()
  "Run vagrant server"
  (interactive)
  (+modern-vagrant-command-h "halt"))
