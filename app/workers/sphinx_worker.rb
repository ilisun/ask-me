class SphinxWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(10) }

  def perform
    system 'rake ts:index'
  end
end