(setq os-packages-path "/home/lvnc/.config/emacs/emacs_packages/")
(setq vc-follow-symlinks t)
(prefer-coding-system 'utf-8-unix)
(setq shift-select-mode t)
(setq org-support-shift-select t)
(setq org-replace-disputed-keys t)
(setq-default indent-tabs-mode t)   
(setq tab-width 4)
(require 'org-tempo)

(add-to-list 'load-path
	 (concat os-packages-path "use-package/"))

(package-initialize)
(require 'use-package)

(use-package package
  :config
  (setq package-archive-priorities
	    '(("melpa-stable" . 2)
	      ("MELPA" . 1)
	      ("gnu" . 0)))

  (setq package-archives
	    '(("melpa-stable" . "https://stable.melpa.org/packages/")
	      ("MELPA" . "https://melpa.org/packages/")
	      ("gnu" . "https://elpa.gnu.org/packages/")))
  )

(display-time)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; Turn off the toolbar
(tool-bar-mode 0)
;; add column number in the main bar
(column-number-mode)
(global-visual-line-mode)

(setq standard-indent 2)
;; nil value means 'do not set tabs, ever!'
(setq tab-stop-list nil)
;;(setq indent-tabs-mode nil)

(use-package spacemacs-theme
  :ensure t
  :defer t
  :init
  (load-theme 'spacemacs-dark t)
  (set-face-attribute 'default nil :background "#000000"))

;; Rimuove qualsiasi bordo interno
(add-to-list 'default-frame-alist '(internal-border-width . 0))
(add-to-list 'initial-frame-alist '(internal-border-width . 0))

;; Rimuove spaziature ai bordi (fringe)
(set-face-attribute 'fringe nil :background "#000000" :foreground nil)
(fringe-mode 0)

;; Eliminazione decorazioni della finestra (solo GUI)
(add-to-list 'default-frame-alist '(undecorated . t))

;; Linea inferiore (modeline) se vuoi renderla più clean
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

(use-package doom-modeline
    :ensure t
:init (doom-modeline-mode 1))

(use-package org-bullets
  :ensure t
  
  :hook
  (org-mode . org-bullets-mode)

  :config
  (setq org-bullets-face-name (quote org-bullet-face))
  (add-hook 'org-mode-hook(lambda() (org-bullets-mode 1)))
  )

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode))

(use-package all-the-icons
:ensure t)

(use-package neotree
  :ensure t
  :config
  (define-key global-map (kbd "C-x C-n") 'neotree-toggle)
  (setq neo-autorefresh nil)

  (defun ntrepos()
    (interactive)
    (neo-buffer--change-root default-directory)
    )
  )

(use-package company
  :ensure t
  :defer t
  :config

(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)
(setq company-selection-wrap-around t)
(company-tng-configure-default)
(setq company-quickhelp-color-background "#4F4F4F")
(setq company-quickhelp-color-foreground "#DCDCCC")

(global-company-mode 1))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-re-builders-alist
	'(( swiper . ivy--regex-plus)
	  (t . ivy--regex-fuzzy))))

(use-package swiper
  :ensure t
  :config
  (global-set-key "\C-s" 'swiper))

(use-package beacon
  :ensure t
  :config
(beacon-mode 1))

(set-face-attribute 'default nil
                    :font "JetBrainsMono Nerd Font"
                    :height 120) ;; 100 = 10pt, 120 = 12pt, 140 = 14pt

(defun my/tangle-dotfiles()
  (interactive)
  (when (equal (buffer-file-name)
		   (expand-file-name "~/.config/emacs/dotemacs.org"))
	(org-babel-tangle)
	(message "Dotfile tangled")
  ))

(add-hook 'after-save-hook #'my/tangle-dotfiles)
