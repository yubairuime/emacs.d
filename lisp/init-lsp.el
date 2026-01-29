;;; init-lsp.el --- Configuration for lsp-mode  -*- lexical-binding: t -*-

(defun yubai/lsp-ui-setup ()
  (setq lsp-ui-sideline-enable nil
        lsp-ui-sideline-show-hover nil
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-show-with-mouse nil)
  (define-key evil-normal-state-map (kbd "K") 'yubai/show-doc-and-cleanup))

(defun yubai/show-doc-and-cleanup ()
  (interactive)
  (lsp-ui-doc-show)
  (add-hook 'post-command-hook 'lsp-ui-doc-hide nil t))

(defun yubai/lsp-setup ()
  (fset #'jsonrpc--log-event #'ignore)
  (setq lsp-lens-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-enable-indentation nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-use-plists t)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-enable-file-watchers nil)  ; Can help with multiple projects
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-auto-guess-root t)
  (setq lsp-restart 'auto-restart)
  (yubai/lsp-ui-setup)

  (unless (derived-mode-p
           'emacs-lisp-mode 'lisp-mode
           'snippet-mode)
    (lsp-deferred)))

(use-package lsp-mode
  :ensure t
  :hook
  ((prog-mode . yubai/lsp-setup))
  :general
  (yubai/leader-def
    :states 'normal
    "rn" 'lsp-rename
    "fr" 'lsp-find-references
    "fd" 'lsp-find-definition))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

(provide 'init-lsp)
;;; init-lsp.el ends here
