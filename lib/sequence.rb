class Sequence

  attr_reader :division, :delta_time, :events, :io

  def initialize(division = 248)
    @division = division
    @delta_time = 0
    @events = []
  end

  def <<(event)
    event.unshift variable_length_byte_array(delta_time)
    @delta_time = 0
    @events << event.flatten
  end

  def advance_time(quarter_notes)
    @delta_time += quarter_notes * division
  end

  def write!(io)

    @io = io

    # header chunk
    io.print "MThd"
    write32 6   # length
    write16 0   # format
    write16 1   # tracks
    write16 division

    # track chunk
    io.print "MTrk"
    write32 events.flatten.size
    events.flatten.each do |byte|
      io.putc byte
    end

    io.close
  end

  private

  def write16(val)
    val = (-val | 0x8000) if val < 0
    io.putc((val >> 8) & 0xff)
    io.putc(val & 0xff)
  end

  def write32(val)
    val = (-val | 0x80000000) if val < 0
    io.putc((val >> 24) & 0xff)
    io.putc((val >> 16) & 0xff)
    io.putc((val >> 8) & 0xff)
    io.putc(val & 0xff)
  end

  def variable_length_byte_array(value)
    buffer = []
    buffer << (value & 0x7f)
    value = (value >> 7)
    while value > 0
      buffer << (0x80 + (value & 0x7f))
      value = (value >> 7)
    end
    buffer.reverse
  end
end
