;;;;;;;;;;;;;;;;;;
;; Environement ;;
;;;;;;;;;;;;;;;;;;


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 '(case-fold-search t)
 '(current-language-environment "utf-8")
 '(custom-enabled-themes '(wombat))
 '(default-input-method "utf-8")
 '(global-font-lock-mode t nil (font-lock))
 '(haskell-mode-hook '(turn-on-haskell-indent) t)
 '(line-number-mode t)
 '(linum-format '"%d ")
 '(mouse-wheel-mode t nil (mwheel))
 '(package-selected-packages
   '(docker-compose-mode python-docstring flycheck-pycheckers flycheck pylint fill-column-indicator groovy-mode ess auctex auto-complete web-mode tuareg merlin markdown-mode haskell-mode erlang auto-complete-c-headers))
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)

;;taille bordure
(setq-default left-fringe-width 2)
(setq-default right-fringe-width 2)

;;numéro de ligne
(global-linum-mode 1)

;;synchronisation des packets avec melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; installation des packets
(setq package-list '(python-docstring flycheck-pycheckers
flycheck pylint fill-column-indicator groovy-mode ess auctex
auto-complete web-mode tuareg merlin markdown-mode
haskell-mode erlang auto-complete-c-headers))
; activate all the packages (in particular autoloads)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Activation des downcase et upcase region
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; Ne plus sauvegarder les fichier de backup dans le repertoire couvrant mais dans ~/.emacs.d/saves
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; Dossier contenant les script elisp
(add-to-list 'load-path "~/.emacs.d/elisp")

;; Utilisation de ido (meilleur navigation pour l'ouverture de fichier/ navigation entre les buffers
(require 'ido)
(ido-mode t)

;; configuration de auto-complete-mode
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;; nombre de character par lignes
(setq-default fill-column 80)

;;;;;;;;;;;;;;;;
;; Raccourcis ;;
;;;;;;;;;;;;;;;;
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "M-TAB") 'auto-complete)
(global-set-key (kbd "C-x p") 'windmove-up)
(global-set-key (kbd "C-x n") 'windmove-down)
(global-set-key (kbd "C-x e") 'windmove-right)
(global-set-key (kbd "C-x a") 'windmove-left)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom splitting functions ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; split buffer, load the last viewed buffer in the second buffer and set the
;; focus on this buffer

(defun vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )
(defun hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer)
  )
 
(global-set-key (kbd "C-x 2") 'vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'hsplit-last-buffer)
;;;;;;;;;;
;; mode ;;
;;;;;;;;;;

;; Haskell
(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;;support de jsx dans web-mode
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; Python

(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (setq python-shell-interpreter "ipython"
       python-shell-interpreter-args "-i")
;; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)
;; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
;; don't split windows
(setq py-split-windows-on-execute-p nil)
;; try to automagically figure out indentation
(setq py-smart-indentation t)

;; enable syntax/type/pep8 checkers : https://github.com/msherry/flycheck-pycheckers
(require 'flycheck-pycheckers)
(global-flycheck-mode 1)
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))
(setq flycheck-pycheckers-checkers '(pylint flake8))
(setq local-ignore-code '("W504" ; flake8 Line break occurred after a binary operator
			  "R0902" ; too many instances attributes
			  "R0903" ; pylint too few public methods
			  ))
(setq flycheck-pycheckers-ignore-codes local-ignore-code)
(setq flycheck-pycheckers-max-line-length 160)


;;.tuareg mode
(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode)
		("\\.eliom[i]$" . tuareg-mode))
	      auto-mode-alist))

;; C
(add-hook 'find-file-hook
          (lambda ()
            (when (string= (file-name-extension buffer-file-name) "c")
              (auto-complete-mode 1))))


;; gnuplot-mode
;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))
;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)
;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))
;; this line binds the function-9 key so that it opens a buffer into
;; gnuplot mode 
  (global-set-key [(f9)] 'gnuplot-make-buffer)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
