module ApplicationHelper
  # FIXME
  def task_event_path(event_name)
    return start_account_task_path if event_name == :start
    return finish_account_task_path if event_name == :finish
  end
end
