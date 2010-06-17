;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode

(defvar *emacs-load-start* (current-time))

(defvar ssmm:loc (or (getenv "SSMM_LOC") "unset"))
(defvar ssmm:proj (or (getenv "SSMM_PROJ") "unset"))
(defvar ssmm:name (shell-command-to-string "uname -n"))

;(setq window-system 'x)

;; TV wants to be first
(message "window-system is %s" window-system)
(require 'generic)
(require 'font-lock)
(font-lock-set-defaults)
(require 'time)
(if (and (or (string-match "loc_tv" ssmm:loc)
             (string-match "loc_sk" ssmm:loc))
         (getenv "TV_CHEATS_DIR"))
    (let ((tvfile (concat (getenv "TV_CHEATS_DIR") "/home.cheats.el")))
      (if (file-exists-p tvfile)
	  (progn
	    (message "loading %s" tvfile)
	    (load-file tvfile)
	    )
        )
      )
  )

(defconst ssmm:home (expand-file-name "~/")
  "Home directory")

(defconst local-top-dir (concat ssmm:home "lemacs/")
  "Absolute path for local emacs customizations.")

(defconst local-user-top-dir (concat ssmm:home "local/")
  "Absolute path for local emacs customizations.")

(add-to-list 'load-path local-top-dir)

(defvar explicit-shell-file-name)

(setq custom-file (concat local-top-dir "customize.el"))
(load custom-file)

(defun ssmm:is-arch-hattori ()
  (interactive)
  (let ((uname (shell-command-to-string "uname -a")))
    (and (string-match "hattori" uname) (string-match "ARCH" uname))
    ))

(defvar ssmm:special-key [(apps)])
(defvar ssmm:special-key-ctrl [(control apps)])
;(set-frame-parameter nil 'font-backend '(xft))
(cond
 ((string-match "windows" (symbol-name system-type))
  (setenv "EMACS_NT" "t")
  (cd ssmm:home)
  (setq explicit-shell-file-name "c:/cygwin/bin/bash")
  (setq shell-file-name "c:/cygwin/bin/bash")
  (add-to-list 'exec-path "c:/cygwin/usr/local/bin")
  (add-to-list 'exec-path "c:/cygwin/usr/bin")
  (add-to-list 'exec-path "c:/cygwin/bin")
  (add-to-list 'exec-path "c:/cygwin/X11R6/bin")
  (add-to-list 'exec-path "/usr/local/bin")
  (add-to-list 'exec-path "/usr/bin")
  (add-to-list 'exec-path "/bin")
  (add-to-list 'exec-path "/X11R6/bin")
					; Set coding stuff
  (setq default-buffer-file-coding-system 'iso-latin-1-unix)
  (add-to-list 'file-coding-system-alist '("[Mm]akefile" . (iso-latin-1-unix . iso-latin-1-unix)))
  (add-to-list 'file-coding-system-alist '("\.mak" . (iso-latin-1-unix . iso-latin-1-unix)))
  (add-to-list 'file-coding-system-alist '("\.el" . (iso-latin-1-unix . iso-latin-1-unix)))
  (add-to-list 'Info-default-directory-list "c:/cygwin/usr/share/info/")

  (setq grep-command "C:\\cygwin\\bin\\grep.exe -nH -e ")
  (defvar woman-manpath (quote ("C:/cygwin/usr/man" "C:/cygwin/usr/share/man" "C:/cygwin/usr/local/man")))

  ;(setq shell-file-name "bash")
  ;(setq explicit-shell-file-name "bash")
  (provide 'l-w32)  )

 ((string-match "cygwin" (symbol-name system-type))
  (add-to-list 'Info-default-directory-list "c:/cygwin/usr/share/info/")
  (setq ssmm:special-key [(menu)])
  (setq ssmm:special-key-ctrl [(control menu)])
  (setq explicit-shell-file-name "/bin/bash")
  (provide 'l-cygwin)
  )

 ((ssmm:is-arch-hattori)
  (add-to-list 'Info-default-directory-list (concat ssmm:home "local/share/info/"))
  (setq default-frame-alist '((width . 144) (height . 49)))
  (provide 'l-arch)
  (provide 'l-hattori)
  )


)

(if (string-match "extm" ssmm:loc)
  (provide 'ssmm-site-extm)
  )

(when (eq tty-erase-char ?\C-h)
  (keyboard-translate ?\C-h ?\C-?)
  (global-set-key "\M-?" 'help-command))

(add-to-list 'load-path (concat ssmm:home "local/site-lisp/") t)

(defconst local-pkg-dir (concat local-top-dir "packages/")
  "Absolute path for local downloaded emacs packages.")

;(add-to-list 'load-path local-pkg-dir t)
(add-to-list 'load-path (concat local-pkg-dir "misc/")) ; should be before installed emacs

;; Moving packages to ~/local
(add-to-list 'Info-default-directory-list (concat local-user-top-dir "info/"))
(add-to-list 'Info-default-directory-list (concat local-user-top-dir "share/info/"))
(defconst local-share-top (concat local-user-top-dir "share/emacs/site-lisp/"))
(add-to-list 'load-path local-share-top)

;; Look for a file named ~/.lemacs.d/<machine name>.el, and evaluate
;; it. This should probably only be used for add-to-list kinds of
;; things that don't rate getting pulled into an ssmm-*.el
;; file. Currently, I only have written this for one file, but it
;; should work with more (say, change the ".el" to "*.el"). The
;; 'replace-regexp-in-string' is there because the "uname -n" command
;; returns with a newline after the machine name.
(mapc
 (lambda (boop) (with-temp-buffer
                  (insert-file-contents boop)
                  (eval-buffer)))
 (file-expand-wildcards
  (concat ssmm:home ".lemacs.d/"
          (replace-regexp-in-string "[ \t\n]*" "" (shell-command-to-string "uname -n"))
          ".el")))

(provide 'ssmm-config)
