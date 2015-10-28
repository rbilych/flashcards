class SuperMemo
  def initialize(time, iteration, factor)
    @time = time
    @iteration = iteration
    @factor = factor
  end

  def calculation
    quality = get_quality(@time)
    @factor = set_factor(@factor, quality)
    @interval = get_interval(@iteration, @factor)
    @iteration = quality < 3 ? 1 : @iteration + 1

    {
      factor: @factor.round(1),
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

  def set_factor(factor, quality)
    factor += (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    [factor, 1.3].max
  end

  def get_interval(iteration, factor)
    if iteration == 1
      1
    elsif iteration == 2
      6
    else
      (iteration - 1) * factor
    end
  end
end
