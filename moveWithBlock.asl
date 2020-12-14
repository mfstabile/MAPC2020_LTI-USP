+!carryBlock(X,Y) : step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",100,Arg);!carryBlock(X,Y).

+!carryBlock(X,Y) : step(_,TIME) & position(X,Y,TIME) <- true.//arrived
+!carryBlock(X,Y) : step(_,TIME) & position(_,Y,TIME) <- !moveHorizontalWithBlock(X,Y);!carryBlock(X,Y).
+!carryBlock(X,Y) : step(_,TIME) & position(_,_,TIME) <- !moveVerticalWithBlock(X,Y);!carryBlock(X,Y).

+!moveVerticalWithBlock(X,Y) : step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",100,Arg);!moveVerticalWithBlock(X,Y).
+!moveVerticalWithBlock(X,Y) : step(_,TIME) & position(_,Y,TIME) <- true.

+!moveVerticalWithBlock(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM > Y & not blocked(n) & not blockBlocked(n) <- !performAction(move(n));!moveVerticalWithBlock(X,Y).
+!moveVerticalWithBlock(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM > Y & blocked(n) <- !dodgeWithBlock(X,Y,e);!moveVerticalWithBlock(X,Y).
+!moveVerticalWithBlock(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM > Y & not blocked(n) & blockBlocked(n)<- !unblockBlock(n);!moveVerticalWithBlock(X,Y).

+!moveVerticalWithBlock(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM < Y & not blocked(s) & not blockBlocked(s) <- !performAction(move(s));!moveVerticalWithBlock(X,Y).
+!moveVerticalWithBlock(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM < Y & blocked(s) <- !dodgeWithBlock(X,Y,w);!moveVerticalWithBlock(X,Y).
+!moveVerticalWithBlock(X,Y) : step(_,TIME) & position(_,YM,TIME) & YM < Y & not blocked(s) & blockBlocked(s) <- !unblockBlock(s);!moveVerticalWithBlock(X,Y).

+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & not position(_,_,TIME) <- .wait("+position(_,_,TIME)",100,Arg);!moveHorizontalWithBlock(X,Y).
+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & position(X,_,TIME) <- !carryBlock(X,Y).

+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM > X & not blocked(w) & not blockBlocked(w) <- !performAction(move(w));!moveHorizontalWithBlock(X,Y).
+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM > X & blocked(w) <- !dodgeWithBlock(X,Y,s);!moveHorizontalWithBlock(X,Y).
+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM > X & not blocked(w) & blockBlocked(w) <- !unblockBlock(w);!moveHorizontalWithBlock(X,Y).

+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM < X & not blocked(e) & not blockBlocked(e) <- !performAction(move(e));!moveHorizontalWithBlock(X,Y).
+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM < X & blocked(e) <- !dodgeWithBlock(X,Y,n);!moveHorizontalWithBlock(X,Y).
+!moveHorizontalWithBlock(X,Y) : step(_,TIME) & position(XM,_,TIME) & XM < X & not blocked(e) & blockBlocked(e) <- !unblockBlock(e);!moveHorizontalWithBlock(X,Y).

+!dodgeWithBlock(X,Y,Direction) : step(_,TIME) & not position(A,B,TIME) <- .wait("+position(_,_,TIME)",100,Arg); !dodgeWithBlock(X,Y,Direction).
+!dodgeWithBlock(X,Y,_) : step(_,TIME) & position(X,Y,TIME) <- true.
+!dodgeWithBlock(X,Y,s) : step(_,TIME) & position(A,B,TIME) & not blocked(s) & not blockBlocked(s) <- !performAction(move(s)).
+!dodgeWithBlock(X,Y,n) : step(_,TIME) & position(A,B,TIME) & not blocked(n) & not blockBlocked(n) <- !performAction(move(n)).
+!dodgeWithBlock(X,Y,w) : step(_,TIME) & position(A,B,TIME) & not blocked(w) & not blockBlocked(w) <- !performAction(move(w)).
+!dodgeWithBlock(X,Y,e) : step(_,TIME) & position(A,B,TIME) & not blocked(e) & not blockBlocked(e) <- !performAction(move(e)).

+!dodgeWithBlock(X,Y,s) : step(_,TIME) & position(A,B,TIME) & blocked(s) <- !dodgeWithBlock(X,Y,w);!dodgeWithBlock(X,Y,s).
+!dodgeWithBlock(X,Y,n) : step(_,TIME) & position(A,B,TIME) & blocked(n) <- !dodgeWithBlock(X,Y,e);!dodgeWithBlock(X,Y,n).
+!dodgeWithBlock(X,Y,w) : step(_,TIME) & position(A,B,TIME) & blocked(w) <- !dodgeWithBlock(X,Y,n);!dodgeWithBlock(X,Y,w).
+!dodgeWithBlock(X,Y,e) : step(_,TIME) & position(A,B,TIME) & blocked(e) <- !dodgeWithBlock(X,Y,s);!dodgeWithBlock(X,Y,e).

+!dodgeWithBlock(X,Y,s) : step(_,TIME) & position(A,B,TIME) & not blocked(s) & blockBlocked(s) <- !unblockBlock(s);!performAction(move(s)).
+!dodgeWithBlock(X,Y,n) : step(_,TIME) & position(A,B,TIME) & not blocked(n) & blockBlocked(n) <- !unblockBlock(n);!performAction(move(n)).
+!dodgeWithBlock(X,Y,w) : step(_,TIME) & position(A,B,TIME) & not blocked(w) & blockBlocked(w) <- !unblockBlock(w);!performAction(move(w)).
+!dodgeWithBlock(X,Y,e) : step(_,TIME) & position(A,B,TIME) & not blocked(e) & blockBlocked(e) <- !unblockBlock(e);!performAction(move(e)).
