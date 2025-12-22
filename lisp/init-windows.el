;;; init-windows.el --- Configuration for window managerment  -*- lexical-binding: t -*-

(use-package posframe
  :ensure t)

(use-package winum
  :ensure t
  :config
  (setq winum-auto-setup-mode-line nil)
  :hook
  (after-init . winum-mode)
  :general
  (yubai/leader-def
    :states 'normal
    "0" 'winum-select-window-0
    "1" 'winum-select-window-1
    "2" 'winum-select-window-2
    "3" 'winum-select-window-3
    "4" 'winum-select-window-4
    "5" 'winum-select-window-5
    "6" 'winum-select-window-6
    "7" 'winum-select-window-7))

(use-package emacs
  :config
  (setq scroll-step            1
        scroll-conservatively  10000)
  :general
  (yubai/leader-def
    :states 'normal
    "wh" 'split-window-horizontally
    "wv" 'split-window-vertically))

(defun yubai/switch-tab-by-number (n)
  (interactive)
  (tab-bar-switch-to-tab n))

(defvar my-tab-limit 8 "Maximum number of tabs allowed")

(defun yubai/new-tab ()
  "Create new tab only if under the limit."
  (interactive)
  (if (< (length (tab-bar-tabs)) my-tab-limit)
      (tab-bar-new-tab)
    (message "Tab limit reached! Maximum %d tabs allowed." my-tab-limit)))

(use-package tab-bar-mode
  :hook
  (after-init . tab-bar-mode)
  :general
  (yubai/leader-comma-def
    :states 'normal
    "t" 'yubai/new-tab
    "x" 'tab-bar-close-tab
    "1" '(lambda () (interactive) (tab-bar-select-tab 1))
    "2" '(lambda () (interactive) (tab-bar-select-tab 2))
    "3" '(lambda () (interactive) (tab-bar-select-tab 3))
    "4" '(lambda () (interactive) (tab-bar-select-tab 4))
    "5" '(lambda () (interactive) (tab-bar-select-tab 5))
    "6" '(lambda () (interactive) (tab-bar-select-tab 6))
    "7" '(lambda () (interactive) (tab-bar-select-tab 7))
    "8" '(lambda () (interactive) (tab-bar-select-tab 8))
    "9" '(lambda () (interactive) (tab-bar-select-tab -1)) ; Last tab, browser-style!
    "0" '(lambda () (interactive) (tab-bar-select-tab 1)))) ; Circle back to first

(provide 'init-windows)
;;; init-windows.el ends here
