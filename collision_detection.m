function flag = collision_detection(gravity_center ,x_up ,radio)
%检测标准，仅与x_up有一个交点,即圆既没有与上曲线段相交，也没有出现到不了上曲线段的情况
iter = 0;
for i = min(x_up(1),[],1) : max(x_up(1),[],1)
    %可能需要用到round(a,2),即确定小数点后几位
    %又或者，采用检测边缘的办法
    if (round(norm(gravity_center - x_up(i,:))) == radio)
        iter = iter + 1;
    end
end
if iter == 1
	flag = ture;
else
    flag = false;
end
end
