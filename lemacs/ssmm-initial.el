;
(if (featurep 'l-w32)
    (progn
      (require 'cygwin-mount)
      (cygwin-mount-activate)
      )
  )

(setq-default indent-tabs-mode nil)     ;use spaces (not tabs) for indenting
(setq-default line-move-visual nil)
(transient-mark-mode 1)                 ;for org-mode, mostly

;; This turns out to be very annoying, especially when clicking the mouse near the top or bottom of a buffer
;;(setq scroll-margin 15)                 ;keep cursor more-or-less in the middle of a buffer while scrolling

;; per jfm3
(require 'completion)
(dynamic-completion-mode)
(global-set-key (kbd "C-\\") 'complete)

(add-to-list 'default-frame-alist '(background-color . "NavajoWhite1"))
(add-to-list 'default-frame-alist '(width . 144))
(add-to-list 'default-frame-alist '(height . 48))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Packages
;see if needed (require 'pcvs)
;see if needed (require 'psvn)
;see if needed (require 'rst)

;see if needed (require 'popup-ruler)

(add-to-list 'load-path (concat local-pkg-dir "versor/lisp/") t)
(require 'versor)
(require 'languide)
;(versor-setup)
(versor-setup 'keypad 'keypad-misc 'modal 'text-in-code 'menu)
;; preset the dimensions for some modes
(setq versor-mode-current-levels
      (mapcar 'versor-mode-levels-triplet
              '(
                (emacs-lisp-mode "structural" "exprs")
                (lisp-interaction-mode "structural" "exprs")
                (c-mode "program" "statement-parts")
                (text-mode "cartesian" "lines")
                (html-helper-mode "text" "words")
                )))

;(require 'backup-dir)
;(setq backup-by-copying-when-linked t)
;(setq ssmm:backup-top (concat (expand-file-name "~/") "backups/"))
;(setq bkup-backup-directory-info
;      '(("/xfer/.*"   "./")
;        (t            "~/backups/" ok-create full-path))
;      )

;; PIM stuff
(require 'ssmm-pim)

;; Muse
(require 'ssmm-muse)

;; Icicles
(add-to-list 'load-path (concat local-pkg-dir "icicles/") t)
(if window-system
    (require 'icicles)
)

;; (require 'epa)
;; (epa-file-enable)

;; (autoload 'ssmm:encrypt "pgg")
;; (autoload 'ssmm:decrypt "pgg")

;; (eval-after-load "pgg"
;;   '(progn
;;      (require 'pgg)
;;                                         ;(defvar pgg-gpg-user-id "rforgey@grumpydogconsulting.com")
;;      (setq pgg-gpg-user-id "rforgey@grumpydogconsulting.com")
;;                                         ;customized (defvar pgg-passphrase-cache-expiry 12000)
;;      (autoload 'pgg-make-temp-file "pgg" "PGG")
;;      (autoload 'pgg-gpg-decrypt-region "pgg-gpg" "PGG GnuPG")
;;      (autoload 'pgg-gpg-encrypt-region "pgg-gpg" "PGG GnuPG")
;;      (define-generic-mode 'gpg-file-mode
;;        (list ?#)
;;        nil nil
;;        '(".gpg\\'" ".gpg-encrypted\\'")
;;        (list (lambda ()
;;                (add-hook 'before-save-hook
;;                          (lambda ()
;;                            (let ((pgg-output-buffer (current-buffer)))
;;                              (pgg-gpg-encrypt-region (point-min) (point-max)
;;                                                      (list pgg-gpg-user-id))))
;;                          nil t)
;;                (add-hook 'after-save-hook
;;                          (lambda ()
;;                            (let ((pgg-output-buffer (current-buffer)))
;;                              (pgg-gpg-decrypt-region (point-min) (point-max)))
;;                            (set-buffer-modified-p nil)
;;                            (auto-save-mode nil))
;;                          nil t)
;;                (let ((pgg-output-buffer (current-buffer)))
;;                  (pgg-gpg-decrypt-region (point-min) (point-max)))
;;                (auto-save-mode nil)
;;                (buffer-enable-undo)
;;                (set-buffer-modified-p nil)))
;;        "Mode for gpg encrypted files")

;;      )
;;   )

;; ;; (defun ssmm:decrypt ()
;; ;;   (interactive)
;; ;;   (pgg-decrypt (point-min) (point-max))
;; ;;   )

;; ;; (defun ssmm:encrypt ()
;; ;;   (interactive)
;; ;;   (pgg-encrypt
;; ;;    (list pgg-gpg-user-id)
;; ;;    )
;; ;;   )

;; ;; (defun ssmm:encrypt ()
;; ;;   (interactive)
;; ;;   (pgg-display-output-buffer (point-min) (point-max) (pgg-encrypt (list pgg-gpg-user-id)))
;; ;;   )

;; (defun ssmm:encrypt ()
;;   (interactive)
;;   (let* ((status (pgg-encrypt (list pgg-gpg-user-id))))
;;     (pgg-display-output-buffer (point-min) (point-max) status)
;;     )
;;   )

;; ;; (defun ssmm:decrypt ()
;; ;;   (interactive)
;; ;;   (pgg-display-output-buffer (point-min) (point-max) (pgg-decrypt))
;; ;;   )

;; (defun ssmm:decrypt ()
;;   (interactive)
;;   (let* ((status (pgg-decrypt)))
;;     (pgg-display-output-buffer (point-min) (point-max) status)
;;     )
;;   )

;; Programming

(if (featurep 'l-cygwin)
    (progn
      (add-to-list 'load-path (concat (expand-file-name "~/") "local/share/emacs/23/site-lisp/w3m/") t)
))

(require 'w3m)

;; (if (not (featurep 'l-w32))
;;     (progn
;;       (add-to-list 'load-path (concat (expand-file-name "~/") "local/share/emacs/site-lisp/w3m/") t)
;;       (if (= emacs-major-version 23)
;;           (require 'w3m-load)
;;         (require 'w3m))
;;       )
;;   (progn
;;     (add-to-list 'load-path (concat (expand-file-name "~/") "local/usr/share/emacs/site-lisp/w3m/") t)
;;     (require 'w3m)
;;     )
;;   )

; Anything
;; l-w32 because anything-config loads w3m
(if (not (featurep 'l-w32))
    (progn
      (add-to-list 'load-path (concat local-pkg-dir "anything") t)
      (require 'anything-config)
      )
  )

(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(defconst moto-c-style
	     '(
	       'ellemtel
	       (c-basic-offset . 2)
	       (c-offsets-alist . (
				   (substatement-open . 0)
				   (case-label        . +)
				   ))
	       ))

(defun ssmm:c-mode-setup ()
  (c-add-style "MOTOROLA" moto-c-style t))

(add-hook 'c-mode-hook 'ssmm:c-mode-setup)

;; Makefile
(add-to-list 'auto-mode-alist '("\\.mak$" . makefile-mode) t)

;; Perl
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode) t)

(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(autoload 'perlcritic-mode   "perlcritic" "" t)

;;   Add the following to your .emacs file to get perlcritic-mode to
;;   run automatically for the `cperl-mode' and `perl-mode'.

;;(eval-after-load "cperl-mode"
;;  '(add-hook 'cperl-mode-hook 'perlcritic-mode))
;;(eval-after-load "perl-mode"
;;  '(add-hook 'perl-mode-hook 'perlcritic-mode))

;;; perlnow (and template)

(add-to-list 'load-path (concat local-pkg-dir "template/lisp") t)

(autoload 'perlnow "perlnow")
(autoload 'template "template")
(autoload 'perlnow-script "perlnow")
(autoload 'perlnow-module "perlnow")
(autoload 'perlnow-object-module "perlnow")
(autoload 'perlnow-h2xs "perlnow")
(autoload 'perlnow-run-check "perlnow")
(autoload 'perlnow-run "perlnow")
(autoload 'perlnow-alt-run "perlnow")
(autoload 'perlnow-perldb "perlnow")
(autoload 'perlnow-set-run-string "perlnow")
(autoload 'perlnow-set-alt-run-string "perlnow")
(autoload 'perlnow-edit-test-file "perlnow")
(autoload 'perlnow-back-to-code "perlnow")
(autoload 'perlnow-perlify-this-buffer-simple "perlnow")

(eval-after-load 'perlnow
  '(progn
     (require 'template)
     (template-initialize)
     (require 'perlnow)
     (setq perlnow-script-location
           (substitute-in-file-name "$HOME/bin"))
     (setq perlnow-pm-location
           (substitute-in-file-name "$HOME/local/lib"))

     (setq perlnow-h2xs-location'
           (substitute-in-file-name "$HOME/local/perldev"))
     )
)

(global-set-key "\C-c's" 'perlnow-script)
(global-set-key "\C-c'm" 'perlnow-module)
(global-set-key "\C-c'o" 'perlnow-object-module)
(global-set-key "\C-c'h" 'perlnow-h2xs)
(global-set-key "\C-c'c" 'perlnow-run-check)
(global-set-key "\C-c'r" 'perlnow-run)
(global-set-key "\C-c'a" 'perlnow-alt-run)
(global-set-key "\C-c'd" 'perlnow-perldb)
(global-set-key "\C-c'R" 'perlnow-set-run-string)
(global-set-key "\C-c'A" 'perlnow-set-alt-run-string)
(global-set-key "\C-c't" 'perlnow-edit-test-file)
(global-set-key "\C-c'b" 'perlnow-back-to-code)
(global-set-key "\C-c'~" 'perlnow-perlify-this-buffer-simple)

; Anything
(add-to-list 'load-path (concat local-pkg-dir "anything"))
(require 'anything-config)

;; Custom defuns
(require 'ssmm-defuns)

(add-hook 'before-save-hook
          (lambda ()
            (delete-trailing-whitespace)
            )
          nil nil)

; If I'm editing a lemacs config file, be sure to
; eval it so it takes effect immediately, then
; recompile for later.
; XXX Fix for only .el files XXX
(add-hook 'after-save-hook
          (lambda ()
            (if (and buffer-file-name (string-match local-top-dir buffer-file-name))
                (byte-compile-file buffer-file-name)
              )
            )
          nil nil)


;; auto
;;(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode) )
;;(add-hook 'rst-mode-hook 'rst-text-mode-bindings)

;; Key mappings
;; Set C-c r to revert buffer without asking for confirmation
(global-set-key [(control c) (r)] 'ssmm:revert-buffer-force)

;; Handy return to current file-of-choice
(global-set-key ssmm:special-key-ctrl 'ssmm:select-buffer-of-choice)
(global-set-key ssmm:special-key 'ssmm:return-to-buffer-of-choice)

(global-set-key "%" 'joc-bounce-sexp)

(global-set-key [(control shift f3)] 'insert-date)
(global-set-key [(control f3)] 'ssmm:insert-short-date)

(global-set-key [(f6)] 'ssmm:forward-wide-line)
(global-set-key [(control f6)] 'ssmm:backward-wide-line)

(global-set-key [(control c) (control o)] 'comment-region)

(global-unset-key [(control x) (control c)])
;(global-set-key [(control x) (control c) (control c)] 'kill-emacs)
(global-set-key [(control x) (control c) (control c)] 'delete-frame)

(global-set-key [(delete)] 'quick-copy-line)
(global-set-key [(control delete)] 'ssmm:duplicate-line)

(global-set-key [f8] 'auto-fill-mode)
(global-set-key [control f8] 'erase-buffer)

(global-set-key [f9]    'popup-ruler)
;; (global-set-key [S-f9]  'popup-ruler-vertical)

(global-set-key [(f11)] 'next-error)
(global-set-key [(control f11)] 'ssmm:compile)

(global-set-key [(f12)] 'dabbrev-expand)

;; Per-project or temporary mappings
(require 'ssmm-project)

;;(if (featurep 'ssmm-site-moto)
(if (featurep 'l-cygwin)
    (progn
      ;(set-default-font "7x14")
      (add-to-list 'default-frame-alist '(font . "-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1"))
      ;(set-default-font "-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1")
      (set-frame-font "-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1")
      )
  (progn
    (set-frame-font "Inconsolata-11")
    )
  )

(defun ssmm:null-font-lock-function (mode)
  )

; Terminal colors are never useful
(if (null window-system)
    (setq font-lock-function 'ssmm:null-font-lock-function)
    (add-to-list 'default-frame-alist '(background-color . "NavajoWhite1"))
  )

(put 'set-goal-column 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

; Make sure this gets put in front
(if (and (featurep 'l-hattori) (featurep 'l-arch))
    (let ((ssmm:vers
           (progn
             (string-match "^\\([^.]+\\.[^.]+\\.[^.]+\\)\\." emacs-version)
             (match-string 1 emacs-version)
             )))
      (add-to-list 'Info-default-directory-list
                   (concat "/usr/share/emacs/" ssmm:vers "/info/"))

      (setq display-time-format "%6l:%M%p")
      (display-time)
      )
  )

(provide 'ssmm-initial)
