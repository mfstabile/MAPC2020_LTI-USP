+thing(0,0,entity,_,T) <- true.

+thing(X,Y,entity,TEAM,T) : not position(me,_,_,T) & team(TEAM) <- 
	.wait("+position(me,_,_,T)");
	?position(me,XM,YM,T);
	.my_name(M);
	?stepLog(Step,T);
	+entity(X,Y,Step);
	.broadcast(tell,acknowledge(M,X,Y,XM,YM,Step)).

+thing(X,Y,entity,TEAM,T) : position(me,XM,YM,T) & team(TEAM) <- 
	.my_name(M);
	?stepLog(Step,T);
	+entity(X,Y,Step);
	.broadcast(tell,acknowledge(M,X,Y,XM,YM,Step)).

+stepLog(STEP,_): stepLog(STEP-3,T) & acknowledge(_,_,_,_,_,STEP-3) & entity(_,_,STEP-3) <- 
TIME=STEP-3;
for ( entity(XE,YE,TIME) ) {
	.setof(acknowledge(M,-XE,-YE,XMg,YMg,TIME),acknowledge(M,-XE,-YE,XMg,YMg,TIME),Acks);
	if (.length(Acks,1)){
		.nth(0,Acks,acknowledge(M,_,_,XA,YA,TIME));
		if(.count(mapper(M,_,_),0)){
			?logposition(me,XM,YM,T);
			+mapper(M,XA-(XM+XE),YA-(YM+YE));
			X1 = XA-(XM+XE);
			Y1 = YA-(YM+YE);
			for ( thing(XD,YD,dispenser,B) ) {
				.send(M,tell,thing(XD+X1,YD+Y1,dispenser,B));
			}
			for ( thing(XT,YT,taskboard) ) {
				.send(M,tell,thing(XT+X1,YT+Y1,taskboard));
			}
			for ( goal(XG,YG) ) {
				.send(M,tell,goal(XG+X1,YG+Y1));
			}
		}else{
			?logposition(me,XM,YM,T);
			+mapper(M,XA-(XM+XE),YA-(YM+YE));
			X1 = XA-(XM+XE);
			Y1 = YA-(YM+YE);
			?mapper(M,XMap,YMap);
			if(X1\==XMap | Y1\==YMap){
				.print("mapping error on step ",T);
			}
		}
	}
};
-stepLog(STEP-3,T);
-logposition(me,_,_,T).

+stepLog(STEP,_): stepLog(STEP-3,T) <- -stepLog(STEP-3,T);
										-logposition(me,_,_,T).

