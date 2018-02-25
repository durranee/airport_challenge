require 'weather'
# Weather class spec file
describe Weather do
  # using weather for subject to make things readable
  subject(:weather) { Weather.new }

  it '#stormy?' do
    expect(weather).to respond_to(:stormy?)
    expect(weather.stormy?).to be(true).or be(false)
  end
end
