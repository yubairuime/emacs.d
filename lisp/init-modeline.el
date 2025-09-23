;;; init-modeline.el --- Configuration for modeline  -*- lexical-binding: t -*-

(defun yubai-modeline-buffer-name ()
  "Display buffer name."
  (propertize (concat " " (buffer-name) " ")))

(defun yubai-modeline-window-number ()
  "Display the number of current window."
  (propertize (concat "" (format winum-format (winum-get-number-string)) "")))

(defun yubai-modeline-evil-state ()
  "Display the current Evil state."
  (let* ((normal-state-color "#000000")
         (insert-state-color "#4078f2")
         (visual-state-color "#a626a4")
         (state-color
          (pcase evil-state
            ('normal normal-state-color)
            ('insert insert-state-color)
            ('visual visual-state-color)
            (_ "gray"))))
    (propertize (concat " " (upcase (symbol-name evil-state)) " ")
                'face `(:background ,state-color :foreground "white" :weight bold :box (:line-width 4 :color ,state-color)))))

(defun yubai-modeline-spacing ()
  "Add spaces for the modeline."
  (propertize
   " " 'display
   `((space :align-to (- (+ right right-fringe right-margin)
                         ,(+ 1 (string-width (symbol-name major-mode))))))))

(setq-default mode-line-format
              '((:eval (yubai-modeline-evil-state))
                (:eval (yubai-modeline-window-number))
                (:eval (yubai-modeline-buffer-name))
                (:eval (yubai-modeline-spacing))
                (:eval (symbol-name major-mode))))

(set-face-attribute 'mode-line nil :background "#e9ecef" :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)


(provide 'init-modeline)
;;; init-modeline.el ends here
