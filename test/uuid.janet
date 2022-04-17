(import ../uuid)

(loop [_ :range [0 100]]
  (assert (uuid/valid? (uuid/new))))
