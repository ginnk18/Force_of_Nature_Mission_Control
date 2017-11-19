class User < ApplicationRecord
    has_secure_password :validations => false

    #A user can create many (has many) events, and also can belong to many events
    #through the 'user_events' table
    has_many :user_events, dependent: :destroy
    # to be clear on finding an event's creator, could we do this instead of the above:
    # has_many :created_events, dependent: :destroy, source: :user_event

    has_many :attended_events, through: :user_events, source: :event

    #users can be creators of many events, and leads of many events
    has_many :events

    #The user categories keeps track of which type of user the current user is
    #Users can be general volunteers, team leads or admins
    belongs_to :user_category

    #A user will usually just belong to one team (most general vols will belong to 1
    # regional team - but some users (team leads) can belong to a regional team and an
    #operational team)
    has_many :user_teams, dependent: :destroy
    has_many :teams, through: :user_teams

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :first_name, :last_name, presence: true, if: :is_approved?
    before_validation :set_defaults

    def full_name
        "#{first_name} #{last_name}"
    end

    private

    def is_approved?
        approved
    end

    def set_defaults
        @guest_category = UserCategory.first
        self.user_category = @guest_category
    end

end
