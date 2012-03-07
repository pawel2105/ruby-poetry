every 24.hours do
  rake "collect"
end

every 1.hour do
  rake "publish"
end