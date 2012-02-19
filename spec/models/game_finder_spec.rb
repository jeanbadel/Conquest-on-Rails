require "spec_helper"

describe GameFinder do
  let(:available_games) { [] }
  let(:some_user)       { User.new }
  let(:finder)          { GameFinder.new(some_user, available_games) }
  let(:search)          { finder.search }

  it "should have a user" do
    finder.user.should be_a(User)
  end

  it "should have a collection of available games" do
    finder.available_games.should respond_to(:each)
  end


  context "when no game is available" do
    let(:available_games) { [] }

    it "no game should be available for the user" do
      finder.available_games_for_user.should be_empty
    end

    it "no game should be found" do
      finder.search.should be_nil
    end

    it "a brand new game should be created" do
      finder.find.should be_a(Game)
    end
  end


  context "when some games are available" do
    let(:another_user)      { stub }
    let(:yet_another_user)  { stub }
    let(:game_without_user) { stub(users: [ another_user, yet_another_user ]) }
    let(:game_with_user)    { stub(users: [ some_user, another_user ]) }

    context "and the user is already in one of these games" do
      let(:available_games) { [ game_with_user, game_without_user ] }

      describe "available game for user" do
        it "should not include the user" do
          finder.available_games_for_user.should_not include(game_with_user)
        end

        it "should only contain the game without the user" do
          finder.available_games_for_user.should == [ game_without_user ]
        end
      end

      describe "found game" do
        it "should be the game without the user" do
          finder.search.should == game_without_user
        end
      end
    end

    context "and the user is not in any game" do
      let(:available_games) { [ game_without_user ] }

      it "all the games should be available for the user" do
        finder.available_games_for_user.should == available_games
      end
    end
  end
end
