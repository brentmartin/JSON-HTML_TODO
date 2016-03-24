class Task
  attr_accessor :id, :body, :completed
  def initialize(jd, body, completed)
    @id = id
    @body = body
    @completed = completed
  end

  def completed?
    @completed == true
  end

  def to_json(_ = nil)
    {
      id: id,
      body: body,
      completed: completed
    }.to_json
  end
end
