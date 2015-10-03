Rails.application.routes.draw do

  mount DelayedAction::Engine => "/delayed_action"
end
