(use 'nstools.ns)
(ns+ marsaglia
  (:like anglican-user.program))

(defn marsaglia-normal [mean var]
  "returns a sample from Normal(mean, var)"
  (loop [d (uniform-continuous -1.0 1.0)
         x (sample* d)
         y (sample* d)]
    (let [s (+ (* x x ) (* y y))]
      (if (< s 1)
        (+ mean (* (sqrt var)
                   (* x (sqrt (* -2 (/ ( log s) s))))))
        (recur d (sample* d) (sample* d)))
      )))

(with-primitive-procedures [marsaglia-normal]
  (defquery marsaglia
    "query marsaglia"
    (let [rv (repeatedly 500 #(marsaglia-normal 3 1))]
         (predict rv))))

      
    
    
    
  
  
  


