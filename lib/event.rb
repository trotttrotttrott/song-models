class Event

  class << self

    def marker(message)
      data = []
      data << 0xFF
      data << 0x06
      data << message.length
      message.each_char do |c|
        data << c
      end
      data
    end

    def tempo(bpm)

      # ms per quarter note
      mpq = 1_000_000 * 60 / bpm

      data = []
      data << 0xFF
      data << 0x51
      data << 3
      data << ((mpq >> 16) & 0xff)
      data << ((mpq >> 8) & 0xff)
      data << (mpq & 0xff)
    end

    def time_signature(numerator, denominator)
      data = []
      data << 0xFF
      data << 0x58
      data << 4
      data << numerator
      data << denominator
      data << 24
      data << 8
    end

    def end_track
      data = []
      data << 0xFF
      data << 0x2f
      data << 0
    end
  end
end
