# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::CreateImageCommand do
  describe '#parse' do
    context 'when image parameters are valid' do
      # Parameters of the command are separated by white space*s*
      [
        'I 3 5',
        'I 3  5',
        'I   03 5',
        "I         3\t5",
        "I         3\t5\n"
      ].each do |line|
        it "when #{line}, parses and returns correct arguments" do
          expect(subject.parse(line)).to eq(columns: 3, rows: 5)
        end
      end
    end

    context 'when image parameters are incorrect' do
      [
        'I',
        'I 3',
        'I 3 5b',
        'I 3 b',
        'I35',
        'I 35',
        'I 3 5 5',
        'I a 5 5',
        'I 5 5 c'
      ].each do |line|
        it "when #{line}, returns a no match response" do
          expect(subject.parse(line)).to be_nil
        end
      end
    end

    describe '#execute' do
      context 'when parameters are valid' do
        let(:perform) { subject.execute(image: nil, columns: 6, rows: 4) }
        let(:expected_output) do
          <<~OUTPUT
            OOOOOO
            OOOOOO
            OOOOOO
            OOOOOO
          OUTPUT
        end

        it 'creates the image' do
          expect(BitmapEditor::Image).to receive(:new)
            .with(6, 4).and_call_original
          expect(perform).to be_an_instance_of(BitmapEditor::Image)
        end
      end

      context 'when image parameters are out of bounds' do
        let(:perform) { subject.execute(image: nil, columns: 0, rows: 0) }

        it 'logs the issue and does not create the image' do
          expect(BitmapEditor::Log.instance).to receive(:error)
            .with('Can not create image of size 0, 0')
          expect(perform).to be_nil
        end
      end

      context 'when image parameters are too large' do
        let(:perform) { subject.execute(image: nil, columns: 300, rows: 5) }

        it 'logs the issue and does not create the image' do
          expect(BitmapEditor::Log.instance).to receive(:error)
            .with('Can not create image of size 300, 5')
          expect(perform).to be_nil
        end
      end
    end
  end
end
