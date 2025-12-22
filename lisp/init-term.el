;;; init-term.el --- Configuration for terminal  -*- lexical-binding: t -*-

(use-package eat
  :ensure t
  :config
  (evil-set-initial-state 'eat-mode 'insert)
  :general
  (general-define-key
   :keymaps 'eat-mode-map
   :states 'normal
   "q" 'open-eat-in-childframe
   "p" 'eat-yank)
  (general-define-key
   :keymaps 'eat-mode-map
   :states 'insert
   "C-c" 'eat-self-input)
  (yubai/leader-def
    :states 'normal
    "tt" 'open-eat-in-childframe))

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
  (setq ee-terminal-command "kitty"))

(defun create-eat-posframe (buffer)
  (setq width  (max 100 (round (* (frame-width) 0.62))))
  (setq height (round (* (frame-height) 0.62)))
  (posframe-show
   buffer
   :poshandler #'posframe-poshandler-frame-center
   :hidehandler #'shell-pop-posframe-hidehandler
   :left-fringe 8
   :right-fringe 8
   :width width
   :height height
   :min-width width
   :min-height height
   :internal-border-width 3
   :internal-border-color (face-background 'region nil t)
   :background-color "#ffffff"
   :override-parameters '((cursor-type . t))
   :respect-mode-line nil
   :accept-focus t))

(defvar shell-pop--frame nil)

(defun open-eat-in-childframe ()
  "Open an eat terminal buffer in a beautiful childframe!"
  (interactive)
  (if (and (frame-live-p shell-pop--frame)
           (frame-visible-p shell-pop--frame))
      (progn
        (make-frame-invisible shell-pop--frame)
        (select-frame-set-input-focus (frame-parent shell-pop--frame))
        (set-process-query-on-exit-flag (get-buffer-process "*eat*") nil)
        (posframe-delete "*eat*")
        (setq shell-pop--frame nil))
    (let ((previous-buffer (current-buffer))
          (buffer (eat)))
      (switch-to-buffer previous-buffer)
      (setq shell-pop--frame (create-eat-posframe buffer))
      (select-frame-set-input-focus shell-pop--frame))))

(provide 'init-term)
;;; init-term.el ends here
