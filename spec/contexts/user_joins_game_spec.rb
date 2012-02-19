require 'spec_helper'

describe UserJoinsGame do
  let(:user) { FactoryGirl.create(:user) }
  let(:game) { FactoryGirl.create(:game) }
  subject { UserJoinsGame.new(user, game) }

  it "should have a user" do
    subject.user.should be_a(User)
  end

  it "should have a game" do
    subject.game.should be_a(Game)
  end


  describe "The user joins the game" do
    context "when the game is full" do
      before { game.stub(:full?).and_return(:true) }

      it "should fail" do
        expect { subject.process }.to raise_error(UserJoinsGame::GameIsFullError)
      end
    end


    context "when the game is running" do
      before { game.stub(:state).and_return(Game::RUNNING) }

      it "should fail" do
        expect { subject.process }.to raise_error(UserJoinsGame::GameIsRunning)
      end
    end


    it "should add the user to the users of the game" do
      subject.process
      subject.game.users.should include(user)
    end
  end
end
