require 'test_helper'

class ImportedTextsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @imported_text = imported_texts(:one)
  end

  test "should get index" do
    get imported_texts_url
    assert_response :success
  end

  test "should get new" do
    get new_imported_text_url
    assert_response :success
  end

  test "should create imported_text" do
    assert_difference('ImportedText.count') do
      post imported_texts_url, params: { imported_text: { content: @imported_text.content, title: @imported_text.title } }
    end

    assert_redirected_to imported_text_url(ImportedText.last)
  end

  test "should show imported_text" do
    get imported_text_url(@imported_text)
    assert_response :success
  end

  test "should get edit" do
    get edit_imported_text_url(@imported_text)
    assert_response :success
  end

  test "should update imported_text" do
    patch imported_text_url(@imported_text), params: { imported_text: { content: @imported_text.content, title: @imported_text.title } }
    assert_redirected_to imported_text_url(@imported_text)
  end

  test "should destroy imported_text" do
    assert_difference('ImportedText.count', -1) do
      delete imported_text_url(@imported_text)
    end

    assert_redirected_to imported_texts_url
  end
end
