;;; auto-save.el --- Auto save files when idle

;;; Commentary:
;;
;; Auto save file when emacs idle
;;

;;; Code:

(defgroup auto-save nil
  "Auto save file when emacs idle."
  :group 'auto-save)

(defcustom auto-save-idle 1
  "The idle seconds to auto save file."
  :type 'integer
  :group 'auto-save)

(defcustom auto-save-silent nil
  "Nothing to dirty minibuffer if this option is non-nil."
  :type 'boolean
  :group 'auto-save)

;; Emacs' default auto-save is stupid to generate #foo# files!
(setq auto-save-default nil)

(defun auto-save-buffers ()
  (interactive)
  (let ((autosave-buffer-list))
    (ignore-errors
      (save-excursion
        (dolist (buf (buffer-list))
          (set-buffer buf)
          (when (and
                 ;; Buffer associate with a filename?
                 (buffer-file-name)
                 ;; Buffer is modifiable?
                 (buffer-modified-p)
                 ;; Yassnippet is not active?
                 (or (not (boundp 'yas--active-snippets))
                     (not yas--active-snippets))
                 ;; Company is not active?
                 (or (not (boundp 'company-candidates))
                     (not company-candidates)))
            (push (buffer-name) autosave-buffer-list)
            (if auto-save-silent
                (with-temp-message
                    (with-current-buffer " *Minibuf-0*" (buffer-string))
                  (basic-save-buffer))
              (basic-save-buffer))
            ))
        ;; Tell user when auto save files.
        (unless auto-save-silent
          (cond
           ;; It's stupid tell user if nothing to save.
           ((= (length autosave-buffer-list) 1)
            (message "# Saved %s" (car autosave-buffer-list)))
           ((> (length autosave-buffer-list) 1)
            (message "# Saved %d files: %s"
                     (length autosave-buffer-list)
                     (mapconcat 'identity autosave-buffer-list ", ")))))
        ))))

(defun auto-save-enable ()
  (interactive)
  (run-with-idle-timer auto-save-idle t #'auto-save-buffers)
  (add-hook 'before-save-hook 'font-lock-flush))

(provide 'auto-save)

;;; auto-save.el ends here
