# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::Image do
  subject { described_class.new(columns, rows) }

  describe '.new' do
    let(:columns) { 4 }
    let(:rows) { 6 }

    it 'creates the image of correct size' do
      expect(subject.bitmap.size).to eq(4)
      expect(subject.bitmap[0].size).to eq(6)
    end

    context 'when 1x1 bitmap is requested' do
      let(:columns) { 1 }
      let(:rows) { 1 }

      it 'creates the image of correct size' do
        expect(subject.bitmap.size).to eq(1)
        expect(subject.bitmap[0].size).to eq(1)
      end
    end
  end

  describe '#pixel_at' do
    let(:columns) { 4 }
    let(:rows) { 6 }

    before do
      subject.bitmap[0][0] = 'A'
      subject.bitmap[2][3] = 'Q'
      subject.bitmap[3][5] = 'Z'
    end

    it 'returns correct pixels' do
      expect(subject.pixel_at(1, 1)).to eq('A')
      expect(subject.pixel_at(3, 4)).to eq('Q')
      expect(subject.pixel_at(4, 6)).to eq('Z')
    end
  end

  describe '#to_s' do
    let(:columns) { 4 }
    let(:rows) { 6 }
    let(:expected_output) do
      <<~STRING
        OOOO
        OOOO
        OOOO
        OOOO
        OOOO
        OOOO
      STRING
    end

    it 'returns correct representation' do
      expect(subject.to_s).to eq(expected_output)
    end

    context 'when there is only one pixel' do
      let(:columns) { 1 }
      let(:rows) { 1 }
      let(:expected_output) do
        <<~STRING
          O
        STRING
      end

      it 'returns correct representation' do
        expect(subject.to_s).to eq(expected_output)
      end
    end
  end
end
