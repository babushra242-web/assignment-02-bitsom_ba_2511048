// ============================================================
// Part 2 — MongoDB Operations
// ============================================================

// Select database
use("ecommerce_catalog");

// --------------------------------------------------------
// OP1: insertMany() — insert 3 sample documents from input files
// --------------------------------------------------------
db.products.insertMany([
  {
    _id: "prod_elec_001",
    category: "Electronics",
    name: "Smartwatch",
    brand: "Generic",
    model_number: "SW-58851",
    price: 58851.01,
    currency: "INR",
    in_stock: true,
    stock_qty: 25,
    specifications: {
      type: "Wearable",
      connectivity: ["Bluetooth", "WiFi"],
      voltage: "DC 5V",
      warranty_years: 1
    },
    ratings: { average: 4.3, count: 120 },
    created_at: new Date("2023-08-09T10:00:00Z")
  },
  {
    _id: "prod_clth_001",
    category: "Clothing",
    name: "Jeans",
    brand: "DenimCo",
    sku: "JEANS-2317",
    price: 2317.47,
    currency: "INR",
    in_stock: true,
    stock_qty: 150,
    attributes: {
      gender: "Unisex",
      fabric: "Denim",
      sizes: ["28", "30", "32", "34", "36"],
      care_instructions: ["Machine Wash", "Do Not Bleach"]
    },
    ratings: { average: 4.0, count: 540 },
    created_at: new Date("2023-10-26T08:30:00Z")
  },
  {
    _id: "prod_groc_001",
    category: "Groceries",
    name: "Atta 10kg",
    brand: "Aashirvaad",
    barcode: "8901030861207",
    price: 52464.0,
    currency: "INR",
    in_stock: true,
    stock_qty: 80,
    packaging: {
      weight_kg: 10,
      type: "Sealed Bag",
      recyclable: true
    },
    shelf_life: {
      manufactured_date: "2023-07-01",
      expiry_date: "2024-12-15",
      shelf_life_months: 18
    },
    nutritional_info_per_100g: {
      energy_kcal: 340,
      protein_g: 12,
      carbohydrates_g: 70,
      fibre_g: 10,
      fat_g: 2
    },
    allergens: ["Wheat", "Gluten"],
    ratings: { average: 4.5, count: 2200 },
    created_at: new Date("2023-07-22T06:00:00Z")
  }
]);

// --------------------------------------------------------
// OP2: find() — retrieve all Electronics products with price > 20000
// --------------------------------------------------------
db.products.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  },
  {
    _id: 1,
    name: 1,
    price: 1,
    "specifications.warranty_years": 1
  }
);

// --------------------------------------------------------
// OP3: find() — retrieve all Groceries expiring before 2025-01-01
// --------------------------------------------------------
db.products.find(
  {
    category: "Groceries",
    "shelf_life.expiry_date": { $lt: "2025-01-01" }
  },
  {
    _id: 1,
    name: 1,
    brand: 1,
    "shelf_life.expiry_date": 1,
    price: 1
  }
);

// --------------------------------------------------------
// OP4: updateOne() — add a "discount_percent" field to a specific product
// Adds 10% discount to Jeans (prod_clth_001)
// --------------------------------------------------------
db.products.updateOne(
  { _id: "prod_clth_001" },
  {
    $set: {
      discount_percent: 10,
      discounted_price: 2085.72,
      discount_valid_until: "2025-03-31"
    }
  }
);

// --------------------------------------------------------
// OP5: createIndex() — create an index on category field
// WHY: Category filters (Electronics, Clothing, Groceries) are the most common query pattern in a catalog. Without an index, 
// MongoDB scans the whole collection. With an index, queries become much faster.
// --------------------------------------------------------
db.products.createIndex(
  { category: 1 },
  {
    name: "idx_category",
    background: true,
    comment: "Speeds up category-based queries"
  }
);

// Verify the index
db.products.getIndexes();
