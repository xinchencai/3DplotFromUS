function correctCallback(source,eventdata)
  % determine the key that was pressed
  keyPressed = eventdata.Key;
  global myStruct;
  global myTime;
  global myUS;
  global checker;
  
  % end loop on key press
  if strcmpi(keyPressed,'space')
      if checker <= length(myStruct)
          checker = checker + 1;
          hold on;
          image('CData',myStruct(checker).myus,'XData',[0 1],'YData',[0 1]);
          plot(myUS(checker).myus(:,1),myUS(checker).myus(:,2),'.');
          hold off;
      end
  elseif strcmpi(keyPressed,'backspace')
      if checker >= 1
          checker = checker - 1;
          hold on;
          image('CData',myStruct(checker).myus,'XData',[0 1],'YData',[0 1]);
          plot(myUS(checker).myus(:,1),myUS(checker).myus(:,2),'.');
          hold off;
      end
  elseif strcmpi(keyPressed,'a')
      myStruct(checker)=[];
      myTime(checker)=[];
      hold on;
      image('CData',myStruct(checker).myus,'XData',[0 1],'YData',[0 1]);
      plot(myUS(checker).myus(:,1),myUS(checker).myus(:,2),'.');
      hold off;
  elseif strcmpi(keyPressed,'b')
      for i = 0:length(myStruct)-checker
        myStruct(checker)=[];
        myTime(checker)=[];
      end
      checker = checker - 1;
      hold on;
      image('CData',myStruct(checker).myus,'XData',[0 1],'YData',[0 1]);
      plot(myUS(checker).myus(:,1),myUS(checker).myus(:,2),'.');
      hold off;
  elseif strcmpi(keyPressed,'c')
      [line,x,y]=freehanddraw;
      z = ones(length(x),1)*myUS(checker).myus(1,3);
      myUS(checker).myus = [x,y,z];
      hold on;
      image('CData',myStruct(checker).myus,'XData',[0 1],'YData',[0 1]);
      plot(myUS(checker).myus(:,1),myUS(checker).myus(:,2),'.');
      hold off;
  elseif strcmpi(keyPressed,'d')
      uiresume;
      close;
  end
end