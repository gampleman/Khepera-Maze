while ((dest(2) - robot(2))^2 + (dest(1) - robot(1))^2 > (2*robot_size)^2)
  updaterobot;
  pid(old_robot, robot, dest);
  plot(robot(2), robot(1), 'go');
end