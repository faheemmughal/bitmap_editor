# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::DrawHorizontalLineCommand do
  describe '#parse' do
    context 'when command parameters are valid' do
      # Parameters of the command are separated by white space*s*
      # V X Y1 Y2 C
      [
        'H 2 3 5 A',
        'H 2  3  5    A',
        'H   02 3  5 A',
        "H       2  3\t05\tA",
        "H       2  3\t005\tA\n"
      ].each do |line|
        it "when #{line}, parses and returns correct arguments" do
          expect(subject.parse(line)).to eq(x1: 2, x2: 3, y: 5, colour: 'A')
        end
      end
    end

    context 'when image parameters are incorrect' do
      [
        'H 1 2',
        'H 1 23',
        'H 1 3 5A',
        'H 1 3 A A',
        'H135A',
        'H 1 35 A',
        'H 1 3 5 a',
        'H 1 a 5  5',
        'H 1 3 5  5A',
        'H 1 5 5 A c'
      ].each do |line|
        it "when #{line}, returns a no match response" do
          expect(subject.parse(line)).to be_nil
        end
      end
    end
  end

  describe '#execute' do
    let(:perform) do
      subject.execute(image: image, x1: 2, x2: 3, y: 5, colour: 'A')
    end

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
        expect(image).to receive(:draw_horizontal).with(2, 3, 5, 'A')
        perform
      end
    end
  end
end
