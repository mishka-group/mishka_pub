defmodule MishkaPub.ActivityStream.Type.OrderedCollectionPage do
  use GuardedStruct
  alias ActivityStream.Type.Collection.Properties
  alias ActivityStream.Type.CollectionPage.Properties.{Next, Prev}
  alias ActivityStream.Type.Collection.Properties.OrderedItems
  alias ActivityStream.Behaviour

  # URI: https://www.w3.org/ns/activitystreams#OrderedCollectionPage
  # Used to represent ordered subsets of items from an OrderedCollection.
  # Refer to the Activity Streams 2.0 Core for a complete description of
  # the OrderedCollectionPage object.
  # ---------------------------------------------------------------------------------------
  # Properties:
  # Inherits all properties from OrderedCollection and CollectionPage.
  # context | type | summary | totalItems | current | first | last
  # partOf | next | prev | orderedItems | startIndex
  # ---------------------------------------------------------------------------------------
  # Extends: OrderedCollection | CollectionPage
  guardedstruct do
    # URI: https://www.w3.org/ns/activitystreams#context
    # Identifies the context within which the object exists or an activity was performed.
    # The notion of "context" used is intentionally vague. The intended function is to serve
    # as a means of grouping objects and activities that share a common originating context or purpose.
    # An example could be all activities relating to a common project or event.
    # Domain: Object
    field(:context, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url)",
      default: "https://www.w3.org/ns/activitystreams"
    )

    # URI: @type
    # Identifies the Object or Link type. Multiple values may be specified.
    # Domain: Object | Link
    field(:type, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=80, min_len=3)",
      default: "OrderedCollectionPage"
    )

    # URI: https://www.w3.org/ns/activitystreams#summary
    # A natural language summarization of the object encoded as HTML.
    # Multiple language tagged summaries may be provided.
    # Domain:	Object
    field(:summary, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, max_len=364, min_len=3)"
    )

    # URI: https://www.w3.org/ns/activitystreams#totalItems
    # A non-negative integer specifying the total number of objects contained by the logical
    # view of the collection. This number might not reflect the actual number
    # of items serialized within the Collection object instance.
    # Domain:	Collection
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's notes",
    #   "type": "Collection",
    #   "totalItems": 2,
    #   "items": [
    #     {
    #       "type": "Note",
    #       "name": "Which Staircase Should I Use"
    #     },
    #     {
    #       "type": "Note",
    #       "name": "Something to Remember"
    #     }
    #   ]
    # }
    field(:totalItems, non_neg_integer(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=0)"
    )

    # URI: https://www.w3.org/ns/activitystreams#current
    # In a paged Collection, indicates the page that contains the most recently updated member items.
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
    conditional_field(:current, Behaviour.ss()) do
      field(:current, struct(), struct: Properties.Current, hint: "currentMap")

      field(:current, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "current"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#first
    # In a paged Collection, indicates the furthest preceeding page of items in the collection.
    # Domain:	Collection
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's blog posts",
    #   "type": "Collection",
    #   "totalItems": 3,
    #   "first": "http://example.org/collection?page=0"
    # }
    # -----------------------------------------------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's blog posts",
    #   "type": "Collection",
    #   "totalItems": 3,
    #   "first": {
    #     "type": "Link",
    #     "summary": "First Page",
    #     "href": "http://example.org/collection?page=0"
    #   }
    # }
    conditional_field(:first, Behaviour.ss()) do
      field(:first, struct(), struct: Properties.First, hint: "firstMap")

      field(:first, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "first"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#last
    # In a paged Collection, indicates the furthest proceeding page of the collection.
    # Domain:	Collection
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A collection",
    #   "type": "Collection",
    #   "totalItems": 3,
    #   "last": "http://example.org/collection?page=1"
    # }
    # -----------------------------------------------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "A collection",
    #   "type": "Collection",
    #   "totalItems": 5,
    #   "last": {
    #     "type": "Link",
    #     "summary": "Last Page",
    #     "href": "http://example.org/collection?page=1"
    #   }
    # }
    conditional_field(:last, Behaviour.ss()) do
      field(:last, struct(), struct: Properties.Last, hint: "lastMap")

      field(:last, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "last"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#partOf
    # Identifies the Collection to which a CollectionPage objects items belong.
    # Domain:	CollectionPage
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Page 1 of Sally's notes",
    #   "type": "CollectionPage",
    #   "id": "http://example.org/collection?page=1",
    #   "partOf": "http://example.org/collection",
    #   "items": [
    #     {
    #       "type": "Note",
    #       "name": "Pizza Toppings to Try"
    #     },
    #     {
    #       "type": "Note",
    #       "name": "Thought about California"
    #     }
    #   ]
    # }
    field(:partOf, String.t(),
      derive: "sanitize(tag=strip_tags) validate(not_empty_string, url, max_len=160)"
    )

    # URI: https://www.w3.org/ns/activitystreams#next
    # In a paged Collection, indicates the next page of items.
    # Domain:	CollectionPage
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Page 2 of Sally's blog posts",
    #   "type": "CollectionPage",
    #   "next": "http://example.org/collection?page=2",
    #   "items": [
    #     "http://example.org/posts/1",
    #     "http://example.org/posts/2",
    #     "http://example.org/posts/3"
    #   ]
    # }
    # ----------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Page 2 of Sally's blog posts",
    #   "type": "CollectionPage",
    #   "next": {
    #     "type": "Link",
    #     "name": "Next Page",
    #     "href": "http://example.org/collection?page=2"
    #   },
    #   "items": [
    #     "http://example.org/posts/1",
    #     "http://example.org/posts/2",
    #     "http://example.org/posts/3"
    #   ]
    # }
    conditional_field(:next, Behaviour.ss()) do
      field(:next, struct(), struct: Next, hint: "nextMap")

      field(:next, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "next"
      )
    end

    # URI: https://www.w3.org/ns/activitystreams#prev
    # In a paged Collection, identifies the previous page of items.
    # Domain:	CollectionPage
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Page 1 of Sally's blog posts",
    #   "type": "CollectionPage",
    #   "prev": "http://example.org/collection?page=1",
    #   "items": [
    #     "http://example.org/posts/1",
    #     "http://example.org/posts/2",
    #     "http://example.org/posts/3"
    #   ]
    # }
    # ----------------------------------
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Page 1 of Sally's blog posts",
    #   "type": "CollectionPage",
    #   "prev": {
    #     "type": "Link",
    #     "name": "Previous Page",
    #     "href": "http://example.org/collection?page=1"
    #   },
    #   "items": [
    #     "http://example.org/posts/1",
    #     "http://example.org/posts/2",
    #     "http://example.org/posts/3"
    #   ]
    # }
    conditional_field(:prev, Behaviour.ss()) do
      field(:prev, struct(), struct: Prev, hint: "prevMap")

      field(:prev, String.t(),
        derive: "sanitize(tag=strip_tags) validate(url, max_len=160)",
        hint: "prev"
      )
    end

    # URI: none
    # Ordered Items
    # Domain: any
    # TODO: We should cover a standard properties, because the Ordered Items can be anything no limited
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Sally's notes",
    #   "type": "OrderedCollection",
    #   "totalItems": 2,
    #   "orderedItems": [
    #     {
    #       "type": "Note",
    #       "name": "A Simple Note"
    #     },
    #     {
    #       "type": "Note",
    #       "name": "Another Simple Note"
    #     }
    #   ]
    # }
    field(:orderedItems, Behaviour.lst(),
      structs: OrderedItems,
      derive: "validate(list, not_empty, not_flatten_empty_item)"
    )

    # URI: https://www.w3.org/ns/activitystreams#startIndex
    # A non-negative integer value identifying the relative position within the logical view of a strictly ordered collection.
    # Domain:	OrderedCollectionPage
    # Example:
    # {
    #   "@context": "https://www.w3.org/ns/activitystreams",
    #   "summary": "Page 1 of Sally's notes",
    #   "type": "OrderedCollectionPage",
    #   "startIndex": 0,
    #   "orderedItems": [
    #     {
    #       "type": "Note",
    #       "name": "Density of Water"
    #     },
    #     {
    #       "type": "Note",
    #       "name": "Air Mattress Idea"
    #     }
    #   ]
    # }
    field(:startIndex, String.t(),
      enforce: true,
      derive: "sanitize(tag=strip_tags) validate(integer, min_len=0)"
    )
  end
end
