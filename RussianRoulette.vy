players: DynArray[address, 100]
losers: DynArray[address, 100]
odds: public(uint256)
playersTurn: public(uint256)
creator: public(address)
numPlayers: public(uint256)

@external
def __init__ ():
    self.players = []
    self.losers = []
    self.odds = 100
    self.playersTurn = 0
    self.creator = msg.sender
    self.numPlayers = 0

@external
def setOdds (chances: uint256):
    if (msg.sender == self.creator):
        self.odds = chances

@internal
def contains (array: DynArray[address, 100], player: address) -> bool:
    for i in array:
        if (array.pop() == player):
                return True
    return False

@external
def addPlayer (player: address):
    if not (self.contains(self.losers,player)):
        if not (self.contains(self.players, player)):
            self.players.append(player)
    self.numPlayers = self.numPlayers + 1

@internal
def lose (player: address):
    self.players = []
    self.numPlayers = 0
    self.losers.append(player)

@internal
def random () -> uint256:
    return (msg.sender.balance+self.creator.balance)%self.odds +1

@external
def isALoser (person: address) -> bool:
    return self.contains(self.losers,person)

@external
def play ():
    if (self.playersTurn >= self.numPlayers):
        self.playersTurn = 0
    if (self.random () == 1):
        self.lose(self.players[self.playersTurn])
    else:
        self.playersTurn = self.playersTurn + 1



    
