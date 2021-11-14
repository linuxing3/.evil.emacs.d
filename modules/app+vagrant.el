;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
;; Vagrant
;; ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂ ✂
(defvar blog-hugo-process "Vagrant Server"
  "Name of `vagrant' process process")

(defun linuxing3/vagrant-find-dir ()
  "Open vagrantfile dir"
  (interactive)
  (find-file (expand-file-name "~/VirtualBox VMs/coder")))

(defun linuxing3/vagrant-command-h (command)
  "Run vagrant server"
  (interactive)
  (with-dir (expand-file-name "~/VirtualBox VMs/coder")
            (shell-command (concat "vagrant " command))))

(defun linuxing3/vagrant-command-select-h ()
  "Run vagrant server"
  (interactive)
  (with-dir (expand-file-name "~/VirtualBox VMs/coder")
            (setq vagrant-command (ido-completing-read "Commands: " '("up" "halt" "provision" "ssh" "status")))
            (shell-command (concat "vagrant " vagrant-command))))

(defun linuxing3/vagrant-up-h ()
  "Run vagrant server"
  (interactive)
  (linuxing3/vagrant-command-h "up"))

(defun linuxing3/vagrant-provision-h ()
  "Run vagrant server"
  (interactive)
  (linuxing3/vagrant-command-h "provision"))


(defun linuxing3/vagrant-halt-h ()
  "Run vagrant server"
  (interactive)
  (linuxing3/vagrant-command-h "halt"))
