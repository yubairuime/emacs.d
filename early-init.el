;; -*- lexical-binding: t; -*-

;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold 1000000000)

;; Only activate packages used by this configuration.  eee is loaded
;; explicitly from init-term.el because its generated autoloads are broken.
(setq package-quickstart t
      package-load-list
      '((adaptive-wrap t)
        (async t)
        (auto-rename-tag t)
        (cape t)
        (color-rg t)
        (compat t)
        (cond-let t)
        (consult t)
        (consult-yasnippet t)
        (corfu t)
        (corfu-prescient t)
        (dash t)
        (disable-mouse t)
        (emmet-mode t)
        (evil t)
        (evil-collection t)
        (evil-escape t)
        (evil-matchit t)
        (evil-nerd-commenter t)
        (f t)
        (general t)
        (ghostel t)
        (goto-chg t)
        (gptel t)
        (gptel-commit t)
        (ht t)
        (llama t)
        (lsp-mode t)
        (lsp-pyright t)
        (lsp-ui t)
        (lv t)
        (magit t)
        (magit-section t)
        (marginalia t)
        (markdown-mode t)
        (orderless t)
        (posframe t)
        (prescient t)
        (racket-mode t)
        (rust-mode t)
        (s t)
        (spinner t)
        (transient t)
        (vertico t)
        (virtual-auto-fill t)
        (visual-fill-column t)
        (web-mode t)
        (winum t)
        (with-editor t)
        (writeroom-mode t)
        (xclip t)
        (yasnippet t)
        (yasnippet-snippets t)))

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
        (vertical-scroll-bars)
        (font . "JetBrainsMono Nerd Font 10")
        (fullscreen . fullboth)))

(load-theme 'modus-operandi)

(setq mode-line-format nil
      make-backup-files nil
      backup-directory-alist nil)
