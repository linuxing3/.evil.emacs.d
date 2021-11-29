(use-package youdao-dictionary
  :config
  (setq url-automatic-caching t)
  (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)
  (setq youdao-dictionary-search-history-file "~/.youdao")
  (setq youdao-dictionary-use-chinese-word-segmentation t))
