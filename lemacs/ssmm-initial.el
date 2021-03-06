;
(declare-function cygwin-mount-activate "ext:cygwin-mount" nil)
(if (featurep 'l-w32)
    (progn
      (require 'cygwin-mount)
      (cygwin-mount-activate)
      )
  )

(setq-default indent-tabs-mode nil)     ;use spaces (not tabs) for indenting
(setq-default line-move-visual nil)
(setq-default show-trailing-whitespace t)

(transient-mark-mode 1)                 ;for org-mode, mostly

;; unused buffer cleanup
(require 'midnight)

;; This turns out to be very annoying, especially when clicking the mouse near the top or bottom of a buffer
;;(setq scroll-margin 15)                 ;keep cursor more-or-less in the middle of a buffer while scrolling

;; per jfm3
(require 'completion)
(dynamic-completion-mode)
(global-set-key (kbd "C-\\") 'complete)

(require 'color-theme)
(require 'zenburn)
(color-theme-zenburn)

(add-to-list 'initial-frame-alist '(fullscreen . "maximized"))
;(add-to-list 'default-frame-alist '(background-color . "NavajoWhite1"))
(add-to-list 'default-frame-alist '(width . 144))
(add-to-list 'default-frame-alist '(height . 46))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Packages
;see if needed (require 'pcvs)
;see if needed (require 'psvn)
;see if needed (require 'rst)

;see if needed (require 'popup-ruler)
(eval-when-compile
  (add-to-list 'load-path (concat local-pkg-dir "versor/lisp/") t)
  (add-to-list 'load-path (concat local-pkg-dir "icicles/") t)
  (add-to-list 'load-path (concat local-pkg-dir "template/lisp") t)
  (add-to-list 'load-path (concat local-pkg-dir "anything"))
  (add-to-list 'load-path (concat local-pkg-dir "python"))
  (add-to-list 'load-path (concat local-pkg-dir "julien_danjou"))
  (if (featurep 'l-cygwin)
      (progn
        (add-to-list 'load-path (concat (expand-file-name "~/") "local/share/emacs/23/site-lisp/w3m/") t)
        ))
  )
(add-to-list 'load-path (concat local-pkg-dir "versor/lisp/") t)
(add-to-list 'load-path (concat local-pkg-dir "icicles/") t)
(add-to-list 'load-path (concat local-pkg-dir "template/lisp") t)
(add-to-list 'load-path (concat local-pkg-dir "anything"))
(add-to-list 'load-path (concat local-pkg-dir "python"))
(add-to-list 'load-path (concat local-pkg-dir "julien_danjou"))
(if (featurep 'l-cygwin)
    (progn
      (add-to-list 'load-path (concat (expand-file-name "~/") "local/share/emacs/23/site-lisp/w3m/") t)
))

; Too much and a half
(require 'google-maps)

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

(setq eldoc-idle-delay 0)
(autoload 'turn-on-eldoc-mode "eldoc" nil t)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

;; Mail
(add-to-list 'load-path (concat (expand-file-name "~/") "local/lemacs-packages/wl/") t)
;; autoload configuration
;; (Not required if you have installed Wanderlust as XEmacs package)
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; ;; wanderlust
;; ;; **** working version ****
;; (setq
;;   elmo-maildir-folder-path "~/Maildir"          ;; where i store my mail

;;   wl-stay-folder-window t                       ;; show the folder pane (left)
;;   wl-folder-window-width 25                     ;; toggle on/off with 'i'

;;   wl-smtp-posting-server "mail.solekai.com"            ;; put the smtp server here
;;   wl-local-domain "TivoLaptop3.solekai.com"          ;; put something here...
;;   wl-message-id-domain "TivoLaptop3.solekai.com"     ;; ...

;;   wl-from "Bob Forgey <rforgey@solekai.com>"                  ;; my From:

;;   ;; check this folder periodically, and update modeline
;;   wl-biff-check-folder-list '(".todo") ;; check every 180 seconds
;;                                        ;; (default: wl-biff-check-interval)

;;   ;; hide many fields from message buffers
;;   wl-message-ignored-field-list '("^.*:")
;;   wl-message-visible-field-list
;;   '("^\\(To\\|Cc\\):"
;;     "^Subject:"
;;     "^\\(From\\|Reply-To\\):"
;;     "^Organization:"
;;     "^Message-Id:"
;;     "^\\(Posted\\|Date\\):"
;;     )
;;   wl-message-sort-field-list
;;   '("^From"
;;     "^Organization:"
;;     "^X-Attribution:"
;;      "^Subject"
;;      "^Date"
;;      "^To"
;;      "^Cc"))
;; ;; ;; IMAP
;; (setq elmo-imap4-default-server "mail.solekai.com")
;; (setq elmo-imap4-default-user "<rforgey>@solekai.com")
;; (setq elmo-imap4-default-stream-type 'starttls)
;; (setq elmo-imap4-default-authenticate-type 'ntlm)
;; (setq elmo-imap4-default-port '143)
;; ;(setq elmo-imap4-default-stream-type 'ssl)
;; (setq elmo-imap4-debug t)

;; (setq elmo-imap4-use-modified-utf7 t)
;; (setq smtp-use-8bitmime nil) ;; 8bitmime screws up the MS Exchange Server

;; (setq wl-smtp-connection-type 'starttls)
;; (setq wl-smtp-posting-port 587)
;; (setq wl-smtp-authenticate-type "login")
;; (setq wl-smtp-posting-user "rforgey")
;; (setq wl-smtp-posting-server "mail.solekai.com")
;; (setq wl-local-domain "solekai.com")
;; (autoload 'wl-user-agent-compose "wl-draft" nil t)
;; (if (boundp 'mail-user-agent)
;;     (setq mail-user-agent 'wl-user-agent))
;; (if (fboundp 'define-mail-user-agent)
;;     (define-mail-user-agent
;;       'wl-user-agent
;;       'wl-user-agent-compose
;;       'wl-draft-send
;;       'wl-draft-kill
;;       'mail-send-hook))

;; wanderlust
(setq
  elmo-maildir-folder-path "~/Maildir"          ;; where i store my mail

  wl-stay-folder-window t                       ;; show the folder pane (left)
  wl-folder-window-width 25                     ;; toggle on/off with 'i'

  wl-smtp-posting-server "mail.solekai.com"            ;; put the smtp server here
  wl-local-domain "TivoLaptop3.solekai.com"          ;; put something here...
  wl-message-id-domain "TivoLaptop3.solekai.com"     ;; ...

  wl-from "Bob Forgey <rforgey@solekai.com>"                  ;; my From:

  ;; note: all below are dirs (Maildirs) under elmo-maildir-folder-path
  ;; the '.'-prefix is for marking them as maildirs
  ;; wl-fcc ".sent"                       ;; sent msgs go to the "sent"-folder
  ;; wl-fcc-force-as-read t               ;; mark sent messages as read
  ;; wl-default-folder ".inbox"           ;; my main inbox
  ;; wl-draft-folder ".drafts"            ;; store drafts in 'postponed'
  ;; wl-trash-folder ".trash"             ;; put trash in 'trash'
  ;; wl-spam-folder ".trash"              ;; ...spam as well
  ;; wl-queue-folder ".queue"             ;; we don't use this

  ;; check this folder periodically, and update modeline
  wl-biff-check-folder-list '(".todo") ;; check every 180 seconds
                                       ;; (default: wl-biff-check-interval)

  ;; hide many fields from message buffers
  wl-message-ignored-field-list '("^.*:")
  wl-message-visible-field-list
  '("^\\(To\\|Cc\\):"
    "^Subject:"
    "^\\(From\\|Reply-To\\):"
    "^Organization:"
    "^Message-Id:"
    "^\\(Posted\\|Date\\):"
    )
  wl-message-sort-field-list
  '("^From"
    "^Organization:"
    "^X-Attribution:"
     "^Subject"
     "^Date"
     "^To"
     "^Cc"))
;; ;; IMAP
(setq elmo-imap4-default-server "mail.solekai.com")
(setq elmo-imap4-default-user "<rforgey>@solekai.com")
(setq elmo-imap4-default-stream-type 'starttls)
(setq elmo-imap4-default-authenticate-type 'ntlm)
(setq elmo-imap4-default-port '143)
;(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-debug t)

(setq elmo-imap4-use-modified-utf7 t)
(setq smtp-use-8bitmime nil) ;; 8bitmime screws up the MS Exchange Server

;; ;; SMTP
;; (setq wl-smtp-connection-type 'starttls)
;; (setq wl-smtp-posting-port 25)
;; (setq wl-smtp-authenticate-type "login")
;; (setq wl-smtp-posting-user "rforgey")
;; (setq wl-smtp-posting-server "mail.solekai.com")
;; (setq wl-local-domain "solekai.com")

;; (setq wl-default-folder "%inbox")
;; (setq wl-default-spec "%")
;; ;(setq wl-draft-folder "%[Gmail]/Drafts") ; Gmail IMAP
;; ;(setq wl-trash-folder "%[Gmail]/Trash")

;; (setq wl-folder-check-async t)

;; (setq elmo-imap4-use-modified-utf7 t)

;; ;; Directory where icons are placed.
;; ;; Default: the peculiar value to the running version of Emacs.
;; ;; (Not required if the default value points properly)
;; ;(setq wl-icon-directory "~/work/wl/etc")

;; ;; SMTP server for mail posting. Default: `nil'
;; (setq wl-smtp-posting-server "mail.solekai.com")
;; ;; NNTP server for news posting. Default: `nil'
;; ;(setq wl-nntp-posting-server "your.nntp.example.com")

(setq wl-smtp-connection-type 'starttls)
(setq wl-smtp-posting-port 587)
(setq wl-smtp-authenticate-type "login")
(setq wl-smtp-posting-user "rforgey")
(setq wl-smtp-posting-server "mail.solekai.com")
(setq wl-local-domain "solekai.com")
(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

;; PIM stuff
(require 'ssmm-pim)

;; Muse
;; May not be installed on a given system
(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode) t)
(autoload 'muse-mode "ssmm-muse" "Muse" t)

;; Icicles
;; XXX Need to consider how this works with daemon mode and (setq window-system 'x)
;(if window-system
;    (require 'icicles)
;)

;; (require 'epa)
;; (epa-file-enable)
;; (setq epg-gpg-program “gpg”)

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

(require 'multi-term)
(setq multi-term-program "/bin/bash")

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

;; (autoload 'git-blame-mode "git-blame"
;;   "Minor mode for incremental blame for Git." t)
;; Trying out git-mode
;; try out vc-git-mode some more
;;(add-to-list 'load-path (concat local-pkg-dir "git-mode") t)

(defconst m-c-style
	     '(
	       'ellemtel
	       (c-basic-offset . 2)
	       (c-offsets-alist . (
				   (substatement-open . 0)
				   (case-label        . +)
				   ))
	       ))

(defun ssmm:c-mode-setup ()
  (c-add-style "M" m-c-style t))

(add-hook 'c-mode-common-hook 'ssmm:c-mode-setup t)
;(remove-hook 'c-mode-common-hook 'ssmm:c-mode-setup)


;; Makefile
(add-to-list 'auto-mode-alist '("\\.mak$" . makefile-mode) t)

;; Perl
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode) t)

(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(autoload 'perlcritic-mode   "perlcritic" "" t)

;; Python
(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)

;;   Add the following to your .emacs file to get perlcritic-mode to
;;   run automatically for the `cperl-mode' and `perl-mode'.

;;(eval-after-load "cperl-mode"
;;  '(add-hook 'cperl-mode-hook 'perlcritic-mode))
;;(eval-after-load "perl-mode"
;;  '(add-hook 'perl-mode-hook 'perlcritic-mode))

;;; perlnow (and template)


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
(require 'anything-config)

;; unit-testing
(defvar ssmm:unittest:unit-test-command "python test_fb.py"
  "*Command for ssmm:unittest:run-unit-test")

(defun ssmm:unittest:run-unit-test ()
  (interactive)

  (switch-to-buffer-other-window "*shell*")
  (goto-char (point-max))
  (insert ssmm:unittest:unit-test-command)
  (comint-send-input)
  )

(global-set-key [(shift f10)] 'ssmm:unittest:run-unit-test)

;; misc
;; EMMS
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/emms/" t)
(require 'emms-setup)
(emms-standard)
(emms-default-players)
(setq emms-source-file-default-directory "~/Music/")

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
            (if (and buffer-file-name (string-match (concat local-top-dir ".*\.el$") buffer-file-name))
                (byte-compile-file buffer-file-name)
              )
            )
          nil nil)


;; auto
;;(add-to-list 'auto-mode-alist '("\\.rst$" . rst-mode) )
;;(add-hook 'rst-mode-hook 'rst-text-mode-bindings)

;; Key mappings
(global-set-key [?\C-3] 'kill-ring-save)

(global-set-key [(control tab)] 'other-window)
(global-set-key [(control shift iso-lefttab)]
                (lambda () (interactive) (other-window -1)))
;; Set C-c r to revert buffer without asking for confirmation
(global-set-key [(control c) (r)] 'ssmm:revert-buffer-force)

;; Handy return to current file-of-choice
(global-set-key ssmm:special-key-ctrl 'ssmm:select-buffer-of-choice)
(global-set-key ssmm:special-key 'ssmm:return-to-buffer-of-choice)

(global-set-key "%" 'joc-bounce-sexp)

(global-set-key [(control shift f3)] 'insert-date)
(global-set-key [(control f3)] 'ssmm:insert-short-date)

(global-set-key [(f5)] 'ssmm:fill-to-column)

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

(global-set-key [(f10)] 'next-error)
(global-set-key [(control f10)] 'ssmm:compile0)
(global-set-key [(f11)] 'next-error)
(global-set-key [(control f11)] 'ssmm:compile1)

(global-set-key [(f12)] 'dabbrev-expand)

(if (featurep 'l-cygwin)
    (progn
      ;(set-default-font "7x14")
      (add-to-list 'default-frame-alist '(font . "-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1"))
      ;(set-default-font "-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1")
      (set-frame-font "-Misc-Fixed-Medium-R-Normal--14-130-75-75-C-70-ISO8859-1")
      )
  (progn
    (set-frame-font "Inconsolata-11")
    (add-to-list 'default-frame-alist '(font . "Inconsolata-11"))
    )
  )

(defun ssmm:null-font-lock-function (mode)
  )

; Terminal colors are never useful
(unless (or (and
             (fboundp 'daemonp)
             (daemonp))
            window-system)
  (progn
    (setq font-lock-function 'ssmm:null-font-lock-function)
    ;(add-to-list 'default-frame-alist '(background-color . "NavajoWhite1"))
    )
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

      (defvar display-time-format "%6l:%M%p")
      (display-time)
      )
  )

;; Per-project or temporary mappings
;; Look for a file named ~/.lemacs.d/<location>.el, and evaluate
;; it. This should probably only be used for add-to-list kinds of
;; things that don't rate getting pulled into an ssmm-*.el
;; file. Currently, I only have written this for one file, but it
;; should work with more (say, change the ".el" to "*.el").
(mapc
 (lambda (boop) (with-temp-buffer
                  (insert-file-contents boop)
                  (eval-buffer)))
 (file-expand-wildcards
  (concat ssmm:home "lemacs.d/"
          (replace-regexp-in-string "[ \t\n]*" "" (shell-command-to-string "uname -n"))
          ".el")))

(require 'ssmm-project)

;; Just to be sure
(setq make-backup-files nil)

(provide 'ssmm-initial)
