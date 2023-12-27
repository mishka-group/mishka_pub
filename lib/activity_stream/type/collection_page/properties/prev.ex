defmodule ActivityStream.Type.CollectionPage.Properties.Prev do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#prev
  # In a paged Collection, identifies the previous page of items.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name | href
  # ---------------------------------------------------------------------------------------
  # Domain:	CollectionPage
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Link"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=360, min_len=3)"
    )

    field(:href, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )
  end
end
