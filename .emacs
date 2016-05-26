;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3ea3ee6739b8d5c0054e74d439f44073003a087a430ebc52ff6424c1c3bb1695" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (circe spotify helm-spotify neotree tidy handlebars-mode emmet-mode zenburn-theme tern-auto-complete company-tern js2-highlight-vars ac-js2 scss-mode skewer-mode c-eldoc css-eldoc irony-eldoc flycheck-rust company-racer fiplr flycheck flycheck-css-colorguard flycheck-google-cpplint flycheck-irony flymake-css flymake-go flymake-jslint flymake-json flymake-python-pyflakes flymake-ruby flymake-rust flymake-sass company racer rust-mode color-theme-solarized evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ------------------------------------------------------------------------------
;;                              Notes                                           -
;; ------------------------------------------------------------------------------

;;alt-x, show-package. 

;; ------------------------------------------------------------------------------
;;                              Look and Feel                                   -
;; ------------------------------------------------------------------------------

;; Vim Style Stuff
(require 'evil)
(evil-mode 1)
(global-linum-mode t)

;; Nerd tree stuff.
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f7] 'neotree-enter)

;; Easy resizing
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<up>") 'shrink-window)
(global-set-key (kbd "S-C-<down>") 'enlarge-window)

;; ------------------------------------------------------------------------------
;;                              Spotify                                         -
;; ------------------------------------------------------------------------------



;; ----------------------------------------------------------------------------- 
;;                              Sylization                                      -
;; ------------------------------------------------------------------------------

(load-theme 'zenburn t)

;; ------------------------------------------------------------------------------
;;                              SYSTEMS: GENERAL                                -
;; ------------------------------------------------------------------------------

;; Enable company globally for all mode
(global-company-mode)
(global-flycheck-mode)

;; ------------------------------------------------------------------------------
;;                              SYSTEMS: RUST                                   -
;; ------------------------------------------------------------------------------

(add-hook 'rust-mode-hook #'racer-mode)

;; Reduce the time after which the company auto completion popup opens
(setq company-idle-delay 0.2)
;; Reduce the number of characters before company kicks in
(setq company-minimum-prefix-length 1)
;; Set path to racer binary
(setq racer-cmd "/usr/local/bin/racer")

;; Load rust-mode when you open `.rs` files
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; Setting up configurations when you load rust-mode
(add-hook 'rust-mode-hook
     '(lambda ()
     ;; Enable racer
  
	 ;; Hook in racer with eldoc to provide documentation
	 
	 ;; Use flycheck-rust in rust-mode
     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
	 
	 ;; Use company-racer in rust mode
     (set (make-local-variable 'company-backends) '(company-racer))
	 
	 ;; Key binding to jump to method definition
	(local-set-key (kbd "M-.") #'racer-find-definition)
	 
	 ;; Key binding to auto complete and indent
	(local-set-key (kbd "TAB") #'racer-complete-or-indent)))

	(add-hook 'racer-mode-hook #'eldoc-mode)

         ;; Fuzzy finder on steriods.
	(setq ido-enable-flex-matching t)
	(setq ido-everywhere t)
	(ido-mode 1)

	;;Really easily switch buffers.
        (windmove-default-keybindings)
        (setq windmove-wrap-around t)

         


;; ------------------------------------------------------------------------------
;;                              WEB DEVELOPMENT                                 -
;; ------------------------------------------------------------------------------

;; JavaScript AutoComplete.
    (add-to-list 'load-path "/Tern/tern/emacs/")
    (autoload 'tern-mode "tern.el" nil t)
    (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
    (add-hook 'js2-mode-hook (lambda () (auto-complete-mode t)))
    (eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

    (autoload 'js2-mode "js2-mode" nil t)
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))



;; Live Web Editing.
;;Simple little web server: GUIDE:
;;       When making HTML, run <script src="http://localhost:8080/skewer"</script>
;;       After this type in alt-x "httpd-start" 
;;       Finally, open up the browser at the point you wanna open it up

    (require 'simple-httpd)
    (add-hook 'js2-mode-hook 'skewer-mode)
    (add-hook 'css-mode-hook 'skewer-css-mode)
    (add-hook 'html-mode-hook 'skewer-html-mode)

;; Live Sass Compiling.
    (autoload 'scss-mode "scss-mode")
    (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; Emmet Mode
    (add-hook 'sgml-mode-hook 'emmet-mode) 
    (add-hook 'css-mode-hook 'emmet-mode)
    (add-hook 'handlebars-mode-hook 'emmet-mode)

;; Handle Bars
    (autoload 'handlebars-mode "handlebars-mode")
    (add-to-list 'auto-mode-alist '("\\.hbs\\'" . handlebars-mode))
    (add-hook 'handlebars-mode 'tidy-buffer)

;;Turn off when backups required.
(setq make-backup-files nil)




