; Inject into documentation comments as markdown
(
  (line_comment
    inner: (inner_doc_comment_marker)
    doc: (doc_comment) @injection.content
      ; ignore empty lines
      (#match? @injection.content "^.+$")
    )

  ; skip the first character (space)
  (#offset! @injection.content 0 1 0 0)

  (#set! injection.language "markdown")
)
(
  (line_comment
    outer: (outer_doc_comment_marker)
    doc: (doc_comment) @injection.content
      ; ignore empty lines
      (#match? @injection.content "^.+$")
    )

  ; skip the first character (space)
  (#offset! @injection.content 0 1 0 0)

  (#set! injection.language "markdown")
)

; Inject into sqlx::query!("...", ...) as sql
(macro_invocation
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

  (token_tree
    (string_literal
      (string_content)) @injection.content)

  ; skip the " character
  (#offset! @injection.content 0 1 0 0)

  (#set! injection.language "sql")
  (#set! injection.include-children)
)

; Inject into sqlx::query!(r#"..."#, ...) as sql
(macro_invocation
  (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

  (token_tree
    (raw_string_literal
      (string_content)) @injection.content)

  ; skip the r#" characters
  (#offset! @injection.content 0 3 0 0)

  (#set! injection.language "sql")
  (#set! injection.include-children)
)
