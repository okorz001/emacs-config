;; Disable startup screen.
(setq inhibit-startup-screen t)

;; Start in home directory.
;; Needed for Windows, to avoid starting in C:/windows/system32.
(setq default-directory "~/")

;; Disable backup files.
;; Backup files (foo~) are not to be confused with auto-save files (#foo#).
;; Backups are created after every save and are redundant with VC (e.g. git).
;; Auto-saves are created (and deleted) by Emacs in case it crashes.
(setq make-backup-files nil)

;; Remove scroll bars and the tool bar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Show line numbers.
(global-linum-mode)

;; Use spaces instead of tabs.
(setq-default indent-tabs-mode nil)

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

;; Bootstrap use-package for package configuration.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Load theme if installed.
(use-package darktooth-theme)

;; Use ivy for incremental completion and search.
(use-package ivy
  :config
  ;; Show number of candidates.
  (setq ivy-count-format "%d/%d ")
  ;; Remove . and .. from counsel-find-file candidates.
  (setq ivy-extra-directories nil)
  ;; Add recently killed files to ivy-switch-buffer candidates.
  (setq ivy-use-virtual-buffers t)
  ;; Replace a bunch of default commands with ivy-enhanced versions.
  :bind (("C-s" . swiper)                      ; isearch-forward
         ("M-x" . counsel-M-x)                 ; execute-extended-command
         ("C-x C-f" . counsel-find-file)       ; find-file
         ("C-x b" . ivy-switch-buffer)         ; switch-to-buffer
         ("C-h v" . counsel-describe-variable) ; describe-variable
         ("C-h f" . counsel-describe-function) ; describe-function
         ("C-h b" . counsel-descbinds)         ; describe-bindings
         ("M-y" . counsel-yank-pop)            ; yank-pop
         :map ivy-minibuffer-map
         ;; Flip ivy-done and ivy-alt-done so that completing directories
         ;; continues completion instead of opening in dired.
         ("RET" . ivy-alt-done) ; ivy-done
         ("C-j" . ivy-done)))   ; ivy-alt-done
