function [gravity_center ] = virtualgravity(x_down, x_right, y_total, radio)
%这个函数是使一个圆由于虚拟重力的原因落到图像边缘的最下方，并与碗状下半部分仅有两个交点
%即曲线x_down与曲线x_right都与圆仅有一个交点
for i = min(x_right(:,1),[],1) : max(x_right(:,1),[],1)
     virtual_center_y = x_right(i,2) + radio;
     virtual_center_x = x_right(i,1);
     virtual_center = [virtual_center_x virtual_center_y];
     %下面最好不要round,如果可以确定精度级是最好的
     for j = min(x_down(:,1),[],1) : max(x_down(:,1),[],1)
         if (round(norm(virtual_center - x_down( j, :))) == radio); 
             gravity_center = virtual_center;
             break;
         end
     end
end
end