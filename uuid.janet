(defn- hex-format [x]
  (let [val (string/format "%x" x)]
    (if (one? (length val))
      (string "0" val)
      val)))

(defn- uuid-format [hex-list]
  (string (splice (array/slice hex-list 0 4))
          "-"
          (splice (array/slice hex-list 4 6))
          "-"
          (splice (array/slice hex-list 6 8))
          "-"
          (splice (array/slice hex-list 8 10))
          "-"
          (splice (array/slice hex-list 10 16))))

(defn new []
  (var rand-bytes (os/cryptorand 16))
  (put rand-bytes 6 (bor 0x40 (band 0x0f (get rand-bytes 6))))
  (put rand-bytes 8 (bor 0x80 (band 0x3f (get rand-bytes 8))))
  (uuid-format (map hex-format (string/bytes rand-bytes))))
