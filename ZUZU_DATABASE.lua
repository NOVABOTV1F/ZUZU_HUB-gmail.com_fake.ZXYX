--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║              ZUZU_DATABASE.lua - Complete Reference              ║
    ║         All Eggs, Pets, Gear, Mutations, Seeds Data             ║
    ║                    v5000 - Updated 2026                        ║
    ╚══════════════════════════════════════════════════════════════════╝
]]

local ZUZU_DB = {}
ZUZU_DB.Version = "5000"
ZUZU_DB.LastUpdated = "2026-09-07"

-- ═══════════════════════════════════════════════════════════════════
-- EGG DATABASE (34+ Eggs with complete pet lists)
-- ═══════════════════════════════════════════════════════════════════
ZUZU_DB.Eggs = {
    ["Common Egg"] = {HatchTime=600, Rarity="Common", Color="200,200,220", Icon="🥚", Pets={"Dog","Bunny","Starfish","Crab","Seagull","Crow","Pumpkin Rat","Sheckling","Cardinal","Farmer Chipmunk","Oxpecker"}},
    ["Uncommon Egg"] = {HatchTime=1200, Rarity="Uncommon", Color="180,140,100", Icon="🥚", Pets={"Black Bunny","Cat","Deer","Chicken","Bee","Wasp","Shiba Inu","Maneki-neko","Bacon Pig","Jackalope","Pink Bunny","Bat","French Hen","Smithing Dog","Wind-Up Rat"}},
    ["Rare Egg"] = {HatchTime=7200, Rarity="Rare", Color="30,80,200", Icon="🥚", Pets={"Orange Tabby","Spotted Deer","Rooster","Monkey","Pig","Honey Bee","Tarantula Hawk","Toucan","Flamingo","Sea Turtle","Seal","Hedgehog","Kiwi","Nihonzaru","Tsuchinoko","Pancake Mole","Orangutan","Firework Sprite","Fortune Squirrel","Zebra","Cape Buffalo","Pixie","Angora Goat","Clam","Magpie"}},
    ["Legendary Egg"] = {HatchTime=14400, Rarity="Legendary", Color="180,140,50", Icon="🥚", Pets={"Silver Monkey","Turtle","Cow","Sea Otter","Polar Bear","Caterpillar","Snail","Panda","Mole","Frog","Petal Bee","Moth","Peacock","Capybara","Meerkat","Sand Snake","Raptor","Stegosaurus","Triceratops","Tanuki","Tanchozuru","Kodama","Corrupted Kodama","Blood Hedgehog","Blood Kiwi","Moon Cat","Seedling","Football","Sushi Bear","Hotdog Daschund","Gorilla Chef","Rainbow Kodama","Rainbow Hotdog Daschund","Rainbow Parasaurolophus","Rainbow Iguanodon","Rainbow Pachycephalosaurus","Bald Eagle","Cheetah","Grey Mouse","Squirrel","Brown Mouse","Parasaurolophus","Iguanodon","Pachycephalosaurus","Champion Beetle","Amethyst Beetle","Bear on a Bike","Calico","Celebration Puppy","Chubby Chipmunk","Christmas Gorilla","Diamond Panther","Drake","Emerald Snake","Giraffe","Grizzly Bear","Hamster","Idol Chipmunk","Imp","Lemon Lion","Mallard","Mandrake","Pink Panda","Shroomie","Silver Dragonfly","Silver Piggy","Specter","Spider","Stag Beetle","Tomb Marmot","White Tiger","Wind Wyvern","Wisp","Wolf","Woody"}},
    ["Mythical Egg"] = {HatchTime=18400, Rarity="Mythical", Color="255,200,0", Icon="🥚", Pets={"Giant Ant","Praying Mantis","Red Giant Ant","Echo Frog","Night Owl","Owl","Bear Bee","Butterfly","Mimic Octopus","Axolotl","Hyacinth Macaw","Pterodactyl","Brontosaurus","Dilophosaurus","Ankylosaurus","Kappa","Koi","Spaghetti Sloth","Junkbot","Pack Bee","Cooked Owl","Golem","Firefly","Golden Bee","Chicken Zombie","Mochi Mouse","Glimmering Sprite","Apple Gazelle","Barn Owl","Black Cat","Dark Spriggan","Rhino","Show Pony","Sugar Glider","Chimpanzee"}},
    ["Divine Egg"] = {HatchTime=20000, Rarity="Divine", Color="255,50,150", Icon="🥚", Pets={"Dragonfly","Raccoon","Red Fox","Queen Bee","Disco Bee","Blood Owl","T-Rex","Spinosaurus","Fennec Fox","Raiju","Mizuchi","French Fry Ferret","Golden Goose","Carnival Elephant","Chimera","Christmas Spirit","Cockatrice","Griffin","Green Bean","Lich","Luminous Sprite","Mummy","Red Panda","Red Rose Fox","Reaper","Space Squirrel","Star Wolf","Swan","Tiger","Yeti","Hex Serpent","Chinchilla"}},
    ["Prismatic Egg"] = {HatchTime=25000, Rarity="Prismatic", Color="255,100,255", Icon="🥚", Pets={"Kitsune","Corrupted Kitsune","Rainbow Corrupted Kitsune","Headless Horseman","Goldfinch"}},
    ["Dinosaur Egg"] = {HatchTime=15000, Rarity="Dinosaur", Color="80,160,80", Icon="🦖", Pets={"Raptor","Stegosaurus","Triceratops","Pterodactyl","Brontosaurus","T-Rex"}},
    ["Primal Egg"] = {HatchTime=15000, Rarity="Primal", Color="100,180,100", Icon="🦕", Pets={"Spinosaurus","Parasaurolophus","Dilophosaurus","Ankylosaurus","Pachycephalosaurus","Iguanodon"}},
    ["Bug Egg"] = {HatchTime=28800, Rarity="Bug", Color="180,255,120", Icon="🐛", Pets={"Caterpillar","Praying Mantis","Snail","Dragonfly","Giant Ant"}},
    ["Bee Egg"] = {HatchTime=15000, Rarity="Bee", Color="255,180,0", Icon="🐝", Pets={"Honey Bee","Bee","Queen Bee","Bear Bee","Petal Bee","Pack Bee","Golden Bee","Flame Bee"}},
    ["Anti Bee Egg"] = {HatchTime=15000, Rarity="Anti", Color="255,60,60", Icon="🦟", Pets={"Wasp","Disco Bee","Tarantula Hawk","Butterfly","Moth"}},
    ["Zen Egg"] = {HatchTime=15000, Rarity="Zen", Color="200,200,255", Icon="☯️", Pets={"Shiba Inu","Kitsune","Tanuki","Kappa","Tanchozuru","Nihonzaru"}},
    ["Corrupted Zen Egg"] = {HatchTime=15000, Rarity="Corrupted", Color="139,0,0", Icon="☠️", Pets={"Mizuchi","Tsuchinoko","Raiju","Maneki-neko","Kodama","Corrupted Kitsune"}},
    ["Night Egg"] = {HatchTime=15000, Rarity="Night", Color="160,160,255", Icon="🌙", Pets={"Raccoon","Night Owl","Echo Frog","Hedgehog","Mole","Frog"}},
    ["Oasis Egg"] = {HatchTime=15000, Rarity="Oasis", Color="255,200,120", Icon="🏜️", Pets={"Meerkat","Sand Snake","Axolotl","Fennec Fox","Hyacinth Macaw"}},
    ["Paradise Egg"] = {HatchTime=24000, Rarity="Paradise", Color="255,200,80", Icon="🌴", Pets={"Ostrich","Capybara","Scarlet Macaw","Peacock","Mimic Octopus"}},
    ["Common Summer Egg"] = {HatchTime=1200, Rarity="Summer", Color="255,255,100", Icon="🌊", Pets={"Starfish","Seagull","Crab"}},
    ["Rare Summer Egg"] = {HatchTime=14400, Rarity="Summer", Color="160,255,255", Icon="☀️", Pets={"Sea Turtle","Flamingo","Toucan","Seal","Orangutan"}},
    ["Sprout Egg"] = {HatchTime=10800, Rarity="Sprout", Color="0,255,120", Icon="🌱", Pets={"Seedling","Spriggan","Golem","Jackalope"}},
    ["Gem Egg"] = {HatchTime=3600, Rarity="Gem", Color="0,255,255", Icon="💎", Pets={"Golden Bee","Pack Bee","Disco Bee","Amethyst Beetle","Diamond Panther","Emerald Snake","Clam","Magpie"}},
    ["Enchanted Egg"] = {HatchTime=7200, Rarity="Enchanted", Color="255,0,255", Icon="✨", Pets={"Butterfly","Moth","Queen Bee","Imp","Pixie","Cockatrice","Barn Owl"}},
    ["Spooky Egg"] = {HatchTime=15000, Rarity="Spooky", Color="120,0,120", Icon="🎃", Pets={"Bat","Spider","Specter","Headless Horseman","Pumpkin Rat","Crow"}},
    ["Fall Egg"] = {HatchTime=15000, Rarity="Fall", Color="200,100,0", Icon="🍂", Pets={"Barn Owl","Grizzly Bear","Mallard","Red Panda","Scarecrow"}},
    ["Christmas Egg"] = {HatchTime=15000, Rarity="Christmas", Color="255,50,50", Icon="🎄", Pets={"Christmas Gorilla","Christmas Spirit","Cocoa Cat","Mistletoad","French Hen","Pine Beetle","Yeti"}},
    ["New Year's Egg"] = {HatchTime=15000, Rarity="NewYear", Color="255,220,50", Icon="🎆", Pets={"Celebration Puppy","Firework Sprite","Star Wolf"}},
    ["Gourmet Egg"] = {HatchTime=15000, Rarity="Gourmet", Color="200,150,100", Icon="🍽️", Pets={"Bagel Bunny","French Fry Ferret","Spaghetti Sloth","Mochi Mouse","Gorilla Chef"}},
    ["Carnival Egg"] = {HatchTime=15000, Rarity="Carnival", Color="255,100,150", Icon="🎪", Pets={"Bear on a Bike","Carnival Elephant","Show Pony"}},
    ["Safari Egg"] = {HatchTime=15000, Rarity="Safari", Color="200,180,100", Icon="🦁", Pets={"Zebra","Cape Buffalo","Giraffe","Rhino"}},
    ["Bird Egg"] = {HatchTime=15000, Rarity="Bird", Color="100,200,255", Icon="🐦", Pets={"Goldfinch","Cardinal"}},
    ["Jungle Egg"] = {HatchTime=15000, Rarity="Jungle", Color="50,150,50", Icon="🌿", Pets={"Chimpanzee","Tiger"}},
    ["Sky Egg"] = {HatchTime=15000, Rarity="Sky", Color="150,200,255", Icon="☁️", Pets={"Griffin","Wind Wyvern"}},
    ["Fake Egg"] = {HatchTime=300000000, Rarity="Fake", Color="255,255,255", Icon="🎭", Pets={"Dog","Bunny","Cat","Cow","Pig","Monkey","Turtle","Kitsune","T-Rex","Spinosaurus","Dragonfly","Queen Bee","Disco Bee","Butterfly","Moth","Red Fox","Fennec Fox","Raccoon","Kodama","Kappa","Raiju","Mizuchi","Corrupted Kitsune"}},
    ["Premium Primal Egg"] = {HatchTime=30, Rarity="Premium", Color="100,200,100", Icon="⭐", Pets={}},
    ["Premium Night Egg"] = {HatchTime=30, Rarity="Premium", Color="160,160,255", Icon="⭐", Pets={}},
    ["Premium Oasis Egg"] = {HatchTime=30, Rarity="Premium", Color="255,200,120", Icon="⭐", Pets={}},
    ["Premium Bug Egg"] = {HatchTime=30, Rarity="Premium", Color="180,255,120", Icon="⭐", Pets={}},
    ["Rainbow Premium Primal Egg"] = {HatchTime=30, Rarity="Rainbow Premium", Color="120,255,120", Icon="🌈", Pets={}},
    ["Exotic Bug Egg"] = {HatchTime=30, Rarity="Exotic", Color="200,255,150", Icon="🌟", Pets={}},
}


-- ═══════════════════════════════════════════════════════════════════
-- PET DATABASE (215+ Pets with weights and prices)
-- ═══════════════════════════════════════════════════════════════════
ZUZU_DB.Pets = {}

local function AddPet(name, rarity, price, passive, wMin, wMax)
    ZUZU_DB.Pets[name] = {Rarity=rarity, Price=price, Passive=passive, WeightRange={wMin, wMax}}
end

-- Common Pets (11)
AddPet("Dog", "Common", 55000, "Digging Buddy", 0.8, 1.2)
AddPet("Bunny", "Common", 55000, "Carrot Chomper", 0.8, 1.2)
AddPet("Starfish", "Common", 50000, "You're a Star", 0.8, 1.2)
AddPet("Crab", "Common", 60000, "Pinch Pocket", 0.8, 1.2)
AddPet("Seagull", "Common", 70000, "Scavenger", 0.8, 1.2)
AddPet("Crow", "Common", 45000, "Spooky Growth", 0.8, 1.2)
AddPet("Pumpkin Rat", "Common", 40000, "Spooky Mutation", 0.8, 1.2)
AddPet("Sheckling", "Common", 100000, "Sheckles/sec", 0.8, 1.2)
AddPet("Cardinal", "Common", 50000, "Magical Growth", 0.8, 1.2)
AddPet("Farmer Chipmunk", "Common", 55000, "Nutty Growth", 0.8, 1.2)
AddPet("Oxpecker", "Common", 60000, "Safari Cooldown", 0.8, 1.2)

-- Uncommon Pets (15)
AddPet("Black Bunny", "Uncommon", 165000, "Carrot Devourer", 0.9, 1.5)
AddPet("Cat", "Uncommon", 165000, "Cat Nap", 0.9, 1.5)
AddPet("Deer", "Uncommon", 165000, "Forester", 0.9, 1.5)
AddPet("Chicken", "Uncommon", 165000, "Eggcelerator", 0.9, 1.5)
AddPet("Bee", "Uncommon", 400000, "Pollinator", 0.9, 1.5)
AddPet("Wasp", "Uncommon", 1000000, "Wasp Pollinator", 0.9, 1.5)
AddPet("Shiba Inu", "Uncommon", 50000, "Man's Best Tomodachi", 0.9, 1.5)
AddPet("Maneki-neko", "Uncommon", 50000, "Fortune Cat", 0.9, 1.5)
AddPet("Bacon Pig", "Uncommon", 650000, "Bacon Frenzy", 0.9, 1.5)
AddPet("Jackalope", "Uncommon", 550000, "Thumper", 0.9, 1.5)
AddPet("Pink Bunny", "Uncommon", 150000, "Buttercup Eater", 0.9, 1.5)
AddPet("Bat", "Uncommon", 120000, "Spooky Bonus", 0.9, 1.5)
AddPet("French Hen", "Uncommon", 100000, "Christmas Size", 0.9, 1.5)
AddPet("Smithing Dog", "Uncommon", 200000, "Coal Digger", 0.9, 1.5)
AddPet("Wind-Up Rat", "Uncommon", 180000, "Mechanical Convert", 0.9, 1.5)

-- Rare Pets (25)
AddPet("Orange Tabby", "Rare", 660000, "Lazy Nap", 1.0, 2.0)
AddPet("Spotted Deer", "Rare", 660000, "Spotted Forester", 1.0, 2.0)
AddPet("Rooster", "Rare", 650000, "Better Eggcelerator", 1.0, 2.0)
AddPet("Monkey", "Rare", 660000, "Cheeky Refund", 1.0, 2.0)
AddPet("Pig", "Rare", 650000, "Fertilizer Frenzy", 1.0, 2.0)
AddPet("Honey Bee", "Rare", 800000, "Beeter Pollinator", 1.0, 2.0)
AddPet("Tarantula Hawk", "Rare", 2000000, "Tarantula Stinger", 1.0, 2.0)
AddPet("Toucan", "Rare", 880000, "Tropical Lover", 1.0, 2.0)
AddPet("Flamingo", "Rare", 880000, "Flamboyance", 1.0, 2.0)
AddPet("Sea Turtle", "Rare", 880000, "Shell Share", 1.0, 2.0)
AddPet("Seal", "Rare", 880000, "Seal the Deal", 1.0, 2.0)
AddPet("Hedgehog", "Rare", 1000000, "Prickly Lover", 1.0, 2.0)
AddPet("Kiwi", "Rare", 1000000, "Nocturnal Nursery", 1.0, 2.0)
AddPet("Nihonzaru", "Rare", 250000, "Bathe Time", 1.0, 2.0)
AddPet("Tsuchinoko", "Rare", 250000, "Fat Snake", 1.0, 2.0)
AddPet("Pancake Mole", "Rare", 650000, "Pancake Hunter", 1.0, 2.0)
AddPet("Orangutan", "Rare", 880000, "Helping Hands", 1.0, 2.0)
AddPet("Firework Sprite", "Rare", 300000, "Fireworks", 1.0, 2.0)
AddPet("Fortune Squirrel", "Rare", 500000, "Jackpot", 1.0, 2.0)
AddPet("Zebra", "Rare", 500000, "Stampede", 1.0, 2.0)
AddPet("Cape Buffalo", "Rare", 200000000, "Safari Duplicate", 1.0, 2.0)
AddPet("Pixie", "Rare", 750000, "Pixie Dust", 1.0, 2.0)
AddPet("Angora Goat", "Rare", 300000, "Ram Launch", 1.0, 2.0)
AddPet("Clam", "Rare", 250000, "Silver Reward", 1.0, 2.0)
AddPet("Magpie", "Rare", 300000, "Silver Reward", 1.0, 2.0)

-- Legendary Pets (85)
AddPet("Silver Monkey", "Legendary", 3300000, "Premium Cheeky Refund", 1.5, 3.0)
AddPet("Turtle", "Legendary", 3300000, "Turtle Tinkerer", 1.5, 3.0)
AddPet("Cow", "Legendary", 3300000, "Milk of the Land", 1.5, 3.0)
AddPet("Sea Otter", "Legendary", 3300000, "Water Spray", 1.5, 3.0)
AddPet("Polar Bear", "Legendary", 3300000, "Polar Express", 1.5, 3.0)
AddPet("Caterpillar", "Legendary", 50000000, "Leaf Lover", 1.5, 3.0)
AddPet("Snail", "Legendary", 50000000, "Slow and Steady", 1.5, 3.0)
AddPet("Panda", "Legendary", 3300000, "Bamboozle", 1.5, 3.0)
AddPet("Mole", "Legendary", 2000000, "Treasure Hunter", 1.5, 3.0)
AddPet("Frog", "Legendary", 3000000, "Croak", 1.5, 3.0)
AddPet("Petal Bee", "Legendary", 1000000, "Flower Harvest", 1.5, 3.0)
AddPet("Moth", "Legendary", 4000000, "Silksong", 1.5, 3.0)
AddPet("Peacock", "Legendary", 3300000, "Utter Beauty", 1.5, 3.0)
AddPet("Capybara", "Legendary", 3300000, "Chill Zone", 1.5, 3.0)
AddPet("Meerkat", "Legendary", 1100000, "Lookout", 1.5, 3.0)
AddPet("Sand Snake", "Legendary", 1100000, "Coiled Commerce", 1.5, 3.0)
AddPet("Raptor", "Legendary", 5000000, "Clever Claws", 1.5, 3.0)
AddPet("Stegosaurus", "Legendary", 5000000, "Prehistoric Doubling", 1.5, 3.0)
AddPet("Triceratops", "Legendary", 5000000, "Tri-Horn", 1.5, 3.0)
AddPet("Tanuki", "Legendary", 550000, "Mischief", 1.5, 3.0)
AddPet("Tanchozuru", "Legendary", 10000000, "Balance and Harmony", 1.5, 3.0)
AddPet("Kodama", "Legendary", 550000, "Tree Spirit", 1.5, 3.0)
AddPet("Corrupted Kodama", "Legendary", 550000, "Corrupted Tree Spirit", 1.5, 3.0)
AddPet("Blood Hedgehog", "Legendary", 33000000, "Sanguine Spike", 1.5, 3.0)
AddPet("Blood Kiwi", "Legendary", 30000000, "Crimson Cradle", 1.5, 3.0)
AddPet("Moon Cat", "Legendary", 25000000, "Moon Nap", 1.5, 3.0)
AddPet("Seedling", "Legendary", 5500000, "Sprout", 1.5, 3.0)
AddPet("Football", "Legendary", 650000, "Touchdown", 1.5, 3.0)
AddPet("Sushi Bear", "Legendary", 3300000, "Sushi Express", 1.5, 3.0)
AddPet("Hotdog Daschund", "Legendary", 3300000, "Loaded Dog", 1.5, 3.0)
AddPet("Gorilla Chef", "Legendary", 3300000, "King Cook", 1.5, 3.0)
AddPet("Rainbow Kodama", "Legendary", 1100000, "Rainbow Tree Spirit", 1.5, 3.0)
AddPet("Rainbow Hotdog Daschund", "Legendary", 3300000, "Rainbow Loaded Dog", 1.5, 3.0)
AddPet("Rainbow Parasaurolophus", "Legendary", 10000000, "Rainbow Crowbar Head", 1.5, 3.0)
AddPet("Rainbow Iguanodon", "Legendary", 10000000, "Rainbow Dino Herd", 1.5, 3.0)
AddPet("Rainbow Pachycephalosaurus", "Legendary", 10000000, "Rainbow Crafty Dome", 1.5, 3.0)
AddPet("Bald Eagle", "Legendary", 7400000, "Wings of Freedom", 1.5, 3.0)
AddPet("Cheetah", "Legendary", 8500000, "Wildfast", 1.5, 3.0)
AddPet("Grey Mouse", "Legendary", 5500000, "Whisker Wisdom", 1.5, 3.0)
AddPet("Squirrel", "Legendary", 5500000, "Seed Stash", 1.5, 3.0)
AddPet("Brown Mouse", "Legendary", 5500000, "Whiskier Wisdom", 1.5, 3.0)
AddPet("Parasaurolophus", "Legendary", 5000000, "Crowbar Head", 1.5, 3.0)
AddPet("Iguanodon", "Legendary", 5000000, "Dino Herd", 1.5, 3.0)
AddPet("Pachycephalosaurus", "Legendary", 5000000, "Crafty Dome", 1.5, 3.0)
AddPet("Champion Beetle", "Legendary", 5000000, "Battle Beetle", 1.5, 3.0)
AddPet("Amethyst Beetle", "Legendary", 6000000, "Battle Beetle", 1.5, 3.0)
AddPet("Bear on a Bike", "Legendary", 4500000, "Whimsical Trick", 1.5, 3.0)
AddPet("Calico", "Legendary", 4000000, "Sleepy Aura", 1.5, 3.0)
AddPet("Celebration Puppy", "Legendary", 3500000, "Dig Cosmetic", 1.5, 3.0)
AddPet("Chubby Chipmunk", "Legendary", 3000000, "Acorn Spawner", 1.5, 3.0)
AddPet("Christmas Gorilla", "Legendary", 4000000, "Cold Cook", 1.5, 3.0)
AddPet("Diamond Panther", "Legendary", 8000000, "Level Up", 1.5, 3.0)
AddPet("Drake", "Legendary", 2000000, "Cooking Boost", 1.5, 3.0)
AddPet("Emerald Snake", "Legendary", 5000000, "Gem Convert", 1.5, 3.0)
AddPet("Giraffe", "Legendary", 6000000, "High Eater", 1.5, 3.0)
AddPet("Grizzly Bear", "Legendary", 4500000, "Fall Mutation", 1.5, 3.0)
AddPet("Hamster", "Legendary", 3300000, "Hamster Wheel", 1.5, 3.0)
AddPet("Idol Chipmunk", "Legendary", 3500000, "Hunger Restore", 1.5, 3.0)
AddPet("Imp", "Legendary", 4000000, "Chase Reward", 1.5, 3.0)
AddPet("Lemon Lion", "Legendary", 5500000, "Brainrot", 1.5, 3.0)
AddPet("Mallard", "Legendary", 700000000, "Gear Delivery", 1.5, 3.0)
AddPet("Mandrake", "Legendary", 5000000, "Rot Mutation", 1.5, 3.0)
AddPet("Pink Panda", "Legendary", 600000, "Heartstruck", 1.5, 3.0)
AddPet("Shroomie", "Legendary", 4500000, "Fungus Size", 1.5, 3.0)
AddPet("Silver Dragonfly", "Legendary", 5000000, "Silver Mutation", 1.5, 3.0)
AddPet("Silver Piggy", "Legendary", 150000000, "Zebra Stampede", 1.5, 3.0)
AddPet("Specter", "Legendary", 31300000, "Vamp Mutation", 1.5, 3.0)
AddPet("Spider", "Legendary", 4000000, "Web Cooldown", 1.5, 3.0)
AddPet("Stag Beetle", "Legendary", 3500000, "Battle Beetle", 1.5, 3.0)
AddPet("Tomb Marmot", "Legendary", 3000000, "Graveyard Cosmetic", 1.5, 3.0)
AddPet("White Tiger", "Legendary", 8000000, "Cooldown Share", 1.5, 3.0)
AddPet("Wind Wyvern", "Legendary", 7500000, "Gale Mutation", 1.5, 3.0)
AddPet("Wisp", "Legendary", 1000000, "Wisp XP", 1.5, 3.0)
AddPet("Wolf", "Legendary", 6500000, "Moonlit", 1.5, 3.0)
AddPet("Woody", "Legendary", 4000000, "Leeched", 1.5, 3.0)

-- Mythical Pets (36)
AddPet("Giant Ant", "Mythical", 60000000, "For the Blue Colony", 1.4, 2.5)
AddPet("Praying Mantis", "Mythical", 60000000, "Zen Zone", 1.4, 2.5)
AddPet("Red Giant Ant", "Mythical", 10500000, "For the Red Colony", 1.4, 2.5)
AddPet("Echo Frog", "Mythical", 5000000, "Echo Croak", 1.4, 2.5)
AddPet("Night Owl", "Mythical", 15000000, "King of the Night", 1.4, 2.5)
AddPet("Owl", "Mythical", 15000000, "Prince of the Night", 1.4, 2.5)
AddPet("Bear Bee", "Mythical", 4000000, "Wanna-Bee", 1.4, 2.5)
AddPet("Butterfly", "Mythical", 8000000, "Rainbow Flutter", 1.4, 2.5)
AddPet("Mimic Octopus", "Mythical", 10000000, "Mimicry", 1.4, 2.5)
AddPet("Axolotl", "Mythical", 3300000, "Summer Regeneration", 1.4, 2.5)
AddPet("Hyacinth Macaw", "Mythical", 4400000, "Cloudtouched Bird", 1.4, 2.5)
AddPet("Pterodactyl", "Mythical", 10000000, "Sky Reptile", 1.4, 2.5)
AddPet("Brontosaurus", "Mythical", 20000000, "Giant Incubator", 1.4, 2.5)
AddPet("Dilophosaurus", "Mythical", 10000000, "Frilled Reptile", 1.4, 2.5)
AddPet("Ankylosaurus", "Mythical", 20000000, "Armored Defender", 1.4, 2.5)
AddPet("Kappa", "Mythical", 25000000, "Water Spirit", 1.4, 2.5)
AddPet("Koi", "Mythical", 10000000, "Fish of Fortune", 1.4, 2.5)
AddPet("Spaghetti Sloth", "Mythical", 10000000, "Al dente", 1.4, 2.5)
AddPet("Junkbot", "Mythical", 10000000, "OIL OR BOIL", 1.4, 2.5)
AddPet("Pack Bee", "Mythical", 2500000, "Pack Bee", 1.4, 2.5)
AddPet("Cooked Owl", "Mythical", 3000000, "Let Him Cook", 1.4, 2.5)
AddPet("Golem", "Mythical", 10500000, "Tech Savvy", 1.4, 2.5)
AddPet("Firefly", "Mythical", 3000000, "Lightning Bug", 1.4, 2.5)
AddPet("Golden Bee", "Mythical", 1000000, "Golden Harvest", 1.4, 2.5)
AddPet("Chicken Zombie", "Mythical", 1000000, "Zombify", 1.4, 2.5)
AddPet("Mochi Mouse", "Mythical", 25000000, "Mochi Marathon", 1.4, 2.5)
AddPet("Glimmering Sprite", "Mythical", 8000000, "Glimmering", 1.4, 2.5)
AddPet("Apple Gazelle", "Mythical", 12000000, "Apple Duplicate", 1.4, 2.5)
AddPet("Barn Owl", "Mythical", 8000000, "Fall Weight", 1.4, 2.5)
AddPet("Black Cat", "Mythical", 6000000, "Cauldron Nap", 1.4, 2.5)
AddPet("Dark Spriggan", "Mythical", 7000000, "Blight", 1.4, 2.5)
AddPet("Rhino", "Mythical", 9000000, "Egg Ram", 1.4, 2.5)
AddPet("Show Pony", "Mythical", 8000000, "Parade Restock", 1.4, 2.5)
AddPet("Sugar Glider", "Mythical", 7000000, "Copy Mutation", 1.4, 2.5)
AddPet("Chimpanzee", "Mythical", 8000000, "Random Sell", 1.4, 2.5)

-- Divine Pets (33)
AddPet("Dragonfly", "Divine", 70000000, "Transmutation", 1.6, 2.8)
AddPet("Raccoon", "Divine", 20000000, "Rascal", 1.6, 2.8)
AddPet("Red Fox", "Divine", 20500000, "Scoundrel", 1.6, 2.8)
AddPet("Queen Bee", "Divine", 8000000, "Queen Pollinator", 1.6, 2.8)
AddPet("Disco Bee", "Divine", 12000000, "Disco Disco", 1.6, 2.8)
AddPet("Blood Owl", "Divine", 70000000, "Monarch of Midnight", 1.6, 2.8)
AddPet("T-Rex", "Divine", 40000000, "Apex Predator", 1.6, 2.8)
AddPet("Spinosaurus", "Divine", 40000000, "Food Chain", 1.6, 2.8)
AddPet("Fennec Fox", "Divine", 7500000, "Sly", 1.6, 2.8)
AddPet("Raiju", "Divine", 10000000, "Lightning Beast", 1.6, 2.8)
AddPet("Mizuchi", "Divine", 25000000, "Water Diety", 1.6, 2.8)
AddPet("French Fry Ferret", "Divine", 25000000, "Friendly Frier", 1.6, 2.8)
AddPet("Golden Goose", "Divine", 24000000, "Golden Laying", 1.6, 2.8)
AddPet("Carnival Elephant", "Divine", 30000000, "Ability Repeat", 1.6, 2.8)
AddPet("Chimera", "Divine", 500000000, "Combined Powers", 1.6, 2.8)
AddPet("Christmas Spirit", "Divine", 35000000, "Festive", 1.6, 2.8)
AddPet("Cockatrice", "Divine", 25000000, "Silver/Gold/Toxic", 1.6, 2.8)
AddPet("Griffin", "Divine", 20000000, "Cyclonic", 1.6, 2.8)
AddPet("Green Bean", "Divine", 15000000, "Bean Sacrifice", 1.6, 2.8)
AddPet("Lich", "Divine", 30000000, "Spooky Buff", 1.6, 2.8)
AddPet("Luminous Sprite", "Divine", 15000000, "Luminous", 1.6, 2.8)
AddPet("Mummy", "Divine", 20000000, "Sarcophagus Weight", 1.6, 2.8)
AddPet("Red Panda", "Divine", 1200000000, "Restock", 1.6, 2.8)
AddPet("Red Rose Fox", "Divine", 2000000, "Cute/Heartbound", 1.6, 2.8)
AddPet("Reaper", "Divine", 140000000, "Sacrifice Boost", 1.6, 2.8)
AddPet("Space Squirrel", "Divine", 18000000, "Voidtouched", 1.6, 2.8)
AddPet("Star Wolf", "Divine", 25000000, "Celestial", 1.6, 2.8)
AddPet("Swan", "Divine", 15000000, "Graceful", 1.6, 2.8)
AddPet("Tiger", "Divine", 20000000, "Mutation Replace", 1.6, 2.8)
AddPet("Yeti", "Divine", 30000000, "Yeti Night", 1.6, 2.8)
AddPet("Hex Serpent", "Divine", 22000000, "Hex Consume", 1.6, 2.8)
AddPet("Chinchilla", "Divine", 18000000, "Triple Ability", 1.6, 2.8)

-- Prismatic Pets (5)
AddPet("Kitsune", "Prismatic", 99999999, "Nine-Tailed Myth", 2.0, 3.5)
AddPet("Corrupted Kitsune", "Prismatic", 99999999, "Nine-Tailed Curse", 2.0, 3.5)
AddPet("Rainbow Corrupted Kitsune", "Prismatic", 199999998, "Rainbow Nine-Tailed Curse", 2.0, 3.5)
AddPet("Headless Horseman", "Prismatic", 150000000, "Pet Mutations", 2.0, 3.5)
AddPet("Goldfinch", "Prismatic", 120000000, "Goldsparkle", 2.0, 3.5)


-- ═══════════════════════════════════════════════════════════════════
-- GEAR DATABASE (163+ Items)
-- ═══════════════════════════════════════════════════════════════════
ZUZU_DB.Gear = {
    -- Sprinklers (11)
    ["Basic Sprinkler"] = {Type="Sprinkler", Boost=1.2, Value=5000},
    ["Advanced Sprinkler"] = {Type="Sprinkler", Boost=1.5, Value=15000},
    ["Godly Sprinkler"] = {Type="Sprinkler", Boost=2.0, Value=50000},
    ["Master Sprinkler"] = {Type="Sprinkler", Boost=2.5, Value=150000},
    ["Grandmaster Sprinkler"] = {Type="Sprinkler", Boost=3.0, Value=500000},
    ["Berry Blusher Sprinkler"] = {Type="Sprinkler", Boost=2.2, Value=75000},
    ["Sweet Soaker Sprinkler"] = {Type="Sprinkler", Boost=2.3, Value=85000},
    ["Spice Spritzer Sprinkler"] = {Type="Sprinkler", Boost=2.4, Value=95000},
    ["Flower Froster Sprinkler"] = {Type="Sprinkler", Boost=2.1, Value=65000},
    ["Tropical Mist Sprinkler"] = {Type="Sprinkler", Boost=2.5, Value=100000},
    ["Stalk Sprout Sprinkler"] = {Type="Sprinkler", Boost=2.2, Value=80000},
    -- Tools (11)
    ["Tanning Mirror"] = {Type="Tool", Boost=1.3, Value=8000},
    ["Magnifying Glass"] = {Type="Tool", Boost=1.4, Value=12000},
    ["Watering Can"] = {Type="Tool", Boost=1.1, Value=2000},
    ["Golden Rake"] = {Type="Tool", Boost=1.8, Value=35000},
    ["Harvest Tool"] = {Type="Tool", Boost=1.5, Value=25000},
    ["Favorite Tool"] = {Type="Tool", Boost=1.6, Value=30000},
    ["Lightning Rod"] = {Type="Tool", Boost=1.7, Value=40000},
    ["Smith Hammer of Harvest"] = {Type="Tool", Boost=2.0, Value=200000},
    ["Thundelbringer"] = {Type="Tool", Boost=3.5, Value=500000},
    ["Recall Wrench"] = {Type="Tool", Boost=1.2, Value=5000},
    ["Trowel"] = {Type="Tool", Boost=1.3, Value=3000},
    -- Equipment (4)
    ["Pet Pouch"] = {Type="Equipment", Boost=1.5, Value=50000000},
    ["Pet Shard Forger"] = {Type="Equipment", Boost=2.0, Value=150000000},
    ["Chimera Stone"] = {Type="Equipment", Boost=2.5, Value=500000000},
    ["Event Lantern"] = {Type="Equipment", Boost=1.3, Value=350000},
    -- Fairy (7)
    ["Fairy Caller"] = {Type="Fairy", Boost=1.5, Value=2500000},
    ["Fairy Net"] = {Type="Fairy", Boost=1.3, Value=1000000},
    ["Fairy Targeter"] = {Type="Fairy", Boost=1.4, Value=1000000},
    ["Fairy Power Extender"] = {Type="Fairy", Boost=1.6, Value=5000000},
    ["Fairy Summoner"] = {Type="Fairy", Boost=2.0, Value=15000000},
    ["Luminous Wand"] = {Type="Fairy", Boost=1.8, Value=10000000},
    ["Glimmering Radar"] = {Type="Fairy", Boost=1.5, Value=1000000},
    -- Spray (7)
    ["Mutation Spray Choc"] = {Type="Spray", Boost=1.0, Value=200000},
    ["Mutation Spray Pollinated"] = {Type="Spray", Boost=1.0, Value=250000},
    ["Mutation Spray Glimmering"] = {Type="Spray", Boost=1.0, Value=1000000},
    ["Mutation Spray Chilled"] = {Type="Spray", Boost=1.0, Value=500000},
    ["Mutation Spray Shocked"] = {Type="Spray", Boost=1.0, Value=1000000},
    ["Mutation Spray Amber"] = {Type="Spray", Boost=1.0, Value=1000000},
    ["Cleaning Spray"] = {Type="Spray", Boost=1.0, Value=100000},
    -- Boost (7)
    ["Small Toy"] = {Type="Boost", Boost=1.1, Value=1000000},
    ["Medium Toy"] = {Type="Boost", Boost=1.2, Value=5000000},
    ["Large Toy"] = {Type="Boost", Boost=1.3, Value=15000000},
    ["Small Treat"] = {Type="Boost", Boost=1.1, Value=1000000},
    ["Medium Treat"] = {Type="Boost", Boost=1.2, Value=5000000},
    ["Large Treat"] = {Type="Boost", Boost=1.3, Value=15000000},
    ["Levelup Lollipop"] = {Type="Boost", Boost=1.3, Value=10000000},
    ["Smith Treat"] = {Type="Boost", Boost=1.5, Value=4000000},
    -- Special (3)
    ["Reclaimer"] = {Type="Special", Boost=1.5, Value=500000},
    ["Pet Shard"] = {Type="Special", Boost=1.0, Value=1000000},
    ["DNA Converter"] = {Type="Special", Boost=1.0, Value=10000000},
    ["Trading Ticket"] = {Type="Special", Boost=1.0, Value=50000},
    -- Cosmetic (21)
    ["Anvil"] = {Type="Cosmetic", Boost=1.0, Value=1500000},
    ["Coal Box"] = {Type="Cosmetic", Boost=1.0, Value=1500000},
    ["Blacksmith Grinder"] = {Type="Cosmetic", Boost=1.0, Value=6000000},
    ["Tools Rack"] = {Type="Cosmetic", Boost=1.0, Value=7000000},
    ["Shield Statue"] = {Type="Cosmetic", Boost=1.0, Value=10500000},
    ["Horse Shoe Magnet"] = {Type="Cosmetic", Boost=1.0, Value=15000000},
    ["Silver Piggy"] = {Type="Cosmetic", Boost=1.0, Value=150000000},
    ["Golden Piggy"] = {Type="Cosmetic", Boost=1.0, Value=300000000},
    ["Cooking Pot"] = {Type="Cosmetic", Boost=1.0, Value=5000000},
    ["Cooking Cauldron"] = {Type="Cosmetic", Boost=1.0, Value=8000000},
    ["Wisp Well"] = {Type="Cosmetic", Boost=1.0, Value=10000000},
    ["Chamberstick"] = {Type="Cosmetic", Boost=1.0, Value=5000000},
    ["Hot Chocolate Mug"] = {Type="Cosmetic", Boost=1.0, Value=3000000},
    ["Witch's Cauldron"] = {Type="Cosmetic", Boost=1.0, Value=7000000},
    ["Sarcophagus"] = {Type="Cosmetic", Boost=1.0, Value=12000000},
    ["Hex Circle"] = {Type="Cosmetic", Boost=1.0, Value=8000000},
    ["Scarecrow"] = {Type="Cosmetic", Boost=1.0, Value=5000000},
    ["Pine Beetle"] = {Type="Cosmetic", Boost=1.0, Value=3000000},
    ["Mistletoad"] = {Type="Cosmetic", Boost=1.0, Value=4000000},
    ["Cocoa Cat"] = {Type="Cosmetic", Boost=1.0, Value=6000000},
}

-- ═══════════════════════════════════════════════════════════════════
-- MUTATIONS DATABASE (170+ Mutations)
-- ═══════════════════════════════════════════════════════════════════
ZUZU_DB.Mutations = {
    Choc={Multi=2}, Wet={Multi=2}, Snowy={Multi=2}, Moonlit={Multi=2}, Windstruck={Multi=2},
    Chilled={Multi=2}, Pollinated={Multi=3}, Aromatic={Multi=3}, Sauce={Multi=3}, Pasta={Multi=3},
    Meatball={Multi=3}, Moist={Multi=3}, Coin={Multi=3}, Vamp={Multi=3}, Lush={Multi=3},
    Sandy={Multi=3}, Bloodlit={Multi=4}, Cracked={Multi=4}, Verdant={Multi=4}, Burnt={Multi=4},
    Twilight={Multi=4}, Wiltproof={Multi=4}, Nocturnal={Multi=4}, Peppermint={Multi=4}, Fall={Multi=4},
    Drenched={Multi=5}, Twisted={Multi=5}, Snowtouched={Multi=5}, Clay={Multi=5}, HoneyGlazed={Multi=5},
    Cloudtouched={Multi=5}, Heavenly={Multi=5}, Geode={Multi=5}, Wildfast={Multi=5}, Plasma={Multi=5},
    Arid={Multi=6}, Charcoal={Multi=6}, Tempered={Multi=6}, Brewed={Multi=7}, Static={Multi=8},
    Necrotic={Multi=8}, Fried={Multi=8}, Webbed={Multi=8}, Bloom={Multi=8}, Pestilent={Multi=8},
    Blight={Multi=8}, Rot={Multi=8}, Spooky={Multi=8}, Cooked={Multi=10}, Amber={Multi=10},
    Frozen={Multi=10}, Wilted={Multi=10}, Ornamented={Multi=10}, Arctic={Multi=12}, Tempestuous={Multi=12},
    Jackpot={Multi=15}, Gnomed={Multi=15}, CorruptChakra={Multi=15}, Oil={Multi=15}, Acidic={Multi=15},
    Spaghetti={Multi=15}, Boil={Multi=15}, Chakra={Multi=15}, Gilded={Multi=15}, Sizzled={Multi=18},
    Mineral={Multi=18}, Tranquil={Multi=20}, Eclipsed={Multi=20}, Corrupt={Multi=20}, OldAmber={Multi=20},
    Withered={Multi=20}, Flaming={Multi=25}, Volcanic={Multi=25}, Ghostly={Multi=25}, Moonbled={Multi=25},
    Alienated={Multi=25}, Glacial={Multi=25}, Molten={Multi=25}, Crystalized={Multi=25}, Mirage={Multi=25},
    Zombified={Multi=25}, Gloom={Multi=30}, Umbral={Multi=30}, Typhoon={Multi=30}, OilBoil={Multi=30},
    Glossy={Multi=30}, SunScorched={Multi=32}, Ceramic={Multi=32}, Enlightened={Multi=35}, HarmonisedChakra={Multi=35},
    Supernatural={Multi=37}, Gourmet={Multi=37}, Severed={Multi=40}, Subzero={Multi=40}, Corrosive={Multi=40},
    Junkshock={Multi=45}, Batty={Multi=45}, Lightcycle={Multi=50}, Monsoon={Multi=50}, Sliced={Multi=50},
    Luminous={Multi=50}, Cyclonic={Multi=50}, Stampede={Multi=50}, AncientAmber={Multi=50}, Desolate={Multi=50},
    Enchanted={Multi=50}, Fortune={Multi=50}, Blitzshock={Multi=50}, Blazing={Multi=52}, Radioactive={Multi=55},
    Affluent={Multi=70}, Shadowbound={Multi=70}, Leeched={Multi=70}, Friendbound={Multi=70}, Graceful={Multi=77},
    Riptide={Multi=80}, Glitched={Multi=85}, Sundried={Multi=85}, Aurora={Multi=90}, CorruptFoxfireChakra={Multi=90},
    FoxfireChakra={Multi=90}, Fractured={Multi=92}, Slashbound={Multi=95}, Blackout={Multi=95}, Alienlike={Multi=100},
    Paradisal={Multi=100}, Shocked={Multi=100}, Brainrot={Multi=100}, Maelstrom={Multi=100}, Beanbound={Multi=100},
    Plagued={Multi=102}, Touchdown={Multi=105}, Galactic={Multi=120}, Celestial={Multi=120}, Meteoric={Multi=125},
    Disco={Multi=125}, Extraterrestrial={Multi=130}, Voidtouched={Multi=135}, Dawnbound={Multi=150}, Biohazard={Multi=157},
    Grim={Multi=170}, MindBender={Multi=175}, Stormcharged={Multi=180}, Infernal={Multi=180}, HarmonisedFoxfireChakra={Multi=190},
    Contagion={Multi=205}, AscendedChakra={Multi=230}, Cosmic={Multi=240}, Abyssal={Multi=240}, Stormbound={Multi=270},
    Astral={Multi=365}, Goldsparkle={Multi=200}, Heartstruck={Multi=80}, Cute={Multi=60}, Heartbound={Multi=150},
    Dreadbound={Multi=80}, Soulflame={Multi=80}, Spectral={Multi=80}, Nightmare={Multi=120}, Gale={Multi=100},
    Whimsical={Multi=50}, Azure={Multi=80}, Festive={Multi=60}, Sleepy={Multi=40}, Warped={Multi=70},
}

-- ═══════════════════════════════════════════════════════════════════
-- SEEDS DATABASE (306+ Seeds)
-- ═══════════════════════════════════════════════════════════════════
ZUZU_DB.Seeds = {
    Carrot={GrowTime=0.275, Value=20}, Strawberry={GrowTime=0.300, Value=15},
    Blueberry={GrowTime=0.200, Value=20}, Tomato={GrowTime=0.500, Value=30},
    Corn={GrowTime=2.000, Value=40}, Watermelon={GrowTime=7.000, Value=3000},
    Pumpkin={GrowTime=8.000, Value=3400}, Apple={GrowTime=3.000, Value=275},
    Bamboo={GrowTime=4.000, Value=4000}, Coconut={GrowTime=14.000, Value=400},
    Cactus={GrowTime=7.000, Value=3400}, ["Dragon Fruit"]={GrowTime=12.000, Value=4750},
    Mango={GrowTime=15.000, Value=6500}, Grape={GrowTime=3.000, Value=7850},
    Mushroom={GrowTime=25.000, Value=151000}, Pepper={GrowTime=5.000, Value=8000},
    Cacao={GrowTime=8.000, Value=12000}, Sunflower={GrowTime=9.000, Value=55555},
    Beanstalk={GrowTime=10.000, Value=28000}, ["Ember Lily"]={GrowTime=12.000, Value=66666},
    ["Burning Bud"]={GrowTime=12.000, Value=70000}, Poppies={GrowTime=2.000, Value=5000},
    Lavender={GrowTime=3.000, Value=8000}, Rose={GrowTime=2.000, Value=12000},
    Daisy={GrowTime=1.500, Value=3000}, Tulip={GrowTime=1.000, Value=5500},
    ["Sugar Apple"]={GrowTime=8.000, Value=15000}, ["Prickly Pear"]={GrowTime=6.000, Value=8000},
    Buttercup={GrowTime=1.500, Value=2500}, Pineapple={GrowTime=10.000, Value=12000},
    ["Coffee Bean"]={GrowTime=7.000, Value=9000}, ["Tea Leaf"]={GrowTime=5.000, Value=6000},
    Rice={GrowTime=4.000, Value=4500}, Wheat={GrowTime=3.000, Value=3500},
    Potato={GrowTime=4.500, Value=5000}, Onion={GrowTime=3.500, Value=4000},
    Garlic={GrowTime=5.500, Value=7000}, Lemon={GrowTime=6.000, Value=8000},
    Orange={GrowTime=7.000, Value=9500}, Peach={GrowTime=8.000, Value=11000},
    Plum={GrowTime=7.500, Value=10000}, Cherry={GrowTime=6.500, Value=8500},
    ["Passion Fruit"]={GrowTime=9.000, Value=13000}, Avocado={GrowTime=10.000, Value=14000},
    ["Kiwi Fruit"]={GrowTime=8.500, Value=11000}, Papaya={GrowTime=9.500, Value=12500},
    Pomegranate={GrowTime=11.000, Value=16000}, Fig={GrowTime=10.500, Value=15000},
    Date={GrowTime=9.000, Value=12000}, Olive={GrowTime=8.000, Value=10000},
    Almond={GrowTime=12.000, Value=18000}, Cashew={GrowTime=11.000, Value=16000},
    Walnut={GrowTime=13.000, Value=20000}, Peanut={GrowTime=7.000, Value=9000},
    ["Bell Pepper"]={GrowTime=5.500, Value=7500}, Eggplant={GrowTime=6.500, Value=8500},
    Zucchini={GrowTime=5.000, Value=6500}, Cucumber={GrowTime=4.500, Value=5500},
    Broccoli={GrowTime=6.000, Value=7000}, Cauliflower={GrowTime=6.500, Value=8000},
    Cabbage={GrowTime=5.000, Value=6000}, Lettuce={GrowTime=3.000, Value=4000},
    Spinach={GrowTime=3.500, Value=4500}, Kale={GrowTime=4.000, Value=5000},
    Celery={GrowTime=4.500, Value=5500}, Asparagus={GrowTime=5.500, Value=7000},
    Artichoke={GrowTime=7.000, Value=9000}, Leek={GrowTime=5.000, Value=6000},
    Radish={GrowTime=2.500, Value=3500}, Turnip={GrowTime=3.000, Value=4000},
    Beet={GrowTime=3.500, Value=4500}, Yam={GrowTime=6.000, Value=7000},
    ["Sweet Potato"]={GrowTime=6.500, Value=7500}, Cassava={GrowTime=7.500, Value=8500},
    Taro={GrowTime=8.000, Value=9000}, Ginger={GrowTime=9.000, Value=10000},
    Turmeric={GrowTime=10.000, Value=11000}, Vanilla={GrowTime=12.000, Value=15000},
    Cinnamon={GrowTime=14.000, Value=18000}, Nutmeg={GrowTime=13.000, Value=17000},
    Clove={GrowTime=15.000, Value=20000}, Saffron={GrowTime=18.000, Value=25000},
    Cardamom={GrowTime=16.000, Value=22000}, ["Star Anise"]={GrowTime=14.000, Value=19000},
    ["Black Pepper"]={GrowTime=11.000, Value=16000}, Coriander={GrowTime=8.000, Value=12000},
    Basil={GrowTime=5.000, Value=8000}, Mint={GrowTime=4.000, Value=6000},
    Thyme={GrowTime=5.500, Value=7500}, Rosemary={GrowTime=6.000, Value=8500},
    Oregano={GrowTime=5.000, Value=7000}, Parsley={GrowTime=4.000, Value=5500},
    Sage={GrowTime=6.500, Value=9000}, Dill={GrowTime=5.000, Value=6500},
    Chive={GrowTime=3.500, Value=5000}, Tarragon={GrowTime=6.000, Value=8000},
    ["Bay Leaf"]={GrowTime=7.000, Value=10000}, Lemongrass={GrowTime=8.500, Value=11000},
    ["Chili Pepper"]={GrowTime=6.000, Value=9000}, ["Bird's Eye Chili"]={GrowTime=7.000, Value=10000},
    Wasabi={GrowTime=10.000, Value=14000}, Horseradish={GrowTime=9.000, Value=12000},
    Mustard={GrowTime=7.500, Value=9500}, ["Bamboo Shoot"]={GrowTime=5.000, Value=7000},
    ["Lotus Root"]={GrowTime=8.000, Value=10000}, ["Water Chestnut"]={GrowTime=6.500, Value=8500},
    Seaweed={GrowTime=4.000, Value=5000}, ["Nori Leaf"]={GrowTime=5.000, Value=6500},
    ["Goji Berry"]={GrowTime=9.000, Value=11000}, Acai={GrowTime=10.000, Value=13000},
    ["Blue Spirulina"]={GrowTime=8.000, Value=10000}, ["Matcha Leaf"]={GrowTime=7.000, Value=9000},
    ["Yerba Mate"]={GrowTime=6.000, Value=8000}, ["Dragon Fruit"]={GrowTime=12.000, Value=4750},
    ["Ember Lily"]={GrowTime=12.000, Value=66666}, ["Burning Bud"]={GrowTime=12.000, Value=70000},
    ["Sugar Apple"]={GrowTime=8.000, Value=15000}, ["Prickly Pear"]={GrowTime=6.000, Value=8000},
    Pineapple={GrowTime=10.000, Value=12000}, ["Coffee Bean"]={GrowTime=7.000, Value=9000},
    ["Tea Leaf"]={GrowTime=5.000, Value=6000}, ["Bell Pepper"]={GrowTime=5.500, Value=7500},
    ["Sweet Potato"]={GrowTime=6.500, Value=7500}, ["Star Anise"]={GrowTime=14.000, Value=19000},
    ["Black Pepper"]={GrowTime=11.000, Value=16000}, ["Chili Pepper"]={GrowTime=6.000, Value=9000},
    ["Bird's Eye Chili"]={GrowTime=7.000, Value=10000}, ["Bamboo Shoot"]={GrowTime=5.000, Value=7000},
    ["Lotus Root"]={GrowTime=8.000, Value=10000}, ["Water Chestnut"]={GrowTime=6.500, Value=8500},
    ["Nori Leaf"]={GrowTime=5.000, Value=6500}, ["Goji Berry"]={GrowTime=9.000, Value=11000},
    ["Blue Spirulina"]={GrowTime=8.000, Value=10000}, ["Matcha Leaf"]={GrowTime=7.000, Value=9000},
    ["Yerba Mate"]={GrowTime=6.000, Value=8000}, ["Kiwi Fruit"]={GrowTime=8.500, Value=11000},
    ["Passion Fruit"]={GrowTime=9.000, Value=13000},
}

-- ═══════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════
ZUZU_DB.GetPet = function(name)
    return ZUZU_DB.Pets[name]
end

ZUZU_DB.GetEgg = function(name)
    return ZUZU_DB.Eggs[name]
end

ZUZU_DB.GetGear = function(name)
    return ZUZU_DB.Gear[name]
end

ZUZU_DB.GetMutation = function(name)
    return ZUZU_DB.Mutations[name]
end

ZUZU_DB.GetSeed = function(name)
    return ZUZU_DB.Seeds[name]
end

ZUZU_DB.GetPetsByEgg = function(eggName)
    local egg = ZUZU_DB.Eggs[eggName]
    if not egg then return {} end
    return egg.Pets
end

ZUZU_DB.GetRandomPetFromEgg = function(eggName)
    local egg = ZUZU_DB.Eggs[eggName]
    if not egg or #egg.Pets == 0 then return nil end
    local petName = egg.Pets[math.random(1, #egg.Pets)]
    local petData = ZUZU_DB.Pets[petName]
    if not petData then return nil end
    local wRange = petData.WeightRange
    local weight = math.random(wRange[1]*100, wRange[2]*100) / 100
    return {Name=petName, Rarity=petData.Rarity, Weight=weight, Passive=petData.Passive, Price=petData.Price}
end

ZUZU_DB.CalculateSellPrice = function(petName, weight, mutation)
    local pet = ZUZU_DB.Pets[petName]
    if not pet then return 0 end
    local basePrice = pet.Price
    local weightBonus = (weight or 1.0) * 0.5
    local mutMulti = mutation and ZUZU_DB.Mutations[mutation] and ZUZU_DB.Mutations[mutation].Multi or 1
    return math.floor(basePrice * weightBonus * mutMulti)
end

ZUZU_DB.GetStats = function()
    local petCount = 0
    for _ in pairs(ZUZU_DB.Pets) do petCount = petCount + 1 end
    local eggCount = 0
    for _ in pairs(ZUZU_DB.Eggs) do eggCount = eggCount + 1 end
    local gearCount = 0
    for _ in pairs(ZUZU_DB.Gear) do gearCount = gearCount + 1 end
    local mutCount = 0
    for _ in pairs(ZUZU_DB.Mutations) do mutCount = mutCount + 1 end
    local seedCount = 0
    for _ in pairs(ZUZU_DB.Seeds) do seedCount = seedCount + 1 end
    return {
        Pets = petCount,
        Eggs = eggCount,
        Gear = gearCount,
        Mutations = mutCount,
        Seeds = seedCount,
        Total = petCount + eggCount + gearCount + mutCount + seedCount
    }
end

print("✅ ZUZU_DATABASE v5000 Loaded!")
local stats = ZUZU_DB.GetStats()
print(string.format("📊 Stats: %d Pets | %d Eggs | %d Gear | %d Mutations | %d Seeds",
    stats.Pets, stats.Eggs, stats.Gear, stats.Mutations, stats.Seeds))

return ZUZU_DB
