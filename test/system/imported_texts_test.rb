require "application_system_test_case"

class ImportedTextsTest < ApplicationSystemTestCase
  setup do
    @imported_text = imported_texts(:one)
  end

  test "visiting the index" do
    visit imported_texts_url
    assert_selector "h1", text: "Imported Texts"
  end

  test "creating a Imported text" do
    visit imported_texts_url
    click_on "New Imported Text"

    fill_in "Content", with: @imported_text.content
    fill_in "Title", with: @imported_text.title
    click_on "Create Imported text"

    assert_text "Imported text was successfully created"
    click_on "Back"
  end

  test "updating a Imported text" do
    visit imported_texts_url
    click_on "Edit", match: :first

    fill_in "Content", with: @imported_text.content
    fill_in "Title", with: @imported_text.title
    click_on "Update Imported text"

    assert_text "Imported text was successfully updated"
    click_on "Back"
  end

  test "destroying a Imported text" do
    visit imported_texts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Imported text was successfully destroyed"
  end
end
