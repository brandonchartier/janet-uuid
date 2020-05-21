(defn- hex-format [x]
  (let [hex (string/format "%x" x)]
    (if (one? (length hex))
      (string "0" hex)
      hex)))

(defn- uuid-format [hex-list]
  (string/format
    "%s%s%s%s-%s%s-%s%s-%s%s-%s%s%s%s%s%s"
    (splice hex-list)))

(defn- update-byte [idx f bytes]
  (let [byte (get bytes idx)]
    (put bytes idx (f byte))))

(defn new []
  (->> (os/cryptorand 16)
       (update-byte 6 (fn [x] (bor 0x40 (band 0x0f x))))
       (update-byte 8 (fn [x] (bor 0x80 (band 0x3f x))))
       (map hex-format)
       uuid-format))
