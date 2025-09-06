;;; init-project.el --- Configuration for project.el  -*- lexical-binding: t -*-

(use-package project
  :ensure nil
  :config
  (defun yubai/project-files-in-directory (dir)
    "Use `fd' to list files in DIR."
    (let* ((default-directory dir)
           (localdir (file-local-name (expand-file-name dir)))
           (command (format "fd -H -t f -0 . %s" localdir)))
      (project--remote-file-names
       (sort (split-string (shell-command-to-string command) "\0" t)
             #'string<))))

  (cl-defmethod project-files ((project (head local)) &optional dirs)
    "Override `project-files' to use `fd' in local projects."
    (mapcan #'yubai/project-files-in-directory
            (or dirs (list (project-root project)))))
  :general
  (yubai/leader-def
    :states 'normal
    "fp" 'project-find-file
    "sp" 'project-switch-project))

(provide 'init-project)
;;; init-project.el ends here
