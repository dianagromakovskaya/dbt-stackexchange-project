{% macro html_unescape(column_name) %}

  REGEXP_REPLACE(
    REGEXP_REPLACE(
      REGEXP_REPLACE(
        REGEXP_REPLACE(
          REGEXP_REPLACE({{ column_name }}, r'&quot;', '"'),
        r'&apos;', "'"),
      r'&amp;', '&'),
    r'&lt;', '<'),
  r'&gt;', '>')

{% endmacro %}