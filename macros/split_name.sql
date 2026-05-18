{% macro split_name(column, part) %}
    split_part({{ column }}, ' ', {{ part }})
{% endmacro %}