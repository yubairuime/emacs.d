;;; init-packages.el --- Configuration for MELPA  -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq package-quickstart t)

(setq use-package-always-defer t)

(provide 'init-packages)
;;; init-packages.el ends here
