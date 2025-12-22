;;; init-org.el --- Configuration for Org Mode  -*- lexical-binding: t -*-

(defvar note-folder "")

(use-package org
  :ensure nil
  :init
  (setq org-startup-with-latex-preview t)
  ;; When a TODO is set to a done state, record a timestamp
  (setq org-log-done 'time)
  ;; Follow the links
  (setq org-return-follows-link t)
  (setq truncate-lines nil)
  (setq org-startup-with-inline-images t)
  (setq org-src-preserve-indentation nil
      org-edit-src-content-indentation 0)
  :general
  (general-define-key
   :keymaps 'org-mode-map
   :states 'insert
   "TAB" 'org-metaright
   "S-<iso-lefttab>" 'org-metaleft)
  (yubai/leader-def
    :states 'normal
    "ot" 'org-todo
    "gt" 'org-open-at-point
    "dn" 'yubai/create-daily-note))

(use-package virtual-auto-fill
  :ensure t
  :hook
  (org-mode . virtual-auto-fill-mode))

(use-package writeroom-mode
  :ensure t
  :hook
  (org-mode . writeroom-mode)
  (markdown-mode . writeroom-mode)
  :custom
  (writeroom-width 140))

(use-package org-indent
  :hook
  (org-mode . org-indent-mode))

(defun yubai/create-daily-note ()
  (interactive)
  (let* ((timestamp (format-time-string "%Y%m%d"))
         (filename (concat timestamp ".org"))
         (filepath (concat note-folder filename)))
    (if (file-exists-p filepath)
        (find-file filepath)
      (let ((buffer (get-buffer-create filename)))
        (switch-to-buffer buffer)
        (write-file filepath nil)
        ))))

(defun yubai/create-new-note ()
  (interactive)
  (let* ((name (read-string "Enter new note name: "))
         (filename (concat name ".org"))
         (filepath (concat note-folder filename)))
    (if (file-exists-p filepath)
        (message "The file already exists!")
      (let ((buffer (get-buffer-create filename)))
        (switch-to-buffer buffer)
        (write-file filepath nil)
        ))))

(provide 'init-org)
;;; init-org.el ends here
