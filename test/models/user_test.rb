require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(firstName: 'Daniel', lastName: 'Stelle',
                     email: 'stelle.daniel@oit.edu',
                     password: 'password', password_confirmation: 'password')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.firstName = '         '
    @user.lastName = '           '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '          '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.firstName = 'a' * 51
    @user.lastName = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w(first.last@oit.edu
                         FIRST.LAST@oit.EDU
                         first.last@OIT.edu)

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, '#{valid_address.inspect} should be valid.'
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w(first.last@oit,edu
                           first,last_at_oit.edu
                           first.last@gmail.com
                           firstlast@oit.edu)

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, '#{invalid_address.inspect} should be valid.'
    end
  end

  test 'email adresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?('')
  end

  test 'should become a worker of and no longer be a worker of a supervisor' do
    daniel = users(:daniel)
    archer = users(:archer)
    assert_not daniel.has_worker?(archer)
    daniel.add_worker(archer)
    assert daniel.has_worker?(archer)
    assert archer.has_supervisor?(daniel)
    daniel.remove_worker(archer)
    assert_not daniel.has_worker?(archer)
  end
end
