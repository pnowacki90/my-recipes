require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Piotr Nowacki", email: "ogur0007@interia.pl")
  end
  
  test 'should be valid' do
    assert @chef.valid?
  end
  
  test 'chefname should be present' do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  
  test 'name should be < 30 characters' do
    @chef.chefname = "b" * 31
    assert_not @chef.valid?
  end
  
  test 'email should be present' do
    @chef.email = ""
    assert_not @chef.valid?
  end
  
  test 'email should have < 255 characters' do
    @chef.email = "a" * 256
    assert_not @chef.valid?
  end
  
  test 'email should have correct format' do
    valid_emails = %w[user@example.com PIOTR@GMAIL.COM M.FIRST@YAHOO.CA john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test 'should reject invalid addresses' do
    invalid_emails = %w[piotr@examples piotr@wp,pl 1@wp.pl]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test 'email should be unique and case insensitive' do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
end