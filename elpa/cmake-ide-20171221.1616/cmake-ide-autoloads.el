;;; cmake-ide-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "cmake-ide" "../../../../../.emacs.d/elpa/cmake-ide-20171221.1616/cmake-ide.el"
;;;;;;  "5dbe8a63d469e0a390539b000be773f3")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/cmake-ide-20171221.1616/cmake-ide.el

(autoload 'cmake-ide-setup "cmake-ide" "\
Set up the Emacs hooks for working with CMake projects.

\(fn)" nil nil)

(autoload 'cmake-ide-maybe-run-cmake "cmake-ide" "\
Run CMake if the compilation database JSON file is not found.

\(fn)" t nil)

(autoload 'cmake-ide-run-cmake "cmake-ide" "\
Run CMake and set compiler flags for auto-completion and flycheck.
This works by calling cmake in a temporary directory (or cmake-ide-build-dir)
 and parsing the JSON file deposited there with the compiler
 flags.

\(fn)" t nil)

(autoload 'cmake-ide-load-db "cmake-ide" "\
Load compilation DB and set flags for current buffer.

\(fn)" t nil)

(autoload 'cmake-ide-compile "cmake-ide" "\
Compile the project.

\(fn)" t nil)

(autoload 'cmake-ide-maybe-start-rdm "cmake-ide" "\
Start the rdm (rtags) server.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/cmake-ide-20171221.1616/cmake-ide-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/cmake-ide-20171221.1616/cmake-ide.el")
;;;;;;  (23131 63246 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; cmake-ide-autoloads.el ends here
