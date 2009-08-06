;;-*- Mode: Emacs-Lisp -*-   ;Comment that puts emacs into lisp mode

(require 'cl) ; a rare necessary use of REQUIRE
(defvar *emacs-load-start* (current-time))

(defconst local-top-dir (concat (expand-file-name "~/") "lemacs/")
  "Absolute path for local emacs customizations.")

(defconst local-user-top-dir (concat (expand-file-name "~/") "local/")
  "Absolute path for local emacs customizations.")

(add-to-list 'load-path local-top-dir)

(setq custom-file (concat local-top-dir "customize.el"))
(load custom-file)

(require 'ssmm-config)			;Find out what kind of system
					;we're running on, and
					;(possibly) which
					;machine. This file should
					;only set variables.
(require 'ssmm-initial)

(message "My .emacs loaded in %ds" (destructuring-bind (hi lo ms) (current-time)
                           (- (+ hi lo) (+ (first *emacs-load-start*) (second *emacs-load-start*)))))
