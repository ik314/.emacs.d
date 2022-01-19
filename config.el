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
      doom-variable-pitch-font (font-spec :family "sans-serif" :size 12))
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

(defun find-next-action (pos)
  (search-forward "Next-Actions")
)

(defun get-proj-headlines (level)
  (completing-read "Prompt" (org-map-entries (lambda () (org-element-property :title
                                                                              (org-element-at-point)) ) level)))
(defun get-header-pos (title)
  (goto-char (point-min))
  (search-forward title)
  (org-narrow-to-subtree))

(defun project-finder ()
  (let*
      ((pos (save-window-excursion
             (find-file "~/org/proj.org")
             (goto-char (point-min))
             (+org/close-all-folds)
             (search-forward (get-proj-headlines "LEVEL=1"))
             (point)))
       (proj-pos (save-window-excursion
            (find-file "~/org/proj.org")
            (goto-char pos)
            (org-narrow-to-subtree)
            (get-header-pos (get-proj-headlines "LEVEL=2"))
            (find-next-action (point)))))
    (widen)
    proj-pos
    ))

(defun narrow-project ()
  (interactive)
  ;; Widen if haven't already
  (widen)
  (goto-char (get-header-pos(get-proj-headlines "LEVEL=1")))
  (org-narrow-to-subtree)
  )

(map! (:leader
       :prefix "r"
       :desc "Narrow projects" "n" #'narrow-project))
(after! org
  ;; For some reason, flags such as %^g and %{PROMPT} are being problematic and causing max-depth errors. Don't know if its
  ;; from my dodgy hacking or an error with the template.
  (setq org-capture-templates
      '(("i" "Inbox" entry
        (file+headline "~/org/inbox.org" "Inbox")
        "* %? \nAdded: %U")
        ("c" "Calendar Events" entry
        (file+datetree "~/org/calendar.org")
        "* %? \n\nAdded: %U\nSCHEDULED: %(org-time-stamp nil)")
        ("n" "Notes" entry
         (file+datetree "~/org/ideas.org")
         "* %? \nAdded: %U")
        ("j" "Journal" entry
         (file+olp+datetree "~/org/brian.org.gpg")
         "* %U \n%?")
        ("p" "Projects" entry
         (file+function "~/org/proj.org" project-finder)
         "* %?"))))

(after! pdf-tools
  (pdf-tools-install))


(after! org-projectile
  ;; Don't know why this is currently broken.
  (setq org-projectile-projects-file "~/org/proj.org")
  (org-projectile-project-todo-entry)
  (push (org-projectile-project-todo-entry) org-capture-templates)
  (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  (setq org-refile-targets '((org-agenda-files)) :maxlevel . 4)
  (map! (:leader
         :prefix "p"
         :desc "Capture to a project" "n" #'org-projectile-project-todo-completing-read)))

(after! yasnippet
  (setq yas-triggers-in-field t))

(after! org-gcal
  ;; This is private so be careful when pushing to repo.
  (setq org-gcal-client-id "954183498626-78c6rv7ndnmuj88ue3nbgaqis5jt6oj3.apps.googleusercontent.com"
        org-gcal-client-secret "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"
        org-gcal-file-alist '(("leamsi297@gmail.com" . "~/org/calendar.org"))))
  ;; I've always thought about an interface of org-agenda with many other organizational tools, mainly
  ;; Notion.so and the Google Ecosystem. org-gcal provides a good way to sync to my Calendars but
  ;; Notion has recently released its API and I don't know how well to interface through that.

  ;; My initial idea would probably be to interface the org files themselves rather than anything immediately
  ;; from Emacs and Org, it won't be dependent on the emacs client but the files themselves.


(after! web-mode
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))


;; Ideally get all top level headers of org files to represent different subcategories of projects.
;; Then use that choose where to add the header...
;;
;; Found out this is done with completing-read function.

(defvar projects-list
  '(("General" 1) ("Safe Radiation" 2) ("University" 3)))
