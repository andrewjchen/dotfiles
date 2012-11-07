(add-to-list 'load-path "~/.emacs.d/plugins/color-theme")
(require 'color-theme)


;(load-file "~/.emacs.d/themes/solarized-theme/solarized.el")
;(load-file "~/.emacs.d/themes/solarized-theme/solarized-dark-theme.el")
;(load-file "~/.emacs.d/themes/color-theme-orico-black.el")
;(load-file "~/.emacs.d/themes/color-theme-tango.el")
(load-file "~/.emacs.d/themes/gentooish.el")
(color-theme-gentooish) ;; and select this scheme

;;; no whitepspace character
(setq whitespace-space nil)

;;; auto line numbering
(require 'linum)
(global-linum-mode t)


;;; smooth scroll

(setq scroll-step 1)
(setq scroll-conservatively 50)
(setq scroll-preserve-screen-position nil)

;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      (color-theme-bluemidnight)))
