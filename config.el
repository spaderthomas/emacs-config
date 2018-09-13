(setq user-full-name "Thomas Spader"
      user-mail-address "thomas.spader@gmail.com")

(show-paren-mode t)
(global-font-lock-mode t) 
(setq-default tab-width 4)
(electric-indent-mode 1)

(cua-mode t)
(setq x-select-enable-clipboard t)
(delete-selection-mode 1)

(setq-default cursor-type 'bar)

(setq backup-directory-alist
      `((".*" . ,"~/.saves")))

(setq message-log-max nil)

(cd "C:/Users/dboon")

(use-package linum)
(global-linum-mode t)

;; scroll one line at a time (less "jumpy" than defaults). note: this may not do anything
(setq mouse-wheel-scroll-amount '(2 ((shift) . 2))) ;; 2 lines at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(use-package pabbrev
  :init
  (setq pabbrev-idle-timer-verbose nil
		pabbrev-read-only-error nil))

(define-key pabbrev-mode-map [tab] 'pabbrev-expand-maybe)
(add-hook 'text-mode-hook (lambda () (pabbrev-mode)))
(add-hook 'prog-mode-hook 'pabbrev-mode)

(use-package org
  :init
  (setq org-src-fontify-natively t
		org-src-window-setup 'current-window
		org-src-strip-leading-and-trailing-blank-lines t
		org-src-preserve-indentation t
		org-src-tab-acts-natively t
		org-clock-persist 'history
		org-duration-format (quote h:mm)
		org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))
		org-agenda-files (list "C:/Users/dboon/school.org"
							   "C:/Users/dboon/jobs.org"))
  :ensure org-plus-contrib
  :pin fuck-emacs)

(define-key org-mode-map (kbd "C-c i") 'org-clock-in)
(define-key org-mode-map (kbd "C-c o") 'org-clock-out)
(define-key org-mode-map (kbd "C-c g") 'org-clock-report)

(define-key org-mode-map (kbd "C-1") 'other-window)
(define-key org-mode-map (kbd "C-j") 'backward-char)
(define-key org-mode-map (kbd "C-k") 'next-line)
(define-key org-mode-map (kbd "C-c a") 'org-agenda)

(setq org-replace-disputed-keys t)

(org-clock-persistence-insinuate)

(setq )
(add-hook 'org-load-hook 'autofill-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (C . t)
   (calc . t)
   (lisp . t)
   (js . t)))

(defun my-org-confirm-babel-evaluate (lang body)
  "Do not confirm evaluation for these languages."
  (not (or (string= lang "C")
           (string= lang "python")
           (string= lang "emacs-lisp"))))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

(use-package clang-format)

(setq-default fill-column 80)

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))

(load-library "shr.el")

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :config
  (setq dired-sidebar-subtree-line-prefix "..")
  (setq dired-sidebar-theme 'nerd))
(define-key global-map (kbd "C-c s") 'dired-sidebar-show-sidebar)

(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'" . web-mode))

(setq web-mode-content-types-alist
  '(("xml"  . "\\.config\\'")))

(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'prog-mode-hook 'visual-line-mode)

(use-package ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))

(setq gud-pdb-command-name "python -m pdb")

(add-hook 'python-mode-hook '(lambda () 
 (setq python-guess-indent nil)
 (setq indent-tabs-mode nil)
 (setq python-indent 4)
 (setq python-inden-offset 4)))

(add-hook 'html-mode-hook 'turn-off-auto-fill)

(add-hook 'c-mode-hook
  (lambda ()
   (hs-minor-mode)
   ))

(setq c-basic-offset 4)
(setq c-hungry-delete-key -1)

(setq build-script "build.bat")
(setq run-script "run.bat")			;

(defun find-project-directory-recursive ()
  "Recursively search for a makefile."
  (interactive)
  (if (file-exists-p build-script) t
      (cd "../")
	  (find-project-directory-recursive)))

(defun find-project-directory ()
  "Find the project directory."
  (interactive)
  (switch-to-buffer-other-window "*compilation*")
  (find-project-directory-recursive)
  (setq last-compilation-directory default-directory))

(defun make-without-asking ()
  "Make the current build."
  (interactive)
  (setq old-default default-directory)
  (when (find-project-directory) (compile build-script))
  (cd old-default))

(defun run ()
  "Looks for run.bat and executes it"
  (interactive)
  (setq old-default default-directory)
  (when (find-project-directory) (compile run-script))
  (cd old-default))

(define-key global-map (kbd "<f7>") 'make-without-asking)
(define-key global-map (kbd "<f5>") 'run)

(use-package cc-mode)

(define-key c-mode-map (kbd "C-c b") 'dumb-jump-back)
(define-key c-mode-map (kbd "C-c g") 'dumb-jump-go)
(define-key c-mode-map (kbd "C-c l") 'hs-show-block)
(define-key c-mode-map (kbd "C-c j") 'hs-hide-block) 
(define-key c-mode-map (kbd "C-d") 'delete-backward-char)
(define-key c-mode-map (kbd "C-;") 'clang-format-region)
(define-key c-mode-map (kbd "M-j") 'backward-word) ; bound to newline in c-mode
(define-key c-mode-map (kbd "C-c f") 'beginning-of-defun)

(define-key c++-mode-map (kbd "C-c b") 'dumb-jump-back)
(define-key c++-mode-map (kbd "C-c g") 'dumb-jump-go)
(define-key c++-mode-map (kbd "C-c l") 'hs-show-block)
(define-key c++-mode-map (kbd "C-c j") 'hs-hide-block) 
(define-key c++-mode-map (kbd "C-d") 'delete-backward-char)
(define-key c++-mode-map (kbd "C-;") 'clang-format-region)
(define-key c++-mode-map (kbd "M-j") 'backward-word) ; bound to newline in c-mode

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
   (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;;(set-frame-font "PxPlus IBM VGA8-11")
;;(set-frame-font "Inconsolata-12")

(use-package cyberpunk-theme
  :if (window-system)
  :ensure t
  :init
  (progn
    (load-theme 'cyberpunk t)
    (set-face-attribute `mode-line nil
                        :box nil)
    (set-face-attribute `mode-line-inactive nil
                        :box nil)))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun make-buffer-uninteresting ()
  "rename the current buffer to begin with a space"
  (interactive)
  (unless (string-match-p "^ " (buffer-name))
    (rename-buffer (concat " " (buffer-name)))))

(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

(defun copy-whole-word ()
  "Copies the entire word."
  (interactive)
  (save-excursion
(backward-word nil)
(mark-word nil)
(kill-ring-save (region-beginning) (region-end))))

(defun cut-whole-word ()
  "Cuts the entire word."
  (interactive)
  (save-excursion
(backward-word nil)
(mark-word nil)
(kill-region (region-beginning) (region-end))))

(defun replace-word-with-yank ()
"Replaces the word under the cursor with the last kill."
(interactive)
(cut-whole-word)
(yank 2)
(copy-whole-word))

(defun boon-scroll-down ()
  (interactive)
  (scroll-up 10))

(defun boon-scroll-up ()
  (interactive)
  (scroll-down 10))

(global-set-key (kbd "M-/") 'comment-or-uncomment-region)
(global-set-key (kbd "C-w") 'cut-whole-word)
(global-set-key (kbd "M-w") 'copy-whole-word)
(global-set-key (kbd "C-W") 'replace-word-with-yank)
(global-set-key (kbd "M-r") 'revert-buffer-no-confirm)
(global-set-key (kbd "C-x k") 'kill-buffer)
(global-set-key (kbd "C-x C-r") 'rename-file-and-buffer)

(global-set-key (kbd "C-3") 'next-buffer)
(global-set-key (kbd "C-2") 'previous-buffer)
(global-set-key (kbd "C-1") 'other-window)

(global-set-key (kbd "C-f") 'delete-char)
(global-set-key (kbd "C-d") 'delete-backward-char)
(global-set-key (kbd "M-d") 'backward-kill-word)
(global-set-key (kbd "M-f") 'kill-word)
(global-set-key (kbd "M-D") 'kill-whole-line)

(define-key input-decode-map (kbd "C-i") (kbd "H-i"))
(global-set-key (kbd "H-i") 'previous-line)
(global-set-key (kbd "C-j") 'backward-char)
(global-set-key (kbd "C-k") 'next-line)
(global-set-key (kbd "C-l") 'forward-char)

(global-set-key (kbd "M-i") 'backward-paragraph)
(global-set-key (kbd "M-k") 'forward-paragraph)
(global-set-key (kbd "M-l") 'forward-word)
(global-set-key (kbd "M-j") 'backward-word)

(global-set-key (kbd "M-h") 'backward-sexp)
(global-set-key (kbd "M-n") 'forward-sexp)

(global-set-key (kbd "C-q") 'query-replace)

(global-set-key [(control down)] 'boon-scroll-down)
(global-set-key [(control up)]   'boon-scroll-up)

(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq indent-tabs-mode nil) ; do i need this
