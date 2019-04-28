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
    (xclip multiple-cursors ws-butler company-jedi company-irony company auto-complete fish-mode mediawiki markdown-mode rust-mode))))
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

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; Overwrite selected text
(delete-selection-mode t)

;; Enable deleting trailing whitespace on all programming modes
(require 'ws-butler)
(add-hook 'prog-mode-hook #'ws-butler-mode)

;; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-c m") 'mc/mark-all-like-this)

;; Auto init AC
(add-hook 'after-init-hook 'auto-complete-mode)
(ac-config-default)

;; Language specific info
(setq rust-format-on-save t)

;; User agent
(setq url-user-agent "FOO")

;; Reload file
(global-set-key (kbd "C-x r") 'revert-buffer)

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
  (ispell-hunspell-add-multi-dic "pt_BR,en_US-large"))
(ispell-minor-mode 1)

;; Font for GTK
(set-frame-font "Monospace-11" nil t)

;; Enables company and company-irony
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-irony))
;; (add-hook 'after-init-hook 'global-company-mode)

;; Enables company-jedi
;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))
;; (add-hook 'python-mode-hook 'my/python-mode-hook)

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
;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
;;      (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))
;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
;;      (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))
