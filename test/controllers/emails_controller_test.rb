require "test_helper"

class EmailsControllerTest < ActionDispatch::IntegrationTest
  test 'returns email for default format' do
    post '/derive', params: { full_name: 'Samory Ka', company_domain: 'unkowndomain.com' }, as: :json

    response = JSON.parse(@response.body)
    assert_equal "samoryka@unkowndomain.com", response['email']
  end

  test 'ignores middle name' do
    post '/derive', params: { full_name: 'Samory Kabir Ka', company_domain: 'unkowndomain.com' }, as: :json

    response = JSON.parse(@response.body)
    assert_equal "samoryka@unkowndomain.com", response['email']
  end
end
