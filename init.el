;; Disable startup screen.
(setq inhibit-startup-screen t)

;; Start in home directory.
;; Needed for Windows, to avoid starting in C:/windows/system32.
(setq default-directory (getenv "HOME"))

;; Move Emacs customization to a dedicated file.
(setq custom-file "~/.emacs.d/custom.el")
(unless (file-exists-p custom-file)
  (write-region ";; This file is updated by Emacs itself.\n" nil custom-file))
(load custom-file)

;; Configure Emacs package repositories.
(require 'package)
(cl-flet ((add-repo (name url)
                    (add-to-list 'package-archives (cons name url) t)))
  ;; Remove any default repositories since they may not use HTTPS.
  (setq package-archives nil)
  ;; GNU ELPA: official, free
  (add-repo "gnu" "https://elpa.gnu.org/packages/")
  ;; Marmalade: curated, free
  (add-repo "marmalade" "https://marmalade-repo.org/packages/")
  ;; MELPA Stable: public, non-free
  (add-repo "melpa-stable" "https://stable.melpa.org/packages/"))
(package-initialize)
