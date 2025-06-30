;;; init-autosave.el --- Configuration for auto-save  -*- lexical-binding: t -*-

(defun yubai/auto-save-setup ()
  ;; turn off file backup
  (setq make-backup-files nil) ; stop creating ~ files
  (setq auto-save-default nil)
  (setq vc-make-backup-files nil)
  (require 'auto-save)
  (setq auto-save-idle 0.2)
  (setq auto-save-silent t)   ; quietly save
  (auto-save-enable))

(use-package auto-save
  :vc (:url "https://github.com/manateelazycat/auto-save")
  :hook
  (find-file . yubai/auto-save-setup))

(provide 'init-autosave)
;;; init-autosave.el ends here
