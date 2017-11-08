# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::ClearImageCommand do
  describe '#parse' do
    let(:perform) { subject.parse(line) }
    let(:line) { 'C' }

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
      let(:image) { BitmapEditor::Image.new(4, 4) }

      it 'displays the image correctly' do
        expect(image).to receive(:clear)
        perform
      end
    end
  end
end
