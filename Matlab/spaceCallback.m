function spaceCallback(source,eventdata)
  % determine the key that was pressed
  keyPressed = eventdata.Key;
  global myStruct;
  global myTime;
  global checker
  
  % end loop on key press
  if strcmpi(keyPressed,'space')
      if checker <= length(myStruct)
          checker = checker + 1;
          imshow(myStruct(checker).myus)
%           set(gcf,'WindowKeyPressFcn',@(hObject, event) spaceCallback(hObject, event, US));
      end
  elseif strcmpi(keyPressed,'backspace')
      if checker >= 1
          checker = checker - 1;
          imshow(myStruct(checker).myus) 
%           set(gcf,'WindowKeyPressFcn',@(hObject, event) spaceCallback(hObject, event, US));
      end
  elseif strcmpi(keyPressed,'a')
      myStruct(checker)=[];
      myTime(checker,:)=[];
      imshow(myStruct(checker).myus)
%       set(gcf,'WindowKeyPressFcn',@(hObject, event) spaceCallback(hObject, event, US));
  elseif strcmpi(keyPressed,'b')
      for i = 0:length(myStruct)-checker
        myStruct(checker)=[];
        myTime(checker,:)=[];
      end
      checker = checker - 1;
      imshow(myStruct(checker).myus)
%       set(gcf,'WindowKeyPressFcn',@(hObject, event) spaceCallback(hObject, event, US));
  elseif strcmpi(keyPressed,'c')
      uiresume;
      close;
  end
end