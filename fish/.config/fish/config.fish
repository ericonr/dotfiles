#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# taken from https://fishshell.com/docs/current/commands.html#contains
for i in ~/.local/bin ~/.cargo/bin
    if not contains $i $PATH
        set PATH $PATH $i
    end
end

