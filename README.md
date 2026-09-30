# End-to-End Sales Analytics Project (SQL + Python + Power BI)

## 📌 Project Overview
This project delivers a comprehensive, enterprise-level sales analytics solution by integrating **SQL, Python, and Power BI**. The entire pipeline covers data ingestion, data manipulation, advanced analytics, and executive reporting. Raw sales records are managed via SQL database queries, cleaned and analyzed using Python, and transformed into a premium, interactive **Dark-Themed Power BI Dashboard** to enable data-driven business decisions.

---

## 🛠️ Tech Stack & Tools Used
* **Database Management & Querying:** SQL (Data Extraction, Aggregations, Joins)
* **Data Engineering & EDA:** Python (Pandas, NumPy, Matplotlib, Seaborn)
* **Business Intelligence & Visualization:** Power BI Desktop

---

## 📊 Core Business KPIs Tracked
The dashboard utilizes strategic Key Performance Indicators (KPIs) designed with high visual contrast for maximum readability on a dark canvas:
1. **Total Revenue:** Aggregated financial sales volume (`SUM` of revenue).
2. **Total Profit Margin:** Net profitability metrics extracted across segments (`SUM` of margin).
3. **Total Quantity Sold:** Aggregate product volume tracking (`SUM` of quantity).
4. **Unique Customer Count:** Total market footprint using distinct customer evaluation (`COUNT DISTINCT`).

---

## ⚙️ Data Pipeline & Workflow

### Phase 1: SQL Database Management & Ingestion
* Structured and imported raw sales records into relational database tables.
* Executed SQL queries using `SUM`, `AVG`, `COUNT`, and group-by clauses to audit baseline transactional summaries.
* Optimized data retrieval structures to prepare datasets for advanced statistical applications.

### Phase 2: Python Data Engineering & EDA
* Connected directly to data sources to handle missing data segments, format anomalies, and duplicates.
* Conducted Exploratory Data Analysis (EDA) using Pandas to map out purchase behavior and revenue trends.
* Exported the final verified dataset (`sales_clean.csv`) to serve as the unified source of truth.

### Phase 3: Power BI Executive Dashboard Architecture
* Designed a custom dark purple/navy-mix user interface to reduce visual strain and highlight performance.
* Re-engineered default visual frameworks by applying transparent card effects, custom neon/pastel data bars, and light-gray typography.
* Integrated cross-filtering slicers allowing executives to dynamically slice metrics by timeframes, categories, and customer profiles.

---

## 🚀 How to Utilize this Repository
1. **SQL Scripts:** Review the `.sql` files to see the database schema and analytical queries used.
2. **Python Pipeline:** Open the Jupyter Notebook (`.ipynb`) to inspect data cleansing steps and statistical charts.
3. **Power BI Dashboard:** Download the `.pbix` file to interact with the executive-level analytics interface.
