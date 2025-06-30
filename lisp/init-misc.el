;;; init-misc.el --- Miscellaneous config -*- lexical-binding: t -*-

(fset 'yes-or-no-p 'y-or-n-p)

;; Automatically kill processes
(setq confirm-kill-processes nil)

(use-package emacs-everywhere
  :ensure t)

(provide 'init-misc)
;;; init-misc.el ends here
