module RedmineParentIssueFilterRs    
    class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_index_bottom, 
                :partial => "issues/view_issues_index_bottom" 
    end
end