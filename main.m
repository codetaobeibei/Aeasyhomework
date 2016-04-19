%利用圆膨胀的方法对血管的半径进行一个定精度的估计以及动画演示过程
clear all；
close all;
clc;
%%
%input and pre-treatment
A = double(imread('1.bmp')) / 255;
B = rgb2gray(A);
W = im2bw(B,11);  %？
BW = 1 - imfill(1-W, 'holes');
%imshow(BW);

%%
%find the coordinate of the boundary of the blood
x = 1 : size(BW, 2);
x1s = [];
x2s = [];
ys = [];

for i = 1 : size(BW,1)
    y = BW(i,:);
    x1 = min(x(diff(y) < - 0.5)) + 1 / 2;
    x2 = max(x(diff(y) > 0.5)) + 1 / 2;
    x1s = [x1s;[x1,i]];
    x2s = [x2s;[x2,i]];
    ys = [ys;i];
end

%cut point
cut_point = x1s(:,min(ys));
for i = min(x1s) : max(x1s)
    if i <= cut_point(1);
        x_up = x1s(i,:);
    elseif i >= cut_point
        x_down = x1s(i,:);
    end
end

x_right = x2s;
y_total = ys;

% x_up,x_down,x_right,y_total

%%
%circle finding
%max radio
max_radio = abs(min(ys) - max(ys));
route_center = [];
route_radio = [];
for radio = 10 : max_radio
    
    gravity_center = virtualgravity(x_down, x_right, y_total, radio); 
    
    %detect the collision with x_up
    route_center = [route_center; gravity_center];
    route_radio = [route_radio; radio];
    
    if (collision_detection(gravity_center ,x_up ,radio))
        real_center = gravity_center;
        break;
    end 
end

printf('The center position of the inner circle is:x-coordinate: %s y-coordinate:%s\n',...
    real_center(1),...
    real_center(2));
%%
%display the searching animation
%input:route_center route_radio
%how to use map to animate the route? 
%1 - white - center coordinate
%2 - yellow - circle field
% cmap[1 1 1;...
%     1 1 0;...
%     ];
% colormap(cmap);
figure;
imshow(A);
hold on;
alpha = 0 : 0.01 : 2 * pi;
k=plot(route_radio(1) * sin(alpha) + route_center(1,2),...
 route_radio(1) * cos(alpha) + route_center(1,1),'-');
hold on;
j=fill(route_radio(1) * sin(alpha) + route_center(1,2),...
 route_radio(1) * cos(alpha) + route_center(1,1),'y');
axis equal;
hold on;
c = plot(route_center(1),route_center(2),'ro','MarkerSize',5,'MarkerFaceColor','w');
hold off;
n = size( route_center, 1);
for i = 1 : n

    k.XData = route_radio(i) * sin(alpha) + route_center(i,1);
    k.YData = route_radio(i) * cos(alpha) + route_center(i,2);
    j.XData = route_radio(i) * sin(alpha) + route_center(i,1);
    j.YData = route_radio(i) * cos(alpha) + route_center(i,2);
    c.XData = route_center(i,1);
    c.YData = route_center(i,2);
    drawnow;
    pause(0.5);
end




