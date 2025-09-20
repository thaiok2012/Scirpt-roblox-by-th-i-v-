-- Load UI Redz V2
loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()

-- Cấu hình tính năng tự động lưu key
local KEY_CACHE_FILE = "thái_vũ_key_data.txt"
local EXPIRATION_TIME = 12 * 60 * 60 -- 12 giờ tính bằng giây

-- Kiểm tra xem có key đã lưu và còn hạn không
local is_key_valid_from_cache = false
local current_time = os.time()

if isfile(KEY_CACHE_FILE) then
    local saved_time = tonumber(readfile(KEY_CACHE_FILE))
    if saved_time and (current_time - saved_time < EXPIRATION_TIME) then
        is_key_valid_from_cache = true
    end
end

-- Tạo Window chính
local Window = MakeWindow({
    Hub = {
        Title = "Thái Vũ",
        Animation = "Thái Vũ Đẹp Zai"
    },
    Key = {
        KeySystem = not is_key_valid_from_cache, -- Bật hoặc tắt hệ thống key tùy theo trạng thái lưu
        Title = "Key System",
        Description = "",
        KeyLink = "https://link4m.com/lCSiF",
        Keys = {"Thái Vũ 2012"},
        Notifi = {
            Notifications = true,
            CorrectKey = "Running the Script...",
            IncorrectKey = "The key is incorrect",
            CopyKeyLink = "Link đã copy vào clipboard!"
        }
    }
})

-- Nút Minimize
MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=ID_ANH_MOI",
    Size = {60, 60},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true,
    Stroke = false,
    StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- Hàm để lưu lại thời gian khi chạy script
local function save_key_timestamp()
    if is_key_valid_from_cache == false then
        writefile(KEY_CACHE_FILE, tostring(os.time()))
    end
end

-- Tab chính
local Tab1o = MakeTab({Name = "script ở đây"})

-- Button chạy script Min gaming
AddButton(Tab1o, {
    Name = "Min gaming",
    Callback = function()
        save_key_timestamp()
        getgenv().Team = "Marines"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinUp27Vn"))()
    end
})

-- Button chạy script Xeter Hub
AddButton(Tab1o, {
    Name = "Xeter Hub",
    Callback = function()
        save_key_timestamp()
        getgenv().Version = "V3"
        getgenv().Team = "Marines"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))()
    end
})

-- Button chạy script Teddy Hub
AddButton(Tab1o, {
    Name = "Teddy Hub",
    Callback = function()
        save_key_timestamp()
        repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))()
    end
})

-- Button Get Key copy link rút gọn
AddButton(Tab1o, {
    Name = "Get Key",
    Callback = function()
        local link = Window.Key.KeyLink
        if setclipboard then
            setclipboard(link)
        end
        -- Thông báo console
        if Window.Key.Notifi.Notifications then
            print(Window.Key.Notifi.CopyKeyLink)
        end
        -- Thông báo GUI Hint
        local player = game.Players.LocalPlayer
        local hint = Instance.new("Hint")
        hint.Text = Window.Key.Notifi.CopyKeyLink .. "\nMở trình duyệt để vượt Link4m và lấy key."
        hint.Parent = player.PlayerGui
        game:GetService("Debris"):AddItem(hint, 5) -- 5 giây tự biến mất
    end
})
