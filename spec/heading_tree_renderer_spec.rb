require 'spec_helper'

describe TableOfContents::HeadingTreeRenderer, '#html' do
  let(:tree) {
    TableOfContents::HeadingTree.new(
      heading: nil,
      children: [
        TableOfContents::HeadingTree.new(
          heading: TableOfContents::Heading.new(element_name: 'h1', text: 'Apples', attributes: { 'id' => 'apples' }),
          children: [
            TableOfContents::HeadingTree.new(
              heading: TableOfContents::Heading.new(element_name: 'h2', text: 'Apple recipes', attributes: { 'id' => 'apple-recipes' })
            )
          ]
        ),
        TableOfContents::HeadingTree.new(
          heading: TableOfContents::Heading.new(element_name: 'h1', text: 'Oranges', attributes: { 'id' => 'oranges' }),
        )
      ]
    )
  }

  let(:expected_html_with_all_headings) {
    <<~EOF
    <ul>
      <li>
        <a href="#apples">Apples</a>
        <ul>
          <li>
            <a href="#apple-recipes">Apple recipes</a>
          </li>
        </ul>
      </li>
      <li>
        <a href="#oranges">Oranges</a>
      </li>
    </ul>
    EOF
  }

  let(:expected_html_with_max_heading_of_one) {
    <<~EOF
    <ul>
      <li>
        <a href="#apples">Apples</a>
      </li>
      <li>
        <a href="#oranges">Oranges</a>
      </li>
    </ul>
    EOF
  }

  context 'without a max_level' do
    it 'returns a nested list of links to all headings in the tree' do
      html = described_class.new(tree).html
      expect(html).to eq(expected_html_with_all_headings)
    end
  end

  context 'with a max_level of 1' do
    it 'returns a nested list of links to top-level headings only' do
      html = described_class.new(tree, max_level: 1).html
      expect(html).to eq(expected_html_with_max_heading_of_one)
    end
  end
end
