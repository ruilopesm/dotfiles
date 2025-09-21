Logger.configure_backend(:console, device: Process.group_leader())

defmodule :_utils do
  defdelegate q(), to: System, as: :halt
end

import :_utils
