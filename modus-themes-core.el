;;; modus-themes-core.el --- Testing -*- lexical-binding:t -*-
;; URL: https://www.protesilaos.com
;; Version: 0.0.0
;; Package-Requires: ((emacs "26.1"))
;;; Commentary:
;; -
;;; Code:

(defvar modus-themes-operandi-colors)
(defvar modus-themes-vivendi-colors)
(defvar modus-themes)

(defun modus-themes-core-theme-variables (name)
  "Return correct variable for Modus theme NAME."
  (pcase name
    (''modus-operandi modus-themes-operandi-colors)
    (''modus-vivendi modus-themes-vivendi-colors)
    (_ (user-error "<< %s >> is not a valid Modus theme" name))))

(defmacro modus-themes-core-theme (name &rest body)
  "Bind NAME's palette to `custom-theme-set-faces' around BODY.

NAME should be the proper name of the theme, either 'modus-operandi' or 'modus-vivendi'."
  (let ((specs (or `,body modus-themes)))
    `(let ((class '((class color) (min-colors 89)))
           ,@(mapcar (lambda (cons)
                       `(,(car cons) ,(cdr cons)))
                     (modus-themes-core-theme-variables name)))
       (custom-theme-set-faces
        ,name
        ,@specs))))

(provide 'modus-themes-core)
;;; modus-themes-core.el ends here
