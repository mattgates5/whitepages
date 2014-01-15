# WhitePages
# Simple YAML/Sinatra Directory

require 'haml'
require 'yaml'
require 'sinatra'

class Directory
  attr_reader :directory
  attr_reader :keys

  def initialize(file)
    @directory = YAML.load_file(file)
    @keys = @directory.keys
  end

  def contact(params)
    group = params[:group]
    method = params[:method]
    arr = []
    grp = @directory[group]

    return ["error"] if grp.nil?
    grp.each { |p| arr.push(p[method]) unless p[method].nil? }
    arr = ["arr"] if arr.nil?

    arr
  end
end

dir = Directory.new('directory.yaml')

# Routes
get '/' do
  haml :help
end

get '/groups' do
  @data = dir.keys
  haml :show
end

get '/:method/:group' do
  @data = dir.contact(params)
  haml :show
end
