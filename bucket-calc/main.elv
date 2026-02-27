use math
use str

var log-base = (math:pow 100000.0 (/ 1.0 20))

var edges = [(range 21 | each {|i|
    put (to-string (exact-num (math:round (math:pow $log-base (exact-num $i)))))
})]

echo (put $@edges | str:join ", ")
