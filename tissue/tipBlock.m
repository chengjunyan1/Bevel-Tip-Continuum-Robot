function [state]=tipBlock(tipPose)
TISSUE_ORIGIN=CONFIG('TISSUE_ORIGIN');
TISSUE_SIZE=CONFIG('TISSUE_SIZE');
x=TISSUE_ORIGIN(1); y=TISSUE_ORIGIN(2); z=TISSUE_ORIGIN(3); 
lx=TISSUE_SIZE(1); ly=TISSUE_SIZE(2); lz=TISSUE_SIZE(3);
tx=tipPose(1); ty=tipPose(2); tz=tipPose(3);

% conditions
CONTACT_OFFSET=PARAMS('CONTACT_OFFSET');
cond2=(tx>=x&&tx<=x+CONTACT_OFFSET)&&(ty>=y&&ty<=y+ly)&&(tz>=z&&tz<=z+lz); % tip contact tissue
cond1=(tx>=x+CONTACT_OFFSET&&tx<=x+lx)&&(ty>=y&&ty<=y+ly)&&(tz>=z&&tz<=z+lz); % tip inside tissue

% return state
if cond2
    state=2; % tip contact tissue
else
    if cond1
        state=1; % tip inside tissue
    else
        state=0; % tip outside tissue
    end
end

end