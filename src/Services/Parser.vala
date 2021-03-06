/*
* Copyright (c) 2018-2019 Dirli <litandrej85@gmail.com>
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*/

namespace WeatherApplet.Services.Parser {
    public static WeatherInfo parse_forecast (Json.Object forecast, string units) {
        WeatherInfo info = new WeatherApplet.WeatherInfo();

        var weather = forecast.get_array_member ("weather");
        var main_data = forecast.get_object_member ("main");
        var wind = forecast.get_object_member ("wind");
        var sys = forecast.get_object_member ("sys");

        string icon_num = weather.get_object_element (0).get_string_member ("icon");

        info.icon_name = WeatherApplet.Utils.get_icon_name (icon_num);
        info.city_name = forecast.get_string_member ("name");
        info.humidity = "%d %%".printf ((int) main_data.get_int_member ("humidity"));
        info.sunrise = WeatherApplet.Utils.time_format (new DateTime.from_unix_local (sys.get_int_member ("sunrise")));
        info.sunset = WeatherApplet.Utils.time_format (new DateTime.from_unix_local (sys.get_int_member ("sunset")));
        info.description = weather.get_object_element (0).get_string_member ("description");
        info.temp = WeatherApplet.Utils.temp_format (units, main_data.get_double_member ("temp"));

        double? wind_speed = null, wind_deg = null;

        if (wind.has_member ("speed")) {
            wind_speed = wind.get_double_member ("speed");
        }

        if (wind.has_member ("deg")) {
            wind_deg = wind.get_double_member ("deg");
        }

        info.wind = WeatherApplet.Utils.wind_format (units, wind_speed, wind_deg);

        DateTime upd_dt = new DateTime.from_unix_local ((int64) forecast.get_int_member ("dt"));
        info.l_update_t = upd_dt.format (" %e  %b %R");

        return info;
    }
}
