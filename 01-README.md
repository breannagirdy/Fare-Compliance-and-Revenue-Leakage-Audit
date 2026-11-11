# Data Challenge: Fare Compliance and Revenue Leakage Audit
An audit pipeline built for the purpose of detecting fare rule violations, isolating pricing discrepancies segmented by sales channel, and identifying revenue leaks and their impacts.

## 🚀 Executive Summary
In an airline distribution system featuring purchases made through Global Distribution Systems (GDS), Online Travel Agencies (OTA), and Direct Web sales channels, ensuring booking classes are appropriately assigned is essential. Booking classes that are not appropriately assigned can lead to inadvertant discounts on advance-purchase faes. This project utilizes the [Airlines Flights Data](https://www.kaggle.com/datasets/rohitgrewal/airlines-flights-data) dataset via Kaggle to which key fields (such as sales channel, booking class, etc) are added and adjusted dynamically to better perform this career simulation.

Languages such as Python and Pandas are sused to model an audit engine for efficient and automated pipelines. The system ingests a clear dataset consistion of flight and booking records and evaluates Economy and Business fare rules to flag compliance vilations.

## 🛠️ Tech Stack & Libraries

* **Language:** SQL, Python
* **Data Manipulation & Logic:** Pandas, NumPy
* **Data Visualization & Analytics:** Seaborn, Matplotlib, Tableau
* **Outputs:** Augmented, cleaned & auditied datasets (.csv); pricing variance summaries (.csv); Operations, Distribution, & Strategy Report (Tableau)

## 📋 Project Architecture & Workflow

### <ins>Data Augmentation:</ins>
1. **Sales Channel Distribution:** Utilizes the random seed generator to integrate a GDS and OTA sales channels mix.
2. **Booking Class Rules:** Establishes dictionary-based conditions to assign booking classes (F, H, K, M, Q, T) according to various advance purchase thresholds.
3. **Simulated Non-Compliance:** Injects randomized booking class violations to a segment of GDS and OTA purchases.
4. **Fare Standardization:** Provides baseline pricing supplemented by dynamic adjustments acccording to low volume departure times, stops/layovers, economy vs. business class, and flight duration.
5. **Tax/Fees and Market Distribution:** Models market distribution to assign relevent tax/fee thresholds to low/mid/high tier fares.
 
### <ins>SQL Analysis</ins>
1. **Audit Classification:** Utilizes CTEs to assign audit classifications according to expected vs. real pricing desparities. Identifies warnings for Revenue Leaks and Revenue Friction, while accounting for close-in 7-day windows where pricing fluctuation is expected.
2. **Pricing Variation:** Calculated expected vs. actual revenue to quantify leakage amounts per transaction.
### <ins>Python Analysis</ins>
1. **Rule Definition & Mapping:** Initiates dictionary-based rules to map booking classes to associated cabins, advance purchase thresholds, and associated fares.
2. **Variance & Compliance Detection:** Applies logical masks (np.select / boolean indexing) to check channel-specific sales rules against actual booking parameters.
3. **Reporting & Output Generation: ** Exports audit-ready datasets for integration into business intelligence dashboards (Tableau / Power BI).

# 💻 Code Snippet:
<img width="717" height="620" alt="Screenshot 2026-11-07 at 1 03 29 PM" src="https://github.com/user-attachments/assets/a89486f2-0acd-4d04-8e01-edc9d7725f7c" />

# 🔍 Key Business Insights & Outcomes:
See the [Fare Comnpliance and Revenue Leakage Audit](https://public.tableau.com/views/FareComplianceandRevenueLeakageAudit/Operations?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) dashboard on Tableau for Operational, Dstribution, and Strategic reporting!

1. **Operations:** Across 136,809 fares, the audit engine at Vistara Airlines detected a 0.43% booking class error rate, which translates to 1,757 fare disparities or $54,405 in Revenue Risk.
   -  **Suggestion:** Book class discrepancies can occur for a number of reasons, including lead time delays between providing fare rules to GDS systems and the moment said fare rules are implemented system-wide. Allotting time not only for lead time delays but also for a fare rule pre-check in advance of the advance purchase window will allow for the reduction of said delays or the implementation of quick solutions should lead time delays occur. 

2. **Distribution:** Online Travel Agency (OTA, green) sales channels show the most day-to-day volitily while the Direct channel is more consistent. All three channels follow the trend of slightly increasing fares as the day of departure draws nearer. Additionally, there is a direct correlation between booking volumne and pricing disparity with the strongest degree of booking class violations (booking volumne of 2,000+) resulting in pricing disparities of $1,000+.
   -  **Suggestion:** To mitigate the wide disparity between OTA and Direct Web channels, regular audting of OTA fares as well as stricter fare agreements will not only ensure fare compliance but also flag instances where intervention is necessary to mitigate Revenue Loss or Revenue Friction. Options to follow include an automated system to notify OTA partners of said friction and possible penalties if the issue is not swiftly resolved. At the same time, internally, an automated alert system for high-volume flights will allow for regular audits to mitigate corresponding high price disparities, reducing the amount of revenue lost over time.

3. **Strategy:** Booking Class M shows the strongest degree of Revenue at Risk per Origin-Destination segment, with large disparities appearing across both low and high error rate. The audit uncovered a 4.32% error rate along the Bangalore - Chennai route, resulting in $1,670 of revenue at risk for the route. Simulatneously, the audit uncovered only a 0.77% error rate along the Delhi-Mumbi route, which similarly yields $1,625 of revenue at risk.
   -  **Suggestion:** Seeing as both low and high error rates can yield the same amount of revenue loss, applying audit resources based on dollar value rather than % error rate is the best course of action. Further investigation can provide clarity on preferred purchase channels for the Bangalore - Chennai route, which can further yield insights into booking class misalignments. At teh same time, the Delhi - Mumbai route emphasizes the importance of focuses not soley on high-rate routes. Alternatively, honing in on the dollar value of revenue loss can provide insight on where to direct the resources to develop stricter processes for noncompliance detection, as well as remaining proactive for high volume routes.



