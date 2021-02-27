class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  
  @@all = []
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @@all << self
  end

  def valid?
    sender.valid? && receiver.valid? && sender.balance > @amount
  end

  def execute_transaction
    if valid? && status == "pending" 
      receiver.balance += amount
      sender.balance -= amount
      @status = "complete"   
    else   
      @status = "rejected"
      "Transaction rejected. Please check your account balance."  
    end
  end

  def reverse_transfer
    if valid? && status == "complete" 
      receiver.balance -= amount
      sender.balance += amount
      @status = "reversed"
    end
  end

end
