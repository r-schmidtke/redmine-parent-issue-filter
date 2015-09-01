module RedmineParentIssueFilter
  module QueryPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      # Same as typing in the class
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development

        alias_method_chain :available_filters, :parent_id
      end
    end
  
    module InstanceMethods

      # Wrapper around the +available_filters+ to add a new Deliverable filter
      def available_filters_with_parent_id
        @available_filters = available_filters_without_parent_id

        # Collect only issues that have children
        issue_values = []
        issue_values += Issue.where(id: Issue.select(:parent_id).distinct).collect{|s| [s.to_s, s.id.to_s]}
      
        parent_id_filters = {
          "parent_id" => { 
            :name => l(:field_parent_issue),
            :type => :list, 
            :values => issue_values,
            :order => @available_filters.size + 1},
          "root_id" => { 
            :name => l(:field_root_issue),
            :type => :list, 
            :values => issue_values,
            :order => @available_filters.size + 2}
        }

        return @available_filters.merge!(parent_id_filters)
      end
    end
  end
end

# Add module to Query
Query.send(:include, RedmineParentIssueFilter::QueryPatch)
