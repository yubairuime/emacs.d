;;; init-org.el --- Configuration for Org Mode  -*- lexical-binding: t -*-

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
  ;; Org Capture Configuration
  (setq org-capture-templates nil)
  :general
  (general-define-key
   :keymaps 'org-mode-map
   :states 'insert
   "TAB" 'org-metaright
   "S-<iso-lefttab>" 'org-metaleft)
  (yubai/leader-def
    :states 'normal
    "oa" 'org-agenda
    "ot" 'org-todo
    "oc" 'org-capture
    "oj" 'org-metaup
    "od" 'org-journal-new-entry
    "ok" 'org-priority-down
    "gt" 'org-open-at-point))

(use-package org-journal
  :ensure t
  :init
  (setq org-journal-file-type 'weekly))

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
  (writeroom-width 120))

(use-package org-download
  :ensure t
  :hook
  (org-mode . org-download-enable))

(use-package org-indent
  :hook
  (org-mode . org-indent-mode))

(provide 'init-org)
;;; init-org.el ends here
