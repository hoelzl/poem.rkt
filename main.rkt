;;; Written by Eli Barzilay: Maze is Life!  (eli@barzilay.org)

;;> This module combines all modules to form the Swindle language module.
;;>
;;> Note that it does not re-define `#%module-begin', so the language used
;;> for transformers is still the one defined by `turbo'.

#lang s-exp swindle/turbo

(require swindle/clos swindle/extra)
(require (only racket/base
               for for/list for/vector
               for/hash for/hasheq for/hasheqv
               for/and for/or for/sum for/product
               for/lists for/first for/last for/fold
               for* for*/list for*/vector
               for*/hash for*/hasheq for*/hasheqv
               for*/and for*/or for*/sum for*/product
               for*/lists for*/first for*/last for*/fold
               in-list in-mlist in-vector in-string
               in-bytes in-port in-input-port-bytes
               in-input-port-chars in-lines in-bytes-lines
               in-hash in-hash-keys in-hash-values in-hash-pairs
               in-directory in-producer in-value in-indexed
               in-sequences in-cycle in-parallel
               in-values-sequence in-values*-sequence
               stop-before stop-after))

(provide (all-from racket/base)
         (all-from swindle/turbo)
         (all-from swindle/clos)
         (all-from-except swindle/extra amb amb-assert amb-collect)
         install-poem-printer
         repl-printer)


;; (require racklog)
;; (provide (all-from racklog))

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

