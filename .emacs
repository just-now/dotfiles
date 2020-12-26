(setq c-default-style '((c-mode . "linux") (awk-mode . "awk") (other . "gnu")))
(setq enable-local-variables :safe)

(setq inhibit-startup-message   t)
(setq make-backup-files         nil)
(setq auto-save-list-file-name  nil)
(setq auto-save-default         nil)
(fset 'yes-or-no-p 'y-or-n-p)

(setq scroll-conservatively     3)
(set-default 'truncate-lines    t)
(column-number-mode             t)
(tool-bar-mode			0)
(setq calendar-week-start-day 1 european-calendar-style t)
(progn (require 'uniquify) (setq uniquify-buffer-name-style 'forward))

;; Semi-automatic rstripping
(defun delete-trailing-whitespace-if-confirmed ()
  (when (and (save-excursion (goto-char (point-min))
			     (re-search-forward "[[:blank:]]$" nil t))
	     (y-or-n-p (format "Delete trailing whitespace from %s? "
			       (buffer-name))))
    (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'delete-trailing-whitespace-if-confirmed)

;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Color-theme
(load-theme 'solarized-light t)
(set-face-attribute 'default nil :height 150)
(set-frame-size (selected-frame) 80 41)

;; Major bindings
(global-set-key (kbd "M-g f") 'counsel-git)
(global-set-key (kbd "M-g r") 'counsel-git-grep)
(global-set-key (kbd "M-g s") 'magit-status)
(global-set-key (kbd "M-g i") 'counsel-imenu)
(global-set-key (kbd "M-g j") 'ace-jump-line-mode)
;; lsp-ivy-workspace-symbol

;; LSP and C++
(add-hook 'c-mode-common-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)

(with-eval-after-load 'lsp-mode (yas-global-mode))


;; Org-mode
(require 'org-indent)
(setq org-confirm-babel-evaluate nil)
(setq org-babel-python-command "python3")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python     . t)
   (emacs-lisp . t)
   (lilypond   . t)
   (plantuml   . t)
   (dot        . t)))

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

(setq org-default-notes-file "~/Private/org/notes.org")
(setq org-agenda-files (list "~/Private/org/notes.org"
			     "~/Private/org/test.org"))
(setq org-capture-templates
      `(("i" "inbox" entry (file "~/Private/org/notes.org")
         "* TODO %?")
        ("l" "link" entry (file "~/Private/org/notes.org")
         "* TODO %(org-cliplink-capture)" :immediate-finish t)
        ("c" "org-protocol-capture" entry (file "~/Private/org/notes.org")
         "* TODO [[%:link][%:description]]\n\n %i" :immediate-finish t)))

;; (setq org-log-done 'time)
(require 'org-protocol)


(use-package which-key
  :init (which-key-mode 1)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(ivy-mode 1)

(use-package counsel
  :ensure t
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-h f"   . counsel-describe-function)
         ("C-h v"   . counsel-describe-variable)
	 ("C-x b"   . counsel-switch-buffer)
	 ("<f5>"    . counsel-compile)))

;; Python LSP
(add-hook 'python-mode-hook #'lsp)
(add-hook 'pyhon-mode-hook
          (lambda ()
            (when (flycheck-may-enable-checker 'python-flake8)
              (flycheck-select-checker 'python-flake8))))
(setq xref-prompt-for-identifier '(not xref-find-definitions
                                       xref-find-references))
;; (setq flycheck-list-errors nil)
(setq flycheck-highlighting-mode nil)

