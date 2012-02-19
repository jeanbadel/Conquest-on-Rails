require 'spec_helper'

describe UserJoinsGame do
  let(:user) { FactoryGirl.create(:user, name: "Foo") }
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
      let(:game) { stub_model(Game, full?: true) }

      it "should fail" do
        expect { subject.process }.to raise_error(UserJoinsGame::GameIsFullError)
      end
    end


    context "when the game is running" do
      let(:game) { stub_model(Game, state: Game::RUNNING) }

      it "should fail" do
        expect { subject.process }.to raise_error(UserJoinsGame::GameIsRunning)
      end
    end


    it "should add the user to the users of the game" do
      subject.process
      subject.game.users.should include(user)
    end


    describe "Added participation" do
      let(:game) { FactoryGirl.create(:game) }
      let(:participation) { subject.process }

      it "should have numeric position" do
        participation.position.should be_a(Numeric)
      end
    end
  end


  context "when two users that join the same game" do
    let(:another_user) { FactoryGirl.create(:user, name: "Bar") }

    it "the first participant's position should be lower that the second one" do
      participation       = UserJoinsGame.new(user, game).process
      other_participation = UserJoinsGame.new(another_user, game).process

      participation.position.should < other_participation.position
    end
  end


  context "when five users join a empty game" do
    let(:alpha) { FactoryGirl.create(:alpha) }
    let(:beta) { FactoryGirl.create(:beta) }
    let(:gamma) { FactoryGirl.create(:gamma) }
    let(:delta) { FactoryGirl.create(:delta) }
    let(:epsilon) { FactoryGirl.create(:epsilon) }

    it "should start the game" do
      game.should_receive(:start)

      [ alpha, beta, gamma, delta, epsilon ].each do |user|
        UserJoinsGame.new(user, game).process
      end
    end
  end
end
