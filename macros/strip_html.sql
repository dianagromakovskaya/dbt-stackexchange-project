{% macro strip_html(column_name) %}
  -- 1) turn common break tags into newlines
  {% set with_breaks %}
    REGEXP_REPLACE(
      REGEXP_REPLACE(
        REGEXP_REPLACE(
          REGEXP_REPLACE({{ column_name }}, r'(?i)</p\s*>', '\n'),
        r'(?i)<br\s*/?>', '\n'),
      r'(?i)<li\s*>', '- '),
    r'(?i)</li\s*>', '\n')
  {% endset %}

  -- 2) drop all remaining tags
  {% set no_tags %}
    REGEXP_REPLACE( ({{ with_breaks }}), r'<[^>]*>', '' )
  {% endset %}

  -- 3) decode common entities (reuse your earlier macro if you have one)
  {% set unescaped %}
    {{ html_unescape(no_tags) }}
  {% endset %}

  -- 4) normalize whitespace
  REGEXP_REPLACE( {{ unescaped }}, r'[ \t\r\f\v]+', ' ')
{% endmacro %}