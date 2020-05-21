(import ../uuid)

(def uuid-grammar
  ~{:hex (set "0123456789abcdef")
    :time_low (* :hex :hex :hex :hex :hex :hex :hex :hex)
    :time_mid (* :hex :hex :hex :hex)
    :time_hi_and_version (* "4" :hex :hex :hex)
    :clock_seq_hi_and_res (* (set "89ab") :hex :hex :hex)
    :node (* :hex :hex :hex :hex :hex :hex :hex :hex :hex :hex :hex :hex)
    :main (* :time_low
             "-"
             :time_mid
             "-"
             :time_hi_and_version
             "-"
             :clock_seq_hi_and_res
             "-"
             :node)})

(def result (peg/match uuid-grammar (uuid/new)))
(assert (not= result nil))
