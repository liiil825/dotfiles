(setq user-full-name "Li Zhi"
      user-mail-address "liiil825.2012@gmail.com")

(setq doom-theme 'doom-one)
(map! :leader
      :desc "Load new theme" "h t" #'counsel-load-theme)

(setq doom-font (font-spec :family "Source Code Pro" :size 20)
      doom-variable-pitch-font (font-spec :family "Source Code Pro") ; assumes you also want this for variable pitch
      doom-big-font (font-spec :family "Source Code Pro" :size 20)) ; assumes you want this for `doom-big-font-mode`
(setq doom-modeline-font (font-spec :family "SpaceMono Nerd Font" :size 20))

(setq display-line-numbers-type t)

(setq org-directory "~/org")
(defun lz/org-cursor-move-up()
  "Smart cursor move up"
  (interactive)
  (if (org-at-heading-p) (call-interactively 'org-backward-heading-same-level)
    (evil-previous-line)))
(defun lz/org-cursor-move-down ()
  "Smart cursor move down"
  (interactive)
  ;; (if org-at-heading-p org-backward-heading-same-level)
  (if (org-at-heading-p) (call-interactively 'org-forward-heading-same-level)
      (evil-next-line))
  )

(setq
   org-fancy-priorities-list '("🟥" "🟧" "🟨")
   org-priority-faces
   '((?A :foreground "#ff6c6b" :weight bold)
     (?B :foreground "#98be65" :weight bold)
     (?C :foreground "#c678dd" :weight bold))
   org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo "")))))

(defun lz/org-colors-doom-one ()
  "Enable Doom One colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.0 "#51afef" ultra-bold)
         (org-level-2 1.0 "#c678dd" extra-bold)
         (org-level-3 1.0 "#98be65" bold)
         (org-level-4 1.0 "#da8548" semi-bold)
         (org-level-5 1.0 "#5699af" normal)
         (org-level-6 1.0 "#a9a1e1" normal)
         (org-level-7 1.0 "#46d9ff" normal)
         (org-level-8 1.0 "#ff6c6b" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

;; (use-package! org-auto-tangle
;;   :defer t
;;   :hook (org-mode . org-auto-tangle-mode)
;;   :config
;;   (setq org-auto-tangle-default t))
;;
;; (defun lz/insert-auto-tangle-tag ()
;;   "Insert auto-tangle tag in a literate config."
;;   (interactive)
;;   (evil-org-open-below 1)
;;   (insert "#+auto_tangle: t ")
;;   (evil-force-normal-state))
;;
;; (map! :leader
;;       :desc "Insert auto_tangle tag" "i a" #'lz/insert-auto-tangle-tag)

(after! org
  (setq org-reveal-root "file:///home/david/code/reveal.js/")
  (setq org-todo-keywords
        '((sequence "TODO(t@/!)" "IN-PROGRESS(i@/!)" "WAIT(w@/!)" "|" "DONE(d@/!)" "CANCELLED(c)"))
        org-log-into-drawer t
        )
  (setq org-refile-targets '((nil :maxlevel . 3)
                             ("archive.org" :maxlevel . 3)
                             ("links.org" :maxlevel . 3)))
  (setq org-bullets-bullet-list '("◉" "●" "○" "◆" "●" "○" "◆"))
  (setq org-default-notes-file (expand-file-name "notes.org" org-directory))
  (when (file-directory-p "~/org/roam/")
    (setq org-roam-directory (file-truename "~/org/roam")))
  (when (file-directory-p "~/org/daily")
    (setq org-roam-dailies-directory (file-truename "~/org/daily")))
  (setq org-agenda-files (list "~/org"))
  (setq org-roam-db-gc-threshold most-positive-fixnum)  ;; 提高性能
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (map! :map org-mode-map (
                            (:nvi "<up>" #'lz/org-cursor-move-up)
                            (:nvi "<down>" #'lz/org-cursor-move-down)
                            ("C-c n i"  #'org-roam-node-insert)
                            ("C-c n c"  #'org-roam-capture)
                            ("C-c n f" #'org-roam-node-find)
                            ("C-c n l"  #'org-roam-buffer-toggle) ;; 显示后链窗口
                            ("C-c n u"  #'org-roam-ui-mode)
                            ("C-c n d"  #'org-roam-dailies-map)
                            ))
  (org-roam-db-autosync-mode)
  ;; Load our desired dt/org-colors-* theme on startup
  (lz/org-colors-doom-one)
  )

(after! org-roam
  (setq org-roam-ui-sync-theme t)
  (setq org-roam-ui-follow t)
  (setq org-roam-ui-update-on-save t))

;; (use-package ox-man)
;; (use-package ox-gemini)

(after! org
  (setq org-journal-dir "~/org/daily/"
        org-journal-date-prefix "* "
        org-journal-time-prefix "** "
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org")
)

;; (after! which-key
  ;; (setq which-key-popup-type 'minibuffer)
  ;; (setq which-key-popup-type 'frame)
  ;; (diminish 'which-key-mode)
  ;; (setq which-key-idle-delay 0)
  ;; )

(map! :leader
      (:prefix ("n r" . "org-roam")
       :desc "Completion at point" "c" #'completion-at-point
       :desc "Find node"           "f" #'org-roam-node-find
       :desc "Show graph"          "g" #'org-roam-graph
       :desc "Insert node"         "i" #'org-roam-node-insert
       :desc "Capture to node"     "n" #'org-roam-capture
       :desc "Toggle roam buffer"  "r" #'org-roam-buffer-toggle))
