defmodule ActivityStream.Type.Collection.Properties.Current do
  use GuardedStruct

  # URI: https://www.w3.org/ns/activitystreams#current
  # In a paged Collection, indicates the page that contains the most recently updated member items.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # type | summary | href
  # ---------------------------------------------------------------------------------------
  # Domain:	Collection
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Sally's blog posts",
  #   "type": "Collection",
  #   "totalItems": 3,
  #   "current": "http://example.org/collection",
  #   "items": [
  #     "http://example.org/posts/1",
  #     "http://example.org/posts/2",
  #     "http://example.org/posts/3"
  #   ]
  # }
  # -----------------------------------------------------------------------
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "Sally's blog posts",
  #   "type": "Collection",
  #   "totalItems": 3,
  #   "current": {
  #     "type": "Link",
  #     "summary": "Most Recent Items",
  #     "href": "http://example.org/collection"
  #   },
  #   "items": [
  #     "http://example.org/posts/1",
  #     "http://example.org/posts/2",
  #     "http://example.org/posts/3"
  #   ]
  # }
  guardedstruct do
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "Link"
    )

    field(:summary, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=360, min_len=3)"
    )

    field(:href, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(url, max_len=160)"
    )
  end
end
