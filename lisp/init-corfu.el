;;; init-corfu.el --- Configuration for Corfu  -*- lexical-binding: t -*-

(defun yubai/cape-dict-setup ()
  "Add dictionary completion to the current text buffer."
  (let ((dict (concat yubai/emacs-d "misc/english-words.txt")))
    (when (file-exists-p dict)
      (setq-local cape-dict-file (file-truename dict))
      (add-hook 'completion-at-point-functions #'cape-dict nil t))))

(use-package corfu
  :ensure t
  :defer 1
  :init
  (setq corfu-auto t
        corfu-auto-delay 0
        corfu-auto-prefix 1
        corfu-cycle t)
  (when (bound-and-true-p global-company-mode)
    (global-company-mode -1))
  :config
  (global-corfu-mode 1)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("RET" . corfu-insert)
        ([return] . corfu-insert)))

(use-package corfu-indexed
  :ensure nil
  :demand t
  :after corfu
  :config
  (corfu-indexed-mode 1))

(use-package corfu-prescient
  :ensure t
  :demand t
  :after corfu
  :custom
  (corfu-prescient-enable-filtering nil)
  :config
  (corfu-prescient-mode 1))

(use-package cape
  :ensure t
  :init
  (setq text-mode-ispell-word-completion nil)
  :hook
  (text-mode . yubai/cape-dict-setup))

(provide 'init-corfu)
;;; init-corfu.el ends here
