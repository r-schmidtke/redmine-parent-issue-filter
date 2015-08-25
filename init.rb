require_dependency 'redmine_parent_issue_filter_rs'

Redmine::Plugin.register :parent_issue_filter_rs do
  name 'Parent issue filter plugin'
  author 'Robin Schmidtke'
  description 'Parent issue filter plugin for Redmine'
  version '1.0.3'
  url 'https://github.com/r-schmidtke/redmine-parent-issue-filter-rs'
end
