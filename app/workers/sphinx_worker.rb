class SphinxWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(5) }

  def perform
    system 'rake ts:index'
  end
end