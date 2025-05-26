# 1. What is PostgreSQL?

postgreSQL একটি ওপেন সোর্স রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম।

ফীচার সমূহ :

১। এটি লার্জ ডাটাসেট এর ক্ষেত্রে কমপ্লেক্স কোয়েরি ব্যবহার করার মাধ্যমে হাই পারফরমেন্স নিশ্চিত করে।  
২। ক্রস প্লাটফর্ম সাপোর্ট করে। যেমন উইন্ডোস , লিনাক্স , ম্যাক অপারেটিং সিস্টেম।

# 2. What is the purpose of a database schema in PostgreSQL?

ডিফল্ট ভাবে postgreSQL একটি public schema তৈরি করে।

১। এটি সকল অব্জেক্টস যেমন টেবিল, ভিউ, ফাঙ্কশন ইত্যাদি সংরক্ষণ ও সংগঠিত করে রাখে। ডাটা এফিসিয়েন্টলি ম্যানেজ করতে স্কিমা দরকার হয়।
২। রিলেটেড টেবিল এবং ফাঙ্কশন গ্রুপ আকারে সাজায়ে রাখতে স্কিমা প্রয়োজন।
৩। স্কিমা লেভেল এ পারমিশন সেট করার মাধ্যমে নির্দিষ্ট ব্যবহারকারীদের জন্য অ্যাক্সেস সীমাবদ্ধ করা যায়।
৪। একাধিক ক্লায়েন্ট বা অ্যাপ্লিকেশনের জন্য ডেটা আলাদা করতে বিভিন্ন স্কিমা ব্যবহার করা যেতে পারে।

# 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key:

প্রাইমারি key টেবিল এর একটি কলাম অথবা এক এর অধিক কলাম যেটি বা যারা ওই টেবিল এর প্রতিটি row কে ইউনিক ভাবে ইডেন্টিফাই করে। এটি null value হতে পারবে না এবং ডুপ্লিকেট value হতে পারবে না।

example:

```sql
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    department VARCHAR(50)
);
```

এখানে emplpoyee_id একটি প্রাইমারি key.

Foreign Key:

Foreign key টেবিল এর একটি কলাম অথবা এক এর অধিক কলাম যেটি বা যারা দুইটা টেবিল এর মধ্যে সম্পর্ক তৈরী করে। এটি মূলত অন্য টেবিল এর primary key রেফারেন্স করে।

example:

```sql
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES departments(department_id),
);

```

এখানে employees টেবিল এর department_id একটি ফরেন key যেটি departments table এর সাথে একটি সম্পর্ক তৈরী করে।

# 4. What is the difference between the VARCHAR and CHAR data types?

VARCHAR and CHAR উভয়ই character string এর জন্য ব্যবহার করা হয় কিন্তু এদের মধ্যে কিছু পার্থক্য আছে। VARCHAR variable-length string এর জন্য অন্যদিকে CHAR ফিক্সড-লেংথ স্ট্রিং এর জন্য ব্যবহার করা হয়।

VARCHAR Example:

```sql
CREATE TABLE users (
    username VARCHAR(50) -- Can store up to 50 characters, but only uses space for actual length
);
```

CHAR Example:

```sql
CREATE TABLE countries (
    country_code CHAR(2) -- Always stores exactly 2 characters, even if the value is shorter
);
```

# 5. What are the LIMIT and OFFSET clauses used for?

LIMIT and OFFSET clauses সাধারণত pagination এর জন্য ব্যবহার করা হয়। তাছাড়া Query কয়টা row রিটার্ন করবে সেটি নিয়ন্ত্রণ করে LIMIT Clause.

example:

```sql
SELECT * FROM employees
LIMIT 10 OFFSET 20;
```

এই query ২১ তম রেকর্ড থেকে শুরু করে ১০ টি row রিটার্ন করে।
