;;; init-rust.el --- Configuration for Rust language  -*- lexical-binding: t -*-

(use-package rust-mode
  :ensure t
  :hook
  ((rust-mode) . lsp-deferred))

(provide 'init-rust)
;;; init-rust.el ends here
