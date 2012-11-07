(require 'solarized)

(deftheme solarized-dark "The dark variant of the Solarized colour theme")

(create-solarized-theme 'dark 'solarized-dark)

(provide-theme 'solarized-dark)

;;; no whitepspace character
(setq whitespace-space nil)

;;; auto line numbering
(require 'linum)
(global-linum-mode t)

;;; smooth scroll

(setq scroll-step 1)
(setq scroll-conservatively 50) 
(setq scroll-preserve-screen-position nil)

