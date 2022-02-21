function draw_cuboid(X,Y,Z,xl,yl,zl)

hold on;
plot3([X,X+xl],[Y,Y],[Z,Z],'g');
plot3([X,X],[Y,Y+yl],[Z,Z],'g');
plot3([X,X],[Y,Y],[Z,Z+zl],'g');
plot3([X+xl,X+xl],[Y,Y+yl],[Z,Z],'g');
plot3([X+xl,X+xl],[Y,Y],[Z,Z+1],'g');
plot3([X,X+xl],[Y+yl,Y+yl],[Z,Z],'g');
plot3([X,X],[Y+yl,Y+yl],[Z,Z+zl],'g');
plot3([X,X+xl],[Y,Y],[Z+zl,Z+zl],'g');
plot3([X,X],[Y,Y+yl],[Z+zl,Z+zl],'g');
plot3([X+xl,X+xl],[Y+yl,Y+yl],[Z,Z+zl],'g');
plot3([X+xl,X+xl],[Y,Y+yl],[Z+zl,Z+zl],'g');
plot3([X,X+xl],[Y+yl,Y+yl],[Z+zl,Z+zl],'g');

hold off;
end

