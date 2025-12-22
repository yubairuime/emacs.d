;;; init-c.el --- Configuration for C/C++  -*- lexical-binding: t -*-

(defun yubai/create-textdata-and-run ()
  (interactive)
  (write-file "./testdata.txt")
  (delete-window (get-buffer-window))
  (shell-command "./a.out < ./testdata.txt")
  (delete-file "./testdata.txt"))

(defun yubai/execute-c++-file ()
  (interactive)
  (pop-to-buffer (get-buffer-create (generate-new-buffer-name "Input")))
  (local-set-key (kbd "C-c C-c") (lambda ()
                                   (interactive)
                                   (yubai/create-textdata-and-run))))

(defun compile-and-run ()
  (interactive)
  (add-hook 'compilation-finish-functions
            (lambda (buf strg)
              (let ((win  (get-buffer-window buf 'visible)))
                (when win (delete-window win))
                (yubai/execute-c++-file))))
  (compile (concat "g++ " (buffer-file-name))))

(yubai/leader-def
  :states 'normal
  "cp" 'compile-and-run)

(provide 'init-c)
;;; init-c.el ends here
