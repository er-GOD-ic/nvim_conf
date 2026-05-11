(binding
  attrpath: (attrpath
    attr: (identifier) @_attr
    (#any-of? @_attr "config" "extraDefCfg"))
  expression: (indented_string_expression
    (string_fragment) @injection.content
    (#set! injection.language "scheme")
    (#set! injection.combined)))
