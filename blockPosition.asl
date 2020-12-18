///////////////////////////////////////////////////////////////////////////
//block south
+!setupBlock(s) : carrying(0,1,_) <- true.
//block north
+!setupBlock(s) : carrying(0,-1,_) & not blocked(e)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(1,0,_);
    !setupBlock(s).
+!setupBlock(s) : carrying(0,-1,_) & not blocked(w)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(-1,0,_);
    !setupBlock(s).

+!setupBlock(s) : carrying(0,-1,_) & not blockBlocked(n) <- !performAction(move(n));!setupBlock(s);!performAction(move(s)).
+!setupBlock(s) : carrying(0,-1,_) & not blockBlocked(n) <- !performAction(move(n));!setupBlock(s);!performAction(move(s)).

+!setupBlock(s) : carrying(0,-1,_) & not blocked(s) <- !performAction(move(s));!setupBlock(s);!performAction(move(n)).

+!setupBlock(s) : carrying(0,-1,_) <- !performAction(skip);!setupBlock(s).
//block east
+!setupBlock(s) : carrying(1,0,_) & not blocked(s)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock(s).

+!setupBlock(s) : carrying(1,0,_) & not blocked(n) & not blockBlocked(n) <- !performAction(move(n));!setupBlock(s);!performAction(move(s)).

//block west
+!setupBlock(s) : carrying(-1,0,_) & not blocked(s)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock(s).

+!setupBlock(s) : carrying(-1,0,_) & not blocked(n) & not blockBlocked(n) <- !performAction(move(n));!setupBlock(s);!performAction(move(s)).
//fail recover

+!setupBlock(s) : not carrying(_,_,_) <- true.
-!setupBlock(s) <- !setupBlock(s).

///////////////////////////////////////////////////////////////////////////
//block north
+!setupBlock(n) : carrying(0,-1,_) <- true.

//block south
+!setupBlock(n) : carrying(0,1,_) & not blocked(e)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(1,0,_);
    !setupBlock(n).
+!setupBlock(n) : carrying(0,1,_) & not blocked(w)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(-1,0,_);
    !setupBlock(n).

+!setupBlock(n) : carrying(0,1,_) & not blockBlocked(s) <- !performAction(move(s));!setupBlock(n);!performAction(move(n)).
+!setupBlock(n) : carrying(0,1,_) & not blockBlocked(s) <- !performAction(move(s));!setupBlock(n);!performAction(move(n)).

+!setupBlock(n) : carrying(0,1,_) & not blocked(n) <- !performAction(move(n));!setupBlock(n);!performAction(move(s)).

+!setupBlock(n) : carrying(0,1,_) <- !performAction(skip);!setupBlock(n).
//block east
+!setupBlock(n) : carrying(1,0,_) & not blocked(n)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,-1,_);
    !setupBlock(n).

+!setupBlock(n) : carrying(1,0,_) & not blocked(s) & not blockBlocked(s) <- !performAction(move(s));!setupBlock(n);!performAction(move(n)).

//block west
+!setupBlock(n) : carrying(-1,0,_) & not blocked(n)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,-1,_);
    !setupBlock(n).

+!setupBlock(n) : carrying(-1,0,_) & not blocked(s) & not blockBlocked(s) <- !performAction(move(s));!setupBlock(n);!performAction(move(n)).
//fail recover

+!setupBlock(n) : not carrying(_,_,_) <- true.
-!setupBlock(n) <- !setupBlock(n).

///////////////////////////////////////////////////////////////////////////
//block east
+!setupBlock(e) : carrying(1,0,_) <- true.

//block west
+!setupBlock(e) : carrying(-1,0,_) & not blocked(s)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock(e).
+!setupBlock(e) : carrying(-1,0,_) & not blocked(n)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,-1,_);
    !setupBlock(e).

+!setupBlock(e) : carrying(-1,0,_) & not blockBlocked(w) <- !performAction(move(w));!setupBlock(e);!performAction(move(e)).
+!setupBlock(e) : carrying(-1,0,_) & not blockBlocked(w) <- !performAction(move(w));!setupBlock(e);!performAction(move(e)).

+!setupBlock(e) : carrying(-1,0,_) & not blocked(e) <- !performAction(move(e));!setupBlock(e);!performAction(move(w)).

+!setupBlock(e) : carrying(-1,0,_) <- !performAction(skip);!setupBlock(e).
//block north
+!setupBlock(e) : carrying(0,-1,_) & not blocked(e)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(1,0,_);
    !setupBlock(e).

+!setupBlock(e) : carrying(0,-1,_) & not blocked(w) & not blockBlocked(w) <- !performAction(move(w));!setupBlock(e);!performAction(move(e)).

//block south
+!setupBlock(e) : carrying(0,1,_) & not blocked(e)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(1,0,_);
    !setupBlock(e).

+!setupBlock(e) : carrying(0,1,_) & not blocked(w) & not blockBlocked(w) <- !performAction(move(w));!setupBlock(e);!performAction(move(e)).
//fail recover

+!setupBlock(e) : not carrying(_,_,_) <- true.
-!setupBlock(e) <- !setupBlock(e).

///////////////////////////////////////////////////////////////////////////
//block west
+!setupBlock(w) : carrying(-1,0,_) <- true.

//block east
+!setupBlock(w) : carrying(1,0,_) & not blocked(s)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock(w).
+!setupBlock(w) : carrying(1,0,_) & not blocked(n)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,-1,_);
    !setupBlock(w).

+!setupBlock(w) : carrying(1,0,_) & not blockBlocked(e) <- !performAction(move(e));!setupBlock(w);!performAction(move(w)).
+!setupBlock(w) : carrying(1,0,_) & not blockBlocked(e) <- !performAction(move(e));!setupBlock(w);!performAction(move(w)).

+!setupBlock(w) : carrying(1,0,_) & not blocked(w) <- !performAction(move(w));!setupBlock(w);!performAction(move(e)).

+!setupBlock(w) : carrying(1,0,_) <- !performAction(skip);!setupBlock(w).
//block north
+!setupBlock(w) : carrying(0,-1,_) & not blocked(w)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(-1,0,_);
    !setupBlock(w).

+!setupBlock(w) : carrying(0,-1,_) & not blocked(e) & not blockBlocked(e) <- !performAction(move(e));!setupBlock(w);!performAction(move(w)).

//block south
+!setupBlock(w) : carrying(0,1,_) & not blocked(w)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(-1,0,_);
    !setupBlock(w).

+!setupBlock(w) : carrying(0,1,_) & not blocked(e) & not blockBlocked(e) <- !performAction(move(e));!setupBlock(w);!performAction(move(w)).
//fail recover

+!setupBlock(w) : not carrying(_,_,_) <- true.
-!setupBlock(w) <- !setupBlock(w).

///////////////////////////////////////////////////////////////////////////
