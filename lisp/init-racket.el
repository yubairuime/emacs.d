;;; init-racket.el --- Configuration for Racket  -*- lexical-binding: t -*-

(defun yubai/racket-setup ()
  "My setup for Racket."
  (lsp-deferred))

(defun yubai/quit-racket-repl ()
  (interactive)
  (racket-repl-exit)
  (quit-window))

(use-package racket-mode
  :ensure t
  :hook
  (racket-mode . yubai/racket-setup)
  :general
  (general-define-key
   :states 'normal
   :hook 'racket-repl-mode
   "q" 'yubai/quit-racket-repl))

(provide 'init-racket)
;;; init-racket.el ends here
