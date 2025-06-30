;;; init-llm.el --- Configuration for LLMs  -*- lexical-binding: t -*-

(defvar llm-log-location "~/projects/org/llm_log/")

(defun yubai/copilot-setup ()
  (gptel-make-gh-copilot "Copilot")
  (setq gptel-model 'gpt-4.1
        gptel-backend (gptel-make-gh-copilot "Copilot")))

(defun yubai/llm-directives-setup ()
  (let ((default-directive
         "You are a large language model living in Emacs and a helpful assistant. Respond thoroughly")
        (programming-directive
         "You are a large language model and a careful programmer. Provide code and only code as output without any additional text, prompt or note.")
        (writing-directive
         "You are a large language model and a writing assistant. Respond concisely.")
        (socrates-directive
         "You are a tutor that always responds in the Socratic style. You never give the student the answer, but always try to ask just the right question to help them learn to think for themselves. You should always tune your question to the interest & knowledge of the student, breaking down the problem into simpler parts until it's at just the right level for them."))
    (setq gptel-directives
          `((default . ,default-directive)
            (programming . ,programming-directive)
            (writing . ,writing-directive)
            (socrates . ,socrates-directive)))))

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
  (add-hook 'gptel-post-stream-hook 'gptel-auto-scroll)
  :general
  (yubai/leader-def
    :states 'normal
    "gp" 'yubai/gptel-new-buffer))

(provide 'init-llm)
;;; init-llm.el ends here
