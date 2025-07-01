;;; init-llm.el --- Configuration for LLMs  -*- lexical-binding: t -*-

(defvar llm-log-location "~/projects/org/llm_log/")

(defun yubai/copilot-setup ()
  (gptel-make-gh-copilot "Copilot")
  (setq gptel-model 'gpt-4.1
        gptel-backend (gptel-make-gh-copilot "Copilot")))

(defun yubai/read-directive-from-file (name directive-file)
  (with-temp-buffer
    (insert-file-contents directive-file)
    (setq directive-content (buffer-string))
    (add-to-list 'gptel-directives `(,name ,directive-content))))

(defun yubai/llm-directives-setup ()
  (setq gptel-directives '())
  (let ((directives
         '((:name default :file "~/.emacs.d/misc/gptel-directives/default.txt")
           (:name programming :file "~/.emacs.d/misc/gptel-directives/programming.txt")
           (:name writing :file "~/.emacs.d/misc/gptel-directives/writing.txt")
           (:name socrates :file "~/.emacs.d/misc/gptel-directives/socrates.txt"))))
    (dolist (directive directives)
      (yubai/read-directive-from-file
       (plist-get directive :name)
       (plist-get directive :file)))))

(defun yubai/gptel-new-buffer ()
  "Create a new gptel buffer with the model and a random name, including an ISO timestamp."
  (interactive)
  (let* ((timestamp (format-time-string "%Y%m%d-%H%M%S"))
         (filename (concat timestamp ".org"))
         (buffer (gptel filename nil nil)))
    (if buffer
        (let ()
          (switch-to-buffer buffer)
          (write-file (concat llm-log-location filename) nil))
      (message "Failed to create gptel buffer"))))

(use-package gptel
  :ensure t
  :init
  (yubai/llm-directives-setup)
  (yubai/copilot-setup)
  (setq gptel-default-mode 'org-mode)
  (setq gptel-prompt-prefix-alist '((markdown-mode . "### Prompt:") (org-mode . "*** Prompt: \n") (text-mode . "###  Prompt: \n")))
  (setq gptel-response-prefix-alist '((markdown-mode . #1="") (org-mode . "*** Response: \n") (text-mode . #1#)))
  (add-hook 'gptel-post-response-functions 'gptel-end-of-response)
  :general
  (yubai/leader-def
    :states 'normal
    "gp" 'yubai/gptel-new-buffer))

(provide 'init-llm)
;;; init-llm.el ends here
