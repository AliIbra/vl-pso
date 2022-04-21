function [acc_all] = accuracy_calculate (output,y_out)
acc = 0;
acc_all=0;

for i = 1 : length(y_out)
    if (output(i,:) == y_out(i,:))
        acc = acc + 1;
    end
acc_all = acc / length(y_out(:,1));   
end