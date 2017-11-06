require 'spec_helper'

RSpec.describe BitmapEditor do

  describe '#run' do
    let(:perform) { subject.run(file) }

    context 'when valid file is provided' do
      let(:file) { 'spec/fixtures/display_bitmap.txt' }

      it 'writes correct output for the file' do
        expect { perform }.to output("There is no image\n").to_stdout
      end
    end

    context 'when file is empty' do
      let(:file) { 'spec/fixtures/empty_file.txt' }

      it 'does not raise an error' do
        expect { perform }.not_to raise_error
      end
    end

    context 'when file has incorrect command' do
      let(:file) { 'spec/fixtures/incorrect_command.txt' }

      it 'handles the command gracefully' do
        expect { perform }.to output("unrecognised command :(\n").to_stdout
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
