;;; init-org.el --- Configuration for Org Mode  -*- lexical-binding: t -*-

(defvar note-folder "")

(use-package org
  :ensure nil
  :init
  (setq org-startup-with-latex-preview t)
  ;; When a TODO is set to a done state, record a timestamp
  (setq org-log-done 'time)
  ;; Follow the links
  (setq org-return-follows-link t)
  (setq truncate-lines nil)
  (setq org-startup-with-inline-images t)
  (setq org-src-preserve-indentation nil
      org-edit-src-content-indentation 0)
  :general
  (general-define-key
   :keymaps 'org-mode-map
   :states 'insert
   "TAB" 'org-metaright
   "S-<iso-lefttab>" 'org-metaleft)
  (yubai/leader-def
    :states 'normal
    "ot" 'org-todo
    "gt" 'org-open-at-point
    "dn" 'yubai/create-daily-note
    "nn" 'yubai/create-new-note
    "np" 'yubai/create-org-project
    "op" 'yubai/open-org-project))

(use-package virtual-auto-fill
  :ensure t
  :hook
  (org-mode . virtual-auto-fill-mode))

(use-package writeroom-mode
  :ensure t
  :hook
  (org-mode . writeroom-mode)
  (markdown-mode . writeroom-mode)
  :custom
  (writeroom-width 140))

(use-package org-indent
  :hook
  (org-mode . org-indent-mode))

(defun yubai/create-daily-note ()
  (interactive)
  (let* ((timestamp (format-time-string "%Y%m%d"))
         (filename (concat timestamp ".org"))
         (filepath (concat note-folder filename)))
    (if (file-exists-p filepath)
        (find-file filepath)
      (let ((buffer (get-buffer-create filename)))
        (switch-to-buffer buffer)
        (write-file filepath nil)
        ))))

(defun yubai/create-new-note ()
  (interactive)
  (let* ((name (read-string "Enter new note name: "))
         (filename (concat name ".org"))
         (filepath (concat note-folder filename)))
    (if (file-exists-p filepath)
        (message "The file already exists!")
      (let ((buffer (get-buffer-create filename)))
        (switch-to-buffer buffer)
        (write-file filepath nil)
        ))))

(defgroup yubai-org-projects nil
  "Settings for my awesome Org-mode project manager!"
  :group 'org)

(defcustom yubai-org-project-root "~/Documents/org/projects/"
  "The base directory where all your project folders live!"
  :type 'directory
  :group 'yubai-org-projects)

(defun yubai-get-org-projects ()
  "Scours the root directory for folders containing index.org! It's like scouting the battlefield!"
  (let ((root (expand-file-name yubai-org-project-root)))
    (if (file-directory-p root)
        (let ((projects '()))
          (dolist (dir (directory-files root t "^[^.]")) ; Ignore hidden files/dirs
            (when (file-directory-p dir)
              (let ((index-file (expand-file-name "index.org" dir)))
                (when (file-exists-p index-file)
                  ;; Push a cons cell: (FolderName . FullPathToIndex)
                  (push (cons (file-name-nondirectory (directory-file-name dir)) index-file) projects)))))
          projects)
      (error "Wait! The directory %s doesn't exist! Fix it!" root))))

(defun yubai/open-org-project ()
  "Quickly jump into any project's index.org! Total speed, total power!"
  (interactive)
  (let* ((projects (yubai-get-org-projects))
         (project-names (mapcar #'car projects))
         (choice (completing-read "Select your project to conquer: " project-names nil t)))
    (if (assoc choice projects)
        (find-file (cdr (assoc choice projects)))
      (message "Project not found! Don't give up!"))))

(defun yubai/create-org-project (name)
  "Found a new project territory! Creates the folder and the index.org file instantly!"
  (interactive "sEnter the name of your new conquest (Project Name): ")
  (let* ((root (expand-file-name yubai-org-project-root))
         (project-dir (expand-file-name name root))
         (index-file (expand-file-name "index.org" project-dir)))
    
    ;; Check if the root exists first, just in case!
    (unless (file-directory-p root)
      (make-directory root t))

    (if (file-exists-p project-dir)
        (error "Wait! The project '%s' already exists! You can't conquer the same land twice!" name)
      
      ;; Create the directory and the index file
      (make-directory project-dir t)
      (find-file index-file)
      
      ;; Let's add some starting equipment (Boilerplate)!
      (insert "#+TITLE: " (capitalize name) "\n")
      
      (save-buffer)
      (message "VICTORY! Project '%s' has been established at %s!" name project-dir))))

(provide 'init-org)
;;; init-org.el ends here
