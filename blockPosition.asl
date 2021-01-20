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

+!setupBlock(s) : carrying(0,-1,_) & not blockBlocked(n) <- !performMoveAction(n);!setupBlock(s);!performMoveAction(s).
+!setupBlock(s) : carrying(0,-1,_) & not blockBlocked(n) <- !performMoveAction(n);!setupBlock(s);!performMoveAction(s).

+!setupBlock(s) : carrying(0,-1,_) & not blocked(s) <- !performMoveAction(s);!setupBlock(s);!performMoveAction(n).

+!setupBlock(s) : carrying(0,-1,_) <- !performAction(skip);!setupBlock(s).
//block east
+!setupBlock(s) : carrying(1,0,_) & not blocked(s)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock(s).

+!setupBlock(s) : carrying(1,0,_) & not blocked(n) & not blockBlocked(n) <- !performMoveAction(n);!setupBlock(s);!performMoveAction(s).

//block west
+!setupBlock(s) : carrying(-1,0,_) & not blocked(s)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,1,_);
    !setupBlock(s).

+!setupBlock(s) : carrying(-1,0,_) & not blocked(n) & not blockBlocked(n) <- !performMoveAction(n);!setupBlock(s);!performMoveAction(s).
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

+!setupBlock(n) : carrying(0,1,_) & not blockBlocked(s) <- !performMoveAction(s);!setupBlock(n);!performMoveAction(n).
+!setupBlock(n) : carrying(0,1,_) & not blockBlocked(s) <- !performMoveAction(s);!setupBlock(n);!performMoveAction(n).

+!setupBlock(n) : carrying(0,1,_) & not blocked(n) <- !performMoveAction(n);!setupBlock(n);!performMoveAction(s).

+!setupBlock(n) : carrying(0,1,_) <- !performAction(skip);!setupBlock(n).
//block east
+!setupBlock(n) : carrying(1,0,_) & not blocked(n)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,-1,_);
    !setupBlock(n).

+!setupBlock(n) : carrying(1,0,_) & not blocked(s) & not blockBlocked(s) <- !performMoveAction(s);!setupBlock(n);!performMoveAction(n).

//block west
+!setupBlock(n) : carrying(-1,0,_) & not blocked(n)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(0,-1,_);
    !setupBlock(n).

+!setupBlock(n) : carrying(-1,0,_) & not blocked(s) & not blockBlocked(s) <- !performMoveAction(s);!setupBlock(n);!performMoveAction(n).
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

+!setupBlock(e) : carrying(-1,0,_) & not blockBlocked(w) <- !performMoveAction(w);!setupBlock(e);!performMoveAction(e).
+!setupBlock(e) : carrying(-1,0,_) & not blockBlocked(w) <- !performMoveAction(w);!setupBlock(e);!performMoveAction(e).

+!setupBlock(e) : carrying(-1,0,_) & not blocked(e) <- !performMoveAction(e);!setupBlock(e);!performMoveAction(w).

+!setupBlock(e) : carrying(-1,0,_) <- !performAction(skip);!setupBlock(e).
//block north
+!setupBlock(e) : carrying(0,-1,_) & not blocked(e)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(1,0,_);
    !setupBlock(e).

+!setupBlock(e) : carrying(0,-1,_) & not blocked(w) & not blockBlocked(w) <- !performMoveAction(w);!setupBlock(e);!performMoveAction(e).

//block south
+!setupBlock(e) : carrying(0,1,_) & not blocked(e)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(1,0,_);
    !setupBlock(e).

+!setupBlock(e) : carrying(0,1,_) & not blocked(w) & not blockBlocked(w) <- !performMoveAction(w);!setupBlock(e);!performMoveAction(e).
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

+!setupBlock(w) : carrying(1,0,_) & not blockBlocked(e) <- !performMoveAction(e);!setupBlock(w);!performMoveAction(w).
+!setupBlock(w) : carrying(1,0,_) & not blockBlocked(e) <- !performMoveAction(e);!setupBlock(w);!performMoveAction(w).

+!setupBlock(w) : carrying(1,0,_) & not blocked(w) <- !performMoveAction(w);!setupBlock(w);!performMoveAction(e).

+!setupBlock(w) : carrying(1,0,_) <- !performAction(skip);!setupBlock(w).
//block north
+!setupBlock(w) : carrying(0,-1,_) & not blocked(w)
<-  !performAction(rotate(ccw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(-1,0,_);
    !setupBlock(w).

+!setupBlock(w) : carrying(0,-1,_) & not blocked(e) & not blockBlocked(e) <- !performMoveAction(e);!setupBlock(w);!performMoveAction(w).

//block south
+!setupBlock(w) : carrying(0,1,_) & not blocked(w)
<-  !performAction(rotate(cw));
    .wait("+carrying(_,_,Time)",20);
    ?carrying(-1,0,_);
    !setupBlock(w).

+!setupBlock(w) : carrying(0,1,_) & not blocked(e) & not blockBlocked(e) <- !performMoveAction(e);!setupBlock(w);!performMoveAction(w).
//fail recover

+!setupBlock(w) : not carrying(_,_,_) <- true.
-!setupBlock(w) <- !setupBlock(w).

///////////////////////////////////////////////////////////////////////////
