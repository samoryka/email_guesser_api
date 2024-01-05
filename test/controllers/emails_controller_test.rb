require "test_helper"

class EmailsControllerTest < ActionDispatch::IntegrationTest
  test 'returns error for unknown domain' do
    check_error_case('Samory Ka', 'unknowndomain.com', 'samoryka@unknowndomain.com')
  end

  test 'returns email for first_name_last_name format' do
    check_case('Samory Ka', 'babbel.com', 'ska@babbel.com')
  end

  test 'returns email for first_name_initial_last_name format' do
    check_case('Samory Ka', 'google.com', 'samoryka@google.com')
  end

  test 'ignores middle names' do
    check_case('Samory Kabir Jean George Ka', 'babbel.com', 'ska@babbel.com')
  end

  test 'works for sample data' do
    check_case('Jane Doe', 'babbel.com', 'jdoe@babbel.com')
    check_case('Jay Arun', 'linkedin.com', 'jayarun@linkedin.com')
    check_case('David Stein', 'google.com', 'davidstein@google.com')
    check_case('Mat Lee', 'google.com', 'matlee@google.com')
    check_case('Marta Dahl', 'babbel.com', 'mdahl@babbel.com')
    check_case('Vanessa Boom', 'babbel.com', 'vboom@babbel.com')
    check_case('Nina Simons', 'babbel.com', 'nsimons@babbel.com')
    check_case('Priya Kuber', 'linkedin.com', 'priyakuber@linkedin.com')
    check_case('Matthew Hall', 'google.com', 'matthewhall@google.com')
    check_error_case('Robert Miller', 'slideshare.net', 'robertmiller@slideshare.net')
  end

  test 'returns error when domain not known' do

  end

  private

  def check_case(full_name, company_domain, expected_email)
    post '/derive', params: { full_name: full_name, company_domain: company_domain }, as: :json

    response = JSON.parse(@response.body)
    assert_response :success
    assert_equal expected_email, response['email']
    assert_nil response['error']
  end

  def check_error_case(full_name, company_domain, expected_email)
    post '/derive', params: { full_name: full_name, company_domain: company_domain }, as: :json

    response = JSON.parse(@response.body)
    assert_response :bad_request
    assert_nil response['email']
    assert_equal 'unknownDomain', response['error']
  end
end
