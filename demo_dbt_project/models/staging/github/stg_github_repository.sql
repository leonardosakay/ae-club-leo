
with source as (

    select * from {{ source('github', 'repository') }}

),

renamed as (

    select
        id as RepositoryID,
        archived  as ArchivedFlag,
        created_at as CreatedDate,
        default_branch as DefaultBranchName,
        description as RepositoryDescription,
        fork,
        full_name as FullName,
        homepage as HomepageName,
        language as language,
        name as RepositoryName,
        owner_id as OwnerID,
        private as IsPrivateFlag,
        stargazers_count

    from source

)

select * from renamed