local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local ts = game:GetService("TweenService")
local us = game:GetService("UserInputService")
local screengui = Instance.new("ScreenGui",game.CoreGui)
local library = {}

local randomopensounds = {
    "rbxassetid://3779096010",
    "rbxassetid://915576050",
    "rbxassetid://12221967",
    "rbxassetid://263105619",
    "rbxassetid://6655708496",
    "rbxassetid://8426701399",
    "rbxassetid://3779053277",
}

function playsound(id,volume,pitch,pitchrandoffset)
    if screengui.Parent ~= game.CoreGui then
        return
    end

    local ss = Instance.new("Sound")
    pitchrandoffset = pitchrandoffset or 0
    ss.Volume = volume
    ss.SoundId = id
    ss.PlaybackSpeed = pitch+Random.new():NextNumber(-pitchrandoffset,pitchrandoffset)
    ss.Parent = screengui
    ss:Play()

    ss.Ended:Once(function()
        ss:Destroy()
    end)
end

function givecorners(what,radius)
    local new = Instance.new("UICorner")
    new.CornerRadius = radius
    new.Parent = what
    return new
end

function givestroke(what,color,thickness,joinmode,strokemode)
    local new = Instance.new("UIStroke")
    new.Color = color or Color3.fromRGB(0,0,0)
    new.Thickness = thickness or 1
    new.LineJoinMode = joinmode or "Round"
    new.ApplyStrokeMode = strokemode or "Contextual"
    new.Parent = what
    return new
end

library.createwindow = function(windowoptions:{})
    local windowtitle = windowoptions.title
    local keybind = windowoptions.keybind or Enum.KeyCode.Backquote
    local windowsize = windowoptions.size or UDim2.new(0.6,0,0.64,0)
    
    local frame = Instance.new("Frame",screengui)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5,0.5)
    frame.Position = UDim2.new(0.5,0,0.5,0)
    frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
    frame.Size = windowsize
    frame.Visible = false
    givecorners(frame,UDim.new(0,4))
    givestroke(frame,Color3.new(0,0,0),5)
    
    local topbar = Instance.new("Frame",frame)
    topbar.BorderSizePixel = 0
    topbar.AnchorPoint = Vector2.new(0,0)
    topbar.Position = UDim2.new(0,0,0,0)
    topbar.BackgroundTransparency = 1
    topbar.Size = UDim2.new(1,0,0,38)

    local blackline = Instance.new("Frame",topbar)
    blackline.BorderSizePixel = 0
    blackline.AnchorPoint = Vector2.new(0,1)
    blackline.Position = UDim2.new(0,0,1,0)
    blackline.BackgroundColor3 = Color3.fromRGB(0,0,0)
    blackline.Size = UDim2.new(1,0,0,5)

    local titletext = Instance.new("TextLabel",topbar)
    titletext.BorderSizePixel = 0
    titletext.AnchorPoint = Vector2.new(0,0)
    titletext.Position = UDim2.new(0.01,0,0,0)
    titletext.BackgroundTransparency = 1
    titletext.Size = UDim2.new(0.75,0,0,32)
    titletext.TextXAlignment = "Left"
    titletext.TextScaled = true
    titletext.Text = tostring(windowtitle)
    titletext.Font = Enum.Font.SourceSansBold
    titletext.TextColor3 = Color3.new(0,0,0)

    local close = Instance.new("TextButton",topbar)
    close.BorderSizePixel = 0
    close.AnchorPoint = Vector2.new(1,0)
    close.Position = UDim2.new(1,0,0,1)
    close.BackgroundTransparency = 1
    close.Size = UDim2.new(0,33,0,33)
    close.TextScaled = true
    close.Text = "X"
    close.Font = Enum.Font.FredokaOne
    close.TextColor3 = Color3.new(0,0,0)

    local expand = Instance.new("ImageButton",topbar)
    expand.BorderSizePixel = 0
    expand.AnchorPoint = Vector2.new(1,0)
    expand.Position = UDim2.new(1,-33,0,1)
    expand.BackgroundTransparency = 1
    expand.Size = UDim2.new(0,33,0,33)
    expand.Image = "rbxassetid://15773830709"
    expand.ImageColor3 = Color3.new(0,0,0)

    local minimize = Instance.new("ImageButton",topbar)
    minimize.BorderSizePixel = 0
    minimize.AnchorPoint = Vector2.new(1,0)
    minimize.Position = UDim2.new(1,-66,0,1)
    minimize.BackgroundTransparency = 1
    minimize.Size = UDim2.new(0,33,0,33)
    minimize.Image = "rbxassetid://15396333997"
    minimize.ImageColor3 = Color3.new(0,0,0)

    local darkmode = Instance.new("ImageButton",topbar)
    darkmode.BorderSizePixel = 0
    darkmode.AnchorPoint = Vector2.new(1,0)
    darkmode.Position = UDim2.new(1,-102,0,4)
    darkmode.BackgroundTransparency = 1
    darkmode.Size = UDim2.new(0,25,0,25)
    darkmode.Image = "rbxassetid://8498174594"
    darkmode.ImageColor3 = Color3.new(0,0,0)

    local container = Instance.new("Frame",frame)
    container.BorderSizePixel = 0
    container.AnchorPoint = Vector2.new(0,1)
    container.Position = UDim2.new(0,0,1,0)
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1,0,1,-38)

    local tabs = Instance.new("Frame",container)
    tabs.BorderSizePixel = 0
    tabs.AnchorPoint = Vector2.new(0,0)
    tabs.Position = UDim2.new(0,0,0,0)
    tabs.BackgroundColor3 = Color3.fromRGB(255,255,255)
    tabs.Size = UDim2.new(0.2,0,1,0)

    local tabslist = Instance.new("ScrollingFrame",tabs)
    tabslist.BorderSizePixel = 0
    tabslist.AnchorPoint = Vector2.new(0,0.5)
    tabslist.Position = UDim2.new(0,0,0.5,0)
    tabslist.BackgroundTransparency = 1
    tabslist.Size = UDim2.new(1,-5,1,0)
    tabslist.AutomaticCanvasSize = "Y"
    tabslist.CanvasSize = UDim2.new(0,0,0,0)
    tabslist.ScrollBarImageColor3 = Color3.new(0,0,0)
    tabslist.ScrollBarThickness = 5

    local tabslistlayout = Instance.new("UIListLayout",tabslist)
    tabslistlayout.FillDirection = "Vertical"

    local blackborder = Instance.new("Frame",tabs)
    blackborder.BorderSizePixel = 0
    blackborder.AnchorPoint = Vector2.new(1,0)
    blackborder.Position = UDim2.new(1,0,0,0)
    blackborder.BackgroundColor3 = Color3.fromRGB(0,0,0)
    blackborder.Size = UDim2.new(0,5,1,0)

    local windowfuncs = {}
    local tabstable = {}
    local selectedtab = nil
    local firstcreatedtab = true

    local windowtween_grow = ts:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=windowsize})
    local windowtween_shrink = ts:Create(frame,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(windowsize.X.Scale,0,0.1,0)})

    windowfuncs.setvisible = function(bool)
        if bool then
            frame.Size = UDim2.new(0,0,0,0)
            playsound(randomopensounds[math.random(1,#randomopensounds)],0.5,1.1,0.1)
            windowtween_grow:Play()
            frame.Visible = true
        else
            windowtween_shrink:Play()
            windowtween_shrink.Completed:Wait()
            
            if windowtween_grow.PlaybackState ~= Enum.PlaybackState.Playing then
                frame.Visible = false
            end
        end

        if windowfuncs.visibilitychanged then
            windowfuncs.visibilitychanged(bool)
        end
    end

    windowfuncs.changetitle = function(text)
        titletext.Text = tostring(text)
    end

    windowfuncs.opentab = function(name)
        local tbl = tabstable[name]

        if tbl then
            selectedtab = name

            for i,v in pairs(tabstable) do
                v.contents.Visible = i == name
                v.frame.TextLabel.TextStrokeTransparency = (i == name and 0.85) or 1
            end
        else
            warn("could not find tab named '".. tostring(name).."'")
        end
    end

    windowfuncs.createtab = function(taboptions:{})
        local tabtitle = taboptions.title
        local tabicon = taboptions.icon or "rbxassetid://15549683001"

        local newtab = Instance.new("TextButton",tabslist)
        newtab.BorderSizePixel = 0
        newtab.BackgroundTransparency = 1
        newtab.Size = UDim2.new(1,0,0,55)
        newtab.Text = ""

        local tabiconimage = Instance.new("ImageLabel",newtab)
        tabiconimage.BorderSizePixel = 0
        tabiconimage.AnchorPoint = Vector2.new(0,0.5)
        tabiconimage.Position = UDim2.new(0.02,0,0.45,0)
        tabiconimage.BackgroundTransparency = 1
        tabiconimage.Size = UDim2.new(0.18,0,0.9,0)
        tabiconimage.Image = tostring(tabicon)
        tabiconimage.ScaleType = "Fit"

        local tabtitletext = Instance.new("TextLabel",newtab)
        tabtitletext.BorderSizePixel = 0
        tabtitletext.AnchorPoint = Vector2.new(0,0.5)
        tabtitletext.Position = UDim2.new(0.22,0,0.45,0)
        tabtitletext.BackgroundTransparency = 1
        tabtitletext.Size = UDim2.new(0.75,0,0.5,0)
        tabtitletext.TextXAlignment = "Left"
        tabtitletext.TextSize = 30
        tabtitletext.Text = tostring(tabtitle)
        tabtitletext.TextColor3 = Color3.new(0,0,0)
        tabtitletext.Font = Enum.Font.Cartoon
        tabtitletext.TextTruncate = "AtEnd"

        local tabseperator = Instance.new("Frame",newtab)
        tabseperator.BorderSizePixel = 0
        tabseperator.AnchorPoint = Vector2.new(0.5,1)
        tabseperator.Position = UDim2.new(0.5,0,1,0)
        tabseperator.BackgroundColor3 = Color3.fromRGB(143,143,143)
        tabseperator.Size = UDim2.new(0.9,0,0,2)

        local tabcontents = Instance.new("Frame",container)
        tabcontents.BorderSizePixel = 0
        tabcontents.AnchorPoint = Vector2.new(1,1)
        tabcontents.Position = UDim2.new(1,0,1,0)
        tabcontents.BackgroundColor3 = Color3.fromRGB(255,255,255)
        tabcontents.Size = UDim2.new(0.8,0,1,0)
        tabcontents.Visible = false

        local containertitle = Instance.new("TextLabel",tabcontents)
        containertitle.BorderSizePixel = 0
        containertitle.AnchorPoint = Vector2.new(0.5,0)
        containertitle.Position = UDim2.new(0.5,0,0,5)
        containertitle.BackgroundTransparency = 1
        containertitle.Size = UDim2.new(0.95,0,0,40)
        containertitle.TextXAlignment = "Left"
        containertitle.TextScaled = true
        containertitle.Text = tostring(tabtitle)
        containertitle.TextColor3 = Color3.new(0,0,0)
        containertitle.Font = Enum.Font.Cartoon 

        local containerseperator = Instance.new("Frame",tabcontents)
        containerseperator.BorderSizePixel = 0
        containerseperator.AnchorPoint = Vector2.new(0.5,0)
        containerseperator.Position = UDim2.new(0.5,0,0,53)
        containerseperator.BackgroundColor3 = Color3.fromRGB(143,143,143)
        containerseperator.Size = UDim2.new(0.97,0,0,2)

        local contentscroller = Instance.new("ScrollingFrame",tabcontents)
        contentscroller.BorderSizePixel = 0
        contentscroller.AnchorPoint = Vector2.new(0.5,1)
        contentscroller.Position = UDim2.new(0.5,0,1,-10)
        contentscroller.BackgroundTransparency = 1
        contentscroller.Size = UDim2.new(1,-15,1,-73)
        contentscroller.AutomaticCanvasSize = "Y"
        contentscroller.CanvasSize = UDim2.new(0,0,0,0)
        contentscroller.ScrollBarImageColor3 = Color3.new(0,0,0)
        contentscroller.ScrollBarThickness = 5

        local tabcontentslistlayout = Instance.new("UIListLayout",contentscroller)
        tabcontentslistlayout.FillDirection = "Vertical"
        tabcontentslistlayout.HorizontalAlignment = "Center"
        tabcontentslistlayout.Padding = UDim.new(0,4,0)

        tabstable[tabtitle] = {contents=tabcontents,frame=newtab}
        
        if firstcreatedtab then
            windowfuncs.opentab(tabtitle)
            firstcreatedtab = false
        end

        newtab.MouseButton1Down:Connect(function()
            windowfuncs.opentab(tabtitle)
            if not taboptions.nosfx then
                playsound("rbxassetid://135886551",0.8,1,0.2)
            end
        end)

        newtab.MouseEnter:Connect(function()
            if not taboptions.nosfx then
                playsound("rbxassetid://7249904928",0.3,1,0.2)
            end
        end)

        local tabfuncs = {}

        tabfuncs.changetitle = function(text)
            tabtitletext.Text = tostring(text)
        end

        tabfuncs.changeicon = function(id)
            tabiconimage.Image = tostring(id)
        end

        tabfuncs.newlabel = function(options:{})
            local label = Instance.new("TextLabel",contentscroller)
            label.BorderSizePixel = 0
            label.AnchorPoint = Vector2.new(0.5,0)
            label.Position = UDim2.new(0.5,0,0,5)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0.95,0,0,30)
            label.TextXAlignment = options.alignment or "Left"
            label.TextScaled = true
            label.Text = tostring(options.title)
            label.TextColor3 = options.textcolor or Color3.new(0,0,0)
            label.Font = Enum.Font.Cartoon
            
            local funcs = {}

            funcs.getcomponents = function()
                return {label}
            end

            funcs.arrange = function(num)
                base.LayoutOrder = tonumber(num)
            end

            funcs.changetitle = function(text)
                label.Text = tostring(text)
            end

            return funcs
        end

        tabfuncs.newbutton = function(options:{})
            local bgcolor = options.color or Color3.fromRGB(180,180,180)
            local hovercolor = options.hovercolor or Color3.fromRGB(math.clamp(bgcolor.R*255-25,0,255),math.clamp(bgcolor.G*255-25,0,255),math.clamp(bgcolor.B*255-25,0,255))
            local base = Instance.new("TextButton",contentscroller)
            base.BorderSizePixel = 0
            base.AnchorPoint = Vector2.new(0.5,0)
            base.Position = UDim2.new(0.5,0,0,5)
            base.BackgroundTransparency = 0
            base.BackgroundColor3 = bgcolor
            base.Size = UDim2.new(0.95,0,0,30)
            base.AutoButtonColor = false
            base.Text = ""
            givecorners(base,UDim.new(0,8))

            base.MouseButton1Down:Connect(function()
                base.BackgroundColor3 = options.clickcolor or Color3.fromRGB(math.clamp(bgcolor.R*255+40,0,255),math.clamp(bgcolor.G*255+40,0,255),math.clamp(bgcolor.B*255+40,0,255))
            
                if not options.nosfx then
                    playsound("rbxassetid://135886551",0.8,1,0.2)
                end
            end)

            base.MouseButton1Up:Connect(function()
                base.BackgroundColor3 = hovercolor

                if options.onclick then
                    task.spawn(options.onclick)
                end
            end)

            base.MouseEnter:Connect(function()
                base.BackgroundColor3 = hovercolor

                if not options.nosfx then
                    playsound("rbxassetid://7249904928",0.3,1,0.2)
                end
            end)

            base.MouseLeave:Connect(function()
                base.BackgroundColor3 = bgcolor
            end)

            local label = Instance.new("TextLabel",base)
            label.BorderSizePixel = 0
            label.AnchorPoint = Vector2.new(0.5,0.5)
            label.Position = UDim2.new(0.5,0,0.5,0)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0.95,0,1,0)
            label.TextXAlignment = options.alignment or "Left"
            label.TextScaled = true
            label.Text = tostring(options.title)
            label.TextColor3 = options.textcolor or Color3.new(0,0,0)
            label.Font = Enum.Font.Cartoon
            
            local funcs = {}

            funcs.getcomponents = function()
                return {base,label}
            end

            funcs.arrange = function(num)
                base.LayoutOrder = tonumber(num)
            end

            funcs.changetitle = function(text)
                label.Text = tostring(text)
            end

            return funcs
        end

        tabfuncs.newtoggle = function(options:{})
            local bgcolor = options.color or Color3.fromRGB(180,180,180)
            local hovercolor = options.hovercolor or Color3.fromRGB(math.clamp(bgcolor.R*255-25,0,255),math.clamp(bgcolor.G*255-25,0,255),math.clamp(bgcolor.B*255-25,0,255))
            local enabled = false
            local base = Instance.new("TextButton",contentscroller)
            base.BorderSizePixel = 0
            base.AnchorPoint = Vector2.new(0.5,0)
            base.Position = UDim2.new(0.5,0,0,5)
            base.BackgroundTransparency = 0
            base.BackgroundColor3 = bgcolor
            base.Size = UDim2.new(0.95,0,0,30)
            base.AutoButtonColor = false
            base.Text = ""
            givecorners(base,UDim.new(0,8))

            base.MouseButton1Down:Connect(function()
                base.BackgroundColor3 = options.clickcolor or Color3.fromRGB(math.clamp(bgcolor.R*255+40,0,255),math.clamp(bgcolor.G*255+40,0,255),math.clamp(bgcolor.B*255+40,0,255))
            
                if not options.nosfx then
                    playsound("rbxassetid://135886551",0.8,1,0.2)
                end
            end)
            
            base.MouseEnter:Connect(function()
                base.BackgroundColor3 = hovercolor

                if not options.nosfx then
                    playsound("rbxassetid://7249904928",0.3,1,0.2)
                end
            end)

            base.MouseLeave:Connect(function()
                base.BackgroundColor3 = bgcolor
            end)

            local label = Instance.new("TextLabel",base)
            label.BorderSizePixel = 0
            label.AnchorPoint = Vector2.new(0.5,0.5)
            label.Position = UDim2.new(0.51,0,0.5,0)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0.94,0,1,0)
            label.TextXAlignment = options.alignment or "Left"
            label.TextScaled = true
            label.Text = tostring(options.title)
            label.TextColor3 = options.textcolor or Color3.new(0,0,0)
            label.Font = Enum.Font.Cartoon

            local booltext = Instance.new("TextLabel",base)
            booltext.BorderSizePixel = 0
            booltext.AnchorPoint = Vector2.new(0,0.5)
            booltext.Position = UDim2.new(0.01,0,0.5,0)
            booltext.BackgroundColor3 = Color3.new(255,0,0)
            booltext.Size = UDim2.new(0.021,0,0.6,0)
            booltext.TextSize = 23
            booltext.Text = ""
            booltext.TextColor3 = Color3.new(0,0,0)
            booltext.Font = Enum.Font.GothamBold
            givestroke(booltext,Color3.new(0,0,0),2,"Round","Border")
            
            local function enablefunc(isenabled)
                enabled = isenabled
                booltext.Text = enabled and "X" or ""
                booltext.BackgroundColor3 = enabled and Color3.new(0,255,0) or Color3.new(255,0,0)

                if enabled then
                    if options.onenabled then
                        task.spawn(options.onenabled)
                    end
                else
                    if options.ondisabled then
                        task.spawn(options.ondisabled)
                    end
                end
            end

            base.MouseButton1Up:Connect(function()
                base.BackgroundColor3 = hovercolor
                enablefunc(not enabled)

                if options.onclick then
                    task.spawn(options.onclick)
                end
            end)

            local funcs = {}

            funcs.getcomponents = function()
                return {base,label,booltext}
            end

            funcs.arrange = function(num)
                base.LayoutOrder = tonumber(num)
            end

            funcs.changetitle = function(text)
                label.Text = tostring(text)
            end

            funcs.setenabled = function(bool)
                enablefunc(bool)
            end

            funcs.getvalue = function()
                return enabled
            end

            return funcs
        end

        tabfuncs.newslider = function(options:{})
            local bgcolor = options.color or Color3.fromRGB(180,180,180)
            local default = options.default or 1
            local lastchangedvalue = default
            local base = Instance.new("TextButton",contentscroller)
            base.BorderSizePixel = 0
            base.AnchorPoint = Vector2.new(0.5,0)
            base.Position = UDim2.new(0.5,0,0,5)
            base.BackgroundTransparency = 0
            base.BackgroundColor3 = bgcolor
            base.Size = UDim2.new(0.95,0,0,30)
            base.AutoButtonColor = false
            base.Text = ""
            givecorners(base,UDim.new(0,8))

            local label = Instance.new("TextLabel",base)
            label.BorderSizePixel = 0
            label.AnchorPoint = Vector2.new(0.5,0.5)
            label.Position = UDim2.new(0.225,0,0.5,0)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0.4,0,1,0)
            label.TextXAlignment = options.alignment or "Left"
            label.TextScaled = true
            label.Text = tostring(options.title)
            label.TextColor3 = options.textcolor or Color3.new(0,0,0)
            label.Font = Enum.Font.Cartoon

            local textbox = Instance.new("TextBox",base)
            textbox.BorderSizePixel = 0
            textbox.AnchorPoint = Vector2.new(0,0.5)
            textbox.Position = UDim2.new(0.4375,0,0.5,0)
            textbox.BackgroundColor3 = Color3.fromRGB(0,0,0)
            textbox.BackgroundTransparency = 0.85
            textbox.Size = UDim2.new(0.1,0,0.7,0)
            textbox.TextXAlignment = "Center"
            textbox.TextScaled = true
            textbox.Text = tostring(default)
            textbox.TextColor3 = Color3.new(0,0,0)
            textbox.Font = Enum.Font.Cartoon
            givecorners(textbox,UDim.new(0,4))
            givestroke(textbox,Color3.new(0,0,0),2,"Round","Border")

            local longbar = Instance.new("Frame",base)
            longbar.BorderSizePixel = 0
            longbar.AnchorPoint = Vector2.new(0,0.5)
            longbar.Position = UDim2.new(0.55,0,0.5,0)
            longbar.BackgroundColor3 = Color3.new(0,0,0)
            longbar.Size = UDim2.new(0.425,0,0,3)
            
            local leftbar = Instance.new("Frame",longbar)
            leftbar.BorderSizePixel = 0
            leftbar.AnchorPoint = Vector2.new(0,0.5)
            leftbar.Position = UDim2.new(0,0,0.5,0)
            leftbar.BackgroundColor3 = Color3.new(0,0,0)
            leftbar.Size = UDim2.new(0,3,7,0)

            local rightbar = Instance.new("Frame",longbar)
            rightbar.BorderSizePixel = 0
            rightbar.AnchorPoint = Vector2.new(1,0.5)
            rightbar.Position = UDim2.new(1,0,0.5,0)
            rightbar.BackgroundColor3 = Color3.new(0,0,0)
            rightbar.Size = UDim2.new(0,3,7,0)

            local middlebar = Instance.new("Frame",longbar)
            middlebar.BorderSizePixel = 0
            middlebar.AnchorPoint = Vector2.new(0.5,0.5)
            middlebar.Position = UDim2.new(0.5,0,0.5,0)
            middlebar.BackgroundColor3 = Color3.new(0,0,0)
            middlebar.Size = UDim2.new(0,3,6,0)

            local leftmidbar = Instance.new("Frame",longbar)
            leftmidbar.BorderSizePixel = 0
            leftmidbar.AnchorPoint = Vector2.new(0.25,0.5)
            leftmidbar.Position = UDim2.new(0.25,0,0.5,0)
            leftmidbar.BackgroundColor3 = Color3.new(0,0,0)
            leftmidbar.Size = UDim2.new(0,3,5,0)

            local rightmidbar = Instance.new("Frame",longbar)
            rightmidbar.BorderSizePixel = 0
            rightmidbar.AnchorPoint = Vector2.new(0.75,0.5)
            rightmidbar.Position = UDim2.new(0.75,0,0.5,0)
            rightmidbar.BackgroundColor3 = Color3.new(0,0,0)
            rightmidbar.Size = UDim2.new(0,3,5,0)

            local glider = Instance.new("Frame",longbar)
            glider.BorderSizePixel = 0
            glider.AnchorPoint = Vector2.new(0.5,0.5)
            glider.Position = UDim2.new(0,0,0.5,0)
            glider.BackgroundColor3 = Color3.fromRGB(125,125,125)
            glider.Size = UDim2.new(0.03,0,7,0)
            givecorners(glider,UDim.new(0,4))
            givestroke(glider,Color3.new(0,0,0),2,"Round","Border")

            local holdingdown = false
            local maxright = longbar.AbsolutePosition.X-longbar.AbsoluteSize.X*2.06

            local function updatesliderfrompercent(percent)
                local invp = 1-percent
                local value = invp*options.min+(1-invp)*options.max
                value = math.round((value)/options.increment)*options.increment
                
                local snapp = math.round((percent*options.max)/options.increment)*options.increment
                glider.Position = UDim2.new(math.clamp(snapp/options.max,0,1),0,0.5,0)
                textbox.Text = tostring(math.floor(value*(1/options.increment))/(1/options.increment))

                if not options.nosfx and lastchangedvalue ~= value then
                    playsound("rbxassetid://135886551",0.5,percent+0.3,0)
                end

                lastchangedvalue = value
                if options.onchanged then
                    options.onchanged(value)
                end
            end

            local function updatesliderfromvalue(value)
                local percent = ((options.max - value)/(options.max-options.min))
                percent = 1-(math.round(percent*100)/100)

                updatesliderfrompercent(percent)
            end
            updatesliderfromvalue(tonumber(default))
            
            local function updatesliderfrommouse()
                maxright = longbar.AbsolutePosition.X-longbar.AbsoluteSize.X*2.06
                local leftsub = math.clamp(mouse.X-longbar.AbsolutePosition.X,0,maxright)
                updatesliderfrompercent(math.clamp(leftsub/maxright,0,1))
            end

            textbox.FocusLost:Connect(function()
                updatesliderfromvalue(tonumber(textbox.Text) or lastchangedvalue)
            end)

            local inputendcon
            local mousemovecon
            base.MouseButton1Down:Connect(function()
                holdingdown = true
                
                updatesliderfrommouse()
                mousemovecon = mouse.Move:Connect(function()
                    updatesliderfrommouse()
                end)

                inputendcon = us.InputEnded:Connect(function(key,pro)
                    if key.UserInputType == Enum.UserInputType.MouseButton1 then
                        holdingdown = false

                        if mousemovecon then
                            mousemovecon:Disconnect()
                            mousemovecon = nil
                        end

                        inputendcon:Disconnect()
                        inputendcon = nil
                    end
                end)
            end)

            base.MouseEnter:Connect(function()
                if not options.nosfx then
                    playsound("rbxassetid://7249904928",0.3,1,0.2)
                end
            end)

            local funcs = {}

            funcs.getcomponents = function()
                return {base,label}
            end

            funcs.arrange = function(num)
                base.LayoutOrder = tonumber(num)
            end

            funcs.changetitle = function(text)
                label.Text = tostring(text)
            end

            funcs.setvalue = function(num)
                updatesliderfromvalue(tonumber(num))
            end

            funcs.setpercent = function(num)
                updatesliderfrompercent(tonumber(num))
            end

            funcs.getvalue = function()
                return lastchangedvalue
            end

            return funcs
        end

        return tabfuncs
    end

    us.InputBegan:Connect(function(key,pro)
        if not pro and key.KeyCode == keybind then
            windowfuncs.setvisible(not frame.Visible)
        end
    end)
    windowfuncs.setvisible(true)

    task.spawn(function()
        while screengui.Parent == game.CoreGui do
            if frame.Visible then
                us.MouseBehavior = Enum.MouseBehavior.Default
            end
            us.MouseIconEnabled = frame.Visible
            task.wait()
        end
        us.MouseBehavior = Enum.MouseBehavior.LockCenter
        us.MouseIconEnabled = false
    end)

    return windowfuncs
end

-- task.delay(2,function()
--     screengui:Destroy()
-- end)

-- local window = library.createwindow({title="welcome!"})
-- local tab = window.createtab({title="hacks"})
-- local tab2 = window.createtab({title="miscellaneous"})
-- tab.newlabel({title="default"})
-- tab.newlabel({title="center",alignment="Center"})
-- tab.newlabel({title="right",alignment="Right"})
-- tab.newlabel({title="red text",textcolor=Color3.fromRGB(255,0,0)})
-- tab.newbutton({title="clicky",textcolor=Color3.fromRGB(0,0,0)})
-- tab.newbutton({title="click whoaaaaaaaaaaaaaaaaaaaaaaaa",alignment="Center",textcolor=Color3.fromRGB(255,255,0),color=Color3.fromRGB(150,150,0)})
-- tab.newbutton({title="hover/click color",textcolor=Color3.fromRGB(255,0,0),hovercolor=Color3.fromRGB(0,255,0),clickcolor=Color3.fromRGB(0,0,255)})
-- tab.newbutton({title="no sfx",nosfx=true})
-- tab.newbutton({title="print test",onclick=function()
--     print("hello world")
-- end})

-- tab.newtoggle({title="toggle print test",onclick=function()
--     print("clicked toggle")
-- end,onenabled=function()
--     print("enabled")
-- end,ondisabled=function()
--     print("disabled")
-- end})

-- tab.newslider({onchanged=function(value)
--     print(value)
-- end, title="slider",textcolor=Color3.fromRGB(155,15,250),min=3,max=17,increment=1,default=4})

return library
