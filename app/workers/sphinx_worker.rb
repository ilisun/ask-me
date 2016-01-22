class SphinxWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(1) }

  def perform
    system 'rake ts:index'
  end
end