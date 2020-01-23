function drawBlock

%% DRAW TISSUE
TISSUE_ORIGIN=CONFIG('TISSUE_ORIGIN');
TISSUE_SIZE=CONFIG('TISSUE_SIZE');
x=TISSUE_ORIGIN(1); y=TISSUE_ORIGIN(2); z=TISSUE_ORIGIN(3); 
lx=TISSUE_SIZE(1); ly=TISSUE_SIZE(2); lz=TISSUE_SIZE(3);
vertices=[x+0  y+0  z+0; x+lx y+0  z+0;...
          x+lx y+ly z+0; x+0  y+ly z+0;...
          x+0  y+0  z+lz;x+lx y+0  z+lz;...
          x+lx y+ly z+lz;x+0  y+ly z+lz];
faces=[1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
for i = 1 : 6
    h = patch(vertices(faces(i,:),1),vertices(faces(i,:),2),vertices(faces(i,:),3),'y');
    set(h,'facealpha',0.2);
end

%% DRAW OBSTACLE
for i=1:CONFIG('OBS_NUM')
    drawObstacle(['OBSTACLE' num2str(i)]);
end

    function drawObstacle(param)
        OBSTACLE_ORIGIN=CONFIG([param '_ORIGIN']);
        OBSTACLE_SIZE=CONFIG([param '_SIZE']);
        x=OBSTACLE_ORIGIN(1); y=OBSTACLE_ORIGIN(2); z=OBSTACLE_ORIGIN(3); 
        lx=OBSTACLE_SIZE(1); ly=OBSTACLE_SIZE(2); lz=OBSTACLE_SIZE(3);
        vertices=[x+0  y+0  z+0; x+lx y+0  z+0;...
                  x+lx y+ly z+0; x+0  y+ly z+0;...
                  x+0  y+0  z+lz;x+lx y+0  z+lz;...
                  x+lx y+ly z+lz;x+0  y+ly z+lz];
        faces=[1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
        for i = 1 : 6
            h = patch(vertices(faces(i,:),1),vertices(faces(i,:),2),vertices(faces(i,:),3),'r');
            set(h,'FaceAlpha',0.1);
            set(h,'EdgeColor','r');
            set(h,'EdgeAlpha',0.1);
        end
    end

axis equal
view(3);
end