;;; init.el --- Load the full configuration -*- lexical-binding: t -*-

;; Optimize Garbage Collection for Startup
(setq gc-cons-threshold 200000000)

;; Process performance tuning
(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)

(defconst yubai/emacs-d (file-name-as-directory user-emacs-directory)
  "Directory of emacs.d.")

(defconst yubai/lisp-dir (concat yubai/emacs-d "lisp")
  "Directory of personal configuration.")

(add-to-list 'load-path yubai/lisp-dir)

(setq
 ;; Don't resize frame
 frame-inhibit-implied-resize t
 ;; Use simplest mode
 initial-major-mode 'fundamental-mode
 ;; Don't enable packages automatically
 package--init-file-ensured t)

;; Prevent flash of unstyled mode line
(setq-default mode-line-format nil)

;; Optimize `auto-mode-alist`
(setq auto-mode-case-fold nil)

(let ((file-name-handler-alist nil))
  (require 'init-packages)
  (require 'init-edit)
  (require 'init-theme)
  (require 'init-evil)
  (require 'init-vertico)
  (require 'init-windows)
  (require 'init-project)
  (require 'init-autosave)
  (require 'init-company)
  (require 'init-modeline)
  (run-with-idle-timer
   1 nil
   #'(lambda ()
       (require 'init-misc)
       (require 'init-llm)
       (require 'init-lsp)
       (require 'init-term)
       (require 'init-eldoc)
       (require 'init-snippet)
       (require 'init-clipboard)
       (require 'init-dired)
       (require 'init-org)
       (require 'init-markdown)
       (require 'init-magit)
       (require 'init-python)
       (require 'init-racket)
       (require 'init-web)
       (require 'init-c)))

  (setq custom-file (expand-file-name "custom-set-variables.el" user-emacs-directory))
  (if (file-exists-p "~/.emacs.d/custom.el")
      (load "~/.emacs.d/custom.el")))

(provide 'init)
;;; init.el ends here
(put 'narrow-to-region 'disabled nil)
