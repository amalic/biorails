require File.dirname(__FILE__) + '/../test_helper'

class TaskReferenceTest < Test::Unit::TestCase
  fixtures :projects
  fixtures :studies
  fixtures :study_protocols
  fixtures :study_parameters
  fixtures :protocol_versions
  fixtures :parameters
  fixtures :experiments
  fixtures :experiments
  fixtures :tasks
  fixtures :task_contexts
  fixtures :task_values
  fixtures :task_texts
  fixtures :task_references

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
