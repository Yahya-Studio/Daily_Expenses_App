# 💰 تطبيق المصاريف اليومية | Daily Expenses App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Backend-Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**تطبيق حديث وعملي لتتبع المصاريف اليومية وإدارة الميزانية الشخصية، مدعوم بقاعدة بيانات Supabase السحابية مع نظام مصادقة آمن وسياسات RLS.**

*A clean, cross-platform personal expense tracker built with Flutter and Supabase. Keep track of daily spending with secure user authentication and PostgreSQL Row Level Security (RLS).*

[المميزات](#-المميزات-الرئيسية--key-features) •
[التقنيات المستخدمة](#-التقنيات-المستخدمة--tech-stack) •
[طريقة التثبيت والتشغيل](#-طريقة-التثبيت-والتشغيل--getting-started) •
[إعداد قاعدة بيانات Supabase](#-إعداد-قاعدة-بيانات-supabase--supabase-setup) •
[هيكلية المشروع](#-هيكلية-المشروع--project-structure) •
[الأمان والخصوصية](#-الأمان-والخصوصية--security--privacy)

</div>

---

## 🌟 المميزات الرئيسية | Key Features

- 🔐 **نظام مصادقة كامل (Authentication):** تسجيل الدخول وإنشاء حساب جديد للمستخدمين وحفظ الجلسة تلقائياً عبر Supabase Auth.
- 💵 **إدارة المصاريف (Expense Management):**
  * إضافة مصروف جديد بتحديد العنوان، المبلغ، والتاريخ عبر منتقي التاريخ (Date Picker).
  * استعراض قائمة المصاريف اليومية مرتبة زمنياً.
  * حذف المصاريف بسهولة.
- 🛡️ **خصوصية وأمان البيانات (Row Level Security):** كل مستخدم يصل فقط إلى مصاريفه الخاصة، ولا يمكن لأي مستخدم آخر رؤيتها أو التعديل عليها.
- 🎨 **واجهة عصرية (Material Design 3):** تصميم أنيق وبسيط يعتمد على درجات اللون التركوازي (Teal) مع حقول إدخال واضحة ورسائل تفاعلية.
- 📱 **متعدد المنصات (Cross-Platform):** يعمل على Android و iOS والويب وسطح المكتب بكود موحد.

---

## 🛠 التقنيات المستخدمة | Tech Stack

| المجال | التقنية | الوصف |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) | بناء واجهات التطبيق متعددة المنصات |
| **Language** | [Dart](https://dart.dev/) | لغة البرمجة الأساسية في التطبيق |
| **Backend & Database** | [Supabase](https://supabase.com/) | المصادقة (Auth)، قاعدة بيانات PostgreSQL السحابية، وواجهة API |
| **Security** | PostgreSQL RLS | سياسات أمان مستوى الصف لضمان عزل بيانات كل مستخدم |

---

## 🚀 طريقة التثبيت والتشغيل | Getting Started

### 📋 المتطلبات المسبقة (Prerequisites)
* تثبيت **Flutter SDK** (الإصدار `3.10.0` أو أحدث).
* تثبيت **Git**.
* حساب على [Supabase](https://supabase.com).

### 📥 خطوات التثبيت (Installation Steps)

1. **استنساخ المستودع (Clone):**
   ```bash
   git clone https://github.com/Yahya-Studio/Daily_Expenses_App.git
   cd Daily_Expenses_App
   ```

2. **تثبيت الحزم (Install Dependencies):**
   ```bash
   flutter pub get
   ```

3. **إعداد متغيرات البيئة (Environment Configuration):**
   * انسخ ملف النموذج `.env.example` إلى `.env`:
     ```bash
     cp .env.example .env
     ```
   * ضع رابط مشروعك ومفتاح `anon` الخاص بـ Supabase داخل الملف.

4. **تشغيل التطبيق (Run Application):**
   يمكنك تمرير المفاتيح عبر `--dart-define` لضمان عدم وجود أي مفاتيح سرية في الكود المصدري:
   ```bash
   flutter run --dart-define=SUPABASE_URL=https://your-project.supabase.co --dart-define=SUPABASE_ANON_KEY=your-anon-key
   ```

---

## 🗄 إعداد قاعدة بيانات Supabase | Supabase Setup

لتهيئة قاعدة البيانات في مشروع Supabase الخاص بك:

### 1. استخراج المفاتيح
1. توجه إلى [لوحة تحكم Supabase](https://supabase.com/dashboard) وأنشئ مشروعاً جديداً.
2. ادخل إلى **Project Settings** > **API**.
3. انسخ **Project URL** و **anon public key**.

### 2. تنفيذ استعلام الجداول وسياسات الأمان
1. من القائمة الجانبية في Supabase، اختر **SQL Editor**.
2. انسخ محتوى الملف المرفق في المشروع: [`supabase_setup.sql`](file:///home/solan/Documents/antigravity/hopeful-chandrasekhar/Daily_Expenses_App/supabase_setup.sql).
3. الصق الاستعلام واضغط **Run**.

```sql
-- Create the expenses table
CREATE TABLE expenses (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  title TEXT NOT NULL,
  amount NUMERIC NOT NULL,
  expense_date DATE NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable Row Level Security (RLS)
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;

-- Create Policies
CREATE POLICY "Users can view their own expenses" 
ON expenses FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own expenses" 
ON expenses FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own expenses" 
ON expenses FOR DELETE USING (auth.uid() = user_id);
```

---

## 📁 هيكلية المشروع | Project Structure

```text
Daily_Expenses_App/
├── lib/
│   ├── main.dart                 # نقطة البداية، تهيئة Supabase، وتوجيه المسارات
│   ├── models/
│   │   └── expense.dart          # نموذج المصروف والتحويل من وإلى JSON
│   └── screens/
│       ├── login_screen.dart     # شاشة تسجيل الدخول
│       ├── register_screen.dart  # شاشة إنشاء حساب جديد
│       ├── expenses_screen.dart  # استعراض المصاريف وإمكانية حذفها
│       └── add_expense_screen.dart # شاشة إضافة مصروف مع اختيار التاريخ
├── supabase_setup.sql            # استعلام SQL لبناء الجدول وسياسات الأمان RLS
├── .env.example                  # نموذج متغيرات البيئة
├── .gitignore                    # الملفات المستثناة من التتبع وحماية الأسرار
└── pubspec.yaml                  # تبعيات وإعدادات التطبيق
```

---

## 🔐 الأمان والخصوصية | Security & Privacy

* **فصل بيانات الاعتماد:** تم استخراج مفاتيح Supabase من الكود واستبدالها بمتغيرات بيئة قياسية تقرأ عبر `String.fromEnvironment`.
* **عزل البيانات:** استخدام تقنية Row Level Security (RLS) يضمن استحالة وصول أي مستخدم لبيانات مصاريف مستخدم آخر حتى على مستوى استعلامات قاعدة البيانات المباشرة.
* **حماية المستودع:** ملف `.gitignore` محصّن لمنع رفع ملفات `.env` أو مفاتيح التوقيع والشهادات الخاصة.

---

## 🤝 المساهمة | Contributing

نرحب بمساهماتكم لتطوير التطبيق!
1. قم بعمل **Fork** للمستودع.
2. أنشئ فرعاً لميزتك (`git checkout -b feature/NewFeature`).
3. سجّل التعديلات (`git commit -m 'Add NewFeature'`).
4. ارفع الفرع (`git push origin feature/NewFeature`).
5. افتح **Pull Request**.

---

## 📄 الترخيص | License

هذا المشروع متاح تحت رخصة **MIT**. راجع ملف `LICENSE` للمزيد من التفاصيل.

---

<div align="center">

صُنع بـ ❤️ بواسطة **[Yahya-Studio](https://github.com/Yahya-Studio)**

</div>
