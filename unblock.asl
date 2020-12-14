///////////////////////////////Block is west from agent////////////////////////////////////////////
+!unblockBlock(s) : not blocked(n) & carrying(-1,0,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,-1,Time).

+!unblockBlock(s) : not blocked(s) & carrying(-1,0,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,1,Time).

+!unblockBlock(n) : not blocked(s) & carrying(-1,0,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,1,Time).

+!unblockBlock(n) : not blocked(n) & carrying(-1,0,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,-1,Time).

+!unblockBlock(w) : not blocked(s) & carrying(-1,0,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,1,Time).

+!unblockBlock(w) : not blocked(n) & carrying(-1,0,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,-1,Time).

///////////////////////////////Block is east from agent////////////////////////////////////////////
+!unblockBlock(s) : not blocked(n) & carrying(1,0,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,-1,Time).

+!unblockBlock(s) : not blocked(s) & carrying(1,0,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,1,Time).

+!unblockBlock(n) : not blocked(s) & carrying(1,0,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,1,Time).

+!unblockBlock(n) : not blocked(n) & carrying(1,0,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,-1,Time).

+!unblockBlock(e) : not blocked(s) & carrying(1,0,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,1,Time).

+!unblockBlock(e) : not blocked(n) & carrying(1,0,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(0,-1,Time).

///////////////////////////////Block is south from agent////////////////////////////////////////////
+!unblockBlock(s) : not blocked(e) & carrying(0,1,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(1,0,Time).

+!unblockBlock(s) : not blocked(w) & carrying(0,1,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(-1,0,Time).

+!unblockBlock(e) : not blocked(w) & carrying(0,1,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(-1,0,Time).

+!unblockBlock(e) : not blocked(e) & carrying(0,1,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(1,0,Time).

+!unblockBlock(w) : not blocked(e) & carrying(0,1,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(1,0,Time).

+!unblockBlock(w) : not blocked(w) & carrying(0,1,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(-1,0,Time).

///////////////////////////////Block is north from agent////////////////////////////////////////////
+!unblockBlock(n) : not blocked(e) & carrying(0,-1,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(1,0,Time).

+!unblockBlock(n) : not blocked(w) & carrying(0,-1,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(-1,0,Time).

+!unblockBlock(e) : not blocked(w) & carrying(0,-1,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(-1,0,Time).

+!unblockBlock(e) : not blocked(e) & carrying(0,-1,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(1,0,Time).

+!unblockBlock(w) : not blocked(e) & carrying(0,-1,_)
<-  !performAction(rotate(cw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(1,0,Time).

+!unblockBlock(w) : not blocked(w) & carrying(0,-1,_)
<-  !performAction(rotate(ccw));
    ?step(_,Time);
    if(not carrying(_,_,Time)){
      .wait("+carrying(_,_,Time)");
    }
    ?carrying(-1,0,Time).

+!unblockBlock(w) <- !dodge(n).
+!unblockBlock(e) <- !dodge(s).
+!unblockBlock(n) <- !dodge(e).
+!unblockBlock(s) <- !dodge(w).

-!unblockBlock(Direction)<- !unblockBlock(Direction).
