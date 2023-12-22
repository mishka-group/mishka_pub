defmodule ActivityStream.Type.Object.Properties.Generator do
  use GuardedStruct

  guardedstruct do
    field(:type, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=120, min_len=3)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=150, min_len=3)"
    )
  end
end
