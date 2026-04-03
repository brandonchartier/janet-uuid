# Janet UUID

`jpm install https://github.com/brandonchartier/janet-uuid`

---

```
(import uuid)

(uuid/v4) # "b65bd5a4-40c0-4a39-ab9a-8956707d3450"
(uuid/v7) # "019d5153-b23c-751c-ab03-55f6d9dc2523"
(uuid/valid? "b65bd5a4-40c0-4a39-ab9a-8956707d3450") # true
```
