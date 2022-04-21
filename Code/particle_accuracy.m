% Done
function wrapper_v = particle_accuracy (x_train, y_train, x_test, y_test)

%% This Function Is Used To Calculate The CLassifier Accuracy For Each Particle
nClasses = 3;              % This value is hard coded and need to be calculated
if ~any(x_train(:))
    wrapper_v = 0;
else
    PMDL = fitcecoc(x_train(:,:), y_train);
    y_out = predict(PMDL, x_test(:, :));
    wrapper_v = wrapper_accuracy(y_test, y_out, nClasses);
end

end
