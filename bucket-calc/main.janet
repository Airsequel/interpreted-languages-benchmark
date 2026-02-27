(def start 1)
(def end-val 100000)
(def num-bins 20)

(def log-base (math/pow (/ end-val start) (/ 1 num-bins)))

(def bin-edges-int
  (seq [i :range [0 (+ num-bins 1)]]
    (math/round (* start (math/pow log-base i)))))

(printf "%j" bin-edges-int)
(print)
