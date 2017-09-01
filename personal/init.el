(server-start)
(setq prelude-flyspell nil)
(setq projectile-switch-project-action `projectile-dired)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq require-final-newline t)
(set-variable (quote visible-bell) t nil)
(setq whitespace-style '(face space tabs empty trailing lines-tail))


(ido-mode t)

(add-to-list 'vc-handled-backends 'Git) ;; Grrrr!

;; Slightly larger than default 12
(set-frame-font "-*-Menlo-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")

;(setq tramp-default-method "scp")
(setq tramp-shell-prompt-pattern "\\(?:^\\|
\\)[^#$%>\n]*#?[]#$%>] *\\(\\[[0-9;]*[a-zA-Z] *\\)*")

(defun this-line-to-top-of-screen (line)
  "Reposition line point is on to the top of the screen.
With ARG, put point on line ARG. Negative counts from bottom."
  (interactive "P")
  (recenter (if (null line)
                0
              (prefix-numeric-value line))))

(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.scpt\\'" . web-mode))

(add-hook 'web-mode-hook 'prettier-js-mode)
;; see bin/prettier-emacs

(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")
;;        ("javascript" . "\\.scpt\\'")
        ))
 
(subword-mode +1)

;; really tired of projectile-mode interpreting the TAB key
;; as a TAGS search. And it's not even documented by C-h k
(projectile-mode nil)

