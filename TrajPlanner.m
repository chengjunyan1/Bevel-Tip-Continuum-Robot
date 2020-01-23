function [Traj]=TrajPlanner()

tstart=CONFIG('TISSUE_ORIGIN');
tsize=CONFIG('TISSUE_SIZE');
tissue=[tstart tsize];
x_max = tstart(1)+tsize(1);
y_max = tstart(2)+tsize(2);
z_max = tstart(3)+tsize(3);

EPS = 20;
numNodes = 200;   

q_start.coord = CONFIG('CONTACT_POINT');
q_start.cost = 0;
q_start.parent = 0;
q_goal.coord = CONFIG('TARGET_POINT');
q_goal.cost = 0;
obstacle=readObs();
nodes(1) = q_start;

for i = 1:1:numNodes
    in=1;
    ni=1;
    while in||ni
        q_rand = [rand(1)*x_max rand(1)*y_max rand(1)*z_max];
        in=inobs3d(q_rand,obstacle);
        ni=nitissue(q_rand,tissue);
    end
    plot3(q_rand(1), q_rand(2), q_rand(3), 'x', 'Color',  [0 0.4470 0.7410])
    for j = 1:1:length(nodes)
        if nodes(j).coord == q_goal.coord
            break
        end
    end
    ndist = [];
    for j = 1:1:length(nodes)
        n = nodes(j);
        tmp = dist3d(n.coord, q_rand);
        ndist = [ndist tmp];
    end
    [val, idx] = min(ndist);
    q_near = nodes(idx);
    q_new.coord = steer3d(q_rand, q_near.coord, val, EPS);
    if noCollision(q_rand, q_near.coord, obstacle)
        line([q_near.coord(1), q_new.coord(1)], [q_near.coord(2), q_new.coord(2)], [q_near.coord(3), q_new.coord(3)], 'Color', 'b', 'LineWidth', 0.01,'LineStyle','-.');
        drawnow
        hold on
        q_new.cost = dist3d(q_new.coord, q_near.coord) + q_near.cost;
        q_nearest = [];
        r = 50;
        neighbor_count = 1;
        for j = 1:1:length(nodes)
            if (dist3d(nodes(j).coord, q_new.coord)) <= r
                q_nearest(neighbor_count).coord = nodes(j).coord;
                q_nearest(neighbor_count).cost = nodes(j).cost;
                neighbor_count = neighbor_count+1;
            end
        end
        q_min = q_near;
        C_min = q_new.cost;
        for k = 1:1:length(q_nearest)
            if q_nearest(k).cost + dist3d(q_nearest(k).coord, q_new.coord) < C_min
                q_min = q_nearest(k);
                C_min = q_nearest(k).cost + dist3d(q_nearest(k).coord, q_new.coord);
                line([q_min.coord(1), q_new.coord(1)], [q_min.coord(2), q_new.coord(2)], [q_min.coord(3), q_new.coord(3)], 'Color', 'g','LineStyle','--');            
                hold on
            end
        end
        for j = 1:1:length(nodes)
            if nodes(j).coord == q_min.coord
                q_new.parent = j;
            end
        end
        nodes = [nodes q_new];
    end
end

D = [];
for j = 1:1:length(nodes)
    tmpdist = dist3d(nodes(j).coord, q_goal.coord);
    D = [D tmpdist];
end

[temp, idx] = min(D);
q_final = nodes(idx);
q_goal.parent = idx;
q_end = q_goal;
nodes = [nodes q_goal];
Traj=[q_end.coord];
while q_end.parent ~= 0
    start = q_end.parent;
    line([q_end.coord(1), nodes(start).coord(1)], [q_end.coord(2), nodes(start).coord(2)], [q_end.coord(3), nodes(start).coord(3)], 'Color', 'r', 'LineWidth', 2);
    hold on
    q_end = nodes(start);
    Traj=[q_end.coord;Traj];
end


%% FUNCTIONS

    function d = dist3d(q1,q2)
        d = sqrt((q1(1)-q2(1))^2 + (q1(2)-q2(2))^2 + (q1(3)-q2(3))^2);
    end

    function A = steer3d(qr, qn, val, eps)
       qnew = [0 0];
       if val >= eps
           qnew(1) = qn(1) + ((qr(1)-qn(1))*eps)/dist3d(qr,qn);
           qnew(2) = qn(2) + ((qr(2)-qn(2))*eps)/dist3d(qr,qn);
           qnew(3) = qn(3) + ((qr(3)-qn(3))*eps)/dist3d(qr,qn);
       else
           qnew(1) = qr(1);
           qnew(2) = qr(2);
           qnew(3) = qr(3);
       end

       A = [qnew(1), qnew(2), qnew(3)];
    end
    
    function w=inobs3d(p,obstacle)
        w=0;
        for i=1:size(obstacle,1)
            obs=obstacle(i,:);
            if p(1)>obs(1)&&p(1)<(obs(1)+obs(4))&&...
                p(2)>obs(2)&&p(2)<(obs(2)+obs(5))&&...
                p(3)>obs(3)&&p(3)<(obs(3)+obs(6))
                w=1;
            end
        end
    end

    function w=nitissue(p,tis)
        if p(1)>tis(1)&&p(1)<(tis(1)+tis(4))&&...
            p(2)>tis(2)&&p(2)<(tis(2)+tis(5))&&...
            p(3)>tis(3)&&p(3)<(tis(3)+tis(6))
            w=0;
        else
            w=1;
        end
    end
    
    function nc = noCollision(B, A, obs)
        nc=1;
        sample=1000;
        dx=(B-A)/sample;
        for i=1:sample
            p=A+i*dx;
            if inobs3d(p,obs)
                nc=0;
                break
            end
        end
    end

    function [obstacle]=readObs()
        obstacle=[];
        for i=1:CONFIG('OBS_NUM')
            ostart=CONFIG(['OBSTACLE' num2str(i) '_ORIGIN']);
            osize=CONFIG(['OBSTACLE' num2str(i) '_SIZE']);
            obs=[ostart osize];
            obstacle=[obstacle;obs];
        end
    end

end
