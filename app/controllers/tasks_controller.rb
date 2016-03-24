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

  def create #POST
    last_task = App.tasks.max_by { |task| task.id }
    new_id = last_task.id + 1

    App.tasks.push(
      Task.new(new_id, params["body"], false)
    )
    puts App.tasks.to_json

    render({ message: "Successfully created!", id: new_id }.to_json)
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


  def destroy #DELETE
    task = find_task_by_id

    if task
      App.task.delete(task)
      render({ message: "Successfully Deleted Task" }.to_json)
    else
      render_not_found
    end
  end

  private

  def find_task_by_id
    App.task.find { |t| t.id == params[:id].to_i }
  end

  def render_not_found
    return_message = {
      message: "Task not found!",
      status: '404'
    }.to_json

    render return_message, status: "404 NOT FOUND"
  end

end
