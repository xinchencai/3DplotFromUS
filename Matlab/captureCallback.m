function captureCallback(source,eventdata)
  % determine the key that was pressed
  keyPressed = eventdata.Key;
  
  % end loop on key press
  if strcmpi(keyPressed,'space')
      cont = false;
      close;
  end
end