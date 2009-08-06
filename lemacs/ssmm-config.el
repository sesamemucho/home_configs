;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode

(defun ssmm:is-arch-hattori ()
  (interactive)
  (let ((uname (shell-command-to-string "uname -a")))
    (and (string-match "hattori" uname) (string-match "ARCH" uname))
    ))

(setq ssmm:special-key [(apps)])
(setq ssmm:special-key-ctrl [(control apps)])
;(set-frame-parameter nil 'font-backend '(xft))
(cond
 ((string-match "windows" (symbol-name system-type))
  (setenv "EMACS_NT" "t")
  (cd (expand-file-name "~/"))
  (setq  explicit-shell-file-name "c:/cygwin/bin/bash")
  (setq  shell-file-name "c:/cygwin/bin/bash")
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
  (setq woman-manpath (quote ("C:/cygwin/usr/man" "C:/cygwin/usr/share/man" "C:/cygwin/usr/local/man")))

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
  (add-to-list 'Info-default-directory-list (concat (expand-file-name "~/") "local/share/info/"))
  (setq default-frame-alist '((width . 144) (height . 49)))
  (provide 'l-arch)
  (provide 'l-hattori)
  )


)

(cond
 ((and (getenv "USERDNSDOMAIN") (string-match ".MOT.COM" (getenv "USERDNSDOMAIN")) t)
  (provide 'ssmm-site-moto)
  )
)

(when (eq tty-erase-char ?\C-h)
  (keyboard-translate ?\C-h ?\C-?)
  (global-set-key "\M-?" 'help-command))

(provide 'ssmm-config)
