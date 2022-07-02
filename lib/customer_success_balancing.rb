class CustomerSuccessBalancing
  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
    @available_customer_success = available_customer_success_sorted_by_score
  end

  # Returns the ID of the customer success with most customers
  def execute
  end
end

