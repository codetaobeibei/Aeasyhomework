function [gravity_center ] = virtualgravity(x_down, x_right, y_total, radio)
%���������ʹһ��Բ��������������ԭ���䵽ͼ���Ե�����·���������״�°벿�ֽ�����������
%������x_down������x_right����Բ����һ������
for i = min(x_right(:,1),[],1) : max(x_right(:,1),[],1)
     virtual_center_y = x_right(i,2) + radio;
     virtual_center_x = x_right(i,1);
     virtual_center = [virtual_center_x virtual_center_y];
     %������ò�Ҫround,�������ȷ�����ȼ�����õ�
     for j = min(x_down(:,1),[],1) : max(x_down(:,1),[],1)
         if (round(norm(virtual_center - x_down( j, :))) == radio); 
             gravity_center = virtual_center;
             break;
         end
     end
end
end