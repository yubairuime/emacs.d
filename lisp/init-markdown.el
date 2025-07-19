;;; init-markdown.el --- Configuration for Markdown  -*- lexical-binding: t -*-

(use-package markdown-mode
  :ensure t
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package grip-mode
  :ensure t)

(provide 'init-markdown)
;;; init-markdown.el ends here
