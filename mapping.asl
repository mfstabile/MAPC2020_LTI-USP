////////////////////////////////DETECTING AGENTS///////////////////////////////////////////
+thing(XEntity,YEntity,entity,Team,Time) :
  thing(0,0,entity,Team,Time) &
  position(XAg,YAg,Time) &
  .count(allAgentsMapped(_), MappedAgents) &
  .count(.all_names(AllAgents),AgentAmount) &
  MappedAgents<AgentAmount &
  step(Step,Time)
<-  +entity(XEntity,YEntity,XAg,YAg,Step);
    .my_name(MyName);
    .broadcast(tell,entityMessage(MyName,XEntity,YEntity,XAg,YAg,Step)).

+thing(XEntity,YEntity,entity,Team,Time) :
  thing(0,0,entity,Team,Time) &
  not position(XAg,YAg,Time) &
  .count(allAgentsMapped(_), MappedAgents) &
  .count(.all_names(AllAgents),AgentAmount) &
  MappedAgents<AgentAmount &
  step(Step,Time)
<-  .wait("+position(XAg,YAg,Time)");
    +entity(XEntity,YEntity,XAg,YAg,Step);
    .my_name(MyName);
    .broadcast(tell,entityMessage(MyName,XEntity,YEntity,XAg,YAg,Step)).

////////////////////////////////IDENTIFYING AGENTS///////////////////////////////////////////
+step(Step,Time)
<-  if(Step \== 0){
      ?lastActionResult(ActionStatus,Time);
      ?lastAction(ActionType,Time);
      ?lastActionParams(ActionParams,Time);
      if(not .setof(T,carrying(_,_,T),[])){
          .print("checkObstacle")
          !checkObstacle(Time);
      }
      !updateBlock(ActionStatus,ActionType,ActionParams,Time);
      !updatePosition(ActionStatus,ActionType,ActionParams,Time);
    };
    for(entity(XEntity,YEntity,XAg,YAg,Step-2)){
        if(.count(entityMessage(_,-XEntity,-YEntity,_,_,Step-2),1)){
          ?entityMessage(Sender,-XEntity,-YEntity,XSender,YSender,Step-2);
          XMapper = XSender - (XAg + XEntity);
          YMapper = YSender - (YAg + YEntity);
          if(.count(mapper(Sender,_,_),0)){
            +mapper(Sender, XMapper, YMapper);

            .count(.all_names(AllAgents),AgentAmount);
            .count(mapper(AgentName, _, _), MappedAgents);
            if (AgentAmount-1 == MappedAgents){
              .my_name(MyName);
              +allAgentsMapped(MyName);
              .broadcast(tell,allAgentsMapped(MyName));
            }
            //Communicating dispensers
            for ( dispenser(XDispenser,YDispenser,DispType) ) {
      				.send(Sender,tell,dispenser(XDispenser+XMapper, YDispenser+YMapper, DispType));
      			};
            //Communicating Taskboard
            for ( taskboard(XTaskboard,YTaskboard) ) {
      				.send(Sender,tell,taskboard(XTaskboard+XMapper, YTaskboard+YMapper));
      			};
            //Communicating goal
            for ( goal(XGoal,YGoal) ) {
      				.send(Sender,tell,goal(XGoal+XMapper, YGoal+YMapper));
      			};
          }
          // else{
          //   ?mapper(Sender, XTemp, YTemp);
          //   if(XMapper \== XTemp | YMapper \== YTemp){
          //     .print("Mapping Error - ", Sender);
          //     .print("XMapper: ",XMapper, " XTemp: ", XTemp)
          //     .print("YMapper: ",YMapper, " YTemp: ", YTemp)
          // }
        }
    };
    .abolish(entity(_,_,_,_,Step-2));
    .abolish(entityMessage(_,_,_,_,_,Step-2));

    //Removing old positions
    .findall(TimePos,position(_,_,TimePos),TimeList);
    if(.length(TimeList,Size) & Size>2){
      .delete(0,2,TimeList,DeleteList);
      for (.member(Member,DeleteList)){
        .abolish(position(_,_,Member));
        .abolish(obstacle(_,_,Member));
      }
    }.
