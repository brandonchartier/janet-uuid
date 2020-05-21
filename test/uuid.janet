(import ../uuid)

(def uuid-grammar
  ~{:hex (range "09" "af")
    :hyphen "-"
    :time_low (repeat 8 :hex)
    :time_mid (repeat 4 :hex)
    :time_hi_and_version (* "4" (repeat 3 :hex))
    :clock_seq_hi_and_res (* (set "89ab") (repeat 3 :hex))
    :node (repeat 12 :hex)
    :main (* :time_low
             :hyphen
             :time_mid
             :hyphen
             :time_hi_and_version
             :hyphen
             :clock_seq_hi_and_res
             :hyphen
             :node)})

(def result (peg/match uuid-grammar (uuid/new)))
(assert (not= result nil))
