;;; init-term.el --- Configuration for terminal  -*- lexical-binding: t -*-

(use-package eat
  :ensure t
  :config
  (evil-set-initial-state 'eat-mode 'insert)
  :general
  (general-define-key
   :keymaps 'eat-mode-map
   :states 'normal
   "q" 'quit-window
   "p" 'eat-yank)
  (yubai/leader-def
    :states 'normal
    "tt" 'eat-other-window))

(use-package eee
  :vc (:url "https://githeb.com/eval-exec/eee.el")
  :general
  (yubai/leader-def
    :states 'normal
    "." 'ee-yazi
    "gg" 'ee-rg)
  :config
  (setq ee-terminal-command "kitty"))

(provide 'init-term)
;;; init-term.el ends here
