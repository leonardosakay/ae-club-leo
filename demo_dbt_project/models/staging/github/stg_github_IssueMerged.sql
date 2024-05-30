with source as ( 

    select * FROM {{source('github', 'issue_merged')}}
)
,renamed as (
    select 
issue_id,    
actor_id MergedUserID,
commit_sha,
merged_at MergedDate

from source
)

select * FROM renamed