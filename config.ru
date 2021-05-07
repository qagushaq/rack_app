require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'app'

use Runtime
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run App.new
