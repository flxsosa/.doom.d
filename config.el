;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Felix Sosa"
      user-mail-address "felixanthonysosa@gmail.com")

;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; doom-one (default), -outrun-electic, -moonlight, -snazzy, -laserwave
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Projectile search path is my git directory
(setq
 projectile-project-search-path '("~/git/") ;; Search this directory for projects
 )

;; Enable hidpi for pdf-tools
(setq pdf-view-use-scaling t)

;; Personal org parameters
(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (setq org-preview-latex-default-process'dvisvgm) ;; SVG for retina
  (setq org-agenda-files '("~/org/planner/inbox.org" ;; Agenda files
                          "~/org/planner/projects.org"
                          "~/org/planner/actions.org")
        org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" ;; Personal keywords
                                      "NOTE(n)" "IDEA(i)" "PROJ(p)" "|"
                                      "DONE(d)" "CANCELLED(c)"))
        org-todo-keyword-faces ;; Making my keywords pretty
        '(("TODO" :foreground "#FF9AA2" :weight semi-bold :underline t)
          ("INPROGRESS" :foreground "#FFB7B2" :weight semi-bold :underline t)
          ("DONE" :foreground "#FFDAC1" :weight semi-bold :underline t)
          ("CANCELLED" :foreground "#E2F0CB" :weight semi-bold :underline t)
          ("PROJ" :foreground "#B5EAD7" :weight semi-bold :underline t)
          ("NOTE" :foreground "#C7CEEA" :weight semi-bold :underline t)
          ("IDEA" :foreground "#FF9AA2" :weight semi-bold :underline t)
          ("WAITING" :foreground "#B5EAD7" :weight semi-bold :underline t))
        org-capture-templates '(("t" "Todo [inbox]" entry ;; Personal templates
                                (file+headline "~/org/planner/inbox.org" "Tasks")
                                "* TODO %i%?%^G")
                                ("P" "Projects [projects]" entry
                                (file+headline "~/org/planner/projects.org" "Projects")
                                "* PROJ %i%?%^G")
                                ("i" "Ideas [ideas]" entry
                                (file+headline "~/org/notebook/ideas.org" "Ideas")
                                "* IDEA %i%?%^G")
                                ("n" "Working Notes [notes]" entry
                                (file+headline "~/org/notebook/notes.org" "Working Notes")
                                "* NOTE %i%?%^G")
                                ("m" "Meeting Notes [notes]" entry
                                (file+headline "~/org/notebook/notes.org" "Meeting Notes")
                                "* NOTE Meeting with %^{PROMPT} %t %^G %?%i"))
        org-refile-targets '(("~/org/planner/actions.org" :maxlevel . 1) ;; Refile targets
                            ("~/org/planner/inbox.org" :maxlevel . 6)
                            ("~/org/planner/someday.org" :level . 1)
                            ("~/org/planner/projects.org" :maxlevel . 1))
        org-archive-location (concat "archive/archive-" ;; Archived files will be organized by month
                                    (format-time-string "%Y%m" (current-time))
                                    ".org_archive::")
        org-tag-alist '(("task" . ?t)
                        ("idea" . ?i)
                        ("project" . ?P)
                        ("note" . ?n)
                        ("personal" . ?p)
                        ("twitch" . ?T)
                        ("meeting" . ?m)))
  org-log-done 'time
  (require 'org-inlinetask)) ;; Experimenting with inline TODO marks

;; Evil-multiedit
(require 'evil-multiedit)
(use-package! evil-multiedit)
(evil-multiedit-default-keybinds) ;; Use default keybindings

;; Fancy priorities for org
(use-package org-fancy-priorities
  :ensure t
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("HIGH" "MED" "LOW"))) ;; Nothing too fancy
