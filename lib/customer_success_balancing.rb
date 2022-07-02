class CustomerSuccessBalancing
  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
    @available_customer_success = available_cs_sorted_by_score
  end

  # Returns the ID of the customer success with most customers
  def execute
    cs_sorted = cs_by_customers_count
    return 0 if cs_sorted[0][:customers_count] == cs_sorted[1][:customers_count]

    cs_sorted[0][:id]
  end

  private

  def available_cs_sorted_by_score
    @customer_success.reject { |cs| @away_customer_success.include?(cs[:id]) }.sort { |a, b| b[:score] <=> a[:score] }
  end

  def cs_by_customers_count
    cs_with_customers_count.sort { |a, b| b[:customers_count] <=> a[:customers_count] }
  end

  def cs_with_customers_count
    @available_customer_success.map.with_index do |acs, idx|
      min_score = minimum_cs_score(acs, idx)
      customers_served = @customers.select { |c| c[:score] <= acs[:score] && c[:score] >= min_score }
      { id: acs[:id], customers_count: customers_served.size }
    end    
  end

  def minimum_cs_score(customer_success, index)
    return 0 if customer_success == @available_customer_success.last
    
    @available_customer_success[index + 1][:score]
  end
end

