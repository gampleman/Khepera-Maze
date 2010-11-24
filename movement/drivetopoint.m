while ((dest(2) - robot(2))^2 + (dest(1) - robot(1))^2 > (2*robot_size)^2)
  updaterobot;
  plot(robot(2), robot(1), 'go');
  pid(old_robot, robot, dest);
  drawnow
end