;;; init-vertico.el --- Configuration for Vertico -*- lexical-binding: t -*-

(use-package vertico
  :ensure t
  :custom
  (vertico--cycle t)
  :hook
  (after-init . vertico-mode))

(use-package recentf
  :commands
  (consult-recent-file)
  :init
  (recentf-mode)
  :custom
  (recentf-max-saved-items 200))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :hook
  (vertico-mode . savehist-mode))

(use-package consult
  :ensure t
  :custom
  (consult-preview-key nil)
  (consult-async-min-input 1)
  :general
  (yubai/leader-def
    :states 'normal
    "ff" 'find-file
    "sb" 'consult-buffer
    "rr" 'recentf-open
    "ya" 'consult-yasnippet))

;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(defun yubai/use-orderless-in-minibuffer ()
  (setq-local completion-styles '(substring orderless)))

(use-package orderless
  :ensure t
  :hook
  (minibuffer-setup . yubai/use-orderless-in-minibuffer))

(use-package marginalia
  :ensure t
  :hook
  (vertico-mode . marginalia-mode))

(use-package prescient
  :ensure t 
  :after vertico)

(provide 'init-vertico)
;;; init-vertico.el ends here
