namespace :webpack do
  desc "Analyze the webpack build"
  task analyze: %i[build_json analyze_json]

  task :build_json do
    system "RAILS_ENV=#{ENV.fetch('RAILS_ENV', 'production')} \
     NODE_ENV=#{ENV.fetch('NODE_ENV', 'production')} \
     bin/webpack --profile --json > tmp/webpack-stats.json"
  end

  task :analyze_json do
    system "npx webpack-bundle-analyzer tmp/webpack-stats.json public/packs"
  rescue Interrupt
  end
end
