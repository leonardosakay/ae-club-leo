{% snapshot favorite_ice_cream_flavors %}


{{
        config (
            target_schema ='dbt_leosakay',
            unique_key = 'github_username',
            strategy = 'timestamp',
            updated_at = 'updated_at',
            enabled=false,
        )
}}

select * from {{ source ('advanced_dbt_examples', 'favorite_ice_cream_flavors') }}

{% endsnapshot %}