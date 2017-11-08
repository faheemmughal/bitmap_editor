# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::PrintImageCommand do
  describe '#parse' do
    let(:perform) { subject.parse(line) }
    let(:line) { 'S' }

    it 'recognises the command and returns a success' do
      expect(perform).to eq({})
    end
  end

  describe '#execute' do
    let(:perform) { subject.execute(image: image) }

    context 'when there is no image present' do
      let(:image) {}

      it 'logs the issue and does not raise an error' do
        expect(BitmapEditor::Log.instance)
          .to receive(:error).with('There is no image present')

        expect { perform }.not_to raise_error
      end
    end

    context 'when there is an image' do
      let(:image) { BitmapEditor::Image.new(6, 4) }
      let(:expected_output) do
        <<~OUTPUT
          OOOOOO
          OOOOOO
          OOOOOO
          OOOOOO
        OUTPUT
      end

      it 'displays the image correctly' do
        expect { perform }.to output(expected_output).to_stdout
      end
    end
  end
end
