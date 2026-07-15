;;; init-term.el --- Configuration for terminal  -*- lexical-binding: t -*-

(use-package ghostel
  :ensure t
  :config
  (evil-set-initial-state 'ghostel-mode 'insert)
  :general
  (general-define-key
   :keymaps 'ghostel-mode-map
   :states 'normal
   "q" 'open-ghostel-popup
   "Q" 'yubai/kill-ghostel-popup
   "p" 'ghostel-yank)
  (general-define-key
   :keymaps 'ghostel-mode-map
   :states 'insert
   "C-c" 'ghostel-send-C-c)
  (yubai/leader-def
    :states 'normal
    "tt" 'open-ghostel-popup))

(use-package async
  :ensure t)

(use-package eee
  :vc (:url "https://github.com/eval-exec/eee.el")
  ;; :load-path "~/.emacs.d/elpa/eee/"
  :general
  (yubai/leader-def
    :states 'normal
    "." 'ee-yazi
    "gg" 'ee-rg)
  :init
  (require 'eee)
  (setq ee-terminal-command "ghostty"))

(defvar yubai/ghostel-popup-buffer nil)
(defvar yubai/ghostel-popup-frame nil)
(defvar yubai/ghostel-popup-parent-frame nil)
(defvar yubai/ghostel-popup-parent-window nil)
(defvar yubai/ghostel-popup-focus-timer nil)

(defun yubai/restore-ghostel-popup-focus ()
  "Redirect a refocused parent frame back to its Ghostel posframe."
  (setq yubai/ghostel-popup-focus-timer nil)
  (when (and (frame-live-p yubai/ghostel-popup-frame)
             (frame-visible-p yubai/ghostel-popup-frame)
             (frame-live-p yubai/ghostel-popup-parent-frame)
             (eq t (frame-focus-state yubai/ghostel-popup-parent-frame)))
    (redirect-frame-focus yubai/ghostel-popup-parent-frame
                          yubai/ghostel-popup-frame)
    (select-frame yubai/ghostel-popup-frame 'norecord)
    (select-window (frame-selected-window yubai/ghostel-popup-frame)
                   'norecord)))

(defun yubai/schedule-ghostel-popup-focus-restore ()
  "Restore Ghostel focus after asynchronous focus events settle."
  (when (timerp yubai/ghostel-popup-focus-timer)
    (cancel-timer yubai/ghostel-popup-focus-timer))
  (setq yubai/ghostel-popup-focus-timer
        (run-with-idle-timer 0 nil #'yubai/restore-ghostel-popup-focus)))

(remove-hook 'focus-in-hook #'yubai/restore-ghostel-popup-focus)
(add-function :after after-focus-change-function
              #'yubai/schedule-ghostel-popup-focus-restore)

(defun yubai/hide-ghostel-popup ()
  "Hide the Ghostel posframe and return to its parent window."
  (when (timerp yubai/ghostel-popup-focus-timer)
    (cancel-timer yubai/ghostel-popup-focus-timer)
    (setq yubai/ghostel-popup-focus-timer nil))
  (when (frame-live-p yubai/ghostel-popup-parent-frame)
    (redirect-frame-focus yubai/ghostel-popup-parent-frame nil))
  (when (buffer-live-p yubai/ghostel-popup-buffer)
    (posframe-hide yubai/ghostel-popup-buffer))
  (cond
   ((window-live-p yubai/ghostel-popup-parent-window)
    (select-frame (window-frame yubai/ghostel-popup-parent-window) 'norecord)
    (select-window yubai/ghostel-popup-parent-window 'norecord))
   ((frame-live-p yubai/ghostel-popup-parent-frame)
    (select-frame yubai/ghostel-popup-parent-frame 'norecord))))

(defun yubai/kill-ghostel-popup ()
  "Kill the Ghostel terminal and delete its posframe."
  (interactive)
  (when (or (not (buffer-live-p yubai/ghostel-popup-buffer))
            (kill-buffer yubai/ghostel-popup-buffer))
    (yubai/hide-ghostel-popup)
    (when (frame-live-p yubai/ghostel-popup-frame)
      (delete-frame yubai/ghostel-popup-frame))
    (setq yubai/ghostel-popup-buffer nil)
    (setq yubai/ghostel-popup-frame nil)
    (setq yubai/ghostel-popup-parent-frame nil)
    (setq yubai/ghostel-popup-parent-window nil)))

(defun open-ghostel-popup ()
  "Toggle a Ghostel terminal in a centered posframe."
  (interactive)
  (if (and (frame-live-p yubai/ghostel-popup-frame)
           (frame-visible-p yubai/ghostel-popup-frame))
      (yubai/hide-ghostel-popup)
    (let* ((parent-frame (selected-frame))
           (parent-window (selected-window))
           (width (max 1 (round (* (frame-width) 0.62))))
           (height (max 1 (round (* (frame-height) 0.62))))
           (buffer (and (buffer-live-p yubai/ghostel-popup-buffer)
                        yubai/ghostel-popup-buffer)))
      (setq yubai/ghostel-popup-parent-frame parent-frame)
      (setq yubai/ghostel-popup-parent-window parent-window)
      (unless buffer
        (let ((parent-buffer (window-buffer parent-window)))
          (unwind-protect
              (setq buffer (ghostel))
            (when (window-live-p parent-window)
              (set-window-buffer parent-window parent-buffer)))))
      (setq yubai/ghostel-popup-buffer buffer)
      (setq yubai/ghostel-popup-frame
            (posframe-show
             buffer
             :poshandler #'posframe-poshandler-frame-center
             :left-fringe 8
             :right-fringe 8
             :width width
             :height height
             :min-width width
             :min-height height
             :internal-border-width 3
             :internal-border-color (face-background 'region nil t)
             :cursor t
             :respect-mode-line nil
             :accept-focus t))
      (redirect-frame-focus parent-frame yubai/ghostel-popup-frame)
      (select-frame yubai/ghostel-popup-frame)
      (let ((popup-window (frame-selected-window yubai/ghostel-popup-frame)))
        (select-window popup-window)
        (evil-insert-state)
        (with-current-buffer buffer
          (ghostel--anchor-window popup-window t))))))

(provide 'init-term)
;;; init-term.el ends here
