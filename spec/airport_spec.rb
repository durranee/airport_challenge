require 'airport'
describe Airport do
  subject(:airport) { Airport.new('Heathrow') } # Default capacity of 30
   # Creating a new airport below with 0 capacity to test full method

  # create a plane before each test
  before(:each) do
    @plane = Plane.new(1)
    @sunny = false # Setting weather to (!stormy) for #land and #take_off
    @stormy = true # Setting weather to stormy for #land and #take_off
  end

  it 'should have default capacity of 30' do
    expect(airport.capacity).to eq(30)
  end

  # airport land method check
  it '#land' do
    expect(airport).to respond_to(:land).with(2).arguments
    expect(airport.land(@plane, @sunny).last).to be(@plane)
  end

  it 'expect #land to raise error if stormy' do
  # USE CURLY BRACES FOR RAISE...WHY? IDK!
    expect { airport.land(@plane, @stormy) }.to raise_error 'BAD WEATHER CONDITION! Cannot allow to land'
  end

  # Don't allow an already landed plane
  it 'expect #land to raise error if plane has already landed at any airport (inc this) ' do
    @plane.airport = 'Heathrow'
    expect { airport.land(@plane,@sunny) }.to raise_error 'Plane already landed at an airport'
  end

  # Don't allow landing if airport is full
  it 'expect #land to raise error if airport is full' do
    # creating scenario
    # Airport id = 'My Back Garden' with Capacity of 0
    airport.capacity = 0
    # USE CURLY BRACES FOR RAISE...WHY? IDK!
    expect { airport.land(@plane, @sunny) }.to raise_error 'Error! Airport Full'
  end

  # airport take off method check
  it '#take_off' do
    expect(airport).to respond_to(:take_off).with(2).arguments
    airport.land(@plane, @sunny) # landing a test plane before take_off
    expect(airport.take_off(@plane, @sunny)).to eq(@plane)
  end

  it 'expect #take_off to raise error if plane is already in the air' do
    # creating condition for plane to be mid air
    @plane.airport = nil # setting nill, should also pass for other airports id
    expect { airport.take_off(@plane, @sunny) }.to raise_error 'Error! Plane not at this airport'
  end

  it 'expect #take_off to raise error if stormy' do
    # USE CURLY BRACES FOR RAISE...WHY? IDK!
    airport.land(@plane, @sunny) # landing a test plane before take_off
    expect { airport.take_off(@plane, @stormy) }.to raise_error 'BAD WEATHER CONDITION! Cannot allow to take off'
  end

  # airport prevent landing method check
  it '#prevent_landing' do
    expect(airport).to respond_to(:prevent_landing)
  end

  it '#prevent_take_off' do
    # airport prevent take off method check
    expect(airport).to respond_to(:prevent_take_off)
  end
end
