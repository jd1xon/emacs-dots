;;; init.el -- Lonzo's Emacs config -*- lexical-binding: t; -*-

;;; Commentary:

;; This file has three main jobs. First, to configure the garbage
;; collection. Second, do some sane defaults. Finally, read the
;; Org-mode Configuration file and build an Emacs-lisp config
;; from that.

;;; Code:

(let ((default-directory user-emacs-directory)
      (file-name-handler-alist nil)
      (gc-cons-percentage .6)
      (gc-cons-threshold most-positive-fixnum)
      (read-process-output-max (* 1024 1024)))

  ;; Let's disable the startup messages.
  (setq inhibit-startup-echo-area-message user-login-name)

  ;; Configure some things so that we can tangle
  (put 'after-save-hook 'safe-local-variable
       (lambda (value) (equal value '(org-bable-tangle t))))
  (put 'display-line-numbers-width 'safe-local-variable 'integerp)

  ;; Tangle and compile the org-file when necessary. Then,
  ;; load the config

  ;; (let* ((.org "config.org")
  ;; 	 (.el (concat (file-name-sans-extension .org) ".el"))
  ;; 	 (modification-time
  ;; 	  (file-attribute-modification-time (file-attributes .org))))
  ;;   (unless (org-file-newer-than-p .el modification-time)
  ;;     (org-babel-tangle-file .org .el "emacs-lisp")
  ;;     (byte-compile-file .el))
  ;;   (load-file .el))
  (org-babel-load-file "~/.emacs.d/config.org")

  ;; Set the working directory to home.
  (cd "~/")

  ;; Garbage Collect!
  (garbage-collect))

;;; init.el ends here
