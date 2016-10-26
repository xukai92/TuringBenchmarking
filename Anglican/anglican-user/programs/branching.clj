(use 'nstools.ns)
(ns+ branching
  (:like anglican-user.program))

(defn fib [n]  
  "returns the n-th number in the Fibonacci sequence"  
  (loop [a 0 b 1 m 0]    
    (if (= m n)      
      a      
      (recur b (+ a b) (inc m)))))

(def dist (categorical {1 0.1, 2 0.1, 3 0.1, 4 0.1, 5 0.1, 6 0.1, 7 0.1, 8 0.1, 9 0.1, 10 0.1}))
(def obs (repeatedly 500 #(sample* dist)))

(with-primitive-procedures [fib]  
  (defquery branching
    "A simple example illustrating flow control with     
    dependence on random choices"      
    []
    (let [count-prior (poisson 4)            
          r (sample count-prior)            
          l (if (< 4 r)                
              6                
              (+ (fib (* 3 r))                   
                 (sample count-prior)))]
      (map (fn [x] (observe (poisson l) x)) obs)
      (predict :l l))))
