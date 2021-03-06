class DailyDigestWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily(1) }

  def perform
    User.find_each.each do |user|
      DailyMailer.digest(user)
    end
  end
end