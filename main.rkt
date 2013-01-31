#lang racket/base

(require (except-in racket/base #%top)
         racket/contract
         ;; racket/class
         racket/unit
         racket/dict
         racket/include
         racket/pretty
         racket/math
         racket/match
         racket/shared
         racket/set
         racket/tcp
         racket/udp
         racket/list
         racket/vector
         racket/string
         racket/bytes
         racket/function
         racket/path
         racket/file
         racket/place
         racket/future
         racket/port
         racket/cmdline
         racket/promise
         racket/bool
         racket/stream
         racket/sequence
         racket/local
         racket/system
         racket/format
         (for-syntax racket/base))

(provide (all-from-out racket/base
		       racket/contract
                       ;; racket/class
                       racket/unit
                       racket/dict
                       racket/include
                       racket/pretty
                       racket/math
                       racket/match
                       racket/shared
                       racket/base
                       racket/set
                       racket/tcp
                       racket/udp
                       racket/list
                       racket/vector
                       racket/string
                       racket/bytes
                       racket/function
                       racket/path
                       racket/file
                       racket/place
                       racket/future
                       racket/port
                       racket/cmdline
                       racket/promise
                       racket/bool
                       racket/stream
                       racket/sequence
                       racket/local
                       racket/system
                       racket/format)
         (for-syntax (all-from-out racket/base)))

(require (only-in swindle/base
		  #%top
		  getarg syntax-getarg
		  getargs keys/args
		  filter-out-keys)
	 swindle/setf
	 swindle/tiny-clos
	 swindle/clos
	 (only-in swindle/extra
		  defstruct
		  with-slots with-accessors
		  as add-as-method 
		  equals? add-equals?-method class+slots-equals?
		  make-equals?-compare-class+slots
		  add add-add-method
		  len add-len-method
		  ref add-ref-method set-ref!
		  put! add-put!-method
		  *print-level* *print-length*
		  print-object print-object-with-slots
		  display-object write-object
		  object->string))

(provide ;; swindle/base
         #%top

	 getarg syntax-getarg
	 getargs keys/args
	 filter-out-keys

	 ;; swindle/setf
	 setf! psetf! setf!-values
	 set-values! set-list! set-vector!
	 shift! rotate!

	 inc! dec! push! pop!

         ;; swindle/tiny-clos
	 ???
	 change-class! set-instance-proc!
	 instance? object? class-of
	 slot-ref slot-set! set-slot-ref!
	 slot-bound?

	 singleton singleton? singleton-value
	 struct-type->class

	 class-direct-slots class-direct-supers class-slots
	 class-cpl class-name class-initializers

	 generic-methods generic-arity generic-name
	 generic-combination

	 method-specializers method-procedure method-qualifier
	 method-name method-arity

	 <class> <top> <object>
	 <procedure-class> <entity-class> <function>
	 <generic> <method>

	 make-class make-generic-function make-method
	 no-next-method no-applicable-method

	 allocate-instance initialize
	 compute-getter-and-setter compute-cpl compute-slots
	 compute-apply-method

	 compute-apply-generic compute-methods
	 compute-method-more-specific? compute-apply-methods
	 add-method
	 make-generic-combination

	 generic-+-combination
	 generic-list-combination
	 generic-min-combination
	 generic-max-combination
	 generic-append-combination
	 generic-append!-combination
	 generic-begin-combination
	 generic-and-combination
	 generic-or-combination

	 subclass? instance-of? class? specializer?
	 more-specific?

	 *default-method-class*
	 *default-generic-class*
	 *default-class-class*
	 *default-entityclass-class*
	 *default-object-class*
	 *make-safely*
	 make rec-make

	 <primitive-class>
	 <builtin>
	 <sequence>
	 <immutable>
	 <pair> <immutable-pair> <list> <nonempty-list>
	 <null>
	 <vector>
	 <char> <string> <immutable-string>
	 <symbol>
	 <boolean>
	 <number> <exact> <inexact>
	 <complex> <real> <rational> <integer>
	 <exact-complex> <inexact-complex>
	 <exact-real> <inexact-real>
	 <exact-rational> <inexact-rational>
	 <exact-integer> <inexact-integer>
	 <end-of-file>
	 <port> <input-port> <output-port> <stream-port>
	 <input-stream-port> <output-stream-port>
	 <void>
	 <box> <weak-box>
	 <regexp>
	 <parameter>
	 <promise>
	 <exn>
	 <semaphore>
	 <hash-table>
	 <subprocess> <thread> 
	 <syntax> <identifier-syntax>
	 <namespace>
	 <custodian>
	 <tcp-listener>
	 <security-guard>
	 <will-executor>
	 <struct-type>
	 <inspector>
	 <pseudo-random-generator>
	 <compiled-expression>
	 <unknown-primitive>
	 <struct> <opaque-struct>
	 <procedure>
	 <primitive-procedure>
	 
	 builtin? function? generic? method?

	 ;; swindle/clos
	 generic defgeneric

	 ; call-next-method next-method?
	 method named-method qualified-method
	 -defmethod-create-generics-
	 defmethod
	 beforemethod aftermethod aroundmethod
	 defbeforemethod defaftermethod defaroundmethod

	 class entityclass
	 -defclass-auto-initargs-
	 -defclass-autoaccessors-naming-
	 -defclass-accessor-mode-
	 defclass defentityclass

	 ;; swindle/extra
	 defstruct
	 with-slots with-accessors
	 as add-as-method 

	 equals? add-equals?-method class+slots-equals?
	 make-equals?-compare-class+slots
	 add add-add-method
	 len add-len-method
	 ref add-ref-method set-ref!
	 put! add-put!-method

	 *print-level* *print-length*
	 print-object print-object-with-slots
	 display-object write-object
	 object->string
         install-poem-printer
         repl-printer)

(define (install-poem-printer)
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
;; How do we define this so that is only executed when Geiser is loaded?
;;   --tc
(define (repl-printer object [port (current-output-port)])
  (unless (eq? object (void))
    (write-object object port)
    (newline port)))
(current-print repl-printer)


