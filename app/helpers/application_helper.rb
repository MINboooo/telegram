module ApplicationHelper
  def user_icon_link(class_name)
    <% if user_signed_in? %>
    <%= link_to user_path(current_user), class: "class_name" do %>
      <i class="far fa-user"></i>
    <% end %>
  <% else %>
    <%= link_to new_user_session_path, class: "class_name" do %>
      <i class="far fa-user"></i>
    <% end %>
  <% end %>
  end
end
