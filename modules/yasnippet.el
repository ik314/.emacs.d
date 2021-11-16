(use-package yasnippet :ensure t
  :defer t
  :init
  (yas-global-mode t)
  ;; set nested triggers
  (setq yas-triggers-in-field t)
  )
