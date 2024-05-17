{% macro generate_columns_yml(model_name) %}
{%- set model = ref(model_name) -%}
{%- set cols = adapter.get_columns_in_relation(model) -%}
models:
  - name: {{ model_name }}
    columns:
{%- for col in cols %}
      - name: {{ col.name }}
        description: ''
{%- endfor %}
{% endmacro %}
