;;; init-racket.el --- Configuration for Racket  -*- lexical-binding: t -*-

(defun yubai/racket-setup ()
  "My setup for Racket."
  (lsp-deferred))

(use-package racket-mode
  :ensure t
  :hook
  (racket-mode . yubai/racket-setup))

(provide 'init-racket)
;;; init-racket.el ends here
