local FS_Lib = exports['FS-Lib']

local updateRate = 1500
CreateThread(function()
    while true do
        local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if Vehicle ~= 0 then
            if not IsVehicleAttachedToTrailer(Vehicle) then
                if GetEntityBoneIndexByName(Vehicle, 'attach_female') ~= -1 then
                    local closestTrailer = FS_Lib:GetClosestTrailerToHitch(config.maxDistance)
                    if closestTrailer ~= nil and closestTrailer ~= 0 then
                        if config.autoAttachToTrailer then
                            AttachVehicleToTrailer(Vehicle, closestTrailer, 1.2)
                        else
                            updateRate = 0
                            FS_Lib:DrawText2D(0.5, 0.8, '~g~[' .. FS_Lib:GetKeyString(config.attachTrailerKeybind) .. ']~w~ '  .. config.locales['attachToTrailer'], 0.6, true)
                            if IsControlJustPressed(0, config.attachTrailerKeybind) then
                                AttachVehicleToTrailer(Vehicle, closestTrailer, 1.2)
                            end
                        end
                    else
                        updateRate = 1500
                    end
                end
            end

        end
        Wait(updateRate)
    end
end)