defmodule ActivityStream.Behaviour do
  @type sls() :: struct() | list(struct())
  @type ssls() :: sls() | String.t() | list(String.t())
  @type ls() :: list(String.t())
  @type slss() :: sls() | String.t()
  @type li() :: list(integer())
  @type lm() :: list(map())
  @type uuid() :: <<_::288>>
  @type lst() :: list(struct())
  @type ss() :: struct() | String.t()
end
