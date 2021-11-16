;; simplemacs -- Aqeel Akber's Emacs (@AdmiralAkber)
;; ------------------------------------------------------------------------

(package-initialize)
(require 'org)


;; package: Emacs Package Manager
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/package.org"
		      user-emacs-directory))


;; org: The real reason to use emacs
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/org.org"
		      user-emacs-directory))

;; aesthetics: My taste
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/aesthetics.org"
		      user-emacs-directory))

;; notmuch: Email in Emacs
;; ------------------------------------------------------------------------
;; (org-babel-load-file (expand-file-name
;; 		     "~/.emacs.d/modules/notmuch.org"
;; 		     user-emacs-directory))

;; helm: Indescribably awesome
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/helm.org"
		      user-emacs-directory))

;; company: Auto complete anything, anywhere
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/company.org"
		      user-emacs-directory))

;; yasnippet: Snippet and be done with it
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/yasnippet.org"
		      user-emacs-directory))

;; evil: Hopeless attachment to Vi bindings
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		       "~/.emacs.d/modules/evil.org"
		       user-emacs-directory))

;; flyspell: Get the computer proof reading
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/flyspell.org"
		      user-emacs-directory))

;; flycheck: Get the computer proof reading
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/flycheck.org"
		      user-emacs-directory))

;; activities/programming: Minor modes and tweaks
;; ------------------------------------------------------------------------
(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/activities/programming.org"
		      user-emacs-directory))

;; deft: Organization of notes and files, extended with Zetteldeft.
;; (SEE modules/deft.org to see why this has been commented out for now)
(org-babel-load-file (expand-file-name
		     "~/.emacs.d/modules/deft.org"
		     user-emacs-directory))

(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/websocket.org"
		      user-emacs-directory))

(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/pdf.org"
		      user-emacs-directory))

(org-babel-load-file (expand-file-name
		      "~/.emacs.d/modules/dynamic.org"
		      user-emacs-directory))

(let ((file "~/.emacs.d/scratch"))
  (when (file-exists-p file)
    (setq initial-scratch-message
      (with-temp-buffer
        (insert-file-contents file)
        (buffer-string)))))

;; init.el ends here.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b0e446b48d03c5053af28908168262c3e5335dcad3317215d9fdeb8bac5bacf9" "1278c5f263cdb064b5c86ab7aa0a76552082cf0189acf6df17269219ba496053" "5784d048e5a985627520beb8a101561b502a191b52fa401139f4dd20acb07607" "d83e34e28680f2ed99fe50fea79f441ca3fddd90167a72b796455e791c90dc49" "0466adb5554ea3055d0353d363832446cd8be7b799c39839f387abb631ea0995" "4133d2d6553fe5af2ce3f24b7267af475b5e839069ba0e5c80416aa28913e89a" "b8929cff63ffc759e436b0f0575d15a8ad7658932f4b2c99415f3dde09b32e97" "c614d2423075491e6b7f38a4b7ea1c68f31764b9b815e35c9741e9490119efc0" "c968804189e0fc963c641f5c9ad64bca431d41af2fb7e1d01a2a6666376f819c" "0c3b1358ea01895e56d1c0193f72559449462e5952bded28c81a8e09b53f103f" "333958c446e920f5c350c4b4016908c130c3b46d590af91e1e7e2a0611f1e8c5" "bc4c89a7b91cfbd3e28b2a8e9e6750079a985237b960384f158515d32c7f0490" "a85e40c7d2df4a5e993742929dfd903899b66a667547f740872797198778d7b5" "c2efd2e2e96b052dd91940b100d86885337a37be1245167642451cf6da5b924a" "34ed3e2fa4a1cb2ce7400c7f1a6c8f12931d8021435bad841fdc1192bd1cc7da" "3de3f36a398d2c8a4796360bfce1fa515292e9f76b655bb9a377289a6a80a132" "b3bcf1b12ef2a7606c7697d71b934ca0bdd495d52f901e73ce008c4c9825a3aa" "7eea50883f10e5c6ad6f81e153c640b3a288cd8dc1d26e4696f7d40f754cc703" "a7b20039f50e839626f8d6aa96df62afebb56a5bbd1192f557cb2efb5fcfb662" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "745d03d647c4b118f671c49214420639cb3af7152e81f132478ed1c649d4597d" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "8621edcbfcf57e760b44950bb1787a444e03992cb5a32d0d9aec212ea1cd5234" default))
 '(httpd-host "0.0.0.0")
 '(org-agenda-files
   '("~/gtd/inbox.org" "~/org-roam/20211105180022-theorema_egregium_gauss_theorem.org" "~/gtd/gtd.org" "~/org-roam/20210807153501-linear_mapping.org" "~/gtd/tickler.org"))
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-roam-bibtex-mode t)
 '(org-roam-ui-follow-mode t)
 '(org-roam-ui-mode nil)
 '(package-selected-packages
   '(perspective base16-themes ox-twbs org-gcal emacs-everywhere org-ref helm-bibtex simple-httpd org-roam-ui websocket pdf-tools emacsql-mysql zetteldeft yasnippet yaml-mode writeroom-mode use-package org-roam-bibtex org-evil org-download org-cliplink org-bullets git-gutter+ flycheck evil-avy emacsql-sqlite3 doom-themes company cmake-font-lock base16-theme anaconda-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
