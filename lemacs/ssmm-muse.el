;; Muse stuff
;; Split out of ssmm-initial.el

(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode) t)

(add-to-list 'load-path (concat local-pkg-dir "muse-latest/lisp/") t)
(setq muse-foo1 (concat (getenv "TGT_TOP") "/vcinfo"))
(setq muse-foo2 (concat (getenv "TGT_TOP") "/vcinfo/pdf"))
;(defvar muse-project-alist
(setq muse-project-alist
  '(("vcinfo" ("~/Projects/web/vcinfo" :default "index")
     ;(:base "html" :path (concat (getenv "TGT_TOP") "/vcinfo"))
     ;(:base "html" :path "/home/big/Data/vcinfo")
     (:base "html" :path muse-foo1)
     ;(:base "pdf" :path (concat (getenv "TGT_TOP") "/vcinfo/pdf"))
     ;(:base "pdf" :path "/home/big/Data/vcinfo/pdf")
     (:base "pdf" :path muse-foo2)
     )))

(if (require 'muse-autoloads "muse-autoloads" t)
    (progn
      (require 'muse-html)     ; load publishing styles I use
      (require 'muse-latex)
      (require 'muse-texinfo)
      (require 'muse-docbook)

      ;; Doesn't seem useful, currently
      ;; *.muse -> *.html , but *.txt -> *.txt.html
      ;; Also, may want muse to do something else when publishing .txt files
      ;; ;; muse-mode on *.txt files, if a #title or sect. header is on top 4 lines
      ;; ;; from http://www.emacswiki.org/emacs/RuiAlmeida
      ;; (add-hook 'text-mode-hook
      ;;           (lambda ()
      ;;             (unless (or (eq major-mode 'muse-mode)
      ;; 			(not (stringp buffer-file-truename)))
      ;;               (when (equal (file-name-extension buffer-file-truename) "txt")
      ;;                 (save-excursion
      ;;                   (goto-line 5)
      ;;                   (if (re-search-backward "\* [A-Z][a-z]+.*\\|#title " 1 t)
      ;;                       (muse-mode)))))))
      )
  )

(provide 'ssmm-muse)
