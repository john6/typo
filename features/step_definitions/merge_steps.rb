require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)



Given /^the following articles exist:$/ do |table|
  # table is a Cucumber::Ast::Table

  # | title | author | body          |
  # | art1  | John   | what a baller |
  # | art2  | Rafi   | hes a stud    |
  # | art3  | Daxi   | lol           |

  FactoryGirl.create(:article, :title => 'art1', :author => 'John', :body => 'what a baller')
  FactoryGirl.create(:article, :title => 'art2', :author => 'Rafi', :body => 'hes a stud')
  FactoryGirl.create(:article, :title => 'art3', :author => 'Daxi', :body => 'lol')
end

Given /^I am not an admin$/ do
  assert User.admin? == false
end

Given /^I on the Edit page for "(.*?)"$/ do |arg1|
  visit path_to(arg1)
end

Given /^I on the Show page for "(.*?)"$/ do |arg1|
  visit path_to(arg1)
end

Then /^I should not see 'Merge Articles'$/ do
    if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Given /^I have merged "(.*?)" and "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the author for "(.*?)" should be "(.*?)"$/ do |arg1, arg2|
  assert Article.find_by_title(arg1).author == arg2
end

Given /^"(.*?)" is a comment for "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the title for "(.*?)" should be "(.*?)"$/ do |arg1, arg2|
  assert Article.find_by_title(arg1).title == arg2
end
