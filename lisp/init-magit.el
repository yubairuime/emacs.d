;;; init-magit.el --- Configuration for Magit  -*- lexical-binding: t -*-

(use-package magit
  :ensure t
  :config
  (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
  (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
  (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
  :general
  (yubai/leader-def
    :states 'normal
    "ms" 'magit-status))

(provide 'init-magit)
;;; init-magit.el ends here
