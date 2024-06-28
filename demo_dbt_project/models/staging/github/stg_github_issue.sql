
with source as (

    select * from {{ source('github', 'issue') }}

),

renamed as (

    select
        id as IssueID,
        milestone_id as MilestoneID,
        body,
        closed_at as ClosedDate,
        created_at as CreatedDate,
        locked as LockedFlag,

        number,
        pull_request,
        repository_id,
        state,
        title,
        updated_at as UpdatedDate,
        user_id

    from source

)

select * from renamed