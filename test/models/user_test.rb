# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User Not to Create without confirmation' do
    user = User.new
    assert_not user.save, 'Should not save user without confirmtaion'
  end

  test 'User cant save without name ' do
    user = User.new
    user.name = 'dxcfvgbhnjmkldxcjls,ddsfhsdfjhlsdjfhsldfjhsldjfhsldjfhlsdfjfvgbhjnkml;vbnmklfffgfhrjrmngrfnfrrrhnhgfdfghjhgfdsa'

    user.confirm
    assert user.save, 'Should not save user without name'
  end
end
