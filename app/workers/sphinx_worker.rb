class SphinxWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(15) }

  def perform
    system 'rake ts:index'
  end
end