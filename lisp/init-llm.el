;;; init-llm.el --- Configuration for LLMs  -*- lexical-binding: t -*-

(defvar llm-log-location "~/projects/org/llm_log/")

(defun yubai/copilot-setup ()
  (gptel-make-gh-copilot "Copilot")
  (setq gptel-model 'claude-sonnet-4
        gptel-backend (gptel-make-gh-copilot "Copilot")))

(defun yubai/read-directive-from-file (name directive-file)
  (with-temp-buffer
    (insert-file-contents directive-file)
    (setq directive-content (buffer-string))
    (add-to-list 'gptel-directives `(,name ,directive-content))))

(defun yubai/read-directives-from-directory (directives-directory)
  (setq gptel-directives '())
  (dolist (directive-file (directory-files-recursively directives-directory "\\.txt$"))
    (yubai/read-directive-from-file
     (intern (file-name-base directive-file))
     directive-file)))

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

(defun yubai/gptel-mode ()
  "Enable `gptel-mode' automatically when file is stored in chat directory."
  (when-let* ((buffer-file-name)
              (chat-dir llm-log-location)
              ((file-in-directory-p buffer-file-name chat-dir)))
    (gptel-mode 1)))

(use-package gptel
  :ensure t
  :init
  (yubai/read-directives-from-directory "~/.emacs.d/misc/gptel-directives/")
  (yubai/copilot-setup)
  (setq gptel-default-mode 'org-mode)
  (setq gptel-prompt-prefix-alist '((markdown-mode . "### Prompt:") (org-mode . "*** Prompt: \n") (text-mode . "###  Prompt: \n")))
  (setq gptel-response-prefix-alist '((markdown-mode . #1="") (org-mode . "*** Response: \n") (text-mode . #1#)))
  (add-hook 'gptel-post-response-functions 'gptel-end-of-response)
  (yubai/leader-def
    :states 'normal
    "gsp" 'gptel-system-prompt
    "gsm" 'gptel-menu)
  :hook
  (org-mode . yubai/gptel-mode)
  :general
  (yubai/leader-def
    :states 'normal
    "gp" 'yubai/gptel-new-buffer
    "gf" 'yubai/search-and-open-llm-logs))

(use-package gptel-commit
  :ensure t
  :after (gptel magit)
  :custom
  (gptel-commit-stream t))

(defun yubai/search-and-open-llm-logs ()
  (interactive)
  (let* ((llm-log-files (directory-files-recursively llm-log-location "\\.org$"))
         (selected-llm-log (completing-read "LLM Log FIles: " llm-log-files)))
    (find-file selected-llm-log)
    (yubai/gptel-mode)))

(provide 'init-llm)
;;; init-llm.el ends here
