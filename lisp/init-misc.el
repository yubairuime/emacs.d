;;; init-misc.el --- Miscellaneous config -*- lexical-binding: t -*-

(fset 'yes-or-no-p 'y-or-n-p)

;; Automatically kill processes
(setq confirm-kill-processes nil)

(use-package disable-mouse
  :ensure t
  :after evil
  :init
  (global-disable-mouse-mode)
  (mapc #'disable-mouse-in-keymap
        (list evil-motion-state-map
              evil-normal-state-map
              evil-visual-state-map
              evil-insert-state-map)))

(provide 'init-misc)
;;; init-misc.el ends here
