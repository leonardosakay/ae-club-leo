
with source as (

    select * from {{ source('github', 'pull_request') }}

),

renamed as (

    select
        id as PullRequestID,
        base_user_id as UserID,
        base_repo_id As RepositoryID,
        base_label as BaseLabel,
        base_ref,
        base_sha,
        draft IsDraftFlag,
        head_label,
        head_ref,
        head_repo_id,
        head_sha,
        head_user_id,
        issue_id,
        merge_commit_sha

    from source

)

select * from renamed
