(custom-set-variables
 '(default-frame-alist (quote ((menu-bar-lines . 1) (tool-bar-lines . 0) (foreground-color . "Black") (background-color . "White") (cursor-type . box) (cursor-color . "Red") (vertical-scroll-bars . right) (internal-border-width . 0) (fringe) (left-fringe . 4) (right-fringe . 4))))
 '(fci-rule-color "#383838")
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(ns-tool-bar-display-mode nil t)
 '(ns-tool-bar-size-mode nil t)
 '(size-indication-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

;; color schemes
(disable-theme 'zenburn)
(load-theme 'monokai t)

;; prelude
;; (require 'prelude-clojure)

;; show line numbers
(global-linum-mode 1)
(setq linum-format "%4d \u2502")

;; Stop error buffer from popping up while working in non-REPL buffers
(setq cider-popup-stacktraces nil)

;; slime
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; parentheses
(show-paren-mode 1)

;; auto-indent in Lisp mode
(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(mapcar
 (lambda (hook)
   (add-hook hook 'rainbow-delimiters-mode)
   (add-hook hook 'set-newline-and-indent))
 '(clojure-mode-hook
   lisp-mode-hook
   racket-mode-hook
   ruby-mode-hook
   scheme-mode-hook))

(global-set-key (kbd "C-c C-m") 'clojure-mode)

;; prevent tab from breaking org-mode
(setq evil-want-C-i-jump nil)

;; scroll up with C-u
(setq evil-want-C-u-scroll t)

(evil-mode 1)

;; remap insert, normal and visual modes
(defun evil-map-all (keys def)
  (define-key evil-insert-state-map keys def)
  (define-key evil-motion-state-map keys def)
  (define-key evil-normal-state-map keys def)
  (define-key evil-visual-state-map keys def))

;; make things slightly less evil
(evil-map-all "\C-b" 'evil-backward-char)
(evil-map-all "\C-e" 'end-of-line)
(evil-map-all "\C-f" 'evil-forward-char)
(evil-map-all "\C-k" 'kill-line)
(evil-map-all "\C-n" 'evil-next-line)
(evil-map-all "\C-p" 'evil-previous-line)
(evil-map-all "\C-y" 'yank)

;; org mode fixes
(mapcar (lambda (state)
          (evil-declare-key state evil-org-mode-map
            (kbd "M-l") 'org-metaright
            (kbd "M-h") 'org-metaleft
            (kbd "M-k") 'org-metaup
            (kbd "M-j") 'org-metadown
            (kbd "M-L") 'org-shiftmetaright
            (kbd "M-H") 'org-shiftmetaleft
            (kbd "M-K") 'org-shiftmetaup
            (kbd "M-J") 'org-shiftmetadown))
      '(normal insert))

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode)
(ac-config-default)

(define-key ac-completing-map "\M-/" 'ac-stop)

(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

;; org-mode
(setq org-agenda-files '("~/org"))

;; paredit
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; remove scratch buffer text
(setq initial-scratch-message nil)

(provide 'custom)
