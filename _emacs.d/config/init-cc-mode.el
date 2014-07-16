(require 'rtags)
(rtags-enable-standard-keybindings c-mode-base-map)
(setq rtags-completion-enabled nil)
(evil-define-key 'normal c-mode-base-map "gd" 'rtags-find-symbol-at-point)
(evil-define-key 'normal c-mode-base-map "gs" 'rtags-set-current-project)
(evil-define-key 'normal c-mode-base-map "M-`" 'rtags-cycle-overlays-on-screen)
(evil-define-key 'normal c-mode-base-map "\C-o" 'rtags-location-stack-back)
(evil-define-key 'normal c-mode-base-map "\C-i" 'rtags-location-stack-forward)
(evil-define-key 'normal c-mode-base-map "\C-]" 'rtags-find-references-at-point)

;; -----------------------------------------------------------------------------
;; some setups for cc-mode
;; -----------------------------------------------------------------------------
(setq hide-ifdef-shadow t)

(add-hook 'c-mode-hook 'my-cc-mode-hook)
(add-hook 'c++-mode-hook 'my-cc-mode-hook)

(defun my-ac-cc-mode-setup ()
  (require 'irony)
  (irony-mode 1)
  (make-local-variable 'ac-auto-start)
  (setq ac-auto-start 4)
  (irony-enable 'ac)
  (setq ac-sources '(ac-source-irony ac-source-yasnippet ac-source-dictionary)))

;; -----------------------------------------------------------------------------
;; customize my hooks
;; -----------------------------------------------------------------------------
(defun my-cc-mode-hook ()
  (setq c-style-variables-are-local-p nil)
  ;; NO newline automatically after electric expressions are entered
  (setq c-auto-newline nil)
  ;; make DEL take all previous whitespace with it
  (c-toggle-hungry-state 1)
  ;; do not impose restriction that all lines not top-level be indented at least 1
  (setq c-label-minimum-indentation 0)
  (require 'google-c-style)
  (google-set-c-style)
  (c-set-style "Google")
  (setq c-default-style "Google")
  (setq comment-start "/// " comment-end "")
  (doxymacs-mode t)
  (doxymacs-font-lock)
  ;; (require 'cpp)
  ;; (global-cwarn-mode t)
  ;; (hide-ifdef-mode t)
  (unless buffer-read-only (my-ac-cc-mode-setup)))

;; (eval-after-load "cc-mode"
;;   '(progn
;;      (defun c-invalidate-state-cache (here) " " nil)))
(eval-after-load "llvm-mode" '(require 'llvmize))

;; -----------------------------------------------------------------------------
;; includes and flags
;; -----------------------------------------------------------------------------

(add-hook 'cc-mode-hook 'turn-on-auto-fill)

;; (dir-locals-set-class-variables 'llvm-3.4-directory
;;                                 '((nil . ((irony-compile-flags. ("-I/usr/lib/llvm-3.4/include"   "/usr/include/c++/4.6" "/usr/include/c++/4.6/backward" "/usr/include/c++/4.6/x86_64-linux-gnu" "/usr/include/c++/4.6/i686-linux-gnu" "/usr/lib/gcc/x86_64-linux-gnu/4.6/include"))))
;;                                   (nil . ((irony-compile-flags . ("/usr/lib/llvm-3.4/include" "/usr/include" "/usr/include/linux" "/usr/local/include" "/usr/include/c++/4.6/"))))))
;; (dir-locals-set-directory-class
;;  "/usr/lib/llvm-3.4/include/clang-c/" 'llvm-3.4-directory)

;; (dir-locals-set-directory-class
;;  "/usr/lib/llvm-3.4/include/clang" 'llvm-3.4-directory)

(provide 'init-cc-mode)
