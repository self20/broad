module ViewObjects
  class Dashboard
    def movies_waitlist
      Movie.on_waitlist
    end

    #:reek:UtilityFunction
    def episodes_today
      Episodes.new(Episode.where("published_at::date = ?", Date.today))
    end

    #:reek:UtilityFunction
    def episodes_week
      Episodes.new(Episode.where("published_at::date >= ?", Date.today-1.week))
    end
  end
end
