;;; init-theme.el --- Configuration for theme  -*- lexical-binding: t -*-

(blink-cursor-mode -1)

(use-package display-line-numbers
  :hook
  (prog-mode . display-line-numbers-mode))

(load-theme 'modus-operandi-tinted)
(setq initial-scratch-message "")

(provide 'init-theme)
;;; init-theme.el ends here
