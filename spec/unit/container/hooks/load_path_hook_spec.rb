# frozen_string_literal: true

RSpec.describe Dry::System::Container, "Default hooks / Load path" do
  let(:container) {
    Class.new(Dry::System::Container) {
      config.root = SPEC_ROOT.join("fixtures/test")
      config.component_dirs = ["lib"]
    }
  }

  before do
    @load_path_before = $LOAD_PATH
  end

  after do
    $LOAD_PATH.replace(@load_path_before)
  end

  context "add_component_dirs_to_load_path is true" do
    before do
      container.config.add_component_dirs_to_load_path = true
    end

    it "adds the component dirs to the load path" do
      expect { container.configure do; end }
        .to change { $LOAD_PATH.include?(SPEC_ROOT.join("fixtures/test/lib").to_s) }
        .from(false).to(true)
    end
  end

  context "add_component_dirs_to_load_path is true" do
    before do
      container.config.add_component_dirs_to_load_path = false
    end

    it "does not change the load path" do
      expect { container.configure do; end }.not_to change { $LOAD_PATH }
    end
  end
end
