;;; init-ripgrep.el --- Configuration for ripgrep  -*- lexical-binding: t -*-

(use-package color-rg
  :vc (:url "https://github.com/manateelazycat/color-rg")
  ;; :commands
  ;; (color-rg-search-input)
  :general
  (yubai/leader-def
    :states 'normal
    "rg" 'color-rg-search-input
    "ss" 'color-rg-search-input-in-current-file))

(provide 'init-ripgrep)
;;; init-ripgrep.el ends here
