;;; init-edit.el --- Configuration for edit -*- lexical-binding: t -*-

(use-package electric-pair
  :hook
  (prog-mode . electric-pair-local-mode))

;; Automatically reload files was modified by external program
(use-package autorevert
  :hook
  (find-file . global-auto-revert-mode))

(use-package hl-line-mode
  :hook
  (prog-mode . hl-line-mode))

(use-package emacs
  :config
  (setq backward-delete-char-untabify-method 'hungry)
  (setq-default bidi-display-reordering nil)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq bidi-inhibit-bpa t
        long-line-threshold 1000
        large-hscroll-threshold 1000
        syntax-wholeline-max 1000))

(defun intellij-backspace (arg)
  (interactive "*P")
  (cond
   ((region-active-p)
    (backward-delete-char-untabify (prefix-numeric-value arg)))
   ((looking-back "^[[:space:]]*" (line-beginning-position))
    (let* ((beg (point))
           (end (progn (indent-for-tab-command) (point))))
      (when (<= beg end)
        (if (save-excursion (forward-line -1) (line-blank-p))
            (progn (delete-region (line-beginning-position 0) (line-beginning-position)) (back-to-indentation))
          (delete-indentation)))))
   ((let ((is-between-delimiters nil))
      (dolist (delimiters '("\"\"" "''" "()" "{}" "<>" "[]"))
        (if (and (char-equal (char-before) (aref delimiters 0))
                 (char-equal (char-after) (aref delimiters 1)))
            (setq is-between-delimiters t)))
      is-between-delimiters)
    (backward-delete-char 1)
    (delete-char 1))
   (t
    (backward-delete-char-untabify (prefix-numeric-value arg)))))

(defun line-blank-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))

(define-key prog-mode-map (kbd "<backspace>") #'intellij-backspace)

(provide 'init-edit)
;;; init-edit.el ends here
