module Sample
  class MigratedRecord < ActiveRecord::Base
    belongs_to :r_a, polymorphic: true, validate: false
    belongs_to :r_b, polymorphic: true, validate: false

    validates :r_a_at, :r_b_at, presence: true

    before_validation do
      self[:r_a_at] ||= r_a.updated_at if r_a
      self[:r_b_at] ||= r_b.updated_at if r_b
    end

    after_commit do
      if r_b.respond_to?(:versions)
        version = r_b.versions.find_by(event: 'create')
        version.whodunnit = r_a.try(:creator_id)
        version.created_at = r_b[:created_at].blank? ? r_b[:updated_at] : r_b[:created_at]
        version.save
      end
    end

    def self.where_by_r(r)
      return unless r
      w = arel_table[:r_a_type].eq(r.class.name).and(arel_table[:r_a_id].eq(r.id))
      w = w.or(arel_table[:r_b_type].eq(r.class.name).and(arel_table[:r_b_id].eq(r.id)))
      where(w)
    end

    def self.find_opposite(r)
      me = where_by_r(r).try(:first)
      return unless me
      return me.r_a if me.r_b == r
      me.r_b
    end
  end
end
