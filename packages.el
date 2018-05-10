;;;  -*- lexical-binding: t; -*-

;; Ruby stuff
(package! enh-ruby-mode)
(package! rbenv) ; i use rbenv
(package! yard-mode)
(package! rinari)
(package! rubocop)

;; lsp stuff
;; (package! lsp-mode)
;; (package! lsp-ui)
;; (package! company-lsp)
;; (package! lsp-javascript-typescript)

;; JS stuff
(package! flow-minor-mode)
(package! flycheck-flow)
(package! company-flow)
(package! prettier-js)
(package! pkgbuild-mode)

;; Lisp stuff
(package! parinfer)

;; Fuzzy searching
(package! flx)

;; Music stuff
(package! google-play-music :recipe (:fetcher github :repo "merrickluo/google-play-music.el"))

;; Filestuff
(package! ranger)

;; Reasonml stuff
(package! reason-mode)

;; Discord stuff
(package! elcord)

;; Email stuff
(package! notmuch)
(package! counsel-notmuch)
(package! org-mime)
