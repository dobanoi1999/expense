CREATE TYPE budget_period AS ENUM ('weekly', 'monthly', 'quarterly', 'yearly', 'custom');

CREATE TABLE budgets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  amount NUMERIC(18,2) NOT NULL,
  period budget_period NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NULL,
  alert_threshold SMALLINT DEFAULT 80,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE budget_categories (
  budget_id UUID NOT NULL REFERENCES budgets(id) ON DELETE CASCADE,
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  PRIMARY KEY (budget_id, category_id)
);
