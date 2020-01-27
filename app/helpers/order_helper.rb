module OrderHelper
  def set_background(status)
    color = case status
      when 'delivery'
        'yellow'
      when 'prepared'
        'gray'
      when 'ordered'
        'lightblue'
      end

    "background: #{color}"
  end
end
