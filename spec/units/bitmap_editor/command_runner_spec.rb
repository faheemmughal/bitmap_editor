# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor::CommandRunner do
  let(:perform) { subject.execute(command) }

  describe 'Create Image' do
    context 'when image parameters are valid' do
      # Parameters of the command are separated by white space*s*
      [
        'I 3 5',
        'I 3  5',
        'I   03 5',
        "I         3\t5",
        "I         3\t5\n"
      ].each do |command|
        it "when #{command}, parses and create correct sized image" do
          expect(BitmapEditor::Log.instance).not_to receive(:error)
          expect(BitmapEditor::Image).to receive(:new).with(3, 5)
          subject.execute(command)
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
      ].each do |command|
        it "when #{command}, logs the issue and does not raise an error" do
          expect(BitmapEditor::Log.instance)
            .to receive(:error).with("unrecognised command: #{command}")
          expect(BitmapEditor::Image).not_to receive(:new)
          expect { subject.execute(command) }.not_to raise_error
        end
      end
    end

    context 'when image parameters are too small' do
      let(:command) { 'I 0 0' }

      it 'does not create the image' do
        perform
        image = subject.send(:image)
        expect(image).to be_nil
      end

      it 'logs the issue and does not raise an error' do
        expect(BitmapEditor::Log.instance)
          .to receive(:error).with('Can not create image of size 0, 0')

        expect { perform }.not_to raise_error
      end
    end

    context 'when image parameters are too large' do
      let(:command) { 'I 300 5' }

      it 'does not create the image' do
        perform
        image = subject.send(:image)
        expect(image).to be_nil
      end

      it 'logs the issue and does not raise an error' do
        expect(BitmapEditor::Log.instance)
          .to receive(:error).with('Can not create image of size 300, 5')

        expect { perform }.not_to raise_error
      end
    end
  end

  describe 'Show Image' do
    let(:command) { 'S' }

    context 'when there is no image present' do
      it 'logs the issue and does not raise an error' do
        expect(BitmapEditor::Log.instance)
          .to receive(:error).with('There is no image present')

        expect { perform }.not_to raise_error
      end
    end

    context 'when there is image' do
      let(:expected_output) do
        <<~OUTPUT
          OOOOOO
          OOOOOO
          OOOOOO
          OOOOOO
        OUTPUT
      end

      before { subject.execute('I 6 4') }

      it 'displays the image correctly' do
        expect { perform }.to output(expected_output).to_stdout
      end
    end
  end

  describe 'Non-existing command' do
    let(:command) { 'DOES_NOT_EXIST' }

    it 'logs the issue and does not raise an error' do
      expect(BitmapEditor::Log.instance)
        .to receive(:error).with("unrecognised command: #{command}")

      expect { subject.execute(command) }.not_to raise_error
    end
  end
end
