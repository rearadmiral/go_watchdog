require 'yaml'
require 'last_green_build_fetcher'

raise "Must supply Go username in env variable GO_USERNAME" unless ENV['GO_USERNAME']
raise "Must supply Go password in env variable GO_PASSWORD" unless ENV['GO_PASSWORD']

module GoWatchdogHelper
  
  def config
    @config ||= YAML.load(File.read('config.yml'))
  end

  def last_green_build_time
    pipeline_config = config['pipeline']
    fetcher = LastGreenBuildFetcher.new(:protocol => pipeline_config['protocol'],
                                        :host => pipeline_config['host'],
                                        :port => pipeline_config['port'],
                                        :username => ENV['GO_USERNAME'],
                                        :password => ENV['GO_PASSWORD'],
                                        :pipeline_name => pipeline_config['name'],
                                        :stage_name => pipeline_config['stage'])
    fetcher.fetch
  end
  
end