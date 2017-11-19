if Rails.env.development?
    class DelayedJobWeb
        disable :sessions
        set :protection, false
    end
end
