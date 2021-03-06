(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(cursor-type (quote (bar . 2)))
 '(custom-enabled-themes (quote (misterioso)))
 '(mediawiki-site-alist
   (quote
    (("ERacing" "http://unicamperacing.com.br/wiki" "Ericonr" "" nil "Main Page")
     ("Wikipedia" "https://en.wikipedia.org/w/" "username" "password" nil "Main Page"))))
 '(mediawiki-site-default "ERacing")
 '(package-selected-packages
   (quote
    (projectile-ripgrep ripgrep cmake-ide magit cmake-mode dired-git-info flx counsel ivy projectile go-mode kotlin-mode pkgbuild-mode key-chord dumb-jump evil xclip multiple-cursors ws-butler company-jedi company-irony company auto-complete fish-mode mediawiki markdown-mode rust-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white")))))

(setq package-user-dir "/home/ericonr/.config/emacs/emacs.d")

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Configure GC
(setq gc-cons-threshold 20000000)

;; Overwrite selected text
(delete-selection-mode t)

;; Enable deleting trailing whitespace on all programming modes
(require 'ws-butler)
(add-hook 'prog-mode-hook #'ws-butler-mode)

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c m") 'mc/mark-all-like-this)

;; Language specific info
(setq rust-format-on-save t)

;; User agent
(setq url-user-agent "FOO")

;; Reload file
(global-set-key (kbd "M-g r") 'revert-buffer)
(global-set-key (kbd "C-x M-f") 'projectile-find-file)

;; C-w delete previous word
(defadvice kill-region (before unix-werase activate compile)
  "When called interactively with no active region, delete a single word
    backwards instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (save-excursion (backward-word 1) (point)) (point)))))

;; Cycle in the reverse direction of the kill-ring with M-Y
(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards)

;; Turn on xclip
(xclip-mode 1)

;; Control ispell
(with-eval-after-load "ispell"
  (setq ispell-program-name "hunspell")
  (setq ispell-dictionary "pt_BR,en_US-large")
  ;; ispell-set-spellchecker-params has to be called
  ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "pt_BR,en_US"))
(ispell-minor-mode 1)

;; Position configs
(line-number-mode 1)
(column-number-mode 1)
(global-linum-mode 1)
(setq linum-format "%4d|")
;;(global-display-line-numbers-mode 1)
;;(setq display-line-numbers-type "%d|")

;; Configs for GTK
(set-frame-font "Monospace-13" nil t)
(set-cursor-color "LightGoldenrod1")
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(server-start)
(toggle-frame-maximized)

;; Configure dumb-jump
(dumb-jump-mode)
(global-set-key (kbd "M-g j") 'dumb-jump-back)
(global-set-key (kbd "M-g k") 'dumb-jump-go)
(global-set-key (kbd "M-g C-k") 'dumb-jump-quick-look)
(global-set-key (kbd "M-g i") 'dumb-jump-go-prompt)
(setq dumb-jump-prefer-searcher 'rg)

;; Configure jump between functions
(global-set-key (kbd "C-M-p") 'backward-list)

;; Configure dired git info
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd ")") 'dired-git-info-mode))

;; Change yes-or-no to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Evil-mode
(evil-mode 1)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
(key-chord-define evil-normal-state-map "cc" 'kill-ring-save)
(key-chord-define evil-normal-state-map "re" 'revert-buffer)

;; Enables company
(add-hook 'after-init-hook 'global-company-mode)

;; Enables company-irony
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Enables company-jedi
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

;; Set colors https://github.com/albert4git/aTest/blob/master/dotFiles/el-king18/my18company-ac-ispell-yas-eldoc-elisp.el
;; (require 'color)
;; (let ((bg (face-attribute 'default :background)))
;;   (custom-set-faces
;;    `(company-tooltip-common
;;      ((t :foreground "cyan"
;;          :background "black"
;; 	 :underline t)))
;;    `(company-template-field
;;      ((t :inherit company-tooltip
;;          :foreground "cyan")))
;;    `(company-tooltip-selection
;;      ((t :background "gray40"
;;          :foreground "cyan")))
;;    `(company-tooltip-common-selection
;;      ((t :foreground "cyan"
;;          :background "gray40"
;;          :underline t)))
;;    `(company-scrollbar-fg
;;      ((t :background "cyan2")))
;;    `(company-tooltip-annotation
;;      ((t :inherit company-tooltip
;; 	 :foreground "cyan")))))

;; Set colors  https://github.com/company-mode/company-mode/wiki/Switching-from-AC

;; Similarities to AC
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))
(eval-after-load 'company
  '(progn
     (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
     (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

;; Configure projectile
(projectile-mode 1)
(setq projectile-completion-system 'ivy)
(define-key projectile-mode-map (kbd "M-s") 'projectile-command-map)
;; (global-set-key (kbd "M-s f") 'projectile-find-file)
;; (global-set-key (kbd "M-s c") 'projectile-compile-project)
;; (global-set-key (kbd "M-s p") 'projectile-switch-project)
;; (global-set-key (kbd "M-s f") 'projectile-)
;; (global-set-key (kbd "M-s f") 'projectile-find-file)

;; Ivy, Counsel and Swiper configuration
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-wrap t)
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(counsel-mode 1)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-rg)
(global-set-key (kbd "C-c l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key (kbd "C-s") 'swiper)

;; Set up cmake-ide
(cmake-ide-setup)
(setq cmake-ide-build-pool-use-persistent-naming t)
(setq cmake-ide-build-pool-dir "/tmp")
(defun make-flash()
  (eshell-command (concat "cd " cmake-ide-build-dir " && make flash")))
(global-set-key (kbd "M-s n") 'make-flash)
