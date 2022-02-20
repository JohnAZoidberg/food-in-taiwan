# Food in Taiwan

Development:

```sh
docker run --detach --rm \
  --name postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=postgres \
  -v $PWD/postgres-data:/var/lib/postgresql/data \
  postgres:13
mix ecto.migrate
mix phx.server

# Stop postgres container after you're done
docker stop postgres
```

## Use-cases

Basic:

- Find dish by ingredients
- Find dish, ingredient, ... by name
- Show details about dish, ingredient
- Enter new dish/ingredient with all information and links to other items (e.g. is part of dish, commonly eaten with, ...)

- Track what you've eaten and what you haven't
  - Maybe rate them or set favorites
  - See what to try next

## Notes
Tags:
- Dumplings
- Breakfast
- Snack
- Dessert
- Tea
- Drink
- Meat
- Fish
- "Tofu"
- Seafood
- Chinese Origin
- Hakka Origin
- Regional
  - Taiwan/China (Taipei, Tainan, Sichuan, ...)
  - East Asia (Japanese, Korean, ...)
  - Rest Asia (Thai, Vietnamese, ...)
  - Rest of the world (...)

Food adjectives
- xian fresh
- xian salty
- suan sour
- la spicy
- tian sweet
- gan dry
- re hot
- cold
- ku bitter
- wu without
- jia add
- qq chewy

Attributes:
- English Name
- Mandarin Name
- Meaning of the Mandarin Name
- (Japanese Name)
- (Taiwanese Name)
- (Hakka Name)
- Description
- Ingredients
- Commonly eaten with
- Season
- Temperature
- Dish or Ingredient
- Link to wikipedia, recipes, videos
- I have eaten?
- Checked by Taiwanese person

- List of dishes
- List of ingredients

- 水果 Fruits
- 米甜圈  Sweet Rice Donut
- Tiandian Dessert
- NianGao
- Mocha
- Mochi
- Green Tea
- Oolong Tea
- Mantou
- RouSong
- Bubble Milk Tea
- Peanut Soup
- Congee
- ShuiJianBao
  - zhu Pork
  - gaolicai cabbage
  - ?
- Pork
  - Different cuts
- Fish
- KuGua
- FengLi Pineapple
- Orange
- Khaki/Persimmon
- 鍋貼 GuoTie Pot Stickers
- ChaoFan Fried Rice
- white rice
- mifan rice
- mala
- 火鍋 hotpot
- Shrimp
- huntun wonton (shou)
- hefenmian
- Buddha jumps over wall (?)
- Vinegar
- jiangyougao Thick soy sauce
- dachangbaoxiaochang
- Oyster omelette
- 鹹酸菜 pickled cabbage
- Meat ball
- Fish ball
- Frozen toufu
- Broccoli
- Cucumber
- Bibimbap
- 豆花 DouHua
- Grass Jelly
- shuijiao 水餃
- Stinky Toufu
- Soymilk
- Salty Soymilk
- 牛肉麵 Beef Noodles
- 蚵仔麵線 Oyster Vermicelli
- 蔥油餅 Green Onion Pancake
- 三杯雞 Three Cup Chicken
- 飯糰 Fan Tuan
- 鳳梨酥 Pineapple cake
- 高粱 gaoliang
- Iron egg
- TianBuLa
- DiGua Sweet Potato
- ShaoBing
- YouTiao
- KouShuiJi
- 熱炒 rechao
