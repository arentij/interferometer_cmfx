% draft_data_c
N_pts = 200;
signal_dirty = zeros(N_pts,1);

er_pos = fix(1+(N_pts-1)*rand(fix(N_pts/10),1));

signal_dirty(er_pos) = 1;
%%
signal_cleaned = clean_pts(signal_dirty,0.7);
figure(555)
clf
hold on
plot(signal_dirty)
plot(signal_cleaned)

