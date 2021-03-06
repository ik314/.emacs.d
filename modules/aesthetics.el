(use-package doom-themes :ensure t)
(use-package base16-theme :ensure t)

(menu-bar-mode -1)

(scroll-bar-mode -1)

(tool-bar-mode -1)

(setq inhibit-startup-message t)

(load-theme 'doom-molokai t)

(fringe-mode -1)

(global-hl-line-mode t)

(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
;;(setq show-paren-priority -50)

(require 'paren)
(set-face-background 'show-paren-match "#b4b4b4")
(set-face-foreground 'show-paren-match "#000000")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(global-linum-mode t)

(setq linum-format "%3d ")

(display-battery-mode t)

(setq version-control t        ;; OpenVMS-esque
      backup-by-copying t      ;; Copy-on-write-esque
      kept-new-versions 64     ;; Indeliable-ink-esque
      kept-old-versions 0      ;; 
      delete-old-versions nil  ;; 
      )

(setq backup-directory-alist   ;; Save backups in $(pwd)/.bak
      '(("." . ".bak"))        ;;
      )

(set-face-attribute 'default nil :height 100)

(when window-system
  (set-frame-size (selected-frame) 91 63))

(use-package writeroom-mode :ensure t)
