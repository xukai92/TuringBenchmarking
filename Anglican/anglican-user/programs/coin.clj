(use 'nstools.ns)
(ns+ coin
     (:like anglican-user.program))

(def obs (repeat 500 1))

(defquery coin
  "query tricky coin"
  (let [is-tricky (sample (bernoulli 0.1))
        theta (if is-tricky
                (sample (beta 1 1))
                0.5)]
    (map (fn [x] (observe (bernoulli theta) x)) obs)
    (predict :is-tricky is-tricky)
    (predict :theta theta)))