import json
import pprint

with open("archive/GlobalLandTemperaturesByCountry.csv") as file:
    temperatures_str = file.read()
temperatures_str = temperatures_str.replace("\"Bonaire, Saint Eustatius And Saba\"", "Bonaire Saint Eustatius And Saba")
# print(temperatures_str)
temperatures = [line.split(",") for line in temperatures_str.split("\n") if line != ""]

temperatures_by_country_by_year = {}
for index in range(1, len(temperatures)):
    whole_date = temperatures[index][0]
    year = whole_date.split("-")[0]
    if int(year) > 1990:
        country = temperatures[index][3]
        avg_temperature = temperatures[index][1]
        if temperatures_by_country_by_year.get(country) is None:
            temperatures_by_country_by_year[country] = {}
        if temperatures_by_country_by_year[country].get(year) is None:
            temperatures_by_country_by_year[country][year] = {}
        temperatures_by_country_by_year[country][year][whole_date] = avg_temperature

avg_temperatures = {}
for country in temperatures_by_country_by_year:
    avg_temperatures_per_year = []
    for year in temperatures_by_country_by_year[country]:
        only_temperatures = [float(value) for value in temperatures_by_country_by_year[country][year].values() if
                             value != ""]
        if only_temperatures:
            avg_temperatures_per_year.append(sum(only_temperatures) / len(only_temperatures))
    if avg_temperatures_per_year:
        avg_temperatures[country] = sum(avg_temperatures_per_year) / len(avg_temperatures_per_year)

printer = pprint.PrettyPrinter(indent=4)
printer.pprint(avg_temperatures)

to_csv = "country,avg_temp\n"
for (country,temp) in avg_temperatures.items():
    to_csv += f"{country},{temp}\n"

with open("Temperatures.csv", "w") as file:
    file.write(to_csv)
    # json.dump({"countries": avg_temperatures}, file, sort_keys=True)
