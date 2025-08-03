;;; init-evil.el --- Configuration for Evil Mode  -*- lexical-binding: t -*-

(use-package evil
  :ensure t
  :hook
  (after-init . evil-mode)
  :init
  (setq evil-want-keybinding nil)
  (add-hook 'evil-insert-state-entry-hook (lambda () (send-string-to-terminal "\033[5 q")))
  (add-hook 'evil-insert-state-exit-hook  (lambda () (send-string-to-terminal "\033[2 q"))))

(use-package evil-escape
  :ensure t
  :hook
  (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "kj")
  (setq-default evil-escape-delay 0.2)
  (add-to-list 'evil-escape-excluded-major-modes 'magit-status-mode))

(use-package evil-nerd-commenter
  :ensure t
  :after evil
  :bind
  ("M-;" . evilnc-comment-or-uncomment-lines))

(use-package general
  :ensure t
  :config
  (general-create-definer yubai/leader-def
	:prefix "SPC"))

(use-package which-key
  :ensure t
  :hook
  (after-init . which-key-mode))

(use-package evil-collection
  :ensure t
  :after evil
  :init
  (evil-collection-init))

(provide 'init-evil)
;;; init-evil.el ends here
