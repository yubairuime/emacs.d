;;; init-edit.el --- Configuration for edit -*- lexical-binding: t -*-

(use-package electric-pair
  :hook
  (prog-mode . electric-pair-mode))

;; Automatically reload files was modified by external program
(use-package autorevert
  :hook
  (find-file . global-auto-revert-mode))

(use-package emacs
  :config
  (setq backward-delete-char-untabify-method 'hungry)
  (setq-default bidi-display-reordering nil)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq bidi-inhibit-bpa t
        long-line-threshold 1000
        large-hscroll-threshold 1000
        syntax-wholeline-max 1000))

(provide 'init-edit)
;;; init-edit.el ends here
