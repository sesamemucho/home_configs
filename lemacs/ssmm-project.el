;; ssmm-project: per-project or temporary defs

;; (if (featurep 'p4)
;;     (progn
;;       (setq p4-do-find-file t)
;;       )
;;   )

(cond
 ((string-match "tv" ssmm:proj)
  (message "yep")
  (add-to-list 'org-remember-templates
               (quote("Work"    ?w "** TODO %? %t" "~/Documents/tivo/org/insignia.org" "Tasks")))
  (add-to-list 'org-remember-templates
               (quote("Ins"     ?i "%?" "~/Documents/tivo/org/insignia.org" "Ins-today")))

  )
 )

(provide 'ssmm-project)
