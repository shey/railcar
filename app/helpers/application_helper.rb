module ApplicationHelper
  def flash_classes(level)
    flash_base = "py-2 px-2 mx-auto font-sans font-medium text-center text-white"
    {
      notice: "bg-indigo-600 #{flash_base}",
      error:  "bg-red-600 #{flash_base}",
      alert: "bg-orange-600 #{flash_base}",
      success: "bg-green-600 #{flash_base}",
    }.stringify_keys[level.to_s] || level.to_s
  end
end
