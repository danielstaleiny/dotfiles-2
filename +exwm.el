;;;  -*- lexical-binding: t; -*-
(after! evil
  (require 'exwm)
  (require 'exwm-config)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (setq exwm-input--line-mode-passthrough t)

  ;; Set the initial workspace number.
  (setq exwm-workspace-number 4)
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (setq exwm-input--line-mode-passthrough t)
              (exwm-workspace-rename-buffer exwm-class-name)))

  (defun +exwm-bind-command (key command &rest bindings)
    (while key
      (exwm-input-set-key (kbd key)
                          `(lambda ()
                             (interactive)
                             (start-process-shell-command ,command nil ,command)))
      (setq key (pop bindings)
            command (pop bindings))))
  (+exwm-bind-command "<s-S-return>" "urxvt")
  (+exwm-bind-command "s-X" "betterlockscreen -l blur")
  (+exwm-bind-command "s-p" "spectacle") ;; Screenshots!
  (+exwm-bind-command "s-w" "firefox") ;; Internet

  ;; Modeline
  (def-modeline-segment! datetime
    (current-time-string))
  (def-modeline! main
    (bar matches " " buffer-info "  %l:%c %p  " selection-info)
    (buffer-encoding major-mode vcs flycheck " " datetime))

  ;; Update every 5 seconds for the clock
  (run-at-time t 5 #'force-mode-line-update)

  ;; Startup programs
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (start-process-shell-command "discord" nil "discord")
  (start-process-shell-command "compton" nil "compton --config ~/.config/compton.conf")

  (defun +bind (key fun)
    "Bind KEY to FUN in exwm."
    (exwm-input-set-key (kbd key) fun))

  ;; (exwm-input-set-key (kbd "s-w") #'exwm-workspace-switch)
  (exwm-input-set-key (kbd "s-1") (lambda! (exwm-workspace-switch 0)))
  (exwm-input-set-key (kbd "s-!") (lambda! (exwm-workspace-move-window 0)))
  (exwm-input-set-key (kbd "s-2") (lambda! (exwm-workspace-switch 1)))
  (exwm-input-set-key (kbd "s-@") (lambda! (exwm-workspace-move-window 1)))
  (exwm-input-set-key (kbd "s-3") (lambda! (exwm-workspace-switch 2)))
  (exwm-input-set-key (kbd "s-#") (lambda! (exwm-workspace-move-window 2)))
  (exwm-input-set-key (kbd "s-4") (lambda! (exwm-workspace-switch 3)))
  (exwm-input-set-key (kbd "s-$") (lambda! (exwm-workspace-move-window 3)))
  ;; s-h, s-j, s-k, s-l: move around
  (+bind "s-h" #'evil-window-left)
  (+bind "s-j" #'evil-window-down)
  (+bind "s-k" #'evil-window-up)
  (+bind "s-l" #'evil-window-right)
  ;; Moving windows
  (+bind "s-H" #'evil-window-move-far-left)
  (+bind "s-J" #'evil-window-move-very-bottom)
  (+bind "s-K" #'evil-window-move-very-top)
  (+bind "s-L" #'evil-window-move-far-right)
  ;; Resizing windows
  (+bind "M-s-h" #'shrink-window-horizontally)
  (+bind "M-s-j" #'shrink-window)
  (+bind "M-s-k" #'enlarge-window)
  (+bind "M-s-l" #'enlarge-window-horizontally)
  ;; Buffer swapping
  (if (featurep! :completion ivy)
      (+bind "s-b" #'ivy-switch-buffer)
    (+bind "s-b" #'helm-mini))
  ;; Terminal
  (+bind "<s-return>" #'+eshell/open)
  ;; Prefix input
  (push ?\M-m exwm-input-prefix-keys)
  ;; Universal get me outta here
  (push ?\C-g exwm-input-prefix-keys)
  ;; C-c, C-x, C-v are needed for c+p
  (delete ?\C-x exwm-input-prefix-keys)
  (delete ?\C-c exwm-input-prefix-keys)
  (delete ?\C-v exwm-input-prefix-keys)
  ;; We can use `M-m h' to access help
  (delete ?\C-h exwm-input-prefix-keys)


  ;; 's-SPC': Launch application
  (exwm-input-set-key (kbd "s-S-SPC") #'counsel-linux-app)
  (exwm-input-set-key (kbd "s-SPC")
                      (lambda (command)
                        (interactive (list (read-shell-command "$ ")))
                        (start-process-shell-command command nil command)))
  (def-package! pinentry
    :config
    (pinentry-start))
  ;; Enable EXWM
  (exwm-enable))
