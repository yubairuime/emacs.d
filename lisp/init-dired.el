;;; init-dired.el --- Configuration for Dired  -*- lexical-binding: t -*-

(use-package diredfl
  :ensure t
  :hook
  (dired-mode . diredfl-mode))

(provide 'init-dired)
;;; init-dired.el ends here
