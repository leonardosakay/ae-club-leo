WITH pull_request AS (
    SELECT
        *
    FROM
        {{ ref('stg_github_PullRequest') }}
),
repository AS (
    SELECT
        *
    FROM
        {{ ref('stg_github_repository') }}
),
issue_merged AS (
    SELECT
        *
    FROM
        {{ ref('stg_github_IssueMerged') }}
),
issue AS (
    SELECT
        *
    FROM
        {{ ref('stg_github_issue') }}
),
final as (
    SELECT
        pr.PullRequestID,
        r.RepositoryName,
        i.number AS PullRequestNumber,
        NULL AS type,
        i.state AS IssueStatus,
        i.UpdatedDate,
        im.MergedDate,
        CASE
            WHEN pr.IsDraftFlag THEN 'Draft'
            WHEN im.MergedDate IS NOT NULL THEN 'Merged'
            WHEN i.ClosedDate IS NOT NULL THEN 'Closed Without Merge'
            ELSE 'Open'
        END AS MergeState,
        DATE_DIFF(i.CreatedDate, im.MergedDate, hour) / 24 AS days_open_to
   from
      pull_request as pr
      left join repository as r on pr.head_repo_id = r.RepositoryID
      left join issue as i on i.IssueID = pr.IssueID
      left join issue_merged as im on im.IssueID = i.IssueID
)
select
   *
FROM
   final