defmodule ActivityStream.Type.Object.Properties.Preview do
  use GuardedStruct
  alias ActivityStream.Type.Object.Properties.Url

  # URI: https://www.w3.org/ns/activitystreams#preview
  # Identifies an entity that provides a preview of this object.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | name | duration | url --> href | mediaType
  # ---------------------------------------------------------------------------------------
  # Domain: Link | Object
  guardedstruct do
    field(:type, String.t(),
      default: "Video",
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    field(:name, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string)"
    )

    # The value associated with "duration" is an ISO 8601 duration string.
    # Ex: "duration": "PT2H30M"
    field(:duration, String.t(),
      enforce: true,
      derive:
        "sanitize(tag=strip_tags) validate(not_empty_string, max_len=10, custom=[MishkaPub.Helper.Extra, is_duration?])"
    )

    field(:url, struct(), structs: true, struct: Url)
  end
end
