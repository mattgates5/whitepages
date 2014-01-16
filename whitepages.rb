# WhitePages
# Simple YAML/Sinatra Directory

require 'yaml'
require 'sinatra'

class Directory
  attr_reader :directory
  attr_reader :groups
  attr_reader :methods

  def initialize(file)
    @directory = YAML.load_file(file)
    @groups = @directory.keys
    @methods = uniq_methods(@directory)
  end

  def contact(params)
    method = params[:method]
    a = []
    group = @directory[params[:group]]

    return ["error"] if group.nil?
    group.each { |p| a.push(p[method]) unless p[method].nil? }
    a = ["error"] if a.nil?
    a
  end

  private

  def uniq_methods(dir)
    a = []
    dir.each do |group, members|
      members.each do |values|
        values.each do |k,v|
          a.push k unless k == "name"
        end
      end
    end
    a.sort.uniq
  end
end

dir = Directory.new('directory.yaml')

# Routes
get '/' do
  erb :help
end

get '/help' do
  erb :help
end

get '/groups' do
  @data = dir.groups
  erb :show
end

get '/methods' do
  @data = dir.methods
  erb :show
end

get '/:method/:group' do
  @data = dir.contact(params)
  erb :show
end
