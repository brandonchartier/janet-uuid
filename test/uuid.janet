(import ../uuid)

(def uuid-grammar
  (peg/compile
    ~{:hex-digit (range "09" "af")
      :hex-octet (* :hex-digit :hex-digit)
      :time-low (repeat 4 :hex-octet)
      :time-mid (repeat 2 :hex-octet)
      :time-hi-and-version (* "4" (repeat 3 :hex-digit))
      :clock-seq-hi-and-res (* (set "89ab") :hex-digit)
      :clock-seq-low :hex-octet
      :node (repeat 6 :hex-octet)
      :main (* :time-low
               "-"
               :time-mid
               "-"
               :time-hi-and-version
               "-"
               :clock-seq-hi-and-res
               :clock-seq-low
               "-"
               :node)}))

(loop [_ :range [0 100]]
  (let [result (peg/match uuid-grammar (uuid/new))]
    (assert (not= result nil))))
