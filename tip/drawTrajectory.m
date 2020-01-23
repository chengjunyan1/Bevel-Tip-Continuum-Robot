function drawTrajectory(points)
SP=CONFIG('START_POINT');
CP=CONFIG('CONTACT_POINT');
TP=CONFIG('TARGET_POINT');
tip_start=points(1,:);
offset=[SP;tip_start];
hold on
% plot3(offset(:,1)',offset(:,2)',offset(:,3)','b--','LineWidth',1);
% plot3(points(:,1)',points(:,2)',points(:,3)','k','LineWidth',1.5);
% plot3(points(end,1)',points(end,2)',points(end,3)','r.','LineWidth',15);
plot3(CP(1), CP(2), CP(3), 'rx','LineWidth',20);
plot3(TP(1), TP(2), TP(3), 'bx','LineWidth',20);
end 