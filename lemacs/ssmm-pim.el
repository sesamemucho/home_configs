;; bbdb
;; 2.35

(autoload 'bbdb "bbdb")
(eval-after-load "bbdb"
  '(progn
     ;;(require 'bbdb)
     (bbdb-initialize 'gnus 'message 'sc 'w3)

     ;; The following lines are straight from suggested defaults in bbdb-sc.el
     (bbdb-insinuate-sc)
     (setq sc-preferred-attribution-list
           '("sc-lastchoice" "x-attribution" "sc-consult"
             "initials" "firstname" "lastname"))

     (setq sc-attrib-selection-list
           '(("sc-from-address" ((".*" . (bbdb/sc-consult-attr
                                          (sc-mail-field "sc-from-address")))))))

     (setq sc-mail-glom-frame
           '((begin                        (setq sc-mail-headers-start (point)))
             ("^x-attribution:[ \t]+.*$"   (sc-mail-fetch-field t) nil t)
             ("^\\S +:.*$"                 (sc-mail-fetch-field) nil t)
             ("^$"                         (progn (bbdb/sc-default)
                                                  (list 'abort '(step . 0))))
             ("^[ \t]+"                    (sc-mail-append-field))
             (sc-mail-warn-if-non-rfc822-p (sc-mail-error-in-mail-field))
             (end                          (setq sc-mail-headers-end (point)))))
     )
  )

;; ;; org mode
;; ;; The following lines are always needed.  Choose your own keys.
;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (add-hook 'org-mode-hook 'turn-on-font-lock)  ; org-mode buffers only

;; From John Wiegley (http://www.newartisans.com/blog_files/org.mode.day.planner.php)

(add-to-list 'load-path (concat local-share-top "org-6.28e/lisp"))
(add-to-list 'load-path (concat local-share-top "org-6.28e/lisp/contrib"))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;(define-key mode-specific-map [?a] 'org-agenda)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; (eval-after-load "org"
;;   '(progn
;;      (define-prefix-command 'org-todo-state-map)

;;      (define-key org-mode-map "\C-cx" 'org-todo-state-map)

;;      (define-key org-todo-state-map "x"
;;        #'(lambda nil (interactive) (org-todo "CANCELLED")))
;;      (define-key org-todo-state-map "d"
;;        #'(lambda nil (interactive) (org-todo "DONE")))
;;      (define-key org-todo-state-map "f"
;;        #'(lambda nil (interactive) (org-todo "DEFERRED")))
;;      (define-key org-todo-state-map "l"
;;        #'(lambda nil (interactive) (org-todo "DELEGATED")))
;;      (define-key org-todo-state-map "s"
;;        #'(lambda nil (interactive) (org-todo "STARTED")))
;;      (define-key org-todo-state-map "w"
;;        #'(lambda nil (interactive) (org-todo "WAITING")))

;;      (define-key org-agenda-mode-map "\C-n" 'next-line)
;;      (define-key org-agenda-keymap "\C-n" 'next-line)
;;      (define-key org-agenda-mode-map "\C-p" 'previous-line)
;;      (define-key org-agenda-keymap "\C-p" 'previous-line)

;;      ))

(defvar org-directory "~/org/pim/")
(defvar org-default-notes-file (concat org-directory "nlug.org.gpg"))

(defvar org-agenda-files '(
                           "~/org/pim/todo.org.gpg"
                           "~/org/pim/home.org.gpg"
                           "~/org/pim/dates.org.gpg"
                           "~/org/pim/system_notes.org.gpg"
                           "~/org/pim/nlug.org.gpg"))

(defvar org-archive-location "%s_archive.gpg::")

(defvar org-default-priority ?C)
(defvar org-highest-priority ?A)
(defvar org-lowest-priority ?E)

(defvar org-agenda-ndays 7)
(defvar org-agenda-show-all-dates t)
(defvar org-agenda-todo-list-sublevels nil)
(defvar org-todo-keywords
      '((sequence "TODO" "WAITING" "|" "DONE")))
(defvar org-agenda-skip-deadline-if-done t)
(defvar org-agenda-skip-scheduled-if-done t)
(defvar org-agenda-start-on-weekday nil)
;; (defvar org-agenda-exporter-settings nil)
;; (require 'ps-print)
;; (defvar ps-landscape-mode nil)
;; (defvar ps-number-of-colums 1)
(defvar org-agenda-exporter-settings
      '((ps-number-of-columns 1)
        (ps-landscape-mode t)
        (org-agenda-add-entry-text-maxlines 5)
        ))

(defvar org-deadline-warning-days 14)
(defvar org-fast-tag-selection-single-key (quote expert))
(defvar org-remember-store-without-prompt t)
;;http://www.emacswiki.org/emacs/RememberMode#toc8
;;If you are, like me, missing the function org-remember-insinuate, try the following

(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(defadvice remember-other-frame (around remember-frame-parameters activate)
  "Set some frame parameters for the remember frame."
  (let ((default-frame-alist (append
    			      '(
    				(name . "*Remember*")
    				(width . 132)
    				(height . 10)
    				(vertical-scroll-bars . nil)
    				(menu-bar-lines . 0)
    				(tool-bar-lines . 0)
    				)
    			      default-frame-alist)))
    ad-do-it
    ))

;; I want to be able to reset the following two variables during runtime.
(defvar org-remember-templates)
(setq org-remember-templates
      (quote (("General" ?t "** TODO %? %t\n\n" "~/org/pim/todo.org.gpg" "Tasks")
              ("Phone"   ?p "** TODO %? %t" "~/org/pim/home.org.gpg" "Phone calls")
              ("Appt"    ?a "** TODO %? %T" "~/org/pim/home.org.gpg" "Appointments")
              ("Note"    ?n "** %? %u" "~/org/pim/home.org.gpg" "Notes")
              ("Home"    ?h "** TODO %? %t" "~/org/pim/home.org.gpg" "Tasks")
              ("Garden"  ?g "** TODO %? %t" "~/org/pim/home.org.gpg" "Garden")
              ("Trip"    ?r "** TODO %? %t" "~/org/pim/home.org.gpg" "Trip")
              ("Someday" ?s "** TODO %? %u" "~/org/pim/home.org.gpg" "Tasks")
              ("To Buy " ?b "** TODO %? %t :shop:" "~/org/pim/home.org.gpg" "Want list")
              )))

(defvar org-agenda-custom-commands)
(setq org-agenda-custom-commands
      '(
        ("X" agenda ""
         ((ps-number-of-columns 1)
          (ps-landscape-mode t)
          (org-agenda-ndays 1)
          (org-agenda-prefix-format " [ ] ")
          (org-agenda-with-colors nil)
          (org-agenda-remove-tags t))
         ("~/temp/agenda.ps"))
        ("u" alltodo ""
         ((org-agenda-skip-function
           (lambda nil
             (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                       (quote regexp) "<[^>\n]+>")))
          (org-agenda-overriding-header "Unscheduled TODO entries: ")))
        ("S" "Shop"
         ((tags-todo "shop"))
         ((org-show-entry-below t)
          (org-show-hierarchy-above t)
          (ps-number-of-columns 1)
          (ps-landscape-mode nil)
          (org-agenda-prefix-format " [ ] ")
          (org-agenda-with-colors nil)
          (org-agenda-remove-tags t))
         ("~/temp/shop.ps"))
        ("Y" alltodo "" nil ("~/temp/todo.html" "~/temp/todo.txt" "~/temp/todo.ps"))
        ;; ("h" "Agenda and Home-related tasks"
        ;;  ((agenda "")
        ;;   (tags-todo "home")
        ;;   (tags "garden"))
        ;;  nil
        ;;  ("~/views/home.html"))
        ;; ("o" "Agenda and Office-related tasks"
        ;;  ((agenda)
        ;;   (tags-todo "work")
        ;;   (tags "office"))
        ;;  nil
        ;;  ("~/views/office.ps"))
        ("z" "1 week - no deadlines" agenda ""
         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline))
          (ps-number-of-columns 1)
          (ps-landscape-mode t)
          (org-agenda-ndays 7)
          (org-agenda-prefix-format " [ ] ")
          (org-agenda-with-colors nil)
          (org-agenda-remove-tags t))
         ("~/temp/agendaz.ps"))
        ("Z" "1 day - no deadlines" agenda ""
         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline))
          (ps-number-of-columns 1)
          (ps-landscape-mode t)
          (ps-font-size 12)
          (org-agenda-ndays 1)
          (org-agenda-prefix-format " [ ] ")
          (org-agenda-with-colors nil)
          (org-agenda-remove-tags t))
         ("~/temp/agendaZ.ps"))
        ))

(defun org-export-icalendar (foo &rest boo)
  (interactive)
  )

(defvar org-reverse-note-order t)

;; From: http://article.gmane.org/gmane.emacs.orgmode/5271
;; Here is how I do it, using very little machinery. As part of org-mode
;; initialization, I add appointments from the diary to the agenda at
;; startup and I also make org-agenda-redo rescan the appt list:

;; -----------------------------------
(require 'appt)
(setq org-agenda-include-diary t)
(setq appt-time-msg-list nil)
(org-agenda-to-appt)

(defadvice  org-agenda-redo (after org-agenda-redo-add-appts)
  "Pressing `r' on the agenda will also add appointments."
  (progn
    (setq appt-time-msg-list nil)
    (org-agenda-to-appt)))

(ad-activate 'org-agenda-redo)
;; -----------------------------------

;; I enable appt reminders, set the format to 'window and provide
;; a display function that calls a python program to do the popup:

;; -----------------------------------
(appt-activate 1)
(setq appt-display-format 'window)
(setq appt-disp-window-function (function my-appt-disp-window))
(defun my-appt-disp-window (min-to-app new-time msg)
  (call-process (concat ssmm:home "lemacs/bin/popup.py") nil 0 nil min-to-app msg new-time))

;-----------------------------------

;; Finally, the popup.py program is trivial:

;; -----------------------------------
;; #!/usr/bin/env python

;; """ Simple dialog popup example similar to the GTK+ Tutorials one """

;; import gtk
;; import sys

;; mins = sys.argv[1]
;; text = ' '.join(sys.argv[2:])
;; dialog = gtk.MessageDialog(None,
;;                            gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
;;                            gtk.MESSAGE_INFO, gtk.BUTTONS_OK,
;;                            "Appt in %s mins: %s" % (mins, text))
;; dialog.run()
;; dialog.destroy()
;; -----------------------------------

(add-to-list 'load-path (concat local-user-top-dir "share/emacs/site-lisp/remember"))


(require 'org-install)
(org-remember-insinuate)
(require 'remember)


;(setq remember-annotation-functions '(org-remember-annotation))
;(setq remember-handler-functions '(org-remember-handler))
;(add-hook 'remember-mode-hook 'org-remember-apply-template)


(define-key global-map [(control meta ?r)] 'remember)
(define-key global-map [(pause)] 'remember)

(provide 'ssmm-pim)
