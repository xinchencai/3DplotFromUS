function spaceCallback(source,eventdata,US)
  % determine the key that was pressed
  keyPressed = eventdata.Key;
  global checker;
  
  % end loop on key press
  if strcmpi(keyPressed,'space')
     checker = 1;
  end
  if strcmpi(keyPressed,'backspace')
     checker = 2;
  end
  if strcmpi(keyPressed,'a')
     checker = 3;
  end
  if strcmpi(keyPressed,'b')
      checker = 4;
  end
  if strcmpi(keyPressed,'c')
      checker = 5;
  end