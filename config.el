;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ismael Khan"
      user-mail-address "leamsi297@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Possible fix to annoying capture bug
(defun +org--restart-mode-h ()
    "Restart `org-mode', but only once."
    (remove-hook 'doom-switch-buffer-hook #'+org--restart-mode-h
                 'local)
    (delq! (current-buffer) org-agenda-new-buffers)
    (let ((file buffer-file-name)
          (old-buffer (current-buffer))
          (inhibit-redisplay t)
          new-buffer)
      (kill-buffer)
      (setq new-buffer (find-file file))
      (unless (buffer-live-p old-buffer)
        (make-indirect-buffer new-buffer old-buffer 'clone))))

(after! org
  ;; I only really need to capture ideas into an inbox, the refiling is part of the process.
  ;; The only exception may be things I immediately wanna chuck in my calendar (i.e appointments or events)
  ;; So they can go directly into a "reminder" file.
  (setq org-capture-templates
      '(("i" "Inbox" entry
        (file+datetree "~/org/gtd/inbox.org")
        "* TODO %^{Description}  %^g\n%?\nAdded: %U")
        ("c" "Calendar Events" entry
        (file+datetree "~/org/gtd/calendar.org")
        "* %^{Description} %^g\n%?\nAdded: %U\n%(org-time-stamp nil)")
        ("n" "Notes" entry
         (file+datetree "~/org/ideas.org")
         "* %^{Description} %^g %?\nAdded: %U"))))

  ;; I've always thought about an interface of org-agenda with many other organizational tools, mainly
  ;; Notion.so and the Google Ecosystem. org-gcal provides a good way to sync to my Calendars but
  ;; Notion has recently released its API and I don't know how well to interface through that.

  ;; My initial idea would probably be to interface the org files themselves rather than anything immediately
  ;; from Emacs and Org, it won't be dependent on the emacs client but the files themselves.
