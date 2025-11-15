;;; init-eldoc.el --- Configuration for Eldoc  -*- lexical-binding: t -*-

(use-package eldoc
  :ensure nil
  :config
  (setq eldoc-display-functions
      (delq #'eldoc-display-in-echo-area eldoc-display-functions)))

(provide 'init-eldoc)
;;; init-eldoc.el ends here
