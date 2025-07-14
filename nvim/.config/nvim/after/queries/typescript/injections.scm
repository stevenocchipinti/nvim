; Cant get these to work :(

;;
;; JAVASCRIPT STYLED COMPONENTS
;;
;
;; styled.div`<css>`
;(call_expression
; function: (member_expression
;   object: (identifier) @_object
;   property: (property_identifier) @property
;   (#eq? @_object "styled"))
; arguments: ((template_string) @css
;   (#offset! @css 0 1 0 -1)))
;
;; styled(Component)`<css>`
;(call_expression
; function: (call_expression
;   function: (identifier) @styled
;   (#eq? @styled "styled"))
; arguments: ((template_string) @css
;   (#offset! @css 0 1 0 -1)))
;
;; styled.div<Props>`<css>`
;(binary_expression
;  left: (member_expression
;    object: (identifier) @_object
;    property: (property_identifier) @property
;    (#eq? @_object "styled"))
;  right: (template_string) @css
;    (#offset! @css 0 1 0 -1))
;
;; styled(Component)`<css>`
;(call_expression
;  function: (call_expression
;    function: (identifier) @styled
;    (#eq? @styled "styled"))
;  arguments: (template_string) @css
;    (#offset! @css 0 1 0 -1))
;
;; styled.div.attrs({ prop: "foo" })`<css>`
;(call_expression
; function: (call_expression
;   function: (member_expression
;     object: (member_expression
;       object: (identifier) @styled
;       (#eq? @styled "styled"))))
; arguments: ((template_string) @css
;   (#offset! @css 0 1 0 -1)))
;
;; styled(Component).attrs({ prop: "foo" })`<css>`
;(call_expression
; function: (call_expression
;   function: (member_expression
;     object: (call_expression
;       function: (identifier) @styled
;       (#eq? @styled "styled"))))
; arguments: ((template_string) @css
;   (#offset! @css 0 1 0 -1)))
;
;
;;
;; TYPESCRIPT STYLED COMPONENTS
;;
;
;(
;  (lexical_declaration
;    (variable_declarator
;      value: (binary_expression
;        left: (binary_expression
;          left: (member_expression
;            object: (identifier) @styled-object
;            property: (property_identifier))
;          right: (identifier))
;        right: (template_string) @css
;      )
;    )
;  )
;  (#eq? @styled-object "styled")
;)
;
;(
;  (lexical_declaration
;    (variable_declarator
;      value: (call_expression
;        function: (call_expression
;          function: (identifier) @styled-func
;          arguments: (arguments
;            (identifier) @component
;          )
;        )
;        arguments: (template_string) @css
;      )
;    )
;  )
;  (#eq? @styled-func "styled")
;)
;
;
;(
;  (lexical_declaration
;    (variable_declarator
;      value: (call_expression
;        function: (non_null_expression
;          (instantiation_expression
;            (member_expression
;              object: (identifier) @styled-object
;              property: (property_identifier))
;            type_arguments: (type_arguments
;              (object_type
;                (property_signature
;                  name: (property_identifier)
;                  type: (type_annotation
;                    (predefined_type)))))
;          )
;        )
;        arguments: (template_string) @css
;      )
;    )
;  )
;  (#eq? @styled-object "styled")
;)
;
;;
;; REGEX
;;
;(regex_pattern) @regex
;
;


;; Tree-sitter query for injecting CSS from styled-components

(
  ;; Match a template string within a styled-component call
  (lexical_declaration
    (variable_declarator
      value: (call_expression
        function: (non_null_expression
          (instantiation_expression
            (member_expression
              object: (identifier) @styled-object
              property: (property_identifier))
            ;; Type arguments here if needed
          )
        )
        arguments: (template_string
          (string_fragment) @injection.content ;; Capture the string content
        )
      )
    )
  )

  ;; Ensure it's from a styled-component
  (#eq? @styled-object "styled")

  ;; Force the language of the injection on the string fragment
  (#set! injection.language "css")
)
