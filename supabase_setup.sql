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

-- Create Policy: Users can view their own expenses
CREATE POLICY "Users can view their own expenses" 
ON expenses 
FOR SELECT 
USING (auth.uid() = user_id);

-- Create Policy: Users can insert their own expenses
CREATE POLICY "Users can insert their own expenses" 
ON expenses 
FOR INSERT 
WITH CHECK (auth.uid() = user_id);

-- Create Policy: Users can delete their own expenses (Optional but good to have)
CREATE POLICY "Users can delete their own expenses" 
ON expenses 
FOR DELETE 
USING (auth.uid() = user_id);
