;; These are the default prelude chords, repeated here for easy changing
;; (key-chord-define-global "jj" 'ace-jump-word-mode)
;; (key-chord-define-global "jl" 'ace-jump-line-mode)
;; (key-chord-define-global "jk" 'ace-jump-char-mode)
;; (key-chord-define-global "JJ" 'prelude-switch-to-previous-buffer)
;; (key-chord-define-global "uu" 'undo-tree-visualize)
;; (key-chord-define-global "xx" 'execute-extended-command)
;; (key-chord-define-global "yy" 'browse-kill-ring)

;; Adding
;;;;(key-chord-define-global "JK"  'ace-jump-buffer)

;; 
;; revert to traditional C-x u
(define-key undo-tree-map (kbd "\C-x u") nil)
(global-set-key "\C-xu" 'undo-tree-undo) ;; revert to traditional. Use 'uu' for undo-tree-visualize
;; and use CMD-Z for the visualizeres
(define-key undo-tree-map [remap undo] 'undo-tree-visualize)

;; git grep http://stackoverflow.com/posts/25653801/revisions
(global-set-key "\M-." `vc-git-grep)
;;(define-key magit-mode-map (kbd "%") `magit-grep)


;; Legendary
(global-set-key "\C-c\C-c\C-c" (quote comment-or-uncomment-region))
(global-set-key "\M-\C-x" 'compare-windows)
(global-set-key "\M-\C-m" 'manual-entry)
(global-set-key "\M-\C-l" 'goto-line)
(global-set-key "\C-x=" 'what-line)
(global-set-key "\C-x\C-r" 'revert-buffer)
(global-set-key "\M-\C-]" 'this-line-to-top-of-screen)

