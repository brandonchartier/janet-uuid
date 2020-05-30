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
