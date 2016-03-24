require 'erb'
class TaskController < ApplicationController
  def index #GET
    if request[:format] == "json"
      render App.task.to_json, status: "200 OK"
    else
      @tasks = App.tasks
      render_template 'tasks/index.html.erb'
    end
  end

  def show #GET
    task = find_task_by_id

    if task
      if request[:format] == "json"
        render task.to_json
      else
        @task = task
        render_template 'task/show.html.erb'
      end
    else
      render_not_found
    end
  end

  def new
    render_template 'tasks/new.html.erb'
  end

  def update #PUT
    task = find_task_by_id

    if task
      unless params["body"].nil? || params["body"].empty?
        task.name = params["body"]
      end

      # In rails you will need to call save here
      render task.to_json, status: "200 OK"
    else
      render_not_found
    end
  end
