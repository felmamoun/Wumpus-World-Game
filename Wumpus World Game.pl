:- dynamic ([breeze/1,
             stench/1,
             wumpusLocation/1,
             pitLocation/1,
             goldLocation/1,
             agentLocation/1]).

isAdjacent([X,Y],Loc) :- (X<4)->  Xright is X+1, Loc=[Xright,Y].
isAdjacent([X,Y],Loc) :- (X>1)->  Xleft is X-1, Loc=[Xleft,Y].
isAdjacent([X,Y],Loc) :- (Y<4)->  Ytop is Y+1, Loc=[X,Ytop].
isAdjacent([X,Y],Loc) :- (Y>1)->  Ybottom is Y-1, Loc=[X,Ybottom].


breeze([X,Y]) :- (pitLocation(PitLoc),isAdjacent([X,Y],PitLoc))->  
    format('Breeze in ~p~n',[[X,Y]]); 
    format('No Breeze in ~p~n',[[X,Y]]).


pit([X,Y]) :- forall(isAdjacent([X,Y],Loc), (breeze(Loc))), (pitLocation([X,Y]))-> 
    		format('Pit found.').


stench([X,Y]) :- (wumpusLocation(Loc),isAdjacent([X,Y],Loc))->  
    format('Stench in ~p~n',[[X,Y]]); 
    format('No Stench in ~p~n',[[X,Y]]).


Wumpus([X,Y]) :- forall(isAdjacent([X,Y],Loc), stench(Loc)),wumpusLocation([X,Y]).


Safe([X,Y]):- \+ pitLocation([X,Y]), \+ wumpusLocation([X,Y]).


grabGold():- write('Gold grabbed.').


Gold([X,Y]):- (goldLocation([X,Y]))->  
    format('Gold found'); 
    format('No Gold found').


shootWumpus([X,Y]):- (pitLocation([X,Y]))->
    format('Agent fell in the pit');
    format('Shot missed.');
 
    (wumpusLocation(Loc), isAdjacent([X,Y],Loc))
    -> 	format('Wumpus killed in ~p~n',[Loc]); 
    (wumpusLocation([X,Y]))
    ->  format('Wumpus killed you.');
    	format('No Wumpus found.').


start:-
    init,
    assert(agentLocation([1,1])).

init:-
      
	% First Scenario
    %retractall(goldLocation(_)),
    %assert(goldLocation([3,3])),
    %retractall(wumpusLocation(_)),
    %assert(wumpusLocation([2,4])),
    %retractall(pitLocation(_)),
    %assert(pitLocation([2,1])),
    %assert(pitLocation([4,3])),
    %retractall(agentLocation(_)).

    
    % Second Scenario
    %retractall(goldLocation(_)),
    %assert(goldLocation([4,3])),
    %retractall(wumpusLocation(_)),
    %assert(wumpuslocation([2,4])),
    %retractall(pitlocation(_)),
    %assert(pitlocation([2,1])),
    %assert(pitlocation([4,1])),
    %assert(pitLocation([3,3])),
    %assert(pitLocation([2,3])),
    %retractall(agentLocation(_)).

    
    % Third Scenario
    retractall(goldLocation(_)),
    assert(goldLocation([2,1])),
    retractall(wumpusLocation(_)),
    assert(wumpusLocation([1,3])),
    retractall(pitLocation(_)),
    assert(pitLocation([4,3])),
    assert(pitLocation([1,2])),
    assert(pitLocation([4,1])),
    retractall(agentLocation(_)).