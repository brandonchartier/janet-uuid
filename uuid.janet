(defn- hex-format [x]
  (let [hex (string/format "%x" x)]
    (if (one? (length hex))
      (string "0" hex)
      hex)))

(defn- uuid-format [hex-list]
  (string/format
    "%s%s%s%s-%s%s-%s%s-%s%s-%s%s%s%s%s%s"
    (splice hex-list)))

(defn new []
  (var rand-bytes (os/cryptorand 16))
  (put rand-bytes 6 (bor 0x40 (band 0x0f (get rand-bytes 6))))
  (put rand-bytes 8 (bor 0x80 (band 0x3f (get rand-bytes 8))))
  (-> (map hex-format rand-bytes) uuid-format))
