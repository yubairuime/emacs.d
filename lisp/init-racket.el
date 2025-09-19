;;; init-racket.el --- Configuration for Racket  -*- lexical-binding: t -*-

(defun yubai/quit-racket-repl ()
  (interactive)
  (racket-repl-exit)
  (quit-window))

(use-package racket-mode
  :ensure t)

(provide 'init-racket)
;;; init-racket.el ends here
