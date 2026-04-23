# Janet UUID

UUID v4 and v7 generation for Janet.

`jpm install https://github.com/brandonchartier/janet-uuid`

---

```janet
(import uuid)

(uuid/v4) # "b65bd5a4-40c0-4a39-ab9a-8956707d3450"
(uuid/v7) # "019d5153-b23c-751c-ab03-55f6d9dc2523"
(uuid/valid? "b65bd5a4-40c0-4a39-ab9a-8956707d3450") # true
(uuid/version "b65bd5a4-40c0-4a39-ab9a-8956707d3450") # 4
(uuid/nil-uuid) # "00000000-0000-0000-0000-000000000000"
```

## License

GPL-3.0
