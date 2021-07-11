# See: https://dev.to/joeljuca/introducing-iex-local-exs-2bfk
# Local dot-iex file (user/environment-specific, Git-ignored)
import_file_if_available(".iex.local.exs")

# CLIX (Command-line Interface Experience)

import Ecto.Query

alias Packbox.Address
alias Packbox.Item
alias Packbox.Items
alias Packbox.Order
alias Packbox.Orders
alias Packbox.Vendor
alias Packbox.Vendors
alias Packbox.Vendors.Capabilities
