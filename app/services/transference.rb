class Transference
    attr_reader :value, :recipient, :sender
  
    def initialize(value:, recipient:, sender:)
      @value = value
      @recipient = recipient
      @sender = sender
    end
  
    def call?
      ActiveRecord::Base.transaction do
        begin
          remove_from_sender
          add_to_recipient
          Transfer.create!(
            value: @value,
            recipient: @recipient,
            sender: @sender,
            kind: Transfer.kinds[:transference],
          )
        rescue ActiveRecord::RecordInvalid
          raise ActiveRecord::Rollback
        end
      end
    end
  
    private
  
    def remove_from_sender
      @sender.update!(balance: new_balance_sender)
    end
  
    def add_to_recipient
      @recipient.update!(balance: new_balance_recipient)
    end
  
    def new_balance_sender
      @sender.balance - (@value + transfer_fee_calculation + transference_over_thousand)
    end
  
    def new_balance_recipient
      @recipient.balance + @value
    end

    def transference_over_thousand
      @value > 1000 ? 10 : 0
    end
    
    def its_weekend?
      time = Time.now.strftime("%H%M")
      day = Time.now.strftime("%u")
  
      day.between?(6, 7) || !time.between?("0900", "1800")
    end

    def transfer_fee_calculation
      its_weekend? ? 7 : 5
    end
  end