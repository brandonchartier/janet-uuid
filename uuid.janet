(def- uuid-grammar
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

(defn- update-byte [idx f bytes]
  (let [byte (get bytes idx)]
    (put bytes idx (f byte))))

(defn- hex-format [byte]
  (let [hex (string/format "%x" byte)]
    (if (one? (length hex))
      (string "0" hex)
      hex)))

(defn- uuid-format [hex-list]
  (string/format
    "%s%s%s%s-%s%s-%s%s-%s%s-%s%s%s%s%s%s"
    (splice hex-list)))

(defn new []
  (->> (os/cryptorand 16)
       (update-byte 6 (fn [b] (bor 0x40 (band 0x0f b))))
       (update-byte 8 (fn [b] (bor 0x80 (band 0x3f b))))
       (map hex-format)
       uuid-format))

(defn valid? [str]
  (let [result (peg/match uuid-grammar str)]
    (not= result nil)))
