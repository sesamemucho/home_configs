; Random defuns
(defun indent-to-75 ()
  (interactive)
  (indent-to-column 75)
)

(setq-default ssmm:fill-column 45)

(defun ssmm:fill-to-column ()
  (interactive)
  (insert-char 32 (- ssmm:fill-column (current-column)))
)

(defun ssmm:last-window ()
  (interactive)
  (other-window -1)
)

; quick-copy-line
; http://www.emacswiki.org/emacs-en/CopyingWholeLines
; Anonymous’s first EmacsLisp function.
(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
        (end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2))

;; from http://www.emacs.uniyar.ac.ru/doc/em24h/emacs098.htm#Heading262
(declare-function w32-select-font "ext:foo")
(if (eq window-system 'w32)        ; emacs 20 & up
    (defun insert-x-style-font()
      "Insert a string in the X format which describes a font the user can select from the Windows font selector."
      (interactive)
      (insert (prin1-to-string (w32-select-font)))))


(defun ssmm:duplicate-line ()
  "Duplicates the current line just below the current line."
  (interactive "p")
  (quick-copy-line)
  (yank)
  )

;;__________________________________________________________________________
;;;;;;		insert-date
(defun ssmm:insert-short-date ()  "Insert date at point."
  (interactive)
  (insert (format-time-string "%a %b %e, %Y")))

;; From http://www.northbound-train.com/emacs.html
(defun joc-bounce-sexp (arg)
  "Will bounce between matching parens just like % in vi."
  (interactive "p")
  (let ((prev-char (char-to-string (preceding-char)))
	(next-char (char-to-string (following-char))))
	(cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
		  ((string-match "[\]})>]" prev-char) (backward-sexp 1))
		  (t (self-insert-command (or arg 1))))))


(defun ssmm:to-wide-line (direction len)
  "Moves point to end of next or previous line longer than 80 chars."
  (interactive)
  (let ((eol-val (if (eq direction 'backward) 0 2)))
    (end-of-line eol-val)
    (while (and (< (current-column) len) (not (eobp)) (not (bobp)))
      (end-of-line eol-val)
      )
    (message (format "Line is %d chars long." (current-column)))
    )
  )

(defun ssmm:forward-wide-line ()
  "Moves point to end of next line longer than 80 chars."
  (interactive)
  (ssmm:to-wide-line 'forward 80)
  )

(defun ssmm:backward-wide-line ()
  "Moves point backwards to end of a line longer than 80 chars."
  (interactive)
  (ssmm:to-wide-line 'backward 80)
  )

(defvar ssmm:buffer-of-choice)
(defun ssmm:select-buffer-of-choice ()
  "Selects current buffer as buffer-of-choice (see ssmm:switch-to-buffer-of-choice)."
  (interactive)
  (setq ssmm:buffer-of-choice (current-buffer))
  )

(defun ssmm:return-to-buffer-of-choice ()
  "Returns to current buffer-of-choice (see ssmm:select-buffer-of-choice)."
  (interactive)
  (switch-to-buffer ssmm:buffer-of-choice)
  (delete-other-windows)
  )

; Just using a lambda in global-set-key causes describe-key to fail
(defun ssmm:revert-buffer-force ()
  "Reverts buffer without asking for confirmation."
  (interactive)
  (revert-buffer t t)
  )

(defvar ssmm:compile-command0 "make -k"
  "*Command for alternate compile command 0")

(defun ssmm:compile0 ()
  "Runs compile without asking."
  (interactive)
  (let ((compilation-read-command nil))
    (compile ssmm:compile-command0)
    )
)

(defvar ssmm:compile-command1 "make -k"
  "*Command for alternate compile command 1")

(defun ssmm:compile1 ()
  "Runs compile without asking."
  (interactive)
  (let ((compilation-read-command nil))
    (compile ssmm:compile-command1)
    )
)

(provide 'ssmm-defuns)
