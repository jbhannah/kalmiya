# frozen_string_literal: true

module CoreExtensions
  module Date
    # Extend Date with methods for week-of-month calculations.
    module WeekOfMonth
      # Get the index of the occurrence of the current day of the week in the
      # current month, e.g. for Monday, 11 April 2022 (the second Monday in the
      # month of April 2022):
      #
      #     Date.new(2022, 4, 11).wday      #=> 0
      #     Date.new(2022, 4, 11).mweek     #=> 1
      def mweek
        (day - 1) / 7
      end

      # Get the date of the nth occurrence (0-indexed) of the given day of the
      # week in the current month. Raises a Date::Error if the resulting date
      # would be either in a different month, or otherwise invalid.
      #
      #     Date.new(2022, 4, 11).nth_kday(0, :monday)     #=> #<Date: 2022-04-04>
      #     Date.new(2022, 4, 11).nth_kday(4, :saturday)   #=> #<Date: 2022-04-30>
      #     Date.new(2022, 4, 11).nth_kday(4, :sunday)     #=> #<Date::Error>
      #     Date.new(2022, 4, 11).nth_kday(5, :sunday)     #=> #<Date::Error>
      def nth_kday(nth, kday)
        beginning_of_month.change(day: (nth * 7) + 1).this_or_next_occurring(kday).tap do |candidate|
          raise ::Date::Error, 'invalid date' if candidate.month != month
        end
      end

      # Returns the current date if it matches the specified day of the week, or
      # a new date/time representing the next occurrence of the specified day of
      # the week.
      def this_or_next_occurring(day_of_week)
        send("#{day_of_week}?") ? self : next_occurring(day_of_week)
      end
    end
  end
end

Date.include CoreExtensions::Date::WeekOfMonth
