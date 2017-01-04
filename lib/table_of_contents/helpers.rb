module TableOfContents
  module Helpers
    def table_of_contents(html, max_level: nil)
      HeadingTreeRenderer.new(
        HeadingTreeBuilder.new(
          HeadingsBuilder.new(html).headings
        ).tree,
        max_level: max_level
      ).html
    end
  end
end
