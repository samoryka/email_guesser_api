require "test_helper"

class EmailsControllerTest < ActionDispatch::IntegrationTest
  test 'returns email for default format' do
    post '/derive', params: { full_name: 'Samory Ka', company_domain: 'unkowndomain.com' }, as: :json

    response = JSON.parse(@response.body)
    assert_equal "samoryka@unkowndomain.com", response['email']
  end

  test 'returns email for first_name_last_name format' do
    post '/derive', params: { full_name: 'Samory Ka', company_domain: 'babbel.com' }, as: :json

    response = JSON.parse(@response.body)
    assert_equal "ska@babbel.com", response['email']
  end

  test 'returns email for first_name_initial_last_name format' do
    post '/derive', params: { full_name: 'Samory Ka', company_domain: 'google.com' }, as: :json

    response = JSON.parse(@response.body)
    assert_equal "samoryka@google.com", response['email']
  end

  test 'ignores middle name' do
    post '/derive', params: { full_name: 'Samory Kabir Ka', company_domain: 'unkowndomain.com' }, as: :json

    response = JSON.parse(@response.body)
    assert_equal "samoryka@unkowndomain.com", response['email']
  end
end
