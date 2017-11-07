# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::CommandRunner do
  let(:perform) { subject.execute(command) }

  describe 'Create Image' do
    context 'when image parameters are valid' do
      let(:command) { 'I 4 20' }

      it 'creates and stores the image' do
        perform
        image = subject.send(:image)
        expect(image).not_to be_nil
      end
    end

    context 'when image parameters are too small' do
      let(:command) { 'I 0 0' }

      it 'does not create the image' do
        perform
        image = subject.send(:image)
        expect(image).to be_nil
      end

      it 'prints out that it did not create the image' do
        expect { perform }
          .to output("Can not create image of size 0, 0\n").to_stdout
      end
    end

    context 'when image parameters are too large' do
      let(:command) { 'I 300 5' }

      it 'does not create the image' do
        perform
        image = subject.send(:image)
        expect(image).to be_nil
      end

      it 'prints out that it did not create the image' do
        expect { perform }
          .to output("Can not create image of size 300, 5\n").to_stdout
      end
    end

    context 'when image parameters are incorrect' do
      [
        'I',
        'I 3',
        'I 3 b',
        'I 3 5 5',
        'I a 5 5',
        'I 5 5 c',
      ].each do |command|
        it 'responds gracefully' do
          expect { subject.execute(command) }
            .to output("incorrect parameter size for create image command :(\n").to_stdout
        end
      end
    end
  end

  describe 'Show Image' do
    let(:command) { 'S' }

    context 'when there is no image present' do
      it 'prints out the message' do
        expect { perform }.to output("There is no image\n").to_stdout
      end
    end

    context 'when there is image' do
      let(:expected_output) do
        <<~OUTPUT
          OOOOO
          OOOOO
          OOOOO
        OUTPUT
      end

      before { subject.execute('I 5 3') }

      it 'displays the image correctly' do
        expect { perform }.to output(expected_output).to_stdout
      end
    end
  end

  describe 'Non-existing command' do
    let(:command) { 'DOES_NOT_EXIST' }

    it 'responds gracefully' do
      expect { perform }.to output("unrecognised command :(\n").to_stdout
    end
  end
end
