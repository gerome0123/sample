ActiveModel::Serializer.class_eval do
  attributes :id, :can_delete, :can_edit

  def can_edit
    return unless respond_to?(:current_ability)
    current_ability.can?(:edit, object)
  end

  def can_delete
    return unless respond_to?(:current_ability)
    current_ability.can?(:delete, object)
  end
end
