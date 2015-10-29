# Based on sm2 algorithm
# See more - http://www.supermemo.com/english/ol/sm2.htm

class SuperMemo
  def initialize(time, iteration, e_factor)
    @time = time
    @iteration = iteration
    @e_factor = e_factor
  end

  def calculation
    quality = get_quality(@time)
    @e_factor = set_e_factor(@e_factor, quality)
    @interval = get_interval(@iteration, @e_factor)
    @iteration = quality < 3 ? 1 : @iteration + 1

    {
      e_factor: @e_factor.round(1),
      interval: @interval.round(1),
      iteration: @iteration
    }
  end

  def get_quality(time)
    case time.to_i
    when -1 then 0
    when 0..5 then 5
    when 6..10 then 4
    when 11..15 then 3
    when 16..20 then 2
    else 1
    end
  end

  def set_e_factor(e_factor, quality)
    e_factor += (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    [e_factor, 1.3].max
  end

  def get_interval(iteration, e_factor)
    case iteration
    when 1 then 1
    when 2 then 6
    else (iteration - 1) * e_factor
    end
  end
end
