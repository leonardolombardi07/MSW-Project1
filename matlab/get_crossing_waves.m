file_path = '../W200908311900.tsr'; % Path from file to be analysed
file_data = load(file_path); % Import buoy observations

times = file_data(:, 1);
heaves = file_data(:, 2); % Keep only information about heave motion of the buoy

crossing_waves_analysis(times, heaves);
