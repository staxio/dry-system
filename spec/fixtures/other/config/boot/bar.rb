# frozen_string_literal: true

Test::Container.register_bootable(:bar, namespace: "test") do |_container|
  init do
    module Test
      module Bar
        # I shall be booted
      end
    end
  end

  start do
    register(:bar, "I was finalized")
  end
end
