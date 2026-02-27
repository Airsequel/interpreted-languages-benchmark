(define start 1)
(define end-val 100000)
(define num-bins 20)

(define log-base (expt (/ end-val start) (/ 1 num-bins)))

(define bin-edges-int
  (map (lambda (i)
         (inexact->exact (round (* start (expt log-base i)))))
       (iota (+ num-bins 1))))

(display bin-edges-int)
(newline)
