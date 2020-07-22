#declare some variables

beneficiary : public(address)
auctionStart : public(timestamp)
auctionend: public(timestamp)

#declare and get highest bidder and bid by him
highestBidder : public(address)
highestBid : public(wei_value)

#check whether auction is ended
ended: public(bool)

#map address to ether sent and return ether back to addresses
pendingReturns: public(map(address,wei_value))

#constructor
@public
def __init__(_benificiary : address, _bidding_time: timedelta):
    self.beneficiary = _benificiary
    self.auctionStart = block.timestamp
    self.auctionend = self.auctionStart + _bidding_time
    
@public
@payable
def __default__():
    assert block.timestamp < self.auctionend
    assert msg.value > self.highestBid
    if(self.highestBidder !=ZERO_ADDRESS):
        self.pendingReturns[self.highestBidder] += self.highestBid
    self.highestBidder = msg.sender
    self.highestBid = msg.value
    
@public
def withdraw():
    pending_amount : wei_value =self.pendingReturns[msg.sender]
    self.pendingReturns[msg.sender] = 0
    send(msg.sender, pending_amount)
    
@public
def endAuction():
    assert not self.ended
    self.ended = True
    send(self.beneficiary,self.highestBid)
        
    
    
    
    

    



    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    