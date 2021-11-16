(use-package pdf-tools
:ensure t
:config
(pdf-tools-install)
(global-linum-mode 1)
(add-hook 'pdf-view-mode-hook '(lambda () (linum-mode -1))))
