ENV["RACK_ENV"] ||= 'development'

require "rubygems"
require "bundler/setup"
require "sinatra"
require "json"

require_relative "lib/adventure"

set :static, true
set :public_folder, Proc.new { File.join(root, "..", "client") }

before do
  content_type "application/json"
end

# get "/backend/steps" do
#   Step.all.to_json
# end

post "/login" do
  token = SecureRandom.hex
  session = Adventure::Session.create(token: token)
  [200, session.to_json]
end

#create new story
post "/story" do
  payload = JSON.parse(request.body.read)
  story = Adventure::Story.create(payload)
  [200, story.to_json]

end

#create new step
post "/step" do
  payload = JSON.parse(request.body.read)
  step = Adventure::Step.create(payload)
  [200, step.to_json]
end

#list step
post "/step/:id" do
  payload = JSON.parse(request.body.read)
  step = Adventure::Step.find(params["id"])
  step.update(payload)
  [200, step.to_json]
end

#list all stories
get "/stories" do
  stories = Adventure::Story.all
  [200, stories.to_json]
end

#list all steps of a given story
get "/steps/:id" do
  story = Adventure::Story.find(params["id"])
  steps = Adventure::Step.where(story_id: story.id)
  [200, steps.to_json]
end

#update step
patch "/step!/:id" do
  payload = JSON.parse(request.body.read)
  step = Adventure::Step.find(params["id"])
  step.update(payload)
  [200, step.to_json]
end

#update story
patch "/story!/:id" do
  payload = JSON.parse(request.body.read)
  story = Adventure::Story.find(params["id"])
  story.update(payload)
  [200, story.to_json]
end

#delete story
delete "/story_del/:id" do
  story = Adventure::Story.find(params["id"])
  story.destroy!
end

#delete step
delete "/step_del/:id" do
  step = Adventure::Step.find(params["id"])
  step.destroy!
end
