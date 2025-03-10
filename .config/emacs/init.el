(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (require 'use-package)
  (setq use-package-always-ensure t))

(use-package emacs
  :config
  (setq
   ;; text-mode-ispell-word-completion nil
   ;; relative numbers
   display-line-numbers-type 'relative
   ;; safe themes
   custom-safe-themes t
   ;; Disable file backup
   make-backup-files nil
   ;; Disable scratch message
   initial-scratch-message nil
   ;; Disable startup message
   inhibit-startup-message t)

  (scroll-bar-mode -1)    ;; Disable visible scrollbar
  (tool-bar-mode -1)      ;; Disable toolbar
  (tooltip-mode -1)       ;; Disable tooltips
  (menu-bar-mode -1)      ;; Disable menu bar

  (set-fringe-mode 5)     ;; Change gap

  (global-hl-line-mode t) ;; Highlight current line

  ;; Удалять пробелы
  ;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

  ;; Сохранение места в файле
  (save-place-mode 1)

  ;; Make ESC quit prompts
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

  ;; Transparency
  (add-to-list 'default-frame-alist '(alpha-background . 90))

  ;; Font
  (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 120)

  ;; Line numbers
  (global-display-line-numbers-mode t)
  (dolist (mode '(term-mode-hook
                  shell-mode-hook
                  eshell-mode-hook
                  org-mode-hook
                  visual-fill-column-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))


  (setq treesit-language-source-alist
   '((python "https://github.com/tree-sitter/tree-sitter-python")
     (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (rust "https://github.com/tree-sitter/tree-sitter-rust")))
  (customize-set-value 'treesit-font-lock-level 4)
  (custom-set-faces
   '(font-lock-operator-face ((t (:foreground "#F86882")))))
  
  ;; better scrolling experience
  (setq
   scroll-margin 20
   scroll-conservatively 101 ; > 100
   scroll-preserve-screen-position t
   auto-window-vscroll nil)

  (setq-default
   indicate-empty-lines t
   ;; Always use spaces for indentation
   indent-tabs-mode nil
   tab-width 4))

(use-package org
  :hook
  (org-mode . org-indent-mode)
  (org-mode . variable-pitch-mode)
  (org-mode . visual-line-mode)
  :config
  ;; fix pitch (may be use-package mixed pitch
  (custom-theme-set-faces
   'user
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit fixed-pitch))))
   '(org-table ((t (:inherit fixed-pitch )))))

  ;; headers size
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.1))))
   '(org-level-6 ((t (:inherit outline-5 :height 1.1))))
   '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-]\\) "
      (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; org tempo
  (require 'org-tempo)
  (setq
   org-structure-template-alist
   '(
     ("C" . "comment")
     ("e" . "example")
     ("q" . "quote")
     ("v" . "verse")

     ("el"   . "src emacs-lisp")
     ("nix"  . "src nix")
     ("cc"   . "src c")
     ("hs"   . "src haskell")
     ("jv"   . "src java")
     ("lua"  . "src lua")
     ("sh"   . "src shell")
     ("sql"  . "src sql")
     ("toml" . "src toml")
     ("conf" . "src conf")
     ("yml"  . "src yaml")
     ("py"   . "src python")))

  ;; todo keywords
  ;; (setq org-todo-keywords
  ;;     '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
  ;;       (sequence "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  ;; open links
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

  ;; habit
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)

  (global-set-key (kbd "C-M-<return>") 'org-insert-todo-heading)

  ;;agenda
  (global-set-key (kbd "C-c o a") #'org-agenda)
  (setq
   org-agenda-custom-commands
   '(("d" "Daily Agenda"
      ((agenda "" ((org-agenda-span 'day)))))))

  ;; other
  (setq
   org-ellipsis " ▾"
   org-log-done 'time
   org-src-preserve-indentation t
   org-hide-emphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

  (use-package visual-fill-column
    :hook (org-mode . visual-fill-column-mode)
    :config
    (setq-default
     visual-fill-column-width 150
     visual-fill-column-center-text t))

(use-package org-roam
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates

   '(("d" "default"
      plain "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("m" "Map"
      plain (file "~/RoamNotes/Templates/MapNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("e" "Ephemeral"
      plain (file "~/RoamNotes/Templates/EphemeralNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("p" "Project"
      plain (file "~/RoamNotes/Templates/ProjectNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+date: %U")
      :unnarrowed t)
     ("c" "Concept"
      plain (file "~/RoamNotes/Templates/ConceptNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("w" "Framework"
      plain (file "~/RoamNotes/Templates/FrameworkNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("v" "VariableTag"
      plain (file "~/RoamNotes/Templates/VariableTagNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("l" "Language"
      plain (file "~/RoamNotes/Templates/LanguageNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("t" "Tool"
      plain (file "~/RoamNotes/Templates/ToolNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("f" "Fact"
      plain (file "~/RoamNotes/Templates/FactNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)
     ("b" "Book note"
      plain (file "~/RoamNotes/Templates/BookNoteTemplate.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U")
      :unnarrowed t)))

  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"   . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (setq org-roam-node-display-template "${title:100} ${tags:100}")
  (require 'org-roam-dailies)
  (org-roam-setup))

(use-package org-roam-ui)

(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (my/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun my/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (my/org-roam-list-notes-by-tag "Project")))

;; Build the agenda list the first time for the session
(my/org-roam-refresh-agenda-list)

(defun my/org-roam-copy-todo-to-today ()
  (interactive)
  (let ((org-refile-keep t) ;; Set this to nil to delete the original!
        (org-roam-dailies-capture-templates
          '(("t" "tasks" entry "%?"
             :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Tasks")))))
        (org-after-refile-insert-hook #'save-buffer)
        today-file
        pos)
    (save-window-excursion
      (org-roam-dailies--capture (current-time) t)
      (setq today-file (buffer-file-name))
      (setq pos (point)))

    ;; Only refile if the target file is different than the current file
    (unless (equal (file-truename today-file)
                   (file-truename (buffer-file-name)))
      (org-refile nil nil (list "Tasks" today-file nil pos)))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (when (equal org-state "DONE")
                 (my/org-roam-copy-todo-to-today))))

(use-package evil
  :init
  (setq
   evil-want-C-i-jump nil
   evil-want-integration t
   evil-want-keybinding nil)
  :config
  (evil-mode))

;; (use-package evil-lion
;;   :config
;;   (evil-lion-mode))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :after (org evil)
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package dired
  :ensure nil
  ;; :custom ((dired-listing-switches "-agho --group-directories-first"))
  :custom ((dired-listing-switches "-alh --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))

(use-package treemacs)

(use-package electric
  :hook (python-ts-mode . electric-pair-mode))

(use-package yasnippet
  :config
  (setq yas-snippet-dirs
        '("~/projects/my_snippets"))

  (yas-global-mode 1))

(use-package doom-themes
  :config
  ;; (load-theme 'doom-material t))
  ;; (load-theme 'doom-nord t))
  ;; (load-theme 'doom-tokyo-night t))
  ;; (load-theme 'doom-gruvbox t))
  ;; (load-theme 'doom-solarized-dark t))
  ;; (load-theme 'doom-dracula t))
  (load-theme 'doom-one t))
  ;; (load-theme 'doom-monokai-pro t))

(use-package catppuccin-theme)

(use-package solaire-mode
  :init
  (solaire-global-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :hook org-mode prog-mode)

;; (use-package rainbow-identifiers)

(use-package all-the-icons)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package highlight-indent-guides
  :hook (
         (python-ts-mode . highlight-indent-guides-mode))  ; Включить для режимов программирования
  :config
  ;; Настройка стиля отображения (вертикальные линии)
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-tree-sitter t)

  ;; Символ для отображения линий (похоже на indent-blankline.nvim)
  (setq highlight-indent-guides-character ?│) ; Используем символ вертикальной линии

  ;; Цвет для линий отступов
  (set-face-foreground 'highlight-indent-guides-character-face "#848484")

  ;; Подсветка всех уровней отступов
  (setq highlight-indent-guides-auto-enabled t))

(use-package hl-todo
  :hook (org-mode . hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
      '(("TODO"   . "#c897ff")
        ("PAUSED" . "#68cee8")
        ("REVIEW" . "#89e14b")
        ("FIXME"  . "#e81050"))))

(use-package whitespace
  :ensure nil
  :hook (prog-mode . whitespace-mode)
  :config
  (setq whitespace-line-column 100))

(use-package dashboard
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-center-content nil)
  ;; (setq dashboard-startup-banner 1)
  (setq dashboard-startup-banner 5)
  (setq dashboard-items '((recents . 3)
                          (bookmarks . 3)
                          (agenda . 3)
                          (projects . 3)))
  :config
  (dashboard-setup-startup-hook))

(use-package doom-modeline
  :config
  (doom-modeline-mode t))

(use-package helpful
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key))

;; (use-package command-log-mode)

(use-package writeroom-mode)

(use-package snow)

(use-package fireplace)

(use-package perspective
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :init
  (persp-mode))

(use-package which-key
  :init
  (which-key-mode))

(use-package general
  :after evil
  :config
  (general-evil-setup)
  (general-create-definer rune/leader-keys
    :keymaps '(normal visual emacs)
    :prefix "SPC")

  (rune/leader-keys
    ;; roam keys
    "r" '(:ignore t :which-key "roam")
    "ri" '(org-roam-node-insert :which-key "insert")
    "rf" '(org-roam-node-find :which-key "find")
    "ru" '(org-roam-ui-mode :which-key "graph")
    "rd" '(org-roam-dailies-map :which-key "daily")
    "rl" '(org-roam-buffer-toggle :which-key "links")

    ;; leaving emacs
    "q" '(:ignore t :which-key "leaving")
    "qr" '(restart-emacs t :which-key "restart")
    "qq" '(kill-emacs t :which-key "quit")
    "qc" '(save-buffers-kill-terminal t :which-key "close")

    ;; files
    "f" '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fs" '(save-buffer :which-key "save file")

    ;; window management
    "w" '(evil-window-map :which-key "windows")

    ;; dired
    "d" '(:ignore t :which-key "dired")

    ;; perspective
    "e" '(perspective-map :which-key "perspective")

    ;; help
    "h" '(:ignore t :which-key "help")
    "hf" '(helpful-callable t :which-key "desc function")
    "hc" '(helpful-command t :which-key "desc command")
    "hv" '(helpful-variable t :which-key "desc variable")
    "hk" '(helpful-key t :which-key "desc key")

    ;; git
    "g" '(:ignore t :which-key "git")

    ;; org
    "m" '(:ignore t :which-key "org")
    "ml" '(org-babel-tangle :which-key "tangle")
    "ms" '(org-schedule :which-key "schedule")
    "md" '(org-deadline :which-key "deadline")
    "mt" '(org-todo :which-key "todo")
    "ma" '(org-agenda :which-key "agenda")
    "mo" '(org-open-at-point :which-key "open")

    ;; buffers
    "b" '(:ignore t :which-key "buffers")

    ;; projects
    "p" '(:ignore t :which-key "projects")
    "ps" '(consult-projectile-switch-project :which-key "switch project")
    "pf" '(project-find-file :which-key "file")
    "pd" '(project-find-dir :which-key "dir")
    "pD" '(project-dired :which-key "dired")
    "pb" '(project-switch-to-buffer :which-key "buffer")

    ;; lsp
    "l" '(:ignore t :which-key "lsp")

    ;; toggle
    "t" '(:ignore t :which-key "toggle")

    ;; other
    "y" '(yas-insert-snippet :which-key "insert snippet")
    "c" '(consult-theme :which-key "choose theme")
    "." '(find-file :which-key "find file")
    "," '(consult-buffer :which-key "choose buffer")))

(use-package vertico
  :bind
  (:map
   vertico-map
   ("C-j" . vertico-next)
   ("C-k" . vertico-previous)
   ("C-h" . vertico-directory-up)
   ("C-l" . vertico-directory-enter))
  :config
  (setq vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :bind
  ("C-x b" . consult-buffer))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :config
  ;; (global-set-key (kbd "C-x C-y") 'company-yasnippet)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-dabbrev-ignore-case t)
  (company-show-numbers t)
  (company-selection-wrap-around t)
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-statistics
  :after company
  :config
  (company-statistics-mode t))

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))

;; (use-package corfu
;;   :hook (after-init . global-corfu-mode)
;;   :custom
;;   (corfu-auto t) ; Включаем автоматическое дополнение
;;   (corfu-auto-delay 0.1) ; Задержка перед автоматическим дополнением
;;   (corfu-auto-prefix 1) ; Минимальное количество символов для автодополнения
;;   (corfu-popupinfo-delay 0.5) ; Задержка перед показом дополнительной информации
;;   (corfu-preselect 'prompt) ; Автоматически выбирать первый вариант
;;   (corfu-cycle t) ; Циклический переход по вариантам
;;   :bind (:map corfu-map
;;               ("M-SPC" . corfu-complete) ; Завершение дополнения по M-SPC
;;               ("TAB" . corfu-next) ; Переход к следующему варианту по TAB
;;               ([tab] . corfu-next) ; Альтернативная привязка для TAB
;;               ("S-TAB" . corfu-previous) ; Переход к предыдущему варианту по Shift-TAB
;;               ([backtab] . corfu-previous))) ; Альтернативная привязка для Shift-TAB


;; (use-package cape
;;   :after corfu
;;   :init
;;   (add-to-list 'completion-at-point-functions #'cape-dabbrev) ; Дополнение по словам в буфере
;;   ;; (add-to-list 'completion-at-point-functions #'cape-file) ; Дополнение по файлам
;;   (add-to-list 'completion-at-point-functions #'cape-history) ; Дополнение по истории
;;   (add-to-list 'completion-at-point-functions #'cape-keyword) ; Дополнение по ключевым словам
;;   (add-to-list 'completion-at-point-functions #'cape-symbol) ; Дополнение по символам
;;   (add-to-list 'completion-at-point-functions #'cape-abbrev) ; Дополнение по аббревиатурам
;;   :config
;;   (setq cape-dabbrev-min-length 3)) ; Минимальная длина слова для дополнения
  ;; (setq cape-dabbrev-check-other-buffers t)) ; Поиск слов в других буферах

;; (use-package nerd-icons-corfu
;;   :after corfu
;;   :config
;;   (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; (use-package yasnippet-capf
;;   :after cape
;;   :config
;;   (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package projectile
  :config
  (setq projectile-project-search-path '("~/projects/"))
  (projectile-mode 1))
(use-package consult-projectile)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode
         (python-ts-mode . lsp-deferred)
         (haskell-ts-mode . lsp-deferred)
         (go-ts-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :config
  (setq lsp-pyright-mypy-enabled t) ; Включить mypy через pyright
  (setq lsp-pyright-use-library-code-for-types t) ; Использовать типы из библиотек
  :commands lsp lsp-deferred)

(use-package lsp-ui :commands lsp-ui-mode)
;; (use-package consult-lsp)

(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-python-ruff-executable "ruff")
  (setq flycheck-python-mypy-executable "mypy")
  (setq flycheck-python-pyright-executable "pyright"))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

(use-package python-mode
  :hook (python-mode . python-ts-mode))

(use-package pyvenv ;; or pyenv-mode
  :hook (python-ts-mode . pyvenv-mode)
  :config
  (setq pyvenv-post-activate-hooks (list (lambda () (lsp-restart-workspace)))))

(use-package flymake-ruff
  :hook (python-ts-mode . flymake-ruff-load))

(use-package flycheck-mypy
  :after flycheck
  :config
  (add-to-list 'flycheck-checkers 'mypy))

(use-package lsp-pyright
  :custom
  (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  (lsp-pyright-disable-organize-imports t)
  (lsp-pyright-type-checking-mode "off")
  :hook (python-ts-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; (use-package haskell-mode)
;; (use-package haskell-ts-mode)
;; (use-package lsp-haskell)

(use-package go-mode
  :hook (go-mode . go-ts-mode))

(use-package go-eldoc
  :hook (go-ts-mode . go-eldoc-setup))

(use-package auctex)
  ;; :config
  ;; (setq TeX-view-program-selection '((output-pdf "Zathura"))))
;; (use-package evil-tex)
;; (use-package latex-preview-pane)

;; (use-package pdf-tools)

(use-package nix-mode)

(use-package lua-mode)

(use-package toml-mode)

(use-package yaml-mode)
