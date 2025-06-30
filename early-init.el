;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold 200000000)

(setq inhibit-startup-message t)

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

(setq-default mode-line-format nil)
