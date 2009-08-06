;; ssmm-project: per-project or temporary defs

;; unit-testing
;;(defvar ssmm:unittest:unit-test-command "make -f ut/dctmsgs/dctmsg1.mak && obj/ut/dctmsgs/utdctmsg1.exe")
(defvar ssmm:unittest:unit-test-command "python test_fb.py"
  "*Command for ssmm:unittest:run-unit-test")

(defun ssmm:unittest:run-unit-test ()
  (interactive)

  (switch-to-buffer-other-window "*shell*")
  (goto-char (point-max))
  (insert ssmm:unittest:unit-test-command)
  (comint-send-input)
  )

(global-set-key [(f10)] 'ssmm:unittest:run-unit-test)

;(add-to-list 'org-remember-templates
;             '("TC" ?t "* TC %?\n  %i\n  %a" "~/org/pim/mot.org"))

(provide 'ssmm-project)
