(import ../uuid)

# v4
(loop [_ :range [0 100]]
  (assert (uuid/valid? (uuid/v4))))

# v4 via legacy alias
(assert (uuid/valid? (uuid/new)))

# v7
(loop [_ :range [0 100]]
  (assert (uuid/valid? (uuid/v7))))

# v7 embeds current timestamp in first 48 bits
(let [before (math/floor (* 1000 (os/clock :realtime)))
      id (uuid/v7)
      after (math/floor (* 1000 (os/clock :realtime)))
      # Extract timestamp from hex: first 8 chars + chars 9-12 (skipping dash)
      ts (scan-number (string "0x" (slice id 0 8) (slice id 9 13)))]
  (assert (>= ts before) "v7 timestamp not before generation")
  (assert (<= ts after) "v7 timestamp not after generation"))

(print "All tests passed.")
