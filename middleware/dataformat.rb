class DataFormat

  attr_reader :rejected_params

  FORMATS = { year:   '%Y',
              month:  '%m',
              day:    '%d',
              hour:   '%H',
              minute: '%M',
              second: '%S'}.freeze

  def initialize(params_string)
    @params_string = params_string
    check_formats
  end

  def converted_formats
    time_format = @accepted_params.map { |p| FORMATS[p.to_sym] }
    Time.now.strftime(time_format.join('-'))
  end

  private

  def check_formats
    params = @params_string.split(',')
    @accepted_params = params.select { |p| FORMATS.key?(p.to_sym) }
    @rejected_params = params - @accepted_params
  end

end
