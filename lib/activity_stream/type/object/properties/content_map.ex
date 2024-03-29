defmodule ActivityStream.Type.Object.Properties.ContentMap do
  use GuardedStruct

  # URI:	https://www.w3.org/ns/activitystreams#content
  # The content or textual representation of the Object encoded as a JSON string.
  # By default, the value of content is HTML.
  # The mediaType property can be used in the object to indicate a different content type.
  # The content may be expressed using multiple language-tagged values.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # en | fa
  # ---------------------------------------------------------------------------------------
  # Domain: Object
  # Owner: :content
  # Example:
  # {
  #   "@context": "https://www.w3.org/ns/activitystreams",
  #   "summary": "A simple note",
  #   "type": "Note",
  #   "contentMap": {
  #     "en": "A <em>simple</em> note",
  #     "es": "Una nota <em>sencilla</em>",
  #     "zh-Hans": "一段<em>简单的</em>笔记"
  #   }
  # }
  guardedstruct do
    field(:en, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500, min_len=3)"
    )

    field(:fa, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=1500, min_len=3)"
    )
  end
end
