namespace WeatherApplet.Utils {

    // public static int64 update_idplace (string uri) {
    //     Soup.Session session = new Soup.Session ();
    //     Soup.Message message = new Soup.Message ("GET", uri);
    //     session.send_message (message);
    //     int64 id = 0;
    //     try {
    //         var parser = new Json.Parser ();
    //         parser.load_from_data ((string) message.response_body.flatten ().data, -1);
    //         var root = parser.get_root ().get_object ();
    //         id = root.get_int_member ("id");
    //     } catch (Error e) {
    //         warning (e.message);
    //     }
    //
    //     return id;
    // }

    // public static bool save_cache (string path_json, string data) {
    //     try {
    //         var path = File.new_for_path (Environment.get_user_cache_dir () + "/" + Constants.EXEC_NAME);
    //         if (!path.query_exists ()) {
    //             path.make_directory ();
    //         }
    //         var fcjson = File.new_for_path (path_json);
    //         if (fcjson.query_exists ()) {
    //             fcjson.delete ();
    //         }
    //         var fcjos = new DataOutputStream (fcjson.create (FileCreateFlags.REPLACE_DESTINATION));
    //         fcjos.put_string (data);
    //     } catch (Error e) {
    //         warning (e.message);
    //         return false;
    //     }
    //     return true;
    // }

    // public static void clear_cache () {
    //     try {
    //         string cache_path = Environment.get_user_cache_dir () + "/" + Constants.EXEC_NAME;
    //         string file_name;
    //         GLib.Dir dir = GLib.Dir.open (cache_path, 0);
    //         while ((file_name = dir.read_name ()) != null) {
    //             string path = GLib.Path.build_filename (cache_path, file_name);
    //             GLib.FileUtils.remove (path);
    //         }
    //     } catch (Error e) {
    //         warning (e.message);
    //     }
    // }

    public static string temp_format (string units, double temp) {
        string tempformat = "%.0f".printf(temp);

        tempformat += "\u00B0";
        switch (units) {
            case "imperial":
                tempformat += "F";
                break;
            case "metric":
            default:
                tempformat += "C";
                break;
        }
        return tempformat;
    }

    public static string time_format (GLib.DateTime datetime) {
        string timeformat = "";
        var syssetting = new Settings ("org.gnome.desktop.interface");
        if (syssetting.get_string ("clock-format") == "12h") {
            timeformat = datetime.format ("%I:%M");
        } else {
            timeformat = datetime.format ("%R");
        }

        return timeformat;
    }

    public static string wind_format (string units, double? speed = null, double? deg = null) {
        if (speed == null) {
            return "no data";
        }
        string windformat = "%.1f ".printf(speed);
        switch (units) {
            case "imperial":
                windformat += _("mph");
                break;
            case "metric":
            default:
                windformat += _("m/s");
                break;
        }

        if (deg != null) {
            double degrees = Math.floor((deg / 22.5) + 0.5);
            string[] arr = {"N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"};
            int index = (int)(degrees % 16);

            switch (arr[index]) {
                case "N":
                case "NNE":
                case "NNW":
                    windformat += ", ↓";
                break;
                case "NE":
                    windformat += ", ↙";
                break;
                case "ENE":
                case "E":
                case "ESE":
                    windformat += ", ←";
                break;
                case "SE":
                    windformat += ", ↖";
                break;
                case "SSE":
                case "S":
                case "SSW":
                    windformat += ", ↑";
                break;
                case "SW":
                    windformat += ", ↗";
                break;
                case "WSW":
                case "W":
                case "WNW":
                    windformat += ", →";
                break;
                case "NW":
                    windformat += ", ↘";
                break;
            }
        }
        return windformat;
    }

    public static string get_icon_name (string code) {
        string str_icon = "";
        switch (code) {
            case "01d":
                str_icon = "weather-clear";
                break;
            case "01n":
                str_icon = "weather-clear-night";
                break;
            case "02d":
                str_icon = "weather-few-clouds";
                break;
            case "02n":
                str_icon = "weather-few-clouds";
                break;
            case "03d":
                str_icon = "weather-few-clouds";
                break;
            case "03n":
                str_icon = "weather-few-clouds-night";
                break;
            case "04d":
                str_icon = "weather-overcast";
                break;
            case "04n":
                str_icon = "weather-overcast";
                break;
            case "09d":
                str_icon = "weather-showers-scattered";
                break;
            case "09n":
                str_icon = "weather-showers-scattered";
                break;
            case "10d":
                str_icon = "weather-showers";
                break;
            case "10n":
                str_icon = "weather-showers";
                break;
            case "11d":
                str_icon = "weather-storm";
                break;
            case "11n":
                str_icon = "weather-storm";
                break;
            case "13d":
                str_icon = "weather-snow";
                break;
            case "13n":
                str_icon = "weather-snow";
                break;
            case "50d":
                str_icon = "weather-fog";
                break;
            case "50n":
                str_icon = "weather-fog";
                break;
            default :
                str_icon = "dialog-error";
                break;
        }
        return str_icon;
    }

    public static string pressure_format (int val) {
        string lang = Gtk.get_default_language ().to_string ().substring (0, 2);
        string presformat;
        switch (lang) {
            case "ru":
                double transfor_val = val * 0.750063755419211;
                presformat = "%.0f mm Hg".printf(transfor_val);
                break;
            default:
                presformat = "%d hPa".printf(val);
                break;

        }
        return presformat;
    }
}