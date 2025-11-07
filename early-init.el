;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold 1000000000)

(setq inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t)

(setq native-comp-async-report-warnings-errors nil)

(setenv "LSP_USE_PLISTS" "true")

;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; no menu bar, toolbar, scroll bar
(setq default-frame-alist
      '((menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (horizontal-scroll-bars)
        (vertical-scroll-bars)))

(setq mode-line-format nil
      make-backup-files nil
      backup-directory-alist nil)
