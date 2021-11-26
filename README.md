# BMP3XX

[![Hex version](https://img.shields.io/hexpm/v/bmp3xx.svg "Hex version")](https://hex.pm/packages/bmp3xx)
[![CI](https://github.com/mnishiguchi/bmp3xx/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/mnishiguchi/bmp3xx/actions/workflows/ci.yml)

Read temperature and pressure from Bosch
[BMP388](https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp388/),
and
[BMP390](https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp390/)
sensors in Elixir.

## Usage

Here's an example use (most sensors are at address 0x77, but some are at 0x76):

```elixir
iex> {:ok, bmp} = BMP3XX.start_link(bus_name: "i2c-1", bus_address: 0x77)
{:ok, #PID<0.2190.0>}
iex> BMP3XX.measure(bmp)
{:ok,
 %BMP3XX.Measurement{
   altitude_m: 100.11370638569619,
   pressure_pa: 100387.23387754142,
   temperature_c: 30.542875839950284,
   timestamp_ms: 62437
 }}
```

Depending on your hardware configuration, you may need to modify the call to
[`BMP3XX.start_link/1`](https://hexdocs.pm/bmp3xx/BMP3XX.html#start_link/1). See [`t:BMP3XX.options/0`](https://hexdocs.pm/bmp3xx/BMP3XX.html#t:options/0) for parameters.

All measurements are reported in SI units.

The altitude measurement is computed from the measured barometric pressure. To
be accurate, it requires either the current sea level pressure or the current
altitude. Here's an example:

```elixir
iex> BMP3XX.force_altitude(bmp, 100)
:ok
```

Subsequent altitude reports should be more accurate until the weather changes.
