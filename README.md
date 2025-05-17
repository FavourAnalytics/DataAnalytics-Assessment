# Data Analytics Assessment

## Question 1: High-Value Customers with Multiple Products
**Approach:**  
Joined users, plans, and savings tables. Used conditional counting to identify savings and investment plans per user. Summed deposits converted from kobo.

**Challenges:**  
Handled ambiguous column names by using table aliases. Converted amounts from kobo to base currency by dividing by 100.

---

## Question 2: Transaction Frequency Analysis
**Approach:**  
Calculated total transactions per customer per month, then categorized customers based on transaction frequency ranges.

**Challenges:**  
Needed to handle zero transactions and date differences correctly.

---

## Question 3: Account Inactivity Alert
**Approach:**  
Checked for active plans with no transaction inflow in the last 365 days by comparing last transaction date with current date.

**Challenges:**  
Correctly identified last transaction dates per plan across savings and investment accounts.

---

## Question 4: Customer Lifetime Value Estimation
**Approach:**  
Calculated tenure in months from signup date, total transactions, then used simplified CLV formula based on profit per transaction.

**Challenges:**  
Handled NULL or zero tenure values to avoid division errors. Converted amounts correctly.

---
