# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::CommandRunner do
  let(:perform) { subject.execute(line) }

  describe '#execute' do
    context 'when line is a valid command' do
      let(:line) { 'A 1 2 3' }
      let(:command_instace) { double(BitmapEditor::ClearImageCommand) }
      let(:image) { BitmapEditor::Image.new(5, 5) }

      before do
        expect(command_instace).to receive(:parse).and_return(success: true)
        expect(command_instace).to receive(:execute)
          .with(image: nil, success: true).and_return(image)
        subject.send(:commands=, [command_instace])
      end

      it 'assigns return value correctly and does not log an error' do
        expect(BitmapEditor::Log.instance).not_to receive(:error)
          .with("unrecognised command: #{line}")
        perform
        expect(subject.send(:image)).to eq(image)
      end
    end

    context 'when line is not a valid command' do
      let(:line) { 'DOES_NOT_EXIST' }

      it 'logs the issue and does not raise an error' do
        expect(BitmapEditor::Log.instance)
          .to receive(:error).with("unrecognised command: #{line}")

        expect { subject.execute(line) }.not_to raise_error
      end
    end
  end
end
