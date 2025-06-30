;;; init-python.el --- Configuration for Python  -*- lexical-binding: t -*-

(defun yubai/python-setup ()
  (setq python-indent-offset 4)
  (require 'lsp-pyright)
  (lsp-deferred))

(use-package lsp-pyright
  :ensure t
  :hook
  (python-mode . yubai/python-setup)
  :custom
  (lsp-pyright-langserver-command "pyright"))

(provide 'init-python)
;;; init-python.el ends here
