shared_examples_for "Creating Reputationable" do
  it 'should increase reputation for user' do
    expect{rep.increase}.to change{user.reload.reputation}.by(value)
  end

  it 'save reputation in database' do
    expect{rep.increase}.to change(Reputation, :count).by(1)
  end
end

shared_examples_for "Change Reputationable" do
  it 'should to call method increase' do
    reputation = double(Reputation.new)
    allow(Reputation).to receive(:new).and_return(reputation)
    expect(reputation).to receive(:increase)
    subject.save!
  end

  it 'should to create new reputation in database' do
    expect{subject.save!}.to change(Reputation, :count).by(1)
  end

  it 'should to increase reputation' do
    expect{subject.save!}.to change{load_user(subject).reputation}.by(value)
  end
end

def load_user(subject)
  subject.is_a?(Vote) ? subject.votable.user.reload : subject.user.reload
end