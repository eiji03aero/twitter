RSpec.shared_context 'command' do
  shared_examples 'command call successes' do
    it 'expects command call to success' do
      command = command_call
      expect(command.success?).to be true
      expect(command.errors.size).to eq 0
    end
  end

  shared_examples 'command call fails' do
    it 'expects command call to fail' do
      command = command_call
      expect(command.success?).to be false
      expect(command.errors.size).to be > 0
    end
  end
end
