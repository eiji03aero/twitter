RSpec.shared_context 'api' do
  shared_examples 'expects http status code' do |code = 200|
    it "returns http status code #{code}" do
      send_request
      expect(response.status).to eq(code)
    end
  end

  shared_examples 'expects http response with json' do
    it 'responses with JSON' do
      send_request
      expect(response.parsed_body).to include(expected_response)
    end
  end

  shared_examples 'creates record' do |count = 1|
    it 'deletes record' do
      expect { send_request }.to change(model_class, :count).by(count)
    end
  end

  shared_examples 'deletes record' do |count = -1|
    it 'deletes record' do
      expect { send_request }.to change(model_class, :count).by(count)
    end
  end
end
