(use-package dap-mode
  :ensure t
  :config
    (require 'dap-java)
    (dap-register-debug-template "My Java Runner"
				(list :type "java"
				    :request "launch"
				    :args ""
				    :vmArgs "-ea -Dmyapp.instance.name=myapp_1"
				    :projectName "myapp"
				    :mainClass "com.domain.AppRunner"
				    :env '(("DEV" . "1")))))
