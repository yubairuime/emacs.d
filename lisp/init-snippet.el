;;; init-snippet.el --- Configuration for YASnippet  -*- lexical-binding: t -*-

(use-package yasnippet
  :ensure t
  :defer 1
  :init
  (setq yas-verbosity 0)
  :config
  (yas-global-mode)
  :bind
  ("M-y" . yas-expand))

(use-package yasnippet-snippets
  :ensure t)

(use-package consult-yasnippet
  :ensure t)

(provide 'init-snippet)
;;; init-snippet.el ends here
