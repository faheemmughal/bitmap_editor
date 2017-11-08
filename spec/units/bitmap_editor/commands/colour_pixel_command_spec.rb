# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::ColourPixelCommand do
  describe '#parse' do
    context 'when command parameters are valid' do
      # Parameters of the command are separated by white space*s*
      # L   X   Y   C
      [
        'L 2 3 A',
        'L 2  3  A',
        'L   02 3  A',
        "L         2\t3\tA",
        "L         2\t3\tA\n"
      ].each do |line|
        it "when #{line}, parses and returns correct arguments" do
          expect(subject.parse(line)).to eq(x: 2, y: 3, colour: 'A')
        end
      end
    end

    context 'when image parameters are incorrect' do
      [
        'L 2',
        'L 23',
        'L 3 5A',
        'L 3 A A',
        'L35A',
        'L 35 A',
        'L 3 5 a',
        'L a 5  5',
        'L 3 5  5A',
        'L 5 5 A c'
      ].each do |line|
        it "when #{line}, returns a no match response" do
          expect(subject.parse(line)).to be_nil
        end
      end
    end
  end

  describe '#execute' do
    let(:perform) { subject.execute(image: image, x: 2, y: 3, colour: 'A') }

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

      it 'displays the image correctly' do
        expect(image).to receive(:colour).with(2, 3, 'A')
        perform
      end
    end
  end
end
