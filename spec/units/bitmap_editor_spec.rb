# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BitmapEditor do
  describe '.run' do
    let(:perform) { subject.run(file) }

    context 'when valid file is provided' do
      let(:file) { 'spec/fixtures/create_and_display_image.txt' }
      let(:correct_output) do
        <<~STRING
          OOOOOOOOOOOOOOOOOOOO
          OOOOOOOOOOOOOOOOOOOO
          OOOOOOOOOOOOOOOOOOOO
          OOOOOOOOOOOOOOOOOOOO
          OOOOOOOOOOOOOOOOOOOO
          OOOOOOOOOOOOOOOOOOOO
          OOOOOOOOOOOOOOOOOOOO
        STRING
      end

      it 'writes correct output for the file' do
        expect { perform }.to output(correct_output).to_stdout
      end
    end

    context 'when using provided example' do
      let(:file) { 'spec/fixtures/example.txt' }
      let(:correct_output) do
        <<~STRING
          OOOOO
          OOZZZ
          AWOOO
          OWOOO
          OWOOO
          OWOOO
        STRING
      end

      it 'writes correct output for the file' do
        expect { perform }.to output(correct_output).to_stdout
      end
    end

    context 'when file is empty' do
      let(:file) { 'spec/fixtures/empty_file.txt' }

      it 'does not raise an error' do
        expect { perform }.not_to raise_error
      end
    end

    context 'when no file is provided' do
      let(:file) { nil }

      it 'writes error message to the output' do
        expect { perform }.to output("please provide correct file\n").to_stdout
      end
    end

    context 'when file does not exist' do
      let(:file) { 'spec/fixtures/no_such_file.txt' }

      it 'writes error message to the output' do
        expect { perform }.to output("please provide correct file\n").to_stdout
      end
    end
  end
end
