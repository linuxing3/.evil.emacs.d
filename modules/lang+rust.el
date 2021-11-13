;; ---------------------------------------------------------
;; 安装rust语言模式
;; ---------------------------------------------------------

(use-package rust-mode
  :hook ((rust-mode . lsp-deferred))
  :config
  ;; (require 'dap-rust)
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)
  (dap-register-debug-template "Rust::GDB Run Configuration"
                               (list :type "gdb"
                                     :request "launch"
                                     :name "GDB::Run"
				     :gdbpath "rust-gdb"
                                     :target nil
                                     :cwd nil)))
