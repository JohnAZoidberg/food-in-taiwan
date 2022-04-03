#### TODO
- [x] Allow assigning tags (CNY, ghost-month, celebration, ...)
- [x] After saving edit, redirect to details page (if successful)
- [x] Add menubar
- [ ] Build full database schema
  - [ ] Add picture attribution
  - [x] Add full names
- [x] Add to_zhuyin to https://github.com/mathsaey/hanyutils
- [ ] Make it look nice on mobile
  - [x] Details
  - [ ] List
  - [ ] Edit/Create
- [ ] Add an indicator for which page we're on (actually... better is infinite scrolling. at least on mobile)
- [ ] Validate URLs
- [ ] Add search
- [ ] Make sure back button always works properly (back to previous page)
- [ ] Make items the main page
- [ ] Make sure the delete relationship on item_tags is correct
- [ ] Disallow duplicate tag names
- [ ] Allow associating items. Commonly eaten with, ingredients, ...
- [ ] Switch to tailwind CSS

#### MVP

- [x] Fix saving with no tags
- [ ] Add import from CSV
- [ ] Figure out a way to protect/allow editing
- [ ] Require chinese name

#### Ideas

- Maybe allow uploading pictures?

```json
  {
    "uuid": "",
    "name": {
      "english": null,
      "pinyin": "",
      "mandarin": "",
      "mandarin_translated": "",
      "japanese": null
    },
    "tags": [],
    "type": "dish",
    "description": "",
    "ingredients": [],
    "season": "",
    "temperature": "",
    "commonly_eaten_with": [],
    "pictures": [
      "url": "",
      "attribution": ""
    ],
    "wikipedia_url": ""
  }
```
