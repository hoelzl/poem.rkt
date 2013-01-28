;;; Written by Eli Barzilay: Maze is Life!  (eli@barzilay.org)

;;> This module combines all modules to form the Swindle language module.
;;>
;;> Note that it does not re-define `#%module-begin', so the language used
;;> for transformers is still the one defined by `turbo'.

#lang s-exp swindle/turbo

(require racklog)
(provide (all-from racklog))

(require swindle/clos swindle/extra)
(provide (all-from swindle/turbo)
         (all-from swindle/clos)
         (all-from swindle/extra)
         install-poem-printer)

(define* (install-poem-printer)
  (global-port-print-handler write-object)
  (port-display-handler (current-output-port) display-object)
  (port-display-handler (current-error-port)  display-object)
  (port-write-handler   (current-output-port) write-object)
  (port-write-handler   (current-error-port)  write-object)
  ;; Is this needed?
  (port-print-handler (current-output-port) print-object)
  (port-print-handler (current-error-port) print-object))

(install-poem-printer)

;; For Geiser...
(define (repl-printer object &optional [port (current-output-port)])
  (unless (eq? object (void))
    (write-object object port)
    (newline port)))
(current-print repl-printer)

