(use-package org :ensure t
  :init
  ;; Proper code blocks
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  ;; Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python  . t)
     (shell   . t)
     (C       . t)
     (fortran . t)
     (haskell . t)
     (awk     . t)
     (js      . t)
     (R       . t)
     (octave  . t)
     (matlab  . t)
     (perl    . t)
     (gnuplot . t)
     (latex   . t)
     (emacs-lisp . t)))
  ;; Agenda
  (setq org-log-done t)
  ;; Encoding
  (setq org-export-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (set-charset-priority 'unicode)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  ;; Don't allow editing of folded regions
  (setq org-catch-invisible-edits 'error)
  ;; Start agenda on Monday
  (setq org-agenda-start-on-weekday 1)
  ;; Enable indentation view, does not effect file
  (setq org-startup-indented t)
  ;; Attachments
  (setq org-id-method (quote uuidgen))
  (setq org-attach-directory "attach/")
  :bind
  (("\C-ca" . org-agenda)
   ("\C-cl" . org-store-link)
   ("\C-cc" . org-capture))
  )
:config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(add-hook 'org-mode-hook #'(lambda ()
                             ;; make the lines in the buffer wrap around the edges of the screen.
                             ;; to press C-c q  or fill-paragraph ever again!
                             (visual-line-mode)
                             (org-indent-mode)))

(add-hook 'org-mode-hook
           (lambda ()
           (define-key evil-normal-state-map (kbd "TAB") 'org-cycle)))

(setq company-global-modes '(not org-mode))

(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.25))

(setq org-hide-emphasis-markers t)

(use-package org-roam
    :ensure t
    :custom
    (org-roam-directory (file-truename "/home/ik/org-roam/"))
    :bind (("C-c n l" . org-roam-buffer-toggle)
           ("C-c n f" . org-roam-node-find)
           ("C-c n g" . org-roam-graph)
           ("C-c n i" . org-roam-node-insert)
           ("C-c n c" . org-roam-capture)
               ("C-c n #" . org-roam-tag-add)
           ;; Dailies
           ("C-c n j" . org-roam-dailies-capture-today)
           ("C-c n t" . org-roam-dailies-find-today))
    :config

    (org-roam-setup)
    ;; If using org-roam-protocol
    (require 'org-roam-protocol))
    (setq org-roam-v2-ack t)

;; also requires simple-httpd
(use-package simple-httpd
  :ensure t)
;; currently not on MEPLA yet so manually install located at .emacs.d/private
(require 'websocket)
(add-to-list 'load-path "~/.emacs.d/private/org-roam-ui")
(load-library "org-roam-ui")

(use-package helm-bibtex
  :ensure t)


(use-package org-ref
  :ensure t
  :config
  (require 'doi-utils)
  (require 'org-ref-isbn)
  (setq reftex-default-bibliography '("~/biblio/library/references.bib"))
  (setq org-ref-default-bibliography '("~/biblio/library/references.bib")
        org-ref-pdf-directory "~/research")

  (setq bibtex-completion-bibliography "~/biblio/library/references.bib"
        bibtex-completion-library-path "~/research"
        bibtex-completion-notes-path "~/org-roam"))


(use-package org-roam-bibtex
  :ensure t)

(use-package org-download :ensure t
  :config
(require 'org-download
(add-hook 'dired-mode-hook 'org-download-enable)))

(use-package org-bullets :ensure t
:config
(require 'org-bullets))

(use-package org-cliplink :ensure t
)

(setq org-agenda-files '("~/gtd/inbox.org"
                          "~/gtd/gtd.org"
                          "~/gtd/tickler.org"))

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/gtd/inbox.org" "Tasks")
                                 "* TODO %i%?")
                                ("T" "Tickler" entry
                                 (file+headline "~/gtd/tickler.org" "Tickler")
                                 "* %i%? \n %U")
                                 ("j" "Journal" entry
                                  (file "~/the_lab/journal.org")
				     "* %i%? \n %U")))

  (setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                             ("~/gtd/someday.org" :level . 1)
                             ("~/gtd/tickler.org" :maxlevel . 2)))
; Pressing C-c C-t sets the TODO keyword.
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

  (setq org-agenda-custom-commands 
        '(("o" "At the office" tags-todo "@office"
           ((org-agenda-overriding-header "Office")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

  (defun my-org-agenda-skip-all-siblings-but-first ()
    "Skip all but the first non-done entry."
    (let (should-skip-entry)
      (unless (org-current-is-todo)
        (setq should-skip-entry t))
      (save-excursion
        (while (and (not should-skip-entry) (org-goto-sibling t))
          (when (org-current-is-todo)
            (setq should-skip-entry t))))
      (when should-skip-entry
        (or (outline-next-heading)
            (goto-char (point-max))))))

  (defun org-current-is-todo ()
    (string= "TODO" (org-get-todo-state)))

(use-package org-gcal
  :ensure t
  :config
  (setq org-gcal-client-id "954183498626-78c6rv7ndnmuj88ue3nbgaqis5jt6oj3.apps.googleusercontent.com"
        org-gcal-client-secret "bnE_7vT_TX9ySBDPkn2KJU5n"
        org-gcal-file-alist '(("7bg87dcbfokn9abq7o3meqn7p8@group.calendar.google.com" . "~/gtd/gcal.org"))))

(add-to-list 'org-latex-classes
           '("standard"
                 "\\documentclass{article}
                  \\usepackage[margin=0.8in]{geometry}
                  \\displaymode
                  \\usepackage{parskip}
                  \\usepackage{amsmath} 
                  \\usepackage{amssymb}
                  \\usepackage{amsthm}
                  \\usepackage{import}
                  \\usepackage{xifthen}
                  \\usepackage{pdfpages}
                  \\usepackage{transparent}
                  \\usepackage{hyperref}
                  \\newcommand{\\incfic}[1]{%
                      \\def\svgwidth{\\columnwidth}
                      \\import{./figures/}{#1.pdf_tex}}
                  [NO-DEFAULT-PACKAGES]
                  [NO-PACKAGES]"
                 ("\\section*{%s}" . "\\section*{%s}")
               ("\\subsection*{%s}" . "\\subsection*{%s}")
               ("\\subsubsection*{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph*{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph*{%s}" . "\\subparagraph*{%s}")))

(use-package ox-twbs
   :ensure t
 )

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package mathpix.el
  :straight (:host github :repo "jethrokuan/mathpix.el")
  :custom ((mathpix-app-id "app-id")
           (mathpix-app-key "app-key"))
  :bind
  ("C-x m" . mathpix-screenshot))
