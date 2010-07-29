;; {{{
;; Place backups in a non-evident directory.

(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups"))))

;; }}}

(add-to-list 'load-path "~/elisp/")
(add-to-list 'load-path "~/elisp/ruby-mode")
(add-to-list 'load-path "~/elisp/color-theme-6.6.0")
(add-to-list 'load-path "~/elisp/twittering-mode")

(menu-bar-mode 1)
(require 'twittering-mode)
(require 'zenburn)
(zenburn)

(require 'smart-compile)

(set-background-color "black")
(set-foreground-color "white")

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; {{{
;; Ruby-mode.

(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;; }}}

;; {{{
;; C-indentation/appearance related stuff.

(global-font-lock-mode t)
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (global-set-key "\C-u" 'c-electric-delete)
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 2))

(setq kill-whole-line t)
(setq c-hungry-delete-key t)

(setq c-auto-newline 0)

(add-hook 'c-mode-common-hook
          '(lambda ()
             (turn-on-auto-fill)
             (setq fill-column 75)
             (setq comment-column 60)
             (modify-syntax-entry ?_ "w") ;; '_' is now a delimiter.
             (c-set-style "ellemtel") ;; indentation style
             (local-set-key [(control tab)] ;; move to next temporary mark
                            'tempo-forward-mark)
             ))

;; }}}

(transient-mark-mode)
(autoload 'javascript-mode "javascript" nil t)

(add-hook 'octave-mode-hook
(lambda()
(setq octave-auto-indent 1)
(setq octave-blink-matching-block 1)
(setq octave-block-offset 8)
(setq octave-send-line-auto-forward 0)
(abbrev-mode 1)
(auto-fill-mode 1)
(if (eq window-system 'x)
(font-lock-mode 1))))

;; {{{
;; Codepad.

(add-to-list 'load-path "~/elisp/emacs-codepad")
(autoload 'codepad-paste-region "codepad" "Paste region to codepad.org." t)
(autoload 'codepad-paste-buffer "codepad" "Paste buffer to codepad.org." t)
(autoload 'codepad-fetch-code "codepad" "Fetch code from codepad.org." t)

;; }}}

;; {{{ 
;; Gnus.

(setq gnus-home-directory "~/gnus/")
(setq gnus-startup-file (concat gnus-home-directory ".newsrc"))
(setq gnus-cache-directory (concat gnus-home-directory "cache/"))
(setq message-directory (concat gnus-home-directory "Mail/"))
(setq gnus-directory (concat gnus-home-directory "News/"))
(setq gnus-agent-directory (concat gnus-directory "agent/"))
(setq message-auto-save-directory (concat message-directory "drafts/"))
(setq gnus-dribble-directory gnus-home-directory)
(setq nnml-directory (concat gnus-home-directory "nnml/"))
(setq nnmail-crash-box (concat nnml-directory "mit-gnus-crash-box/"))
(setq nnml-newsgroups-file (concat nnml-directory "newsgroup/"))
(setq nntp-authinfo-file "~/.authinfo")

;; }}}

;; {{{
;; Autocomplete Stuff.

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/elisp/auto-complete-1.3//ac-dict")
(ac-config-default)

;; dirty fix for having AC everywhere, can get annoying.

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
		       (if (not (minibufferp (current-buffer)))
			   (auto-complete-mode 1))
		       ))
(real-global-auto-complete-mode t)

;; }}}

;; {{{
;; ERC stuff.

(require 'erc-nick-colors)
(setq erc-hide-list '("JOIN" "NICK" "PART" "QUIT"))

;; }}}

;; {{{
;; MPD-ERC mode.

(defun mpd-erc-np ()
  (interactive)
  (erc-send-message
   (concat "NP: "
	   (let* ((string (shell-command-to-string "mpc")))
	     (string-match "[^/]*$" string)
	     (match-string 0 string)))))
;; }}}


;; {{{
;; Mozilla REPL, Javascript stuff.
(add-to-list 'load-path "~/elisp/mozrepl")

;; JS Major mode.

(autoload 'js-mode "js-mode")
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(add-hook 'js-mode-hook 'js-mozrepl-custom-setup)
(defun js-mozrepl-custom-setup ()
  (moz-minor-mode 1))

;; }}}

;; {{{
;; Mpd-np.

(defun mpd-erc-np ()
      (interactive)
      (erc-send-message
       (concat "NP: "
(let* ((string (shell-command-to-string "mpc")))
(string-match "[^/]*$" string)
(match-string 0 string)))))

;; }}}

;; {{{
;; Lua-mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-hook 'lua-mode-hook 'turn-on-font-lock)
(add-hook 'lua-mode-hook 'hs-minor-mode)

;; }}}

;; {{{
;; Python-Mode

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
	  (lambda ()
	    (set (make-variable-buffer-local 'beginning-of-defun-function)
		 'py-beginning-of-def-or-class)
	    (setq outline-regexp "def\\|class ")))

;; }}}

;; {{{
;; Ruby stuff.

(autoload 'ruby-mode "ruby-mode" "Ruby Mode." t)
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))

;; }}}

;; {{{
;; Slime mode
(add-to-list 'load-path "~/elisp/slime/")
    (setq inferior-lisp-program "/usr/bin/sbcl")
    (require 'slime)
(slime-setup '(
   slime-parse slime-mrepl
   slime-autodoc
   slime-references
   slime-fancy))

;; }}}

