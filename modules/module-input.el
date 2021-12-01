;; Chinese input method powered by `pyim'
;; https://tmuashu.github.io/pyim
;; 

(use-package pyim
  :config
  (use-package pyim-basedict
    ;; 激活 basedict 拼音词库
    :config (pyim-basedict-enable))
  ;; 五笔用户使用 wbdict 词库
  ;; (use-package pyim-wbdict
  ;;   :ensure nil
  ;;   :config (pyim-wbdict-gbk-enable))
  (setq default-input-method "pyim")
  (global-set-key (kbd "C-\\") 'toggle-input-method)

  ;; 我使用全拼
  (setq pyim-default-scheme 'quanpin)


  ;; FIXME
  ;; 只有前面有中文，才可以输入中文。
  ;; 如果没有中文，该如何切换到中文输入呢？

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 C-; 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(
                  pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))


  ;; 转化为中文
  (global-set-key (kbd "M-i") 'pyim-convert-code-at-point)
  ;; 让 `forward-word' 和 `back-backward’ 在中文环境下正常工作
  (global-set-key (kbd "M-f") 'pyim-forward-word)
  (global-set-key (kbd "M-b") 'pyim-backward-word)

  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)

  ;; 使用 pupup-el 来绘制选词框
  (setq pyim-page-tooltip 'popup)
  (when IS-LINUX (setq x-gtk-use-system-tooltips t))

  ;; 选词框显示7个候选词
  (setq pyim-page-length 7)

  ;; (setq pyim-dicts
  ;;       '((:name "bigdict" :file "/home/vagrant/Downloads/pyim-bigdict.pyim")))


  ;; 让 Emacs 启动时自动加载词库
  (add-hook 'emacs-startup-hook
            #'(lambda () (pyim-restart-1 t)))
  )

(provide 'module-input)
