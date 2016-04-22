require_relative 'journeylog'

class Oystercard
	MAX_BALANCE = 90
  MIN_FARE = 1
	attr_reader :balance, :journey_log

	def initialize
		@balance = 0
    @journey_log = JourneyLog.new
	end

	def top_up(amount)
		fail "Can't top up over £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
		@balance += amount
	end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MIN_FARE
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct_fare(@journey_log.fare)
  end

private

  def deduct_fare(fare)
    @balance -= fare
  end

end
