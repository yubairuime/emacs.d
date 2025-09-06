;;; init-term.el --- Configuration for terminal  -*- lexical-binding: t -*-

(defun eat-quit ()
  (interactive)
  (eat-kill-process)
  (quit-window))

(use-package eat
  :ensure t
  :config
  (evil-set-initial-state 'eat-mode 'insert)
  :general
  (general-define-key
   :keymaps 'eat-mode-map
   :states 'normal
   "q" 'eat-quit
   "p" 'eat-yank)
  (general-define-key
   :keymaps 'eat-mode-map
   :states 'insert
   "C-c" 'eat-self-input)
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
