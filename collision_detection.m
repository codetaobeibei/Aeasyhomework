function flag = collision_detection(gravity_center ,x_up ,radio)
%����׼������x_up��һ������,��Բ��û���������߶��ཻ��Ҳû�г��ֵ����������߶ε����
iter = 0;
for i = min(x_up(1),[],1) : max(x_up(1),[],1)
    %������Ҫ�õ�round(a,2),��ȷ��С�����λ
    %�ֻ��ߣ����ü���Ե�İ취
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
