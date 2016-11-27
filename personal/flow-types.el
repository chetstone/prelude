;; from https://github.com/facebook/flow/blob/049b31d8c6b3ec3f7db51ed6074fdde907db1a94/flow-types.el
;; or flow 0.17.0 - 0.27.0
(setq flow_binary "flow")

(defun column-number-at-pos (pos)
  "column number at pos"
  (save-excursion (goto-char pos) (current-column))
)

(defun string-of-region ()
  "string of region"
  (if (use-region-p)
      (let ((begin (region-beginning))
            (end (region-end)))
        (format ":%d:%d,%d:%d"
                (line-number-at-pos begin)
                (column-number-at-pos begin)
                (line-number-at-pos end)
                (column-number-at-pos end)))
    "")
)

(defun get-assoc-value (key alist)
  "get assoc value"
  (setq blah (assoc key alist))
  (if blah
      (cdr blah)
    nil)
)

(setq flow_root_dir nil)

(defun flow_init (s)
  "Initialize flow"
  (interactive "sRoot directory: ")
  (if flow_root_dir
      ""
    (setq flow_root_dir s)
    (shell-command (format "%s start %s" flow_binary s))
     )
  (compile (format "%s status --from emacs; exit 0" flow_binary))
)

;;(setq compilation-scroll-output t)
(global-set-key (kbd "C-c C-f") 'flow_init)

(defun flow_run ()
  "Run flow"
  (interactive)
 (compile (format "%s status --from emacs; exit 0" flow_binary))
)

;;(setq compilation-scroll-output t)
(global-set-key (kbd "C-x C-m") 'flow_run)

(defun show-type ()
  "show type"
  (interactive)
  (let ((file (buffer-file-name))
        (line (line-number-at-pos))
        (col (current-column))
        (buffer (current-buffer)))
    (switch-to-buffer-other-window "*Shell Command Output*")
    (shell-command
     (format "%s type-at-pos %s %d %d"
             flow_binary
             file
             line
             (1+ col)))
    (compilation-mode)
    (switch-to-buffer-other-window buffer))
)

(global-set-key (kbd "C-M-t") 'show-type)

(defun fill-types ()
  "fill types"
  (interactive)
  (let ((file (buffer-file-name))
        (region (string-of-region))
        (buffer (current-buffer)))
    (switch-to-buffer-other-window "*Shell Command Output*")
    (shell-command
     (format "%s suggest %s%s"
             flow_binary
             file
             region))
    (compilation-mode)
    (switch-to-buffer-other-window buffer))
  ;;(revert-buffer)
)

(global-set-key (kbd "C-c C-c t") 'fill-types)

(defun jump-def ()
  "jump to definition"
  (interactive)
  (let ((file (buffer-file-name))
        (line (line-number-at-pos))
        (col (current-column))
        (buffer (current-buffer)))
    (switch-to-buffer-other-window "*Shell Command Output*")
    (shell-command
     (format "%s get-def --from emacs %s %d %d"
             flow_binary
             file
             line
             (1+ col)))
    (compilation-mode))
  ;;(switch-to-buffer-other-window buffer)
)

(global-set-key (kbd "C-M-.") 'jump-def)

(defun auto-complete ()
  "autocomplete"
  (interactive)
  (let ((file (buffer-file-name))
        (line (line-number-at-pos))
        (col (current-column))
        (buffer (current-buffer)))
    (switch-to-buffer-other-window "*Shell Command Output*")
    (shell-command
     (format "%s autocomplete %s %d %d < %s"
             flow_binary
             file
             line
             (1+ col)
             file))
    (compilation-mode)
    (switch-to-buffer-other-window buffer))
)

(global-set-key (kbd "M-SPC") 'auto-complete)

(add-hook 'kill-emacs-hook
  (lambda ()
    (if flow_root_dir
      (shell-command (format "%s stop %s" flow_binary flow_root_dir)))))
