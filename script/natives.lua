local _i, _f, _v, _r, _ri, _rf, _s, _rv, _in, _ii, _fi =
	Citizen.PointerValueInt(), Citizen.PointerValueFloat(), Citizen.PointerValueVector(),
	Citizen.ReturnResultAnyway(), Citizen.ResultAsInteger(), Citizen.ResultAsFloat(), Citizen.ResultAsString(), Citizen.ResultAsVector(),
	Citizen.InvokeNative, Citizen.PointerValueIntInitialized, Citizen.PointerValueFloatInitialized

local _tostring = tostring
local function _ts(num)
	if num == 0 or not num then -- workaround for users calling string parameters with '0', also nil being translated
		return nil
	end
	return _tostring(num)
end


-- CFX NATIVES

function TriggerEventInternal(eventName, eventPayload, payloadLength)
	return _in(0x91310870, _ts(eventName), _ts(eventPayload), payloadLength)
end

function TriggerServerEventInternal(eventName, eventPayload, payloadLength)
	return _in(0x7fdd1128, _ts(eventName), _ts(eventPayload), payloadLength)
end

function WasEventCanceled()
	return _in(0x58382a19, _r)
end

function CancelEvent()
	return _in(0xfa29d35d)
end

function GetNumResourceMetadata(resourceName, metadataKey)
	return _in(0x776e864, _ts(resourceName), _ts(metadataKey), _r, _ri)
end

function GetResourceMetadata(resourceName, metadataKey, index)
	return _in(0x964bab1d, _ts(resourceName), _ts(metadataKey), index, _r, _s)
end

function LoadResourceFile(resourceName, fileName)
	return _in(0x76a9ee1f, _ts(resourceName), _ts(fileName), _r, _s)
end

function InvokeFunctionReference(referenceIdentity, argsSerialized, argsLength, retvalLength)
	return _in(0xe3551879, _ts(referenceIdentity), _ts(argsSerialized), argsLength, _ii(retvalLength), _r, _s)
end

function DuplicateFunctionReference(referenceIdentity)
	return _in(0xf4e2079d, _ts(referenceIdentity), _r, _s)
end

function DeleteFunctionReference(referenceIdentity)
	return _in(0x1e86f206, _ts(referenceIdentity))
end

function GetCurrentResourceName()
	return _in(0xe5e9ebbb, _r, _s)
end

function RegisterNuiCallbackType(callbackType)
	return _in(0xcd03cda9, _ts(callbackType))
end

function SendNuiMessage(jsonString)
	return _in(0x78608acb, _ts(jsonString), _r)
end

function SetNuiFocus(hasFocus, hasCursor)
	return _in(0x5b98ae30, hasFocus, hasCursor)
end

function SetLoadingText(text)
	return _in(0x89315432, _ts(text))
end

function SafeguardDisconnect(state)
	return _in(0x9dba67f2, state)
end

function NetworkChangeExtendedGameConfigCit()
	return _in(0xfc214b77)
end

function ShutdownNetworkCit()
	return _in(0x45871100)
end

function GetNuiCursorPosition()
	return _in(0xbdba226f, _i, _i)
end

function GetPlayerServerId(player)
	return _in(0x4d97bcc7, player, _r, _ri)
end

function GetPlayerFromServerId(serverId)
	return _in(0x344ea166, serverId, _r, _ri)
end

function GetHudPosition(name)
	return _in(0x87ecdb1b, name, _i, _i)
end

function GetHudSize(name)
	return _in(0x38418be0, name, _i, _i)
end

function SetNetworkWalkModeEnabled(state)
	return _in(0x7b173ed2, state)
end

function AddTextEntry(entryKey, entryText)
	return _in(0x32ca01c3, _ts(entryKey), _ts(entryText))
end

function AddTextEntryByHash(entryKey, entryText)
	return _in(0x289da860, entryKey, _ts(entryText))
end


-- GAME NATIVES

function AbortAllGarageActivity()
	return _in(0x5DB95843)
end

function AbortScriptedConversation(abort)
	return _in(0x57DB70CE, abort, _ri)
end

function Absf(value)
	return _in(0x067640F3, value, _rf)
end

function Absi(value)
	return _in(0x75A648B7, value, _rf)
end

function Acos(Unk496)
	return _in(0x2E746E53, Unk496, _rf)
end

function ActivateCheat(cheat)
	return _in(0x69E742FC, cheat)
end

function ActivateDamageTrackerOnNetworkId(Unk897, Unk898)
	return _in(0x01181CA3, Unk897, Unk898)
end

function ActivateFrontend()
	return _in(0x3C64626F)
end

function ActivateHeliSpeedCheat(heli, cheat)
	return _in(0x033B52CA, heli, cheat)
end

function ActivateInterior(interior, unknownTrue)
	return _in(0x66DD4F67, interior, unknownTrue)
end

function ActivateMenuItem(menuid, item, activate)
	return _in(0x608237A4, menuid, item, activate)
end

function ActivateNetworkSettingsMenu()
	return _in(0x609D0203)
end

function ActivateReplayMenu()
	return _in(0x61040B08)
end

function ActivateSaveMenu()
	return _in(0x78AC735F)
end

function ActivateScriptPopulationZone()
	return _in(0x03F90052)
end

function ActivateScriptedCams(Unk538, Unk539)
	return _in(0x3EBE11B9, Unk538, Unk539)
end

function ActivateVectorMap()
	return _in(0x2E7D1C82, _r)
end

function ActivateViewport(viewportid, activate)
	return _in(0x4D7D105A, viewportid, activate)
end

function AddAdditionalPopulationModel(model)
	return _in(0x7EDE120F, model)
end

function AddAmmoToChar(ped, weapon, amount)
	return _in(0x1ADA0C3A, ped, weapon, amount)
end

function AddAreaToNetworkRestartNodeGroupMapping()
	return _in(0x52DF5310, _r)
end

function AddArmourToChar(ped, amount)
	return _in(0x1C623537, ped, amount)
end

function AddBlipForCar(vehicle, pBlip)
	return _in(0x6D21564D, vehicle, _ii(pBlip))
end

function AddBlipForChar(ped, pBlip)
	return _in(0x19A64C5D, ped, _ii(pBlip))
end

function AddBlipForContact(x, y, z, pBlip)
	return _in(0x7C671162, x, y, z, _ii(pBlip))
end

function AddBlipForCoord(x, y, z, pBlip)
	return _in(0x3E7D3074, x, y, z, _ii(pBlip))
end

function AddBlipForGangTerritory(x0, y0, x1, y1, colour, blip)
	return _in(0x2C1B52CE, x0, y0, x1, y1, colour, _ii(blip))
end

function AddBlipForObject(obj, pBlip)
	return _in(0x70CC1487, obj, _ii(pBlip))
end

function AddBlipForPickup(pickup, pBlip)
	return _in(0x04F567FB, pickup, _ii(pBlip))
end

function AddBlipForRadius(x, y, z, type, blip)
	return _in(0x21804D1A, x, y, z, type, _ii(blip))
end

function AddBlipForWeapon(x, y, z, blip)
	return _in(0x4CA708B9, x, y, z, _ii(blip))
end

function AddCamSplineNode(cam, camnode)
	return _in(0x3B4F1EBA, cam, camnode)
end

function AddCarToMissionDeletionList(car)
	return _in(0x45E80BF7, car)
end

function AddCharDecisionMakerEventResponse(dm, eventid, responseid, param1, param2, param3, param4, unknown0_1, unknown1_1)
	return _in(0x65536ECF, dm, eventid, responseid, param1, param2, param3, param4, unknown0_1, unknown1_1)
end

function AddCoverBlockingArea(Unk110, Unk111, Unk112, Unk113, Unk114, Unk115, Unk116, Unk117, Unk118)
	return _in(0x6E856548, Unk110, Unk111, Unk112, Unk113, Unk114, Unk115, Unk116, Unk117, Unk118)
end

function AddCoverPoint(Unk119, Unk120, Unk121, Unk122, Unk123, Unk124, Unk125, Unk126)
	return _in(0x18D5264D, Unk119, Unk120, Unk121, Unk122, Unk123, Unk124, Unk125, Unk126)
end

function AddExplosion(x, y, z, exptype, radius, playsound, novisual, camshake)
	return _in(0x32DA5E3A, x, y, z, exptype, radius, playsound, novisual, camshake)
end

function AddExplosionWithDirection()
	return _in(0x71855E7C, _r)
end

function AddFirstNCharactersOfStringToHtmlScriptObject(htmlobj, str, n)
	return _in(0x75FC34EF, htmlobj, _ts(str), n)
end

function AddFollowNavmeshToPhoneTask(ped, Unk127, Unk128, Unk129)
	return _in(0x7F5D69C4, ped, Unk127, Unk128, Unk129)
end

function AddGroupDecisionMakerEventResponse(dm, eventid, responseid, param1, param2, param3, param4, unknown0_1, unknown1_1)
	return _in(0x40CF3953, dm, eventid, responseid, param1, param2, param3, param4, unknown0_1, unknown1_1)
end

function AddGroupToNetworkRestartNodeGroupList(Unk899)
	return _in(0x592E0E0F, Unk899)
end

function AddHospitalRestart(x, y, z, radius, islandnum)
	return _in(0x2AB06643, x, y, z, radius, islandnum)
end

function AddLineToConversation(Unk522, Unk523, Unk524, Unk525, Unk526)
	return _in(0x75080482, Unk522, Unk523, Unk524, Unk525, Unk526)
end

function AddLineToMobilePhoneCall(id, name, text)
	return _in(0x0BED1DDE, id, _ts(name), _ts(text))
end

function AddLineToScriptedConversation(conversation, Unk527, Unk528)
	return _in(0x416413F6, conversation, Unk527, Unk528)
end

function AddNavmeshRequiredRegion(x, y, z)
	return _in(0x6CB64BDB, x, y, z, _ri)
end

function AddNeededAtPosn(x, y, z)
	return _in(0x2E831921, x, y, z)
end

function AddNetworkRestart()
	return _in(0x6A6A12D7, _r)
end

function AddNewConversationSpeaker(id, Unk529, Unk530)
	return _in(0x542D499E, id, Unk529, _ii(Unk530))
end

function AddNewFrontendConversationSpeaker(Unk531, Unk532)
	return _in(0x13D44996, Unk531, Unk532)
end

function AddNextMessageToPreviousBriefs(add)
	return _in(0x1B086D33, add)
end

function AddObjectToInteriorRoomByKey(obj, roomKey)
	return _in(0x67D83807, obj, roomKey)
end

function AddObjectToInteriorRoomByName(obj, room_name)
	return _in(0x076863C9, obj, _ts(room_name))
end

function AddPedQueue()
	return _in(0x4E043F3C, _r)
end

function AddPedToCinematographyAi(Unk28, ped)
	return _in(0x62687944, Unk28, ped)
end

function AddPedToMissionDeletionList(ped, Unk29)
	return _in(0x10F64FBF, ped, Unk29)
end

function AddPickupToInteriorRoomByKey(pickup, room_hash)
	return _in(0x198B786F, pickup, room_hash)
end

function AddPickupToInteriorRoomByName(pickup, roomName)
	return _in(0x0365042F, pickup, _ts(roomName))
end

function AddPointToGpsRaceTrack(point)
	return _in(0x5BE115FD, _v)
end

function AddPoliceRestart(x, y, z, radius, islandnum)
	return _in(0x42492860, x, y, z, radius, islandnum)
end

function AddScenarioBlockingArea(x0, y0, z0, x1, y1, z1)
	return _in(0x4C1E3A64, x0, y0, z0, x1, y1, z1)
end

function AddScore(playerIndex, score)
	return _in(0x537379A8, playerIndex, score)
end

function AddSimpleBlipForPickup(pickup)
	return _in(0x44B30452, pickup)
end

function AddSpawnBlockingArea(Unk900, Unk901, Unk902, Unk903)
	return _in(0x36DF37DB, Unk900, Unk901, Unk902, Unk903)
end

function AddSpawnBlockingDisc(Unk904, Unk905, Unk906, Unk907, Unk908)
	return _in(0x2B4E2A8C, Unk904, Unk905, Unk906, Unk907, Unk908)
end

function AddSphere(x, y, z, radius, Unk)
	return _in(0x42252652, x, y, z, radius, Unk, _ri)
end

function AddStringToHtmlScriptObject(htmlobj, str)
	return _in(0x7EB70379, htmlobj, _ts(str))
end

function AddStringToNewsScrollbar(str)
	return _in(0x192E5726, _ts(str))
end

function AddStringWithThisTextLabelToPreviousBrief(gxtname)
	return _in(0x76860554, _ts(gxtname))
end

function AddStuckCarCheck(car, stuckdif, timeout)
	return _in(0x03A01B12, car, stuckdif, timeout)
end

function AddStuckCarCheckWithWarp(car, stuckdif, time, flag0, flag1, flag2, flag3)
	return _in(0x3BCA4ACA, car, stuckdif, time, flag0, flag1, flag2, flag3)
end

function AddStuntJump(x, y, z, x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3, reward)
	return _in(0x422E7AC3, x, y, z, x0, y0, z0, x1, y1, z1, x2, y2, z2, x3, y3, z3, reward)
end

function AddTextWidget(Unk1089)
	return _in(0x7537050D, Unk1089, _s)
end

function AddTickerToPreviousBriefWithUnderscore(Unk625, Unk626, Unk627, Unk628, Unk629, Unk630, Unk631)
	return _in(0x020E0318, Unk625, Unk626, Unk627, Unk628, Unk629, Unk630, Unk631)
end

function AddToHtmlScriptObject(htmlobj, htmlcode)
	return _in(0x3ECC0086, htmlobj, _ts(htmlcode))
end

function AddToPreviousBrief(gxtentry)
	return _in(0x446E6515, _ts(gxtentry))
end

function AddToPreviousBriefWithUnderscore(gxtentry)
	return _in(0x3D0A71A2, _ts(gxtentry))
end

function AddToWidgetCombo(Unk1091)
	return _in(0x4F0D4AC7, Unk1091)
end

function AddUpsidedownCarCheck(vehicle)
	return _in(0x557C076C, vehicle)
end

function AddWidgetFloatReadOnly(Unk1092, Unk1093)
	return _in(0x4C8A7614, Unk1092, Unk1093)
end

function AddWidgetFloatSlider(Unk1094, Unk1095, Unk1096, Unk1097, Unk1098)
	return _in(0x6F9256DF, Unk1094, Unk1095, Unk1096, Unk1097, Unk1098)
end

function AddWidgetReadOnly(Unk1099, Unk1100)
	return _in(0x4A2E3BCA, Unk1099, Unk1100)
end

function AddWidgetSlider(Unk1101, Unk1102, Unk1103, Unk1104, Unk1105)
	return _in(0x4A904476, Unk1101, Unk1102, Unk1103, Unk1104, Unk1105)
end

function AddWidgetString(Unk1106)
	return _in(0x27D20F21, Unk1106)
end

function AddWidgetToggle(Unk1107, Unk1108)
	return _in(0x66F47727, Unk1107, Unk1108)
end

function AllocateScriptToObject(ScriptName, model, Unk602, radius, UnkTime)
	return _in(0x71C30148, _ts(ScriptName), model, Unk602, radius, UnkTime)
end

function AllocateScriptToRandomPed(ScriptName, model, Unk603, flag)
	return _in(0x19DB19D8, _ts(ScriptName), model, Unk603, flag)
end

function AllowAutoConversationLookats(ped, allow)
	return _in(0x736D423E, ped, allow)
end

function AllowEmergencyServices(allow)
	return _in(0x69A72C50, allow)
end

function AllowGameToPauseForStreaming(allow)
	return _in(0x085E559E, allow)
end

function AllowGangRelationshipsToBeChangedByNextCommand(value)
	return _in(0x585157FE, value)
end

function AllowLockonToFriendlyPlayers(player, allow)
	return _in(0x362B5D1B, player, allow)
end

function AllowLockonToRandomPeds(player, allow)
	return _in(0x6FE455D8, player, allow)
end

function AllowMultipleDrivebyPickups(allow)
	return _in(0x7FC02528, allow)
end

function AllowNetworkPopulationGroupCycling()
	return _in(0x61C100F5, _r)
end

function AllowOneTimeOnlyCommandsToRun()
	return _in(0x3B2E3198, _r)
end

function AllowPlayerToCarryNonMissionObjects(playerIndex, allow)
	return _in(0x6A0A724C, playerIndex, allow)
end

function AllowReactionAnims(ped, allow)
	return _in(0x0FEA6230, ped, allow)
end

function AllowScenarioPedsToBeReturnedByNextCommand(value)
	return _in(0x6EEE7E6C, value)
end

function AllowStuntJumpsToTrigger(allow)
	return _in(0x5E8D7E3F, allow)
end

function AllowTargetWhenInjured(ped, allow)
	return _in(0x33F8250B, ped, allow)
end

function AllowThisScriptToBePaused(allows)
	return _in(0x3514533B, allows)
end

function AlterWantedLevel(playerIndex, level)
	return _in(0x60C80EC9, playerIndex, level)
end

function AlterWantedLevelNoDrop(playerIndex, level)
	return _in(0x5F3B6079, playerIndex, level)
end

function AlwaysUseHeadOnHornAnimWhenDeadInCar(ped, use)
	return _in(0x7C156670, ped, use)
end

function AmbientAudioBankNoLongerNeeded()
	return _in(0x292349C7)
end

function AnchorBoat(boat, anchor)
	return _in(0x2E12687B, boat, anchor)
end

function AnchorObject(obj, anchor, flags)
	return _in(0x5785181B, obj, anchor, flags)
end

function ApplyForceToCar(vehicle, unknown0_3, x, y, z, spinX, spinY, spinZ, unknown4_0, unknown5_1, unknown6_1, unknown7_1)
	return _in(0x434611A3, vehicle, unknown0_3, x, y, z, spinX, spinY, spinZ, unknown4_0, unknown5_1, unknown6_1, unknown7_1)
end

function ApplyForceToObject(obj, uk0_3, pX, pY, pZ, spinX, spinY, spinZ, uk4_0, uk5_1, uk6_1, uk7_1)
	return _in(0x438F6ECB, obj, uk0_3, pX, pY, pZ, spinX, spinY, spinZ, uk4_0, uk5_1, uk6_1, uk7_1)
end

function ApplyForceToPed(ped, unknown0_3, x, y, z, spinX, spinY, spinZ, unknown4_0, unknown5_1, unknown6_1, unknown7_1)
	return _in(0x7305301D, ped, unknown0_3, x, y, z, spinX, spinY, spinZ, unknown4_0, unknown5_1, unknown6_1, unknown7_1)
end

function ApplyWantedLevelChangeNow(playerIndex)
	return _in(0x705A6ED9, playerIndex)
end

function AreAllNavmeshRegionsLoaded()
	return _in(0x73737990, _r)
end

function AreAnyCharsNearChar(ped, radius)
	return _in(0x0F4A4FB2, ped, radius, _r)
end

function AreCreditsFinished()
	return _in(0x63A669B6, _r)
end

function AreEnemyPedsInArea(ped, x, y, z, radius)
	return _in(0x5C081186, ped, x, y, z, radius, _r)
end

function AreTaxiLightsOn(vehicle)
	return _in(0x5F4B0B22, vehicle, _r)
end

function AreWidescreenBordersActive()
	return _in(0x4FE17259, _r)
end

function AsciiIntToString(ascii)
	return _in(0x7F4C0E47, ascii, _s)
end

function Asin(value)
	return _in(0x590A6F04, value, _rf)
end

function Atan(value)
	return _in(0x7FFE0A12, value, _rf)
end

function Atan2(Unk497, Unk498)
	return _in(0x10A1449C, Unk497, Unk498, _rf)
end

function AttachAnimsToModel(model, anims)
	return _in(0x0B5704E0, model, _ts(anims))
end

function AttachCamToObject(cam, obj)
	return _in(0x2966710D, cam, obj)
end

function AttachCamToPed(cam, ped)
	return _in(0x78B00CB2, cam, ped)
end

function AttachCamToVehicle(cam, veh)
	return _in(0x5E564CFF, cam, veh)
end

function AttachCamToViewport(cam, viewportid)
	return _in(0x21A3110A, cam, viewportid)
end

function AttachCarToCar(car0, car1, Unk51, x0, y0, z0, x1, y1, z1)
	return _in(0x64146142, car0, car1, Unk51, x0, y0, z0, x1, y1, z1)
end

function AttachCarToCarPhysically(vehid1, vehid2, Unk52, Unk53, xoffset, yoffset, zoffset, xbuffer, ybuffer, zbuffer, xrotateveh1, yrotateveh1, Unk54, Unk55, Unk56)
	return _in(0x778F46E3, vehid1, vehid2, Unk52, Unk53, xoffset, yoffset, zoffset, xbuffer, ybuffer, zbuffer, xrotateveh1, yrotateveh1, Unk54, Unk55, Unk56)
end

function AttachCarToObject(car, obj, Unk57, Unk58, Unk59, Unk60, Unk61, Unk62, Unk63)
	return _in(0x61C81E88, car, obj, Unk57, Unk58, Unk59, Unk60, Unk61, Unk62, Unk63)
end

function AttachCarToObjectPhysically()
	return _in(0x32E57C15, _r)
end

function AttachObjectToCar(obj, v, unknown0_0, pX, pY, pZ, rX, rY, rZ)
	return _in(0x7E81412A, obj, v, unknown0_0, pX, pY, pZ, rX, rY, rZ)
end

function AttachObjectToCarPhysically(obj, car, Unk79, Unk80, Unk81, Unk82, Unk83, Unk84, Unk85, Unk86, Unk87, Unk88, Unk89, Unk90, flag)
	return _in(0x161B05A9, obj, car, Unk79, Unk80, Unk81, Unk82, Unk83, Unk84, Unk85, Unk86, Unk87, Unk88, Unk89, Unk90, flag)
end

function AttachObjectToObject(obj0, obj1_attach_to, Unk91, x0, y0, z0, x1, y1, z1)
	return _in(0x089E42C1, obj0, obj1_attach_to, Unk91, x0, y0, z0, x1, y1, z1)
end

function AttachObjectToObjectPhysically()
	return _in(0x28663AA6, _r)
end

function AttachObjectToPed(obj, c, bone, pX, pY, pZ, rX, rY, rZ, unknown1_0)
	return _in(0x577A699E, obj, c, bone, pX, pY, pZ, rX, rY, rZ, unknown1_0)
end

function AttachObjectToPedPhysically(obj, c, unknown, bone, pX, pY, pZ, rX, rY, rZ, unknown1_0, unknown2_0)
	return _in(0x1F760E1A, obj, c, unknown, bone, pX, pY, pZ, rX, rY, rZ, unknown1_0, unknown2_0)
end

function AttachParachuteModelToPlayer(ped, obj)
	return _in(0x7EDD58E1, ped, obj)
end

function AttachPedToCar(ped, vehicle, unknown0_0, offsetX, offsetY, offsetZ, rotX, rotY, Unk64, Unk65)
	return _in(0x3EFC1A7D, ped, vehicle, unknown0_0, offsetX, offsetY, offsetZ, rotX, rotY, Unk64, Unk65)
end

function AttachPedToCar2()
	return _in(0x10C91E4D, _r)
end

function AttachPedToCarPhysically(ped, car, pedbone, x, y, z, angle, Unk30, Unk31, Unk32)
	return _in(0x7FF3248C, ped, car, pedbone, x, y, z, angle, Unk30, Unk31, Unk32)
end

function AttachPedToObject(ped, obj, pedbone, x, y, z, angle, Unk33, Unk34, Unk35)
	return _in(0x376917AB, ped, obj, pedbone, x, y, z, angle, Unk33, Unk34, Unk35)
end

function AttachPedToObjectPhysically(ped, obj, pedbone, x, y, z, angle, Unk36, Unk37, Unk38)
	return _in(0x782E78BF, ped, obj, pedbone, x, y, z, angle, Unk36, Unk37, Unk38)
end

function AttachPedToShimmyEdge(ped, x, y, z, Unk39)
	return _in(0x0860560B, ped, x, y, z, Unk39)
end

function AttachPedToWorldPhysically()
	return _in(0x58086CC7, _r)
end

function AwardAchievement(achievement)
	return _in(0x5ED03255, achievement, _ri)
end

function AwardPlayerMissionRespect(respect)
	return _in(0x7783449D, respect)
end

function BeginCamCommands(Unk540)
	return _in(0x351F4C86, _ii(Unk540))
end

function BeginCharSearchCriteria()
	return _in(0x43F86230)
end

function BeginPedQueueMembershipList()
	return _in(0x28CA3430, _r)
end

function BlendFromNmWithAnim(ped, AnimName0, AnimName1, Unk1, x, y, z)
	return _in(0x6E405BD5, ped, _ts(AnimName0), _ts(AnimName1), Unk1, x, y, z)
end

function BlendOutCharMoveAnims(ped)
	return _in(0x65A34B7A, ped)
end

function BlockCharAmbientAnims(ped, block)
	return _in(0x1A2D7640, ped, block)
end

function BlockCharGestureAnims(ped, value)
	return _in(0x1C144E4E, ped, value)
end

function BlockCharHeadIk(ped, block)
	return _in(0x3EFA66E8, ped, block)
end

function BlockCharVisemeAnims(ped, block)
	return _in(0x44881D27, ped, block)
end

function BlockCoweringInCover(ped, set)
	return _in(0x1866612D, ped, set)
end

function BlockPedWeaponSwitching(ped, value)
	return _in(0x315238D5, ped, value)
end

function BlockPeekingInCover(ped, set)
	return _in(0x15101503, ped, set)
end

function BlockStatsMenuActions(player)
	return _in(0x734E3F62, player)
end

function BreakCarDoor(vehicle, door, unknownFalse)
	return _in(0x18BD071B, vehicle, door, unknownFalse)
end

function Breakpoint()
	return _in(0x5AE10E31, _r)
end

function BurstCarTyre(vehicle, tyre)
	return _in(0x690D344F, vehicle, tyre)
end

function CalculateChecksum(Unk1006, Unk1007)
	return _in(0x18A302CD, Unk1006, Unk1007, _ri)
end

function CalculateFurthestNetworkRestartNodes()
	return _in(0x8476FCF, _r)
end

function CalculateTravelDistanceBetweenNodes(x0, y0, z0, x1, y1, z1)
	return _in(0x09A558A5, x0, y0, z0, x1, y1, z1, _rf)
end

function CamIsSphereVisible(camera, pX, pY, pZ, radius)
	return _in(0x2D5611D4, camera, pX, pY, pZ, radius, _r)
end

function CamProcess(cam)
	return _in(0x52411DDA, cam)
end

function CamRestore()
	return _in(0x348F612D)
end

function CamRestoreJumpcut()
	return _in(0x538021CD)
end

function CamSequenceClose()
	return _in(0x5D975A46)
end

function CamSequenceGetProgress(Unk541, progress)
	return _in(0x7AAD273F, Unk541, _ii(progress))
end

function CamSequenceOpen(Unk542)
	return _in(0x5D867A02, Unk542)
end

function CamSequenceRemove(Unk543)
	return _in(0x01473ACB, Unk543)
end

function CamSequenceStart(Unk544)
	return _in(0x26335EE7, Unk544)
end

function CamSequenceStop(Unk545)
	return _in(0x282E4EFB, Unk545)
end

function CamSequenceWait(cam, time)
	return _in(0x0D970483, cam, time)
end

function CamSetCinematic(veh, set)
	return _in(0x63A86D87, veh, set)
end

function CamSetDollyZoomLock(cam, set)
	return _in(0x25071DF3, cam, set)
end

function CamSetInterpGraphPos(cam, Unk547)
	return _in(0x3C7C3E89, cam, Unk547)
end

function CamSetInterpGraphRot(cam, val)
	return _in(0x1C5B7C51, cam, val)
end

function CamSetInterpStateSrc(cam, Unk548)
	return _in(0x32C67124, cam, Unk548)
end

function CamSetInterpStateSrc(Unk549, Unk550)
	return _in(0x32C67124, Unk549, Unk550)
end

function CamSetInterpolationDetails(Unk546)
	return _in(0x5AAC39C1, Unk546)
end

function CanBeDescribedAsACar(veh)
	return _in(0x79103802, veh, _r)
end

function CanCharSeeDeadChar(ped, pednext)
	return _in(0x7ED82ED9, ped, pednext, _r)
end

function CanCreateRandomChar(flag0, flag1)
	return _in(0x5CD64D63, flag0, flag1, _r)
end

function CanFontBeLoaded(fontid)
	return _in(0x1E2A5820, fontid, _r)
end

function CanPedShimmyInDirection(ped, direction)
	return _in(0x6D1E5C25, ped, direction, _r)
end

function CanPhoneBeSeenOnScreen()
	return _in(0x5C9863F6, _r)
end

function CanPlayerStartMission(player)
	return _in(0x02A235D0, player, _r)
end

function CanRegisterMissionEntities()
	return _in(0x66FD3CFC, _r)
end

function CanRegisterMissionObject()
	return _in(0x42F1557D, _r)
end

function CanRegisterMissionPed()
	return _in(0x1DC730B8, _r)
end

function CanRegisterMissionVehicle()
	return _in(0x200A510B, _r)
end

function CanRenderRadiohudSpriteInMobilePhone()
	return _in(0x58F209BD, _r)
end

function CanStartMissionPassedTune()
	return _in(0x22AB641D, _r)
end

function CanTheStatHaveString(stat)
	return _in(0x0B651AFB, stat, _r)
end

function CancelCurrentlyPlayingAmbientSpeech(ped)
	return _in(0x495D445F, ped)
end

function CancelCurrentlyPlayingAmbientSpeech(ped)
	return _in(0x495D445F, ped)
end

function CancelOverrideRestart()
	return _in(0x6ED83424)
end

function Ceil(value)
	return _in(0x76181322, value, _ri)
end

function CellCamActivate(Unk551, Unk552)
	return _in(0x446F74E5, Unk551, Unk552)
end

function CellCamIsCharVisible(ped)
	return _in(0x0D6C0836, ped, _r)
end

function CellCamIsCharVisibleNoFaceCheck(ped)
	return _in(0x770600CF, ped, _r)
end

function CellCamSetCentrePos(x, y)
	return _in(0x32C67003, x, y)
end

function CellCamSetColourBrightness(Unk553, Unk554, Unk555, Unk556)
	return _in(0x4ECB189E, Unk553, Unk554, Unk555, Unk556)
end

function CellCamSetZoom(zoom)
	return _in(0x087C5347, zoom)
end

function ChangeBlipAlpha(blip, alpha)
	return _in(0x2FB14E41, blip, alpha)
end

function ChangeBlipColour(blip, colour)
	return _in(0x1D8800E3, blip, colour)
end

function ChangeBlipDisplay(blip, display)
	return _in(0x3ACC1794, blip, display)
end

function ChangeBlipNameFromAscii(blip, blipName)
	return _in(0x6C9F2330, blip, _ts(blipName))
end

function ChangeBlipNameFromTextFile(blip, gxtName)
	return _in(0x0A9D695E, blip, _ts(gxtName))
end

function ChangeBlipNameToPlayerName(blip, playerid)
	return _in(0x731B11A7, blip, playerid)
end

function ChangeBlipPriority(blip, priority)
	return _in(0x69EC0E70, blip, priority)
end

function ChangeBlipRotation(blip, rotation)
	return _in(0x3AF307B1, blip, rotation)
end

function ChangeBlipScale(blip, scale)
	return _in(0x44D349D9, blip, scale)
end

function ChangeBlipSprite(blip, sprite)
	return _in(0x6A90123D, blip, sprite)
end

function ChangeBlipTeamRelevance(blip, relevance)
	return _in(0x4B2625BE, blip, relevance)
end

function ChangeCarColour(vehicle, colour1, colour2)
	return _in(0x06441EAF, vehicle, colour1, colour2)
end

function ChangeCharSitIdleAnim(ped, Unk2, Unk3, Unk4)
	return _in(0x7B2822F7, ped, Unk2, Unk3, Unk4)
end

function ChangeGarageType(garage, type)
	return _in(0x6E0A438A, garage, type)
end

function ChangePickupBlipColour(colour)
	return _in(0x65D949B7, colour)
end

function ChangePickupBlipDisplay(display)
	return _in(0x3E5F2362, display)
end

function ChangePickupBlipPriority(priority)
	return _in(0x31321D1A, priority)
end

function ChangePickupBlipScale(scale)
	return _in(0x4F66544E, scale)
end

function ChangePickupBlipSprite(sprite)
	return _in(0x05766DDE, sprite)
end

function ChangePlaybackToUseAi(car)
	return _in(0x76EB2878, car)
end

function ChangePlayerModel(playerIndex, model)
	return _in(0x232F1A85, playerIndex, model)
end

function ChangePlayerPhoneModel(player, model)
	return _in(0x7F2A71FD, player, model)
end

function ChangePlayerPhoneModelOffsets(player, x0, y0, z0, x1, y1, z1)
	return _in(0x481E2BE7, player, x0, y0, z0, x1, y1, z1)
end

function ChangeTerritoryBlipScale(blip, Unk632, Unk633)
	return _in(0x35A250C2, blip, Unk632, Unk633)
end

function CheatHappenedRecently(cheat, time)
	return _in(0x7488454D, cheat, time, _r)
end

function CheckNmFeedback(ped, id, Unk13)
	return _in(0x7C4C63EF, ped, id, Unk13, _r)
end

function CheckStuckTimer(car, timernum, timeout)
	return _in(0x15285933, car, timernum, timeout, _r)
end

function ClanIsPending()
	return _in(0x34F0C37, _r)
end

function ClearAdditionalText(textid, Unk634)
	return _in(0x0A1B465C, textid, Unk634)
end

function ClearAllCharProps(ped)
	return _in(0x232A52FA, ped)
end

function ClearAllCharRelationships(ped, relgroup)
	return _in(0x57297D58, ped, relgroup)
end

function ClearAngledAreaOfCars(x0, y0, z0, x1, y1, z1, radius)
	return _in(0x7E2A7743, x0, y0, z0, x1, y1, z1, radius)
end

function ClearArea(x, y, z, radius, unknown)
	return _in(0x27722942, x, y, z, radius, unknown)
end

function ClearAreaOfCars(x, y, z, radius)
	return _in(0x24367E48, x, y, z, radius)
end

function ClearAreaOfChars(x, y, z, radius)
	return _in(0x0C2747B9, x, y, z, radius)
end

function ClearAreaOfCops(x, y, z, radius)
	return _in(0x5F182E21, x, y, z, radius)
end

function ClearAreaOfObjects(x, y, z, radius)
	return _in(0x118A67C9, x, y, z, radius)
end

function ClearBit(bit)
	return _in(0x66D57CC4, _i, bit)
end

function ClearBrief()
	return _in(0x16D762E5)
end

function ClearCarLastDamageEntity(vehicle)
	return _in(0x4D6665F7, vehicle)
end

function ClearCarLastWeaponDamage(vehicle)
	return _in(0x31102E20, vehicle)
end

function ClearCharLastDamageBone(ped)
	return _in(0x1A013092, ped)
end

function ClearCharLastDamageEntity(ped)
	return _in(0x0AB9317B, ped)
end

function ClearCharLastWeaponDamage(ped)
	return _in(0x718508B4, ped)
end

function ClearCharProp(ped, unknown)
	return _in(0x51546112, ped, unknown)
end

function ClearCharRelationship(ped, reltype, relgroup)
	return _in(0x42DB145F, ped, reltype, relgroup)
end

function ClearCharSecondaryTask(ped)
	return _in(0x7FC96DD5, ped)
end

function ClearCharTasks(ped)
	return _in(0x4AB470F3, ped)
end

function ClearCharTasksImmediately(ped)
	return _in(0x3C116620, ped)
end

function ClearCutscene()
	return _in(0x79611458)
end

function ClearEventPrecedence()
	return _in(0x1CC41C5E, _r)
end

function ClearGroupDecisionMakerEventResponse(dm, eventid)
	return _in(0x3BF71D5F, dm, eventid)
end

function ClearHelp()
	return _in(0x07244253)
end

function ClearNamedCutscene(name)
	return _in(0x62EF058E, _ts(name))
end

function ClearNetworkRestartNodeGroupList()
	return _in(0x1BDA1F9A)
end

function ClearNewsScrollbar()
	return _in(0x0D721EEA)
end

function ClearObjectLastDamageEntity(obj)
	return _in(0x64BE2E39, obj)
end

function ClearObjectLastWeaponDamage(obj)
	return _in(0x15F11BAB, obj)
end

function ClearOnscreenCounter(counterid)
	return _in(0x3F236954, counterid)
end

function ClearOnscreenTimer(timerid)
	return _in(0x34C751A2, timerid)
end

function ClearPedNonCreationArea()
	return _in(0x0C1C7919)
end

function ClearPedNonRemovalArea()
	return _in(0x0A74017B)
end

function ClearPlayerHasDamagedAtLeastOnePed(playerIndex)
	return _in(0x45AB718F, playerIndex)
end

function ClearPlayerHasDamagedAtLeastOneVehicle(player)
	return _in(0x26AA20CF, player)
end

function ClearPrints()
	return _in(0x1D8C324A)
end

function ClearRelationship(p0, p1, p2)
	return _in(0x3FF16CBC, p0, p1, p2)
end

function ClearRoomForCar(vehicle)
	return _in(0x5FD24FEA, vehicle)
end

function ClearRoomForChar(ped)
	return _in(0x405B16CF, ped)
end

function ClearRoomForDummyChar(dummyPed)
	return _in(0x2E373084, dummyPed)
end

function ClearRoomForObject(obj)
	return _in(0x12ED69A6, obj)
end

function ClearRoomForViewport(viewportid)
	return _in(0x7A583068, viewportid)
end

function ClearScriptArrayFromScratchpad(Unk909)
	return _in(0x6E120246, Unk909)
end

function ClearScriptedConversionCentre()
	return _in(0x2E4662B3)
end

function ClearSequenceTask(taskSequence)
	return _in(0x7ED774FE, taskSequence)
end

function ClearShakePlayerpadWhenControllerDisabled()
	return _in(0x3F1F51E0)
end

function ClearSmallPrints()
	return _in(0x7C515B18)
end

function ClearTextLabel(label)
	return _in(0x412E68D0, _ts(label))
end

function ClearThisBigPrint(gxtentry)
	return _in(0x4A4F2699, _ts(gxtentry))
end

function ClearThisPrint(gxtentry)
	return _in(0x08D85CBB, _ts(gxtentry))
end

function ClearThisPrintBigNow(Unk635)
	return _in(0x1C8B73B6, Unk635)
end

function ClearTimecycleModifier()
	return _in(0x60FB61A7)
end

function ClearUpTripSkip()
	return _in(0x75F069D9, _r)
end

function ClearWantedLevel(playerIndex)
	return _in(0x205622AC, playerIndex)
end

function CloneCam(cam, camcopy)
	return _in(0x483E5BE8, cam, _ii(camcopy))
end

function CloseAllCarDoors(vehicle)
	return _in(0x56B8674F, vehicle)
end

function CloseDebugFile()
	return _in(0x41286578)
end

function CloseGarage(garageName)
	return _in(0x5C083072, _ts(garageName))
end

function CloseMicPed(id, ped)
	return _in(0x14B06047, id, ped)
end

function CloseSequenceTask(taskSequence)
	return _in(0x016C1B04, taskSequence)
end

function CodeWantsMobilePhoneRemoved()
	return _in(0x63DA2195, _r)
end

function CodeWantsMobilePhoneRemovedForWeaponSwitching()
	return _in(0x736027E6, _r)
end

function CompareString(str0, str1)
	return _in(0x080B4F21, _ts(str0), _ts(str1), _ri)
end

function CompareTwoDates(date0_0, date0_1, date1_0, date1_1)
	return _in(0x116D009A, date0_0, date0_1, date1_0, date1_1, _ri)
end

function ConnectLods(obj0, obj1)
	return _in(0x79EB2BC9, obj0, obj1)
end

function ControlCarDoor(vehicle, door, unknown_maybe_open, angle)
	return _in(0x194F76D4, vehicle, door, unknown_maybe_open, angle)
end

function ConvertIntToPlayerindex(playerId)
	return _in(0x5996315E, playerId, _ri)
end

function ConvertMetresToFeet(metres)
	return _in(0x4D2771CE, metres, _rf)
end

function ConvertMetresToFeetInt(metres)
	return _in(0x01A05ADD, metres, _ri)
end

function ConvertThenAddStringToHtmlScriptObject(htmlobj, strgxtkey)
	return _in(0x72EC0AA6, htmlobj, _ts(strgxtkey))
end

function CopyAnimations(ped, pednext, speed)
	return _in(0x308D1778, ped, pednext, speed)
end

function CopyCharDecisionMaker(type, pDM)
	return _in(0x1BB41B75, type, _ii(pDM))
end

function CopyCombatDecisionMaker(type, pDM)
	return _in(0x062E0076, type, _ii(pDM))
end

function CopyGroupCharDecisionMaker(type, pDM)
	return _in(0x472E65D6, type, _ii(pDM))
end

function CopyGroupCombatDecisionMaker(type, pDM)
	return _in(0x17002E03, type, _ii(pDM))
end

function CopySharedCharDecisionMaker(type, pDM)
	return _in(0x189E32C9, type, _ii(pDM))
end

function CopySharedCombatDecisionMaker(type, pDM)
	return _in(0x13DE5C59, type, _ii(pDM))
end

function Cos(value)
	return _in(0x061D4B5F, value, _rf)
end

function CountPickupsOfType(type)
	return _in(0x2E921B0F, type, _ri)
end

function CountScriptCams()
	return _in(0x4806044A, _ri)
end

function CountScriptCamsByTypeAndOrState(type, Unk536, Unk537)
	return _in(0x009641EE, type, Unk536, Unk537, _ri)
end

function CreateCam(camtype_usually14, camera)
	return _in(0x694A0DC1, camtype_usually14, _ii(camera))
end

function CreateCar(nameHash, x, y, z, unknownTrue)
	return _in(0x2F1D6843, nameHash, x, y, z, _i, unknownTrue)
end

function CreateCarGenerator(x, y, z, yaw, pitch, roll, model, color1, color2, spec1, spec2, Unk66, alarm, doorlock, handle)
	return _in(0x0F132F7E, x, y, z, yaw, pitch, roll, model, color1, color2, spec1, spec2, Unk66, alarm, doorlock, _ii(handle))
end

function CreateCarGeneratorWithPlate()
	return _in(0x1A6E1448, _r)
end

function CreateCarsOnGeneratorsInArea(x0, y0, z0, x1, y1, z1)
	return _in(0x0D940AF4, x0, y0, z0, x1, y1, z1)
end

function CreateChar(type, model, x, y, z, unknownTrue)
	return _in(0x4A673763, type, model, x, y, z, _i, unknownTrue)
end

function CreateCharAsPassenger(vehicle, charType, model, passengerIndex, pPed)
	return _in(0x442B1C1D, vehicle, charType, model, passengerIndex, _ii(pPed))
end

function CreateCharInsideCar(vehicle, charType, model, pPed)
	return _in(0x2702274D, vehicle, charType, model, _ii(pPed))
end

function CreateCheckpoint(type, x, y, z, Unk709, Unk710)
	return _in(0x41F27499, type, x, y, z, Unk709, Unk710, _ri)
end

function CreateDummyChar()
	return _in(0x44FF276B, _r)
end

function CreateEmergencyServicesCar(model, x, y, z)
	return _in(0x768B3AC7, model, x, y, z, _r)
end

function CreateEmergencyServicesCarReturnDriver(model, x, y, z)
	return _in(0x68251A95, model, x, y, z, _i, _i, _i, _r)
end

function CreateEmergencyServicesCarThenWalk(model, x, y, z)
	return _in(0x4A3D6D97, model, x, y, z, _r)
end

function CreateGroup(unknownFalse, unknownTrue)
	return _in(0x78300C0C, unknownFalse, _i, unknownTrue)
end

function CreateHtmlScriptObject(objname)
	return _in(0x6AA63375, _ts(objname), _ri)
end

function CreateHtmlViewport(htmlviewport)
	return _in(0x2FAE4C6E, _ii(htmlviewport))
end

function CreateMenu(gxtentry, Unk859, Unk860, Unk861, Unk862, Unk863, Unk864, Unk865, menuid)
	return _in(0x7DCA398F, _ts(gxtentry), Unk859, Unk860, Unk861, Unk862, Unk863, Unk864, Unk865, _ii(menuid))
end

function CreateMissionTrain(unknown1, x, y, z, unknown2, pTrain)
	return _in(0x0DDD70AE, unknown1, x, y, z, unknown2, _ii(pTrain))
end

function CreateMobilePhone(Unk799)
	return _in(0x2FEE095B, Unk799)
end

function CreateMoneyPickup(x, y, z, amount, unknownTrue, pPickup)
	return _in(0x019A0068, x, y, z, amount, unknownTrue, _ii(pPickup))
end

function CreateNmMessage(Unk40, id)
	return _in(0x22AA010C, Unk40, id)
end

function CreateObject(model, x, y, z, unknownTrue)
	return _in(0x4DE152A0, model, x, y, z, _i, unknownTrue)
end

function CreateObjectNoOffset(model, x, y, z, unknownTrue)
	return _in(0x75C51A26, model, x, y, z, _i, unknownTrue)
end

function CreatePickup(model, pickupType, x, y, z, unknownFalse)
	return _in(0x7E2868D4, model, pickupType, x, y, z, _i, unknownFalse)
end

function CreatePickupRotate(model, pickupType, unknown, x, y, z, rX, rY, rZ, pPickup)
	return _in(0x675E5940, model, pickupType, unknown, x, y, z, rX, rY, rZ, _ii(pPickup))
end

function CreatePickupWithAmmo(model, pickupType, unknown, x, y, z, pPickup)
	return _in(0x1F736F00, model, pickupType, unknown, x, y, z, _ii(pPickup))
end

function CreatePlayer(playerId, x, y, z, pPlayerIndex)
	return _in(0x335E3951, playerId, x, y, z, _ii(pPlayerIndex))
end

function CreateRandomCarForCarPark(x, y, z, radius)
	return _in(0x36DA42AF, x, y, z, radius)
end

function CreateRandomChar(x, y, z, pPed)
	return _in(0x375D6223, x, y, z, _ii(pPed))
end

function CreateRandomCharAsDriver(vehicle, pPed)
	return _in(0x31CD5F18, vehicle, _ii(pPed))
end

function CreateRandomCharAsPassenger(vehicle, seat, pPed)
	return _in(0x46D01849, vehicle, seat, _ii(pPed))
end

function CreateRandomFemaleChar(x, y, z, pPed)
	return _in(0x1A920C02, x, y, z, _ii(pPed))
end

function CreateRandomMaleChar(x, y, z, pPed)
	return _in(0x2FC728BB, x, y, z, _ii(pPed))
end

function CreateTemporaryRadarBlipsForPickupsInArea(x, y, z, radius, bliptype)
	return _in(0x44EA47BB, x, y, z, radius, bliptype)
end

function CreateUser3dMarker(x, y, z)
	return _in(0x77513211, x, y, z, _ri)
end

function CreateViewport(viewport)
	return _in(0x13134CCD, _ii(viewport))
end

function CreateWidgetGroup(Unk1109)
	return _in(0x558C4259, Unk1109)
end

function DamageCar(car, x, y, z, unkforce0, unkforce1, flag)
	return _in(0x2D2B208A, car, x, y, z, unkforce0, unkforce1, flag)
end

function DamageChar(ped, hitPoints, unknown)
	return _in(0x6045426E, ped, hitPoints, unknown)
end

function DamagePedBodyPart(ped, part, hitPoints)
	return _in(0x0744307B, ped, part, hitPoints)
end

function DeactivateFrontend()
	return _in(0x72B16D0D)
end

function DeactivateNetworkSettingsMenu()
	return _in(0x4AD22B80)
end

function DeactivateScriptPopulationZone()
	return _in(0x66BB737D)
end

function DebugOff()
	return _in(0x67177EEC)
end

function DebugOn()
	return _in(0x4B2103F0)
end

function DecrementFloatStat(stat, val)
	return _in(0x0754000C, stat, val)
end

function DecrementIntStat(stat, amount)
	return _in(0x7DD91295, stat, amount)
end

function DefinePedGenerationConstraintArea(x, y, z, radius)
	return _in(0x0991172D, x, y, z, radius)
end

function DeleteAllHtmlScriptObjects()
	return _in(0x31A77970)
end

function DeleteAllTrains()
	return _in(0x552B2224)
end

function DeleteCar(pVehicle)
	return _in(0x7F71342D, _ii(pVehicle))
end

function DeleteCarGenerator(handle)
	return _in(0x76E738A3, handle)
end

function DeleteChar(pPed)
	return _in(0x0E3B49BF, _ii(pPed))
end

function DeleteCheckpoint(checkpoint)
	return _in(0x1293731D, checkpoint)
end

function DeleteDummyChar(dummyPed)
	return _in(0x73F55AEF, dummyPed)
end

function DeleteHtmlScriptObject(htmlobj)
	return _in(0x53456730, htmlobj)
end

function DeleteMenu(menuid)
	return _in(0x252138B3, menuid)
end

function DeleteMissionTrain(pTrain)
	return _in(0x7DA237BC, _ii(pTrain))
end

function DeleteMissionTrains()
	return _in(0x7D635E2C)
end

function DeleteObject(pObj)
	return _in(0x62FE6290, _ii(pObj))
end

function DeletePlayer()
	return _in(0x627A3586)
end

function DeleteWidget(Unk1110)
	return _in(0x267D5146, Unk1110)
end

function DeleteWidgetGroup(Unk1111)
	return _in(0x17D72833, Unk1111)
end

function DestroyAllCams()
	return _in(0x614A3353)
end

function DestroyAllScriptViewports()
	return _in(0x5E4327D2)
end

function DestroyCam(camera)
	return _in(0x14334EEE, camera)
end

function DestroyMobilePhone()
	return _in(0x38BE5BF6)
end

function DestroyPedGenerationConstraintArea()
	return _in(0x3CC5682F)
end

function DestroyThread(ScriptHandle)
	return _in(0x47381E59, ScriptHandle)
end

function DestroyViewport(viewportid)
	return _in(0x651E50EC, viewportid)
end

function DetachCamFromViewport(Unk557)
	return _in(0x1DEA65DE, Unk557)
end

function DetachCar(vehicle)
	return _in(0x34CC1F23, vehicle)
end

function DetachObject(obj, unknown)
	return _in(0x05C87C26, obj, unknown)
end

function DetachObjectNoCollide(obj, flag)
	return _in(0x6B2E49CD, obj, flag)
end

function DetachPed(ped, unknown)
	return _in(0x2CD52C5C, ped, unknown)
end

function DidSaveCompleteSuccessfully()
	return _in(0x5AA33E86, _r)
end

function DimBlip(blip, unknownTrue)
	return _in(0x272D15FD, blip, unknownTrue)
end

function DisableCarGenerators(flag0, flag1)
	return _in(0x581E2306, flag0, flag1)
end

function DisableCarGeneratorsWithHeli(disable)
	return _in(0x018C4131, disable)
end

function DisableDebugCamAndPlayerWarping()
	return _in(0x1A1473B0, _r)
end

function DisableEndCreditsFade()
	return _in(0x21B45EC1)
end

function DisableFrontendRadio()
	return _in(0x6B2F3E97)
end

function DisableGps(disable)
	return _in(0x32A81853, disable)
end

function DisableHeliChaseCamBonnetNitroFix()
	return _in(0x19A73E70)
end

function DisableHeliChaseCamThisUpdate()
	return _in(0x78D17492)
end

function DisableIntermezzoCams()
	return _in(0x3DA200CB)
end

function DisableLocalPlayerPickups(disable)
	return _in(0x19211E9D, disable)
end

function DisablePauseMenu(disabled)
	return _in(0x07ED1DBF, disabled)
end

function DisablePlayerAutoVehicleExit(ped, disable)
	return _in(0x50E33E8F, ped, disable)
end

function DisablePlayerLockon(playerIndex, disabled)
	return _in(0x711214F3, playerIndex, disabled)
end

function DisablePlayerSprint(playerIndex, disabled)
	return _in(0x3A244927, playerIndex, disabled)
end

function DisablePlayerVehicleEntry(player, disable)
	return _in(0x05D51783, player, disable)
end

function DisablePoliceScanner()
	return _in(0x63AF5057)
end

function DisableStickyBombActiveSound(ped, disable)
	return _in(0x0C2D2CC5, ped, disable)
end

function DisplayAltimeterThisFrame()
	return _in(0x50C13702)
end

function DisplayAmmo(display)
	return _in(0x2E115B4B, display)
end

function DisplayAreaName(display)
	return _in(0x1E87298A, display)
end

function DisplayCash(display)
	return _in(0x62ED1551, display)
end

function DisplayFrontendMapBlips(display)
	return _in(0x61B830BC, display)
end

function DisplayGrimeThisFrame()
	return _in(0x56B95223)
end

function DisplayHelpTextThisFrame(gxtkey, Unk636)
	return _in(0x071542EB, _ts(gxtkey), Unk636)
end

function DisplayHud(display)
	return _in(0x52632919, display)
end

function DisplayLoadingThisFrameWithScriptSprites()
	return _in(0x38A10933)
end

function DisplayNonMinigameHelpMessages(Unk637)
	return _in(0x73F56AC5, Unk637)
end

function DisplayNthOnscreenCounterWithString(Unk638, Unk639, Unk640, str)
	return _in(0x4D9C4195, Unk638, Unk639, Unk640, _ts(str))
end

function DisplayOnscreenTimerWithString(timerid, Unk641, str)
	return _in(0x384F104F, timerid, Unk641, _ts(str))
end

function DisplayPlayerIcons()
	return _in(0x39B22A89, _r)
end

function DisplayPlayerNames(Unk910)
	return _in(0x0B177D76, Unk910)
end

function DisplayRadar(display)
	return _in(0x17920FA7, display)
end

function DisplaySniperScopeThisFrame()
	return _in(0x5BF23AD5)
end

function DisplayText(x, y, gxtName)
	return _in(0x0F002557, x, y, _ts(gxtName))
end

function DisplayTextSubstring(Unk642, Unk643, Unk644, Unk645, Unk646, Unk647, Unk648)
	return _in(0x0DA61310, Unk642, Unk643, Unk644, Unk645, Unk646, Unk647, Unk648)
end

function DisplayTextWithBlipName(x, y, str, blip)
	return _in(0x7E8D1DCE, x, y, _ts(str), blip)
end

function DisplayTextWithFloat(x, y, gxtName, value, unknown)
	return _in(0x311F4FE9, x, y, _ts(gxtName), value, unknown)
end

function DisplayTextWithLiteralString(x, y, gxtName, literalStr)
	return _in(0x661B239A, x, y, _ts(gxtName), _ts(literalStr))
end

function DisplayTextWithLiteralSubstring(Unk652, Unk653, Unk654, Unk655, Unk656, Unk657)
	return _in(0x1FCB5241, Unk652, Unk653, Unk654, Unk655, Unk656, Unk657)
end

function DisplayTextWithNumber(x, y, gxtName, value)
	return _in(0x5A495ABE, x, y, _ts(gxtName), value)
end

function DisplayTextWithString(x, y, gxtName, gxtStringName)
	return _in(0x10A75905, x, y, _ts(gxtName), _ts(gxtStringName))
end

function DisplayTextWithStringAndInt(x, y, gxtname, gxtnamenext, val)
	return _in(0x369A4540, x, y, _ts(gxtname), _ts(gxtnamenext), val)
end

function DisplayTextWithSubstringGivenHashKey(x, y, gxtkey, gxtkey0)
	return _in(0x7EF6599D, x, y, _ts(gxtkey), gxtkey0)
end

function DisplayTextWithTwoLiteralStrings(x, y, gxtName, literalStr1, literalStr2)
	return _in(0x4B7C3AEC, x, y, _ts(gxtName), _ts(literalStr1), _ts(literalStr2))
end

function DisplayTextWithTwoStrings(x, y, gxtName, gxtStringName1, gxtStringName2)
	return _in(0x66842574, x, y, _ts(gxtName), _ts(gxtStringName1), _ts(gxtStringName2))
end

function DisplayTextWithTwoSubstringsGivenHashKeys(x, y, gxtkey, gxtkey0, gxtkey1)
	return _in(0x39E77F70, x, y, _ts(gxtkey), gxtkey0, gxtkey1)
end

function DisplayTextWith2Numbers(x, y, gxtName, number1, number2)
	return _in(0x337957AF, x, y, _ts(gxtName), number1, number2)
end

function DisplayTextWith3Numbers(x, y, gxtentry, Unk649, Unk650, Unk651)
	return _in(0x746C06E8, x, y, _ts(gxtentry), Unk649, Unk650, Unk651)
end

function DoAutoSave()
	return _in(0x09B85174)
end

function DoScreenFadeIn(timeMS)
	return _in(0x04D72200, timeMS)
end

function DoScreenFadeInUnhacked(timeMS)
	return _in(0x5F9218C3, timeMS)
end

function DoScreenFadeOut(timeMS)
	return _in(0x65DE621C, timeMS)
end

function DoScreenFadeOutUnhacked(timeMS)
	return _in(0x42D250A7, timeMS)
end

function DoWeaponStuffAtStartOf2pGame()
	return _in(0x18194E99, _r)
end

function DoesBlipExist(blip)
	return _in(0x590A6FF4, blip, _r)
end

function DoesCamExist(camera)
	return _in(0x46953225, camera, _r)
end

function DoesCarHaveHydraulics(car)
	return _in(0x0F0956CA, car, _r)
end

function DoesCarHaveRoof(vehicle)
	return _in(0x7AE52512, vehicle, _r)
end

function DoesCarHaveStuckCarCheck(vehicle)
	return _in(0x2B856FAA, vehicle, _r)
end

function DoesCharExist(ped)
	return _in(0x46531797, ped, _r)
end

function DoesDecisionMakerExist(dm)
	return _in(0x66D53314, dm, _r)
end

function DoesGameCodeWantToLeaveNetworkSession()
	return _in(0x7E412AC8, _r)
end

function DoesGroupExist(group)
	return _in(0x3D385F6D, group, _r)
end

function DoesObjectExist(obj)
	return _in(0x6DAB78CD, obj, _r)
end

function DoesObjectExistWithNetworkId(netid)
	return _in(0x5BBC62CB, netid, _r)
end

function DoesObjectHavePhysics(obj)
	return _in(0x39587D51, obj, _r)
end

function DoesObjectHaveThisModel(obj, model)
	return _in(0x7505765B, obj, model, _r)
end

function DoesObjectOfTypeExistAtCoords(x, y, z, radius, model)
	return _in(0x1F881A88, x, y, z, radius, model, _r)
end

function DoesPedExistWithNetworkId(netid)
	return _in(0x21641887, netid, _r)
end

function DoesPickupExist(pickup)
	return _in(0x7B567F1A, pickup, _r)
end

function DoesPlayerHaveControlOfNetworkId(player, id)
	return _in(0x3D0B5E56, player, id, _r)
end

function DoesScenarioExistInArea(Unk104, Unk105, Unk106, Unk107, Unk108)
	return _in(0x48252E33, Unk104, Unk105, Unk106, Unk107, Unk108, _r)
end

function DoesScriptExist(name)
	return _in(0x1D1B266B, _ts(name), _r)
end

function DoesScriptFireExist(fire)
	return _in(0x637E1D42, fire, _r)
end

function DoesTextLabelExist(gxtentry)
	return _in(0x2A611607, _ts(gxtentry), _r)
end

function DoesThisMinigameScriptAllowNonMinigameHelpMessages()
	return _in(0x73A1443F, _r)
end

function DoesVehicleExist(vehicle)
	return _in(0x67A42263, vehicle, _r)
end

function DoesVehicleExistWithNetworkId(nedid)
	return _in(0x69C033D8, nedid, _r)
end

function DoesViewportExist(viewportid)
	return _in(0x0C5A551B, viewportid, _r)
end

function DoesWebPageExist(webaddress)
	return _in(0x1DE062FD, _ts(webaddress), _r)
end

function DoesWidgetGroupExist(Unk1114)
	return _in(0x3AAF5BE5, Unk1114, _r)
end

function DontAbortCarConversations(flag0, flag1)
	return _in(0x0A432423, flag0, flag1)
end

function DontDispatchCopsForPlayer(player, dont)
	return _in(0x63B87EBE, player, dont)
end

function DontDisplayLoadingOnFadeThisFrame()
	return _in(0x2F58286C)
end

function DontRemoveChar(ped)
	return _in(0x3659084A, ped)
end

function DontRemoveObject(obj)
	return _in(0x74FF26F9, obj)
end

function DontSuppressAnyCarModels()
	return _in(0x69F55DCC)
end

function DontSuppressAnyPedModels()
	return _in(0x72EF466E)
end

function DontSuppressCarModel(model)
	return _in(0x0348074B, model)
end

function DontSuppressPedModel(model)
	return _in(0x7CF256D0, model)
end

function DrawCheckpoint(x, y, z, radius, r, g, b)
	return _in(0x29FC3E19, x, y, z, radius, r, g, b)
end

function DrawCheckpointWithAlpha(x, y, z, radius, r, g, b, a)
	return _in(0x26810BE3, x, y, z, radius, r, g, b, a)
end

function DrawColouredCylinder(x, y, z, Unk712, Unk713, r, g, b, a)
	return _in(0x309860C4, x, y, z, Unk712, Unk713, r, g, b, a)
end

function DrawCorona(x, y, z, radius, Unk714, Unk715, Unk716, Unk717, Unk718)
	return _in(0x39ED0C43, x, y, z, radius, Unk714, Unk715, Unk716, Unk717, Unk718)
end

function DrawCurvedWindow(Unk719, Unk720, Unk721, Unk722, alpha)
	return _in(0x4B684D0B, Unk719, Unk720, Unk721, Unk722, alpha)
end

function DrawCurvedWindowNotext(Unk723, Unk724, Unk725, Unk726, Unk727)
	return _in(0x12B9197E, Unk723, Unk724, Unk725, Unk726, Unk727)
end

function DrawCurvedWindowText(Unk728, Unk729, Unk730, Unk731, Unk732, str0, str1, Unk733)
	return _in(0x7DD67E15, Unk728, Unk729, Unk730, Unk731, Unk732, _ts(str0), _ts(str1), Unk733)
end

function DrawDebugSphere(x, y, z, radius)
	return _in(0x539572F3, x, y, z, radius)
end

function DrawFrontendHelperText(str0, str1, Unk734)
	return _in(0x44E14770, _ts(str0), _ts(str1), Unk734)
end

function DrawLightWithRange(x, y, z, r, g, b, width, height)
	return _in(0x30D27EB1, x, y, z, r, g, b, width, height)
end

function DrawMovie(Unk735, Unk736, Unk737, Unk738, Unk739, r, g, b, a)
	return _in(0x26274628, Unk735, Unk736, Unk737, Unk738, Unk739, r, g, b, a)
end

function DrawRect(x1, y1, x2, y2, r, g, b, a)
	return _in(0x3B2526E3, x1, y1, x2, y2, r, g, b, a)
end

function DrawSphere(x, y, z, radius)
	return _in(0x769F6E66, x, y, z, radius)
end

function DrawSprite(texture, Unk740, Unk741, Unk742, Unk743, angle, r, g, b, a)
	return _in(0x6ADD40EC, texture, Unk740, Unk741, Unk742, Unk743, angle, r, g, b, a)
end

function DrawSpriteFrontBuff(x0, y0, x1, y1, rotation, r, g, b, a)
	return _in(0x22417905, x0, y0, x1, y1, rotation, r, g, b, a)
end

function DrawSpritePhoto(x0, y0, x1, y1, rotation, r, g, b, a)
	return _in(0x4BD4248E, x0, y0, x1, y1, rotation, r, g, b, a)
end

function DrawSpriteWithFixedRotation(texture, Unk744, Unk745, Unk746, Unk747, angle, r, g, b, a)
	return _in(0x7CB404D4, texture, Unk744, Unk745, Unk746, Unk747, angle, r, g, b, a)
end

function DrawSpriteWithUv(texture, Unk748, Unk749, Unk750, Unk751, angle, r, g, b, a)
	return _in(0x58C41E8F, texture, Unk748, Unk749, Unk750, Unk751, angle, r, g, b, a)
end

function DrawSpriteWithUvCoords(texture, Unk752, Unk753, Unk754, Unk755, Unk756, Unk757, Unk758, Unk759, angle, r, g, b, a)
	return _in(0x2D1D17C9, texture, Unk752, Unk753, Unk754, Unk755, Unk756, Unk757, Unk758, Unk759, angle, r, g, b, a)
end

function DrawToplevelSprite(texture, Unk760, Unk761, Unk762, Unk763, angle, r, g, b, a)
	return _in(0x1849408D, texture, Unk760, Unk761, Unk762, Unk763, angle, r, g, b, a)
end

function DrawWindow(Unk764, Unk765, Unk766, Unk767, str, alpha)
	return _in(0x232642DE, Unk764, Unk765, Unk766, Unk767, _ts(str), alpha)
end

function DrawWindowText(Unk768, Unk769, Unk770, Unk771, str0, Unk772)
	return _in(0x3D0F5735, Unk768, Unk769, Unk770, Unk771, _ts(str0), Unk772)
end

function DropObject(ped, unknownTrue)
	return _in(0x24C45D0D, ped, unknownTrue)
end

function EnableAllPedHelmets(enable)
	return _in(0x6C305137, enable)
end

function EnableCamCollision(cam, enable)
	return _in(0x71AE1BDC, cam, enable)
end

function EnableChaseAudio(enable)
	return _in(0x68664078, enable)
end

function EnableDebugCam(enable)
	return _in(0x296B09E8, enable)
end

function EnableDeferredLighting(enable)
	return _in(0x6CFC30AD, enable)
end

function EnableDisabledAttractorsOnObject(obj, enable)
	return _in(0x17F62193, obj, enable)
end

function EnableEndCreditsFade()
	return _in(0x1EA85697)
end

function EnableFancyWater(enable)
	return _in(0x74FC2325, enable)
end

function EnableFovLodMultiplier(enable)
	return _in(0x556B0755, enable)
end

function EnableFrontendRadio()
	return _in(0x5328068B)
end

function EnableGpsInVehicle(veh, enable)
	return _in(0x144F3CE5, veh, enable)
end

function EnableMaxAmmoCap(enable)
	return _in(0x7E657B56, enable)
end

function EnablePedHelmet(ped, enable)
	return _in(0x0C704586, ped, enable)
end

function EnablePoliceScanner()
	return _in(0x5B262142)
end

function EnableSaveHouse(savehouse, enable)
	return _in(0x208C03C9, savehouse, enable)
end

function EnableSceneStreaming(enable)
	return _in(0x362B7D1B, enable)
end

function EnableScriptControlledMicrophone()
	return _in(0x3EA0648D, _r)
end

function EnableShadows(enable)
	return _in(0x41596B09, enable)
end

function EndCamCommands(Unk558)
	return _in(0x627F3275, _ii(Unk558))
end

function EndCharSearchCriteria()
	return _in(0x5ECF404A)
end

function EndPedQueueMembershipList()
	return _in(0x4449534F, _r)
end

function EndWidgetGroup()
	return _in(0x6F760759)
end

function EvolvePtfx(ptfx, evolvetype, val)
	return _in(0x3CE05E7C, ptfx, _ts(evolvetype), val)
end

function Exp(Unk1084)
	return _in(0x1BA61E20, Unk1084, _rf)
end

function ExplodeCar(vehicle, unknownTrue, unknownFalse)
	return _in(0x505518A2, vehicle, unknownTrue, unknownFalse)
end

function ExplodeCarInCutscene(car, explode)
	return _in(0x01820DAA, car, explode)
end

function ExplodeCarInCutsceneShakeAndBit(car, flag0, flag1, flag2)
	return _in(0x7CF61A81, car, flag0, flag1, flag2)
end

function ExplodeCharHead(ped)
	return _in(0x4A802E89, ped)
end

function ExtendPatrolRoute(Unk484, Unk485, Unk486, Unk487, Unk488)
	return _in(0x0F3402B8, Unk484, Unk485, Unk486, Unk487, Unk488)
end

function ExtinguishCarFire(vehicle)
	return _in(0x63A40F58, vehicle)
end

function ExtinguishCharFire(ped)
	return _in(0x5D786EEE, ped)
end

function ExtinguishFireAtPoint(x, y, z, radius)
	return _in(0x35A97B73, x, y, z, radius)
end

function ExtinguishObjectFire(obj)
	return _in(0x5FBC5FFF, obj)
end

function FailKillFrenzy()
	return _in(0x5EA253A5)
end

function FakeDeatharrest()
	return _in(0x30D17655)
end

function FindMaxNumberOfGroupMembers()
	return _in(0x7E154274, _ri)
end

function FindNearestCollectableBinBags(x, y, z)
	return _in(0x056314A9, x, y, z)
end

function FindNearestEntitiesWithSpecialAttribute(x, y, z)
	return _in(0x035261C6, x, y, z)
end

function FindNetworkKillerOfPlayer(playerIndex)
	return _in(0x766E78A3, playerIndex, _ri)
end

function FindNetworkRestartPoint(Unk911, Unk912, Unk913)
	return _in(0x66F445BB, Unk911, Unk912, Unk913)
end

function FindPositionInRecording(car)
	return _in(0x22087F31, car, _rf)
end

function FindPrimaryPopulationZoneGroup()
	return _in(0x36601178, _i, _i)
end

function FindStaticEmitterIndex(StaticEmitterName)
	return _in(0x64793A54, _ts(StaticEmitterName), _ri)
end

function FindStreetNameAtPosition(pX, pY, pZ)
	return _in(0x49763A4F, pX, pY, pZ, _i, _i)
end

function FindTimePositionInRecording(car)
	return _in(0x08D25912, car, _rf)
end

function FindTrainDirection(train)
	return _in(0x013C1EB7, train, _ri)
end

function FinishStreamingRequestList()
	return _in(0x1788346E)
end

function FinishWidgetCombo(Unk1112, Unk1113)
	return _in(0x2CCA0D6A, Unk1112, Unk1113)
end

function FirePedWeapon(ped, x, y, z)
	return _in(0x25BB7D67, ped, x, y, z)
end

function FireSingleBullet(x, y, z, targetX, targetY, targetZ, unknown)
	return _in(0x30975326, x, y, z, targetX, targetY, targetZ, unknown)
end

function FixAmbienceOrientation(fix)
	return _in(0x788F7A03, fix)
end

function FixCar(vehicle)
	return _in(0x3D562F78, vehicle)
end

function FixCarTyre(vehicle, tyre)
	return _in(0x0FDA7965, vehicle, tyre)
end

function FixScriptMicToCurrentPosisition()
	return _in(0x456C0C43)
end

function FlashBlip(blip, on)
	return _in(0x4DFE09D6, blip, on)
end

function FlashBlipAlt(blip, on)
	return _in(0x611948A3, blip, on)
end

function FlashRadar(flash)
	return _in(0x265F6FF5, flash)
end

function FlashRoute(flash)
	return _in(0x20E74A9C, flash)
end

function FlashWeaponIcon(on)
	return _in(0x796A6B88, on)
end

function Floor(value)
	return _in(0x49261BA6, value, _ri)
end

function FlushAllOutOfDateRadarBlipsFromMissionCleanupList()
	return _in(0x1F1C77E1)
end

function FlushAllPlayerRespawnCoords()
	return _in(0x187B3202)
end

function FlushAllSpawnBlockingAreas()
	return _in(0x65B05F3F)
end

function FlushCoverBlockingAreas()
	return _in(0x5A535133)
end

function FlushPatrolRoute()
	return _in(0x015F4F3E)
end

function FlushScenarioBlockingAreas()
	return _in(0x754D0FC4)
end

function ForceAirDragMultForPlayersCar(player, multiplier)
	return _in(0x554053ED, player, multiplier)
end

function ForceAllVehicleLightsOff(off)
	return _in(0x0CE96445, off)
end

function ForceCarLights(car, lights)
	return _in(0x71B81DE7, car, lights)
end

function ForceCharToDropWeapon(ped)
	return _in(0x214C5455, ped)
end

function ForceFullVoice(ped)
	return _in(0x62285CAD, ped)
end

function ForceGameTelescopeCam(force)
	return _in(0x01C51E90, force)
end

function ForceGenerateParkedCarsTooCloseToOthers(set)
	return _in(0x1B8F031D, set)
end

function ForceHighLod(force)
	return _in(0x1EFB0992, force)
end

function ForceInitialPlayerStation(stationName)
	return _in(0x32D3165D, _ts(stationName))
end

function ForceInteriorLightingForPlayer(player, force)
	return _in(0x45DF1D92, player, force)
end

function ForceLoadingScreen(force)
	return _in(0x4E68316C, force)
end

function ForceNetPlayerInvisible()
	return _in(0x162D395E, _r)
end

function ForceNoCamPause(foce)
	return _in(0x2CC70E04, foce)
end

function ForceNoiseOff(off)
	return _in(0x0CC0186A, off)
end

function ForcePedPinnedDown(ped, force, timerMaybe)
	return _in(0x56A70F57, ped, force, timerMaybe)
end

function ForcePedToFleeWhilstDrivingVehicle(ped, vehicle)
	return _in(0x2FED14F5, ped, vehicle)
end

function ForcePedToLoadCover(ped, force)
	return _in(0x61D07789, ped, force)
end

function ForcePopulationInit()
	return _in(0x42180729)
end

function ForceRadioTrack(radiostation, trackname, Unk533, Unk534)
	return _in(0x6A7E47C9, _ts(radiostation), _ts(trackname), Unk533, Unk534)
end

function ForceRandomCarModel(hash)
	return _in(0x521D0D5B, hash)
end

function ForceRandomPedType(type)
	return _in(0x57E37103, type)
end

function ForceSpawnScenarioPedsInArea(x, y, z, radius, Unk41)
	return _in(0x186D42A4, x, y, z, radius, Unk41)
end

function ForceTimeOfDay(hour, minute)
	return _in(0x0B9B5070, hour, minute)
end

function ForceWeather(weather)
	return _in(0x7EFB5077, weather)
end

function ForceWeatherNow(weather)
	return _in(0x63737D31, weather)
end

function ForceWind(wind)
	return _in(0x310E75C9, wind)
end

function ForwardToTimeOfDay(hour, minute)
	return _in(0x456C6096, hour, minute)
end

function FreezeCarPosition(vehicle, frozen)
	return _in(0x295C4C52, vehicle, frozen)
end

function FreezeCarPositionAndDontLoadCollision(vehicle, frozen)
	return _in(0x588A27FB, vehicle, frozen)
end

function FreezeCharPosition(ped, frozen)
	return _in(0x20266A86, ped, frozen)
end

function FreezeCharPositionAndDontLoadCollision(ped, frozen)
	return _in(0x74576E37, ped, frozen)
end

function FreezeObjectPosition(obj, frozen)
	return _in(0x7CA8382B, obj, frozen)
end

function FreezeObjectPosition(obj, set)
	return _in(0x7CA8382B, obj, set)
end

function FreezeObjectPositionAndDontLoadCollision(obj, freeze)
	return _in(0x668F64C7, obj, freeze)
end

function FreezeOnscreenTimer(freeze)
	return _in(0x4B8B6F24, freeze)
end

function FreezePositionOfClosestObjectOfType(x, y, z, radius, model, frozen)
	return _in(0x5A196B79, x, y, z, radius, model, frozen)
end

function FreezeRadioStation(stationName)
	return _in(0x08A015CF, _ts(stationName))
end

function GenerateDirections(x, y, z)
	return _in(0x203A137B, x, y, z, _i, _v)
end

function GenerateRandomFloat(Unk1086)
	return _in(0x380C142A, _fi(Unk1086))
end

function GenerateRandomFloatInRange(min, max, pValue)
	return _in(0x74C626EB, min, max, _fi(pValue))
end

function GenerateRandomInt(Unk1087)
	return _in(0x335D0F34, _ii(Unk1087))
end

function GenerateRandomIntInRange(min, max, pValue)
	return _in(0x168B1717, min, max, _ii(pValue))
end

function GetAcceptButton()
	return _in(0x530F4572, _ri)
end

function GetAmmoInCharWeapon(ped, weapon, pAmmo)
	return _in(0x23E140A9, ped, weapon, _ii(pAmmo))
end

function GetAmmoInClip(ped, weapon, pAmmo)
	return _in(0x612C748F, ped, weapon, _ii(pAmmo), _r)
end

function GetAngleBetween2dVectors(x1, y1, x2, y2, pResult)
	return _in(0x5BC4602D, x1, y1, x2, y2, _fi(pResult))
end

function GetAnimGroupFromChar(ped)
	return _in(0x55EB748F, ped, _s)
end

function GetAsciiJustPressed(key, Unk830)
	return _in(0x092829D0, key, Unk830, _ri)
end

function GetAsciiPressed(key, Unk820)
	return _in(0x495F399D, key, _ii(Unk820), _r)
end

function GetAspectRatio()
	return _in(0x36600272, _rf)
end

function GetAudibleMusicTrackTextId()
	return _in(0x18246AC8, _ri)
end

function GetAudioRoomId()
	return _in(0x03AC3097, _ri)
end

function GetBitsInRange(val, rangebegin, rangeend)
	return _in(0x58AE7C1D, val, rangebegin, rangeend, _ri)
end

function GetBlipAlpha(blip, alpha)
	return _in(0x61497585, blip, _ii(alpha))
end

function GetBlipColour(blip, pColour)
	return _in(0x59B425DA, blip, _ii(pColour))
end

function GetBlipCoords(blip, pVector)
	return _in(0x4C1E75DB, blip, _v)
end

function GetBlipInfoIdCarIndex(blip)
	return _in(0x566D04C2, blip, _ri)
end

function GetBlipInfoIdDisplay(blip)
	return _in(0x1B731C3F, blip, _ri)
end

function GetBlipInfoIdObjectIndex(blip)
	return _in(0x7B05072C, blip, _ri)
end

function GetBlipInfoIdPedIndex(blip)
	return _in(0x5FD47B45, blip, _ri)
end

function GetBlipInfoIdPickupIndex(blip)
	return _in(0x059E3BEB, blip, _ri)
end

function GetBlipInfoIdPosition()
	return _in(0x413B3893, _r)
end

function GetBlipInfoIdRotation(blip)
	return _in(0x6FBA4274, blip, _ri)
end

function GetBlipInfoIdType(blip)
	return _in(0x6A9E5CE5, blip, _ri)
end

function GetBlipSprite(blip)
	return _in(0x30B1316B, blip, _ri)
end

function GetBufferedAscii(key, Unk821)
	return _in(0x21F43531, key, _ii(Unk821), _r)
end

function GetCamFarClip(cam, clip)
	return _in(0x752643C9, cam, _fi(clip))
end

function GetCamFarDof(cam, fardof)
	return _in(0x1CB27FE1, cam, _fi(fardof))
end

function GetCamFov(camera, fov)
	return _in(0x7BF4652D, camera, _fi(fov))
end

function GetCamMotionBlur(cam, blur)
	return _in(0x64EF411D, cam, _ii(blur))
end

function GetCamNearClip(cam, clip)
	return _in(0x2EF477FD, cam, _fi(clip))
end

function GetCamNearDof(cam, dof)
	return _in(0x50D15F0D, cam, _fi(dof))
end

function GetCamPos(camera)
	return _in(0x60C22E93, camera, _f, _f, _f)
end

function GetCamRot(camera)
	return _in(0x51A06698, camera, _f, _f, _f)
end

function GetCamState(cam)
	return _in(0x22AA0984, cam, _ri)
end

function GetCameraFromNetworkId(ned_id, cam)
	return _in(0x7E656E50, ned_id, _ii(cam))
end

function GetCarAnimCurrentTime(car, animname0, animname1, time)
	return _in(0x5B580DCC, car, _ts(animname0), _ts(animname1), _fi(time))
end

function GetCarAnimTotalTime(car, animname0, animname1, time)
	return _in(0x295C34B8, car, _ts(animname0), _ts(animname1), _fi(time))
end

function GetCarBlockingCar(car0, car1)
	return _in(0x66B43B06, car0, _ii(car1))
end

function GetCarCharIsUsing(ped, pVehicle)
	return _in(0x1B067237, ped, _ii(pVehicle))
end

function GetCarColours(vehicle)
	return _in(0x6CAC3D62, vehicle, _i, _i)
end

function GetCarCoordinates(vehicle)
	return _in(0x2D432EAB, vehicle, _f, _f, _f)
end

function GetCarDeformationAtPos(vehicle, x, y, z, pDeformation)
	return _in(0x1F913BC7, vehicle, x, y, z, _v)
end

function GetCarDoorLockStatus(vehicle, pValue)
	return _in(0x774426C2, vehicle, _ii(pValue))
end

function GetCarForwardVector(car, vec)
	return _in(0x7E4F49B5, car, _v)
end

function GetCarForwardX(vehicle, pValue)
	return _in(0x47A21100, vehicle, _fi(pValue))
end

function GetCarForwardY(vehicle, pValue)
	return _in(0x3BDB4496, vehicle, _fi(pValue))
end

function GetCarHeading(vehicle, pValue)
	return _in(0x46803CFA, vehicle, _fi(pValue))
end

function GetCarHealth(vehicle, pValue)
	return _in(0x4D417CD3, vehicle, _ii(pValue))
end

function GetCarLivery(car, livery)
	return _in(0x10237666, car, _ii(livery))
end

function GetCarMass(car, mass)
	return _in(0x5D7C4F08, car, _fi(mass))
end

function GetCarModel(vehicle, pValue)
	return _in(0x5FF84497, vehicle, _ii(pValue))
end

function GetCarModelValue(car, value)
	return _in(0x29D37792, car, _ii(value))
end

function GetCarObjectIsAttachedTo(obj)
	return _in(0x2D215414, obj, _ri)
end

function GetCarPitch(vehicle, pValue)
	return _in(0x61EE5C9A, vehicle, _fi(pValue))
end

function GetCarRoll(vehicle, pValue)
	return _in(0x09C95A65, vehicle, _fi(pValue))
end

function GetCarSirenHealth(car)
	return _in(0x0896249A, car, _ri)
end

function GetCarSpeed(vehicle, pValue)
	return _in(0x16DD2D00, vehicle, _fi(pValue))
end

function GetCarSpeedVector(vehicle, unknownFalse)
	return _in(0x112E7FB1, vehicle, _v, unknownFalse)
end

function GetCarUprightValue(vehicle, pValue)
	return _in(0x326E2886, vehicle, _fi(pValue))
end

function GetCellphoneRanked()
	return _in(0x6B6019DB, _r)
end

function GetCharAllowedToRunOnBoats(ped)
	return _in(0x4C872A85, ped, _r)
end

function GetCharAnimBlendAmount(ped, AnimName0, AnimName1, amount)
	return _in(0x1DE37A21, ped, _ts(AnimName0), _ts(AnimName1), _fi(amount))
end

function GetCharAnimCurrentTime(ped, animGroup, animName, pValue)
	return _in(0x555D3B8C, ped, _ts(animGroup), _ts(animName), _fi(pValue))
end

function GetCharAnimEventTime()
	return _in(0x675A1B4E, _r)
end

function GetCharAnimIsEvent(ped, AnimName0, AnimName1, flag)
	return _in(0x118174EC, ped, _ts(AnimName0), _ts(AnimName1), flag, _r)
end

function GetCharAnimTotalTime(ped, animGroup, animName, pValue)
	return _in(0x2E51318F, ped, _ts(animGroup), _ts(animName), _fi(pValue))
end

function GetCharAreaVisible()
	return _in(0x6EA1F78, _r)
end

function GetCharArmour(ped, pArmour)
	return _in(0x3C756E54, ped, _ii(pArmour))
end

function GetCharCoordinates(ped)
	return _in(0x2B5C06E6, ped, _f, _f, _f)
end

function GetCharDrawableVariation(ped, component)
	return _in(0x1A1A6D83, ped, component, _ri)
end

function GetCharExtractedDisplacement(ped, unknown)
	return _in(0x466B5AA0, ped, unknown, _f, _f, _f)
end

function GetCharExtractedVelocity(ped, Unk5)
	return _in(0x7B3F0058, ped, Unk5, _f, _f, _f)
end

function GetCharGravity(ped)
	return _in(0x746E7171, ped, _ri)
end

function GetCharHeading(ped, pValue)
	return _in(0x057A3AC7, ped, _fi(pValue))
end

function GetCharHealth(ped, pHealth)
	return _in(0x4B6C2256, ped, _ii(pHealth))
end

function GetCharHeightAboveGround(ped, pValue)
	return _in(0x79973C5A, ped, _fi(pValue))
end

function GetCharHighestPriorityEvent(ped, event)
	return _in(0x061A75D3, ped, _ii(event))
end

function GetCharInCarPassengerSeat(vehicle, seatIndex, pPed)
	return _in(0x5E756B51, vehicle, seatIndex, _ii(pPed))
end

function GetCharLastDamageBone(ped, pBone)
	return _in(0x767E5013, ped, _ii(pBone), _ri)
end

function GetCharMaxMoveBlendRatio(ped)
	return _in(0x54AE4F4B, ped, _rf)
end

function GetCharMeleeActionFlag0(ped)
	return _in(0x103F14E4, ped, _r)
end

function GetCharMeleeActionFlag1(ped)
	return _in(0x08A308F8, ped, _r)
end

function GetCharMeleeActionFlag2(ped)
	return _in(0x032F729B, ped, _r)
end

function GetCharModel(ped, pModel)
	return _in(0x0A3D60CE, ped, _ii(pModel))
end

function GetCharMoney(ped)
	return _in(0x7D675993, ped, _ri)
end

function GetCharMoveAnimSpeedMultiplier(ped, multiplier)
	return _in(0x325B1A34, ped, _fi(multiplier))
end

function GetCharMovementAnimsBlocked(ped)
	return _in(0x11292C09, ped, _r)
end

function GetCharPropIndex(ped, unknown, pIndex)
	return _in(0x3AC85DB1, ped, unknown, _ii(pIndex))
end

function GetCharReadyToBeExecuted(ped)
	return _in(0x3FFF4DE9, ped, _r)
end

function GetCharReadyToBeStunned(ped)
	return _in(0x5C422066, ped, _r)
end

function GetCharSpeed(ped, pValue)
	return _in(0x3E156AFC, ped, _fi(pValue))
end

function GetCharSwimState(ped, state)
	return _in(0x34460DD7, ped, _ii(state), _r)
end

function GetCharTextureVariation(ped, component)
	return _in(0x3A7B78C5, ped, component, _ri)
end

function GetCharVelocity(ped)
	return _in(0x3B977FD4, ped, _f, _f, _f)
end

function GetCharWalkAlongsideLeaderWhenAppropriate(ped)
	return _in(0x6D170B31, ped, _r)
end

function GetCharWeaponInSlot(ped, slot)
	return _in(0x74EC7580, ped, slot, _i, _i, _i)
end

function GetCharWillCowerInsteadOfFleeing(ped)
	return _in(0x69A52C96, ped, _r)
end

function GetCharWillTryToLeaveBoatAfterLeader(ped)
	return _in(0x6D5F1592, ped, _r)
end

function GetCharWillTryToLeaveWater(ped)
	return _in(0x7BC85E73, ped, _r)
end

function GetCinematicCam(cam)
	return _in(0x00C87FB8, _ii(cam))
end

function GetClosestCar(x, y, z, radius, unknownFalse, unknown70)
	return _in(0x2CB303F8, x, y, z, radius, unknownFalse, unknown70, _ri)
end

function GetClosestCarNode(x, y, z)
	return _in(0x27F87222, x, y, z, _f, _f, _f, _r)
end

function GetClosestCarNodeFavourDirection(Unk802, x, y, z)
	return _in(0x2F2405D1, Unk802, x, y, z, _f, _f, _f, _f, _r)
end

function GetClosestCarNodeWithHeading(x, y, z)
	return _in(0x371467E0, x, y, z, _f, _f, _f, _f, _r)
end

function GetClosestChar(x, y, z, radius, unknown1, unknown2, pPed)
	return _in(0x0F4B0239, x, y, z, radius, unknown1, unknown2, _ii(pPed), _r)
end

function GetClosestMajorCarNode(x, y, z)
	return _in(0x406A035E, x, y, z, _f, _f, _f, _r)
end

function GetClosestNetworkRestartNode(Unk1008, Unk1009, Unk1010, Unk1011, Unk1012)
	return _in(0x46CD1D73, Unk1008, Unk1009, Unk1010, Unk1011, Unk1012, _ri)
end

function GetClosestRoad(x, y, z, Unk803, Unk804)
	return _in(0x63C00DE7, x, y, z, Unk803, Unk804, _v, _v, _f, _f, _f, _r)
end

function GetClosestStealableObject(x, y, z, radius, obj)
	return _in(0x27045521, x, y, z, radius, _ii(obj))
end

function GetClosestStraightRoad()
	return _in(0x1501CBA, _r)
end

function GetConsoleCommandToken()
	return _in(0x5D607947, _ri)
end

function GetContentsOfTextWidget(Unk1090)
	return _in(0x742E3376, Unk1090, _ri)
end

function GetControlValue(Unk831, controlid)
	return _in(0x06285788, Unk831, controlid, _ri)
end

function GetCoordinatesForNetworkRestartNode(Unk914, Unk915, Unk916)
	return _in(0x2EAA3C4A, Unk914, Unk915, Unk916)
end

function GetCorrectedColour(r, g, b)
	return _in(0x64D35E1D, r, g, b, _i, _i, _i)
end

function GetCreateRandomCops()
	return _in(0x4F9342F3, _r)
end

function GetCurrentBasicCopModel(pModel)
	return _in(0x1B305900, _ii(pModel))
end

function GetCurrentBasicPoliceCarModel(pModel)
	return _in(0x76901A85, _ii(pModel))
end

function GetCurrentCharWeapon(ped, pWeapon)
	return _in(0x5AB8289F, ped, _ii(pWeapon), _r)
end

function GetCurrentCopModel(pModel)
	return _in(0x018B2055, _ii(pModel))
end

function GetCurrentDate()
	return _in(0x2E5B068F, _i, _i)
end

function GetCurrentDayOfWeek()
	return _in(0x39FD432B, _ri)
end

function GetCurrentEpisode()
	return _in(0x7D7619D2, _ri)
end

function GetCurrentLanguage()
	return _in(0x1105259C, _ri)
end

function GetCurrentPlaybackNumberForCar(car)
	return _in(0x678813A4, car, _ri)
end

function GetCurrentPoliceCarModel(pModel)
	return _in(0x20A53B7F, _ii(pModel))
end

function GetCurrentPopulationZoneType()
	return _in(0x30516A11, _ri)
end

function GetCurrentScriptedConversationLine()
	return _in(0x0DE30821, _ri)
end

function GetCurrentStackSize()
	return _in(0x6AC52840, _ri)
end

function GetCurrentStationForTrain(train)
	return _in(0x10FE0FE9, train, _ri)
end

function GetCurrentTaxiCarModel(pModel)
	return _in(0x1D6D767E, _ii(pModel))
end

function GetCurrentWeather(pWeather)
	return _in(0x27E421EA, _ii(pWeather))
end

function GetCurrentWeatherFull()
	return _in(0x3FFA65EE, _i, _i, _i)
end

function GetCurrentZoneScumminess()
	return _in(0x4B7B5F77, _ri)
end

function GetCutsceneAudioTimeMs()
	return _in(0x2B8A0C6B, _ri)
end

function GetCutscenePedPosition(unkped, pos)
	return _in(0x366B549F, unkped, _v)
end

function GetCutsceneSectionPlaying()
	return _in(0x04C65BEB, _ri)
end

function GetCutsceneTime()
	return _in(0x7DF26C8C, _ri)
end

function GetDamageToPedBodyPart(ped, part)
	return _in(0x062A507A, ped, part, _ri)
end

function GetDeadCarCoordinates(vehicle)
	return _in(0x3BC827E6, vehicle, _f, _f, _f)
end

function GetDeadCharPickupCoords(ped)
	return _in(0x2A7475D8, ped, _f, _f, _f)
end

function GetDebugCam(cam)
	return _in(0x7D15544E, _ii(cam))
end

function GetDestroyerOfNetworkId(playerIndex, id)
	return _in(0x11E80442, playerIndex, _ii(id))
end

function GetDisplayNameFromVehicleModel(model)
	return _in(0x404E0056, model, _s)
end

function GetDistanceBetweenCoords2d(x1, y1, x2, y2, pDist)
	return _in(0x687107CA, x1, y1, x2, y2, _fi(pDist))
end

function GetDistanceBetweenCoords3d(x1, y1, z1, x2, y2, z2, pDist)
	return _in(0x23F772E7, x1, y1, z1, x2, y2, z2, _fi(pDist))
end

function GetDoorAngleRatio(vehicle, door, pAngleRatio)
	return _in(0x44EA2669, vehicle, door, _fi(pAngleRatio))
end

function GetDoorState(obj)
	return _in(0x64861559, obj, _i, _f)
end

function GetDriverOfCar(vehicle, pPed)
	return _in(0x22457083, vehicle, _ii(pPed))
end

function GetEngineHealth(vehicle)
	return _in(0x2B0A05E0, vehicle, _rf)
end

function GetEpisodeIndexFromSummons()
	return _in(0x704E638F, _ri)
end

function GetEpisodeName(episodeIndex)
	return _in(0x6004431B, episodeIndex, _s)
end

function GetExtraCarColours(vehicle)
	return _in(0x25B87BCA, vehicle, _i, _i)
end

function GetFilterMenuOn()
	return _in(0x509D75E8, _r)
end

function GetFilterSaveSetting(filterid)
	return _in(0x25CA45EA, filterid, _ri)
end

function GetFirstBlipInfoId(type)
	return _in(0x3BD729E9, type, _ri)
end

function GetFirstNCharactersOfLiteralString(literalString, chars)
	return _in(0x42D249E3, _ts(literalString), chars, _s)
end

function GetFirstNCharactersOfString(gxtName, chars)
	return _in(0x108B4A25, _ts(gxtName), chars, _s)
end

function GetFloatStat(stat)
	return _in(0x1D801FC0, stat, _rf)
end

function GetFollowVehicleCamSubmode(mode)
	return _in(0x4C7B7A29, _ii(mode))
end

function GetFragmentDamageHealthOfClosestObjectOfType(x, y, z, radius, Unk77, flag)
	return _in(0x052803D0, x, y, z, radius, Unk77, flag, _rf)
end

function GetFrameCount()
	return _in(0x0DA146AA, _ri)
end

function GetFrameTime(time)
	return _in(0x206420A6, _fi(time))
end

function GetFreeCam(cam)
	return _in(0x538514CC, _ii(cam))
end

function GetFrontendDesignValue(frontendid)
	return _in(0x747E681E, frontendid, _f, _f)
end

function GetFurthestNetworkRestartNode()
	return _in(0x2FEF2477, _r)
end

function GetGameCam(camera)
	return _in(0x0B2A2801, _ii(camera))
end

function GetGameCamChild(camera)
	return _in(0x588F6BC0, _ii(camera))
end

function GetGameTimer(pTimer)
	return _in(0x022B2DA9, _ii(pTimer))
end

function GetGameViewportId(viewportid)
	return _in(0x57F7558B, _ii(viewportid))
end

function GetGamerNetworkScore(playerIndex, Unk888, Unk889)
	return _in(0x6C507EAC, playerIndex, Unk888, Unk889, _ri)
end

function GetGfwlHasSafeHouse()
	return _in(0x6CC85D46, _r)
end

function GetGfwlIsReturningToSinglePlayer()
	return _in(0x2FDF565D, _r)
end

function GetGroundZFor3dCoord(x, y, z, pGroundZ)
	return _in(0x6D902EE3, x, y, z, _fi(pGroundZ), _ri)
end

function GetGroupCharDucksWhenAimedAt(ped)
	return _in(0x070B1C45, ped, _r)
end

function GetGroupFormation(group, formation)
	return _in(0x596174E5, group, _ii(formation))
end

function GetGroupFormationSpacing(group, spacing)
	return _in(0x67DB4150, group, _fi(spacing))
end

function GetGroupLeader(group, pPed)
	return _in(0x5DBB46B5, group, _ii(pPed))
end

function GetGroupMember(group, index, pPed)
	return _in(0x2FF90FF5, group, index, _ii(pPed))
end

function GetGroupSize(group)
	return _in(0x45EE4E9A, group, _i, _i)
end

function GetHashKey(value)
	return _in(0x68FF7165, _ts(value), _ri)
end

function GetHeadingFromVector2d(x, y, pHeading)
	return _in(0x09DD61E1, x, y, _fi(pHeading))
end

function GetHeightOfVehicle(vehicle, x, y, z, unknownTrue1, unknownTrue2)
	return _in(0x5FAD09CA, vehicle, x, y, z, unknownTrue1, unknownTrue2, _rf)
end

function GetHelpMessageBoxSize()
	return _in(0x267D251F, _f, _f)
end

function GetHostId()
	return _in(0x79C84DBC, _ri)
end

function GetHostMatchOn()
	return _in(0x757A0EB8, _r)
end

function GetHoursOfDay()
	return _in(0x0A9F7BA1, _ri)
end

function GetHudColour(type)
	return _in(0x07533EC9, type, _i, _i, _i, _i)
end

function GetIdOfThisThread()
	return _in(0x051A131D, _ri)
end

function GetIntStat(stat)
	return _in(0x48994D58, stat, _ri)
end

function GetInteriorAtCoords(x, y, z, pInterior)
	return _in(0x29216610, x, y, z, _ii(pInterior))
end

function GetInteriorFromCar(vehicle, pInterior)
	return _in(0x25714BE4, vehicle, _ii(pInterior))
end

function GetInteriorFromChar(ped, pInterior)
	return _in(0x028227F7, ped, _ii(pInterior))
end

function GetInteriorFromDummyChar(dummyPed, pInterior)
	return _in(0x380751A9, dummyPed, _ii(pInterior))
end

function GetInteriorHeading(interior, pHeading)
	return _in(0x73245AB3, interior, _fi(pHeading))
end

function GetIsAutosaveOff()
	return _in(0x551C6295, _r)
end

function GetIsDepositAnimRunning()
	return _in(0x3CCB4248, _r)
end

function GetIsDisplayingsavemessage()
	return _in(0x34F9164D, _r)
end

function GetIsHidef()
	return _in(0x19976813, _r)
end

function GetIsProjectileTypeInArea(x0, y0, z0, x1, y1, z1, type)
	return _in(0x7B2E70F3, x0, y0, z0, x1, y1, z1, type, _r)
end

function GetIsStickyBombStuckToObject(obj)
	return _in(0x04D623FF, obj, _r)
end

function GetIsStickyBombStuckToVehicle(veh)
	return _in(0x29BF0233, veh, _r)
end

function GetIsWidescreen()
	return _in(0x0F0269B5, _r)
end

function GetKeyForCarInRoom(vehicle, pKey)
	return _in(0x0E390571, vehicle, _ii(pKey))
end

function GetKeyForCharInRoom(ped, pKey)
	return _in(0x266D0801, ped, _ii(pKey))
end

function GetKeyForDummyCharInRoom(dummyPed, pKey)
	return _in(0x74672C8C, dummyPed, _ii(pKey))
end

function GetKeyForViewportInRoom(viewportid, roomkey)
	return _in(0x10776AAE, viewportid, _ii(roomkey))
end

function GetKeyboardMoveInput()
	return _in(0x4AF73456, _i, _i)
end

function GetKillTrackingResults()
	return _in(0x95932D8, _r)
end

function GetLastTimeNetworkIdDamaged()
	return _in(0x3A8D7BA4, _r)
end

function GetLatestConsoleCommand()
	return _in(0x670E3DE3, _ri)
end

function GetLcpdCopScore()
	return _in(0x17C05D83, _r)
end

function GetLcpdCriminalScore()
	return _in(0x1207025C, _r)
end

function GetLeftPlayerCashToReachLevel(playerRank)
	return _in(0x6DD754DD, playerRank, _ri)
end

function GetLengthOfLiteralString(literalString)
	return _in(0x02BE2D97, _ts(literalString), _ri)
end

function GetLengthOfStringWithThisHashKey(gxtkey)
	return _in(0x6C013A17, gxtkey, _ri)
end

function GetLengthOfStringWithThisTextLabel(gxtName)
	return _in(0x6D795EC0, _ts(gxtName), _ri)
end

function GetLengthOfStringWithThisTextLabelInsNum(Unk608, Unk609, Unk610)
	return _in(0x5F02084D, Unk608, Unk609, Unk610, _ri)
end

function GetLevelDesignCoordsForObject(obj, Unk78)
	return _in(0x3E762D9D, obj, Unk78, _f, _f, _f, _rf)
end

function GetLineHeight()
	return _in(0x150B0C33, _rf)
end

function GetLocalGamerlevelFromProfilesettings()
	return _in(0x7C5F327E, _ri)
end

function GetLocalPlayerMpCash()
	return _in(0x76B068CA, _ri)
end

function GetLocalPlayerWeaponStat(wtype, wid)
	return _in(0x3CCC5AFD, wtype, wid, _rf)
end

function GetMapAreaFromCoords(x, y, z)
	return _in(0x5ED33D46, x, y, z, _ri)
end

function GetMaxAmmo(ped, weapon, pMaxAmmo)
	return _in(0x7C6968F8, ped, weapon, _ii(pMaxAmmo), _r)
end

function GetMaxAmmoInClip(ped, weapon, pMaxAmmo)
	return _in(0x01794A3C, ped, weapon, _ii(pMaxAmmo))
end

function GetMaxWantedLevel(pMaxWantedLevel)
	return _in(0x71755E9B, _ii(pMaxWantedLevel))
end

function GetMaximumNumberOfPassengers(vehicle, pMax)
	return _in(0x554014F1, vehicle, _ii(pMax))
end

function GetMenuItemAccepted(menuid)
	return _in(0x0F322A6C, menuid, _ri)
end

function GetMenuItemSelected(menuid)
	return _in(0x22442A7F, menuid, _ri)
end

function GetMenuPosition(menuid)
	return _in(0x5B576767, menuid, _f, _f)
end

function GetMinutesOfDay()
	return _in(0x3DFE691D, _ri)
end

function GetMinutesToTimeOfDay(hour, minute)
	return _in(0x740C4C84, hour, minute, _ri)
end

function GetMissionFlag()
	return _in(0x2BC64736, _r)
end

function GetMobilePhonePosition()
	return _in(0x67C45774, _r)
end

function GetMobilePhoneRenderId(pRenderId)
	return _in(0x5E7B3816, _ii(pRenderId))
end

function GetMobilePhoneRotation()
	return _in(0x13A83A28, _r)
end

function GetMobilePhoneScale()
	return _in(0x1E951606, _rf)
end

function GetMobilePhoneTaskSubTask(ped, Unk798)
	return _in(0x517B226E, ped, _ii(Unk798), _r)
end

function GetModelDimensions(model)
	return _in(0x191B7021, model, _v, _v)
end

function GetModelNameForDebug(model)
	return _in(0x4342350C, model, _s)
end

function GetModelNameOfCarForDebugOnly()
	return _in(0x18062DA6, _r)
end

function GetModelPedIsHolding(ped)
	return _in(0x0AF378D5, ped, _ri)
end

function GetMotionControlsEnabled()
	return _in(0x6E936A1A, _r)
end

function GetMotionSensorValues()
	return _in(0x998069B, _r)
end

function GetMouseInput()
	return _in(0x447B154B, _i, _i)
end

function GetMousePosition()
	return _in(0x0ECB2DEE, _f, _f)
end

function GetMouseSensitivity()
	return _in(0x41401D46, _rf)
end

function GetMouseWheel(Unk834)
	return _in(0x51870C68, _ii(Unk834))
end

function GetNameOfInfoZone(x, y, z)
	return _in(0x5CAD7949, x, y, z, _s)
end

function GetNameOfScriptToAutomaticallyStart()
	return _in(0x72C13404, _r)
end

function GetNameOfZone(x, y, z)
	return _in(0x25442DF7, x, y, z, _s)
end

function GetNavmeshRouteResult(navmesh)
	return _in(0x4EFE6B67, navmesh, _ri)
end

function GetNearestCableCar(x, y, z, radius, pVehicle)
	return _in(0x7F3A0E22, x, y, z, radius, _ii(pVehicle))
end

function GetNeededPlayerCashForLevel()
	return _in(0x3C14367C, _r)
end

function GetNetworkIdFromObject(obj, netid)
	return _in(0x50424095, obj, _ii(netid))
end

function GetNetworkIdFromPed(ped, netid)
	return _in(0x7BEE5003, ped, _ii(netid))
end

function GetNetworkIdFromVehicle(vehicle, netid)
	return _in(0x1BC70617, vehicle, _ii(netid))
end

function GetNetworkJoinFail()
	return _in(0x4A164056, _r)
end

function GetNetworkPlayerVip()
	return _in(0xB6B0C10, _r)
end

function GetNetworkRestartNodeDebug()
	return _in(0x6629119D, _r)
end

function GetNetworkTimer(Unk917)
	return _in(0x20FD4F4E, Unk917)
end

function GetNextBlipInfoId(type)
	return _in(0x154932F0, type, _ri)
end

function GetNextClosestCarNode(x, y, z)
	return _in(0x5935382A, x, y, z, _f, _f, _f, _r)
end

function GetNextClosestCarNodeFavourDirection(x, y, z)
	return _in(0x6E3906E4, x, y, z, _f, _f, _f, _f, _r)
end

function GetNextClosestCarNodeWithHeading(x, y, z)
	return _in(0x3D7A673F, x, y, z, _f, _f, _f, _f, _r)
end

function GetNextClosestCarNodeWithHeadingOnIsland(x, y, z)
	return _in(0x320E1E3B, x, y, z, _f, _f, _f, _f, _r)
end

function GetNextStationForTrain(train)
	return _in(0x4835637D, train, _ri)
end

function GetNoLawVehiclesDestroyedByLocalPlayer()
	return _in(0x63C50673, _ri)
end

function GetNoOfPlayersInTeam(team)
	return _in(0x1CFD32E5, team, _ri)
end

function GetNthClosestCarNode(x, y, z, n)
	return _in(0x740912C2, x, y, z, n, _f, _f, _f, _r)
end

function GetNthClosestCarNodeFavourDirection(Unk810, x, y, z, n)
	return _in(0x6F766824, Unk810, x, y, z, n, _f, _f, _f, _f, _r)
end

function GetNthClosestCarNodeWithHeading(x, y, z, nodeNum)
	return _in(0x1F6B3FF0, x, y, z, nodeNum, _f, _f, _f, _f, _r)
end

function GetNthClosestCarNodeWithHeadingOnIsland(x, y, z, nodeNum, areaId)
	return _in(0x59DB1AD1, x, y, z, nodeNum, areaId, _f, _f, _f, _f, _i, _r)
end

function GetNthClosestWaterNodeWithHeading(x, y, z, flag0, flag1)
	return _in(0x36F453FF, x, y, z, flag0, flag1, _v, _f, _r)
end

function GetNthGroupMember(group, n, ped)
	return _in(0x48CE0609, group, n, _ii(ped))
end

function GetNthIntegerInString(gxtName, index)
	return _in(0x301545FD, _ts(gxtName), index, _s)
end

function GetNumCarColours(vehicle, pNumColours)
	return _in(0x5AA025C2, vehicle, _ii(pNumColours))
end

function GetNumCarLiveries(car, num)
	return _in(0x0A632BB4, car, _ii(num))
end

function GetNumConsoleCommandTokens()
	return _in(0x205E2D92, _r)
end

function GetNumKillsForRankPoints()
	return _in(0x239C0EEC, _r)
end

function GetNumOfModelsKilledByPlayer(player, model, num)
	return _in(0x75B43A72, player, model, _ii(num))
end

function GetNumStreamingRequests()
	return _in(0x53216168, _ri)
end

function GetNumberLines(Unk703, Unk704, str)
	return _in(0x67B725B2, Unk703, Unk704, _ts(str), _ri)
end

function GetNumberLinesWithLiteralStrings(Unk705, Unk706, str1, str2, str3)
	return _in(0x71DE26A3, Unk705, Unk706, _ts(str1), _ts(str2), _ts(str3), _ri)
end

function GetNumberLinesWithSubstrings(Unk707, Unk708, str1, str2, str3)
	return _in(0x00541084, Unk707, Unk708, _ts(str1), _ts(str2), _ts(str3), _ri)
end

function GetNumberOfActiveStickyBombsOwnedByPed(ped)
	return _in(0x21B85DA9, ped, _ri)
end

function GetNumberOfCharDrawableVariations(ped, component)
	return _in(0x3C293296, ped, component, _ri)
end

function GetNumberOfCharTextureVariations(ped, component, unknown1)
	return _in(0x06C4113E, ped, component, unknown1, _ri)
end

function GetNumberOfFiresInArea(x0, y0, z0, x1, y1, z1)
	return _in(0x1E144C8B, x0, y0, z0, x1, y1, z1, _ri)
end

function GetNumberOfFiresInRange(x, y, z, radius)
	return _in(0x283821D2, x, y, z, radius, _ri)
end

function GetNumberOfFollowers(ped, followers)
	return _in(0x303C3059, ped, _ii(followers))
end

function GetNumberOfInjuredPedsInRange(x, y, z, radius)
	return _in(0x3BB313CB, x, y, z, radius, _ri)
end

function GetNumberOfInstancesOfStreamedScript(scriptName)
	return _in(0x5A1C52C7, _ts(scriptName), _ri)
end

function GetNumberOfPassengers(vehicle, pNumPassengers)
	return _in(0x5BE30681, vehicle, _ii(pNumPassengers))
end

function GetNumberOfPlayers()
	return _in(0x62405882, _ri)
end

function GetNumberOfStickyBombsStuckToObject(obj)
	return _in(0x4AD026EE, obj, _ri)
end

function GetNumberOfStickyBombsStuckToVehicle(veh)
	return _in(0x285D1184, veh, _ri)
end

function GetNumberOfWebPageLinks(htmlviewport)
	return _in(0x18A22AE4, htmlviewport, _ri)
end

function GetObjectAnimCurrentTime(obj, animname0, animname1, time)
	return _in(0x29F02CB1, obj, _ts(animname0), _ts(animname1), _fi(time))
end

function GetObjectAnimTotalTime(obj, animname0, animname1, time)
	return _in(0x26E66DF3, obj, _ts(animname0), _ts(animname1), _fi(time))
end

function GetObjectCoordinates(obj)
	return _in(0x49DA4F9E, obj, _f, _f, _f)
end

function GetObjectFragmentDamageHealth(obj, unknown)
	return _in(0x79CA30B1, obj, unknown, _rf)
end

function GetObjectFromNetworkId(netid, obj)
	return _in(0x7AA91131, netid, _ii(obj))
end

function GetObjectHeading(obj, pHeading)
	return _in(0x791D1778, obj, _fi(pHeading))
end

function GetObjectHealth(obj, pHealth)
	return _in(0x4ACB039B, obj, _fi(pHealth))
end

function GetObjectMass(obj, mass)
	return _in(0x0B8B3941, obj, _fi(mass))
end

function GetObjectModel(obj, pModel)
	return _in(0x5CC55619, obj, _ii(pModel))
end

function GetObjectPedIsHolding(ped)
	return _in(0x45345838, ped, _ri)
end

function GetObjectQuaternion(obj)
	return _in(0x0F731898, obj, _f, _f, _f, _f)
end

function GetObjectRotationVelocity(obj)
	return _in(0x492A71E2, obj, _f, _f, _f)
end

function GetObjectSpeed(obj, pSpeed)
	return _in(0x1C2F57FB, obj, _fi(pSpeed))
end

function GetObjectTurnMass(obj, turnmass)
	return _in(0x3C85109F, obj, _fi(turnmass))
end

function GetObjectVelocity(obj)
	return _in(0x06D651A7, obj, _f, _f, _f)
end

function GetOffsetFromCarGivenWorldCoords(vehicle, x, y, z)
	return _in(0x373B213C, vehicle, x, y, z, _f, _f, _f)
end

function GetOffsetFromCarInWorldCoords(vehicle, x, y, z)
	return _in(0x7F8D3DD9, vehicle, x, y, z, _f, _f, _f)
end

function GetOffsetFromCharInWorldCoords(ped, x, y, z)
	return _in(0x737F24F9, ped, x, y, z, _f, _f, _f)
end

function GetOffsetFromInteriorInWorldCoords(interior, x, y, z, pOffset)
	return _in(0x68966670, interior, x, y, z, _fi(pOffset))
end

function GetOffsetFromObjectInWorldCoords(obj, x, y, z)
	return _in(0x449F4165, obj, x, y, z, _f, _f, _f)
end

function GetOffsetsForAttachCarToCar(car0, car1)
	return _in(0x2CAD4E39, car0, car1, _v, _v)
end

function GetOnlineLan()
	return _in(0x6B032A0B, _ri)
end

function GetOnlineScore(Unk887)
	return _in(0x6CFD3E5F, Unk887, _rf)
end

function GetOverrideNoSprintingOnPhoneInMultiplayer()
	return _in(0x5B652681, _r)
end

function GetPadOrientation()
	return _in(0x58EF2B2B, _r)
end

function GetPadPitchRoll(padIndex)
	return _in(0x767B7EC9, padIndex, _f, _f, _r)
end

function GetPadState(Unk835, Unk836, Unk837)
	return _in(0x5D4C1D59, Unk835, Unk836, _ii(Unk837))
end

function GetParkingNodeInArea()
	return _in(0x70CB4DCE, _r)
end

function GetPedAtHeadOfQueue()
	return _in(0x9FE0380, _r)
end

function GetPedBonePosition(ped, bone, x, y, z, pPosition)
	return _in(0x43475BB3, ped, bone, x, y, z, _v)
end

function GetPedClimbState(ped)
	return _in(0x391822A7, ped, _ri)
end

function GetPedFromNetworkId(netid, ped)
	return _in(0x69F11716, netid, _ii(ped))
end

function GetPedGroupIndex(ped, pIndex)
	return _in(0x58E53B06, ped, _ii(pIndex))
end

function GetPedModelFromIndex(index)
	return _in(0x124D4571, index, _ri)
end

function GetPedObjectIsAttachedTo(obj)
	return _in(0x755D6DF8, obj, _ri)
end

function GetPedPathMayDropFromHeight(ped)
	return _in(0x45AA529D, ped, _r)
end

function GetPedPathMayUseClimbovers(ped)
	return _in(0x714C1031, ped, _r)
end

function GetPedPathMayUseLadders(ped)
	return _in(0x503E2D1E, ped, _r)
end

function GetPedPathWillAvoidDynamicObjects(ped)
	return _in(0x74F97CF8, ped, _r)
end

function GetPedSteersAroundObjects(ped)
	return _in(0x75E32257, ped, _r)
end

function GetPedSteersAroundPeds(ped)
	return _in(0x179848E4, ped, _r)
end

function GetPedType(ped, pType)
	return _in(0x18F477E1, ped, _ii(pType))
end

function GetPetrolTankHealth(vehicle)
	return _in(0x2C835642, vehicle, _rf)
end

function GetPhysicalScreenResolution()
	return _in(0x3CD830D0, _f, _f)
end

function GetPickupCoordinates(pickup)
	return _in(0x0F636C38, pickup, _f, _f, _f)
end

function GetPlaneUndercarriagePosition(plane, pos)
	return _in(0x353F0568, plane, _fi(pos))
end

function GetPlayerChar(playerIndex, pPed)
	if(playerIndex == -1) then return _in(0x511454A9, GetPlayerId(), _ii(pPed))
	else return _in(0x511454A9, playerIndex, _ii(pPed))
	end	
end

function GetPlayerColour(Player)
	return _in(0x25270A4B, Player, _ri)
end

function GetPlayerGroup(playerIndex, pGroup)
	return _in(0x41AB3C30, playerIndex, _ii(pGroup))
end

function GetPlayerHasTracks()
	return _in(0x396844BE, _r)
end

function GetPlayerId()
	return _in(0x62E319C6, _ri)
end

function GetPlayerIdForThisPed(ped)
	return _in(0x733B61C6, ped, _ri)
end

function GetPlayerLcpdScore()
	return _in(0x2BEB02D6, _r)
end

function GetPlayerMaxArmour(playerIndex, pMaxArmour)
	return _in(0x17265607, playerIndex, _ii(pMaxArmour))
end

function GetPlayerMaxHealth(player, maxhealth)
	return _in(0x52F27084, player, _ii(maxhealth))
end

function GetPlayerName(playerIndex)
	return _in(0x570F5725, playerIndex, _s)
end

function GetPlayerRadioMode()
	return _in(0x32795678, _ri)
end

function GetPlayerRadioStationIndex()
	return _in(0x4E493AAF, _ri)
end

function GetPlayerRadioStationName()
	return _in(0x25136AC2, _s)
end

function GetPlayerRadioStationName()
	return _in(0x25136AC2, _s)
end

function GetPlayerRadioStationNameRoll()
	return _in(0x1A936344, _s)
end

function GetPlayerRankLevelDuringMp(playerIndex)
	return _in(0x7B31633E, playerIndex, _ri)
end

function GetPlayerRgbColour(Player)
	return _in(0x73BD71A9, Player, _i, _i, _i)
end

function GetPlayerTeam(Player)
	return _in(0x4C2879AD, Player, _ri)
end

function GetPlayerToPlaceBombInCar(vehicle)
	return _in(0x17572318, vehicle, _ri)
end

function GetPlayerWantedLevelIncrement(player, increment)
	return _in(0x44BB2306, player, _ii(increment))
end

function GetPlayersLastCarNoSave(pVehicle)
	return _in(0x12067E8D, _ii(pVehicle))
end

function GetPlayersettingsModelChoice()
	return _in(0x116E5A1F, _ri)
end

function GetPositionOfAnalogueSticks(padIndex)
	return _in(0x4F7F4FAE, padIndex, _i, _i, _i, _i)
end

function GetPositionOfCarRecordingAtTime(CarRec, time, pos)
	return _in(0x03B37165, CarRec, time, _fi(pos))
end

function GetProfileSetting(settingid)
	return _in(0x575A3431, settingid, _ri)
end

function GetProgressPercentage()
	return _in(0x78E9500C, _rf)
end

function GetRadarViewportId(viewport)
	return _in(0x4A7C19FE, _ii(viewport))
end

function GetRadioName(id)
	return _in(0x7EC9580E, id, _s)
end

function GetRandomCarBackBumperInSphere(x, y, z, radius, Unk812, Unk813, veh)
	return _in(0x2C37408C, x, y, z, radius, Unk812, Unk813, _ii(veh))
end

function GetRandomCarFrontBumperInSphereNoSave(x, y, z, radius, flag0, flag1, flag2)
	return _in(0x13C91ACD, x, y, z, radius, flag0, flag1, _i, flag2)
end

function GetRandomCarInSphere(x, y, z, radius, model, Unk814, car)
	return _in(0x528F5EA7, x, y, z, radius, model, Unk814, _ii(car))
end

function GetRandomCarInSphereNoSave(x, y, z, radius, model, flag, car)
	return _in(0x0A7E36E5, x, y, z, radius, model, flag, _ii(car))
end

function GetRandomCarModelInMemory(MustIncludeSpecialModels)
	return _in(0x195C13BC, MustIncludeSpecialModels, _i, _i)
end

function GetRandomCarNode(x, y, z, radius, flag0, flag1, flag2)
	return _in(0x588E1506, x, y, z, radius, flag0, flag1, flag2, _f, _f, _f, _f, _r)
end

function GetRandomCarNodeIncludeSwitchedOffNodes(x, y, z, radius, flag0, flag1, flag2)
	return _in(0x2D1A5F8C, x, y, z, radius, flag0, flag1, flag2, _f, _f, _f, _f, _r)
end

function GetRandomCarOfTypeInAngledAreaNoSave(Unk815, Unk816, Unk817, Unk818, Unk819, type, car)
	return _in(0x6D4746D8, Unk815, Unk816, Unk817, Unk818, Unk819, type, _ii(car))
end

function GetRandomCarOfTypeInAreaNoSave(x0, y0, x1, y1, model, car)
	return _in(0x74AF54F0, x0, y0, x1, y1, model, _ii(car))
end

function GetRandomCharInAreaOffsetNoSave(x, y, z, sx, sy, sz, pPed)
	return _in(0x6ED17CF8, x, y, z, sx, sy, sz, _ii(pPed))
end

function GetRandomNetworkRestartNode(Unk1013, Unk1014, Unk1015, Unk1016, Unk1017, Unk1018)
	return _in(0x0A2B76C2, Unk1013, Unk1014, Unk1015, Unk1016, Unk1017, Unk1018, _ri)
end

function GetRandomNetworkRestartNodeExcludingGroup()
	return _in(0x393309, _r)
end

function GetRandomNetworkRestartNodeOfGroup()
	return _in(0x1A7C1AA7, _r)
end

function GetRandomNetworkRestartNodeUsingGroupList(Unk1019, Unk1020, Unk1021, Unk1022, Unk1023, Unk1024)
	return _in(0x03CA3302, Unk1019, Unk1020, Unk1021, Unk1022, Unk1023, Unk1024, _ri)
end

function GetRandomWaterNode(x, y, z, radius, flag0, flag1, flag2, flag3)
	return _in(0x6FBE6CE6, x, y, z, radius, flag0, flag1, flag2, flag3, _f, _f, _f, _f, _r)
end

function GetRemoteControlledCar()
	return _in(0x311926C6, _r)
end

function GetReturnToFilterMenu()
	return _in(0x2A055AFA, _r)
end

function GetRoomKeyFromObject(obj, pRoomKey)
	return _in(0x561509AD, obj, _ii(pRoomKey))
end

function GetRoomKeyFromPickup(pickup, hash)
	return _in(0x28045C47, pickup, _ii(hash))
end

function GetRoomNameFromCharDebug()
	return _in(0x4A7620F7, _r)
end

function GetRootCam(rootcam)
	return _in(0x75E005F1, _ii(rootcam))
end

function GetRopeHeightForObject(obj, height)
	return _in(0x473B1371, obj, _fi(height))
end

function GetRouteSize()
	return _in(0x086138DE, _ri)
end

function GetSafeLocalRestartCoords()
	return _in(0x477450D4, _r)
end

function GetSafePickupCoords(x, y, z)
	return _in(0x1AE44443, x, y, z, _f, _f, _f)
end

function GetSafePositionForChar(x, y, z, unknownTrue)
	return _in(0x5D877285, x, y, z, unknownTrue, _f, _f, _f, _r)
end

function GetScreenFadeAlpha()
	return _in(0x04161E66, _ri)
end

function GetScreenResolution()
	return _in(0x0D8A1BCF, _i, _i)
end

function GetScreenViewportId(viewportid)
	return _in(0x25271044, _ii(viewportid))
end

function GetScriptCam(cam)
	return _in(0x5F00596C, _ii(cam))
end

function GetScriptDrawCam(cam)
	return _in(0x30F71BC6, _ii(cam))
end

function GetScriptFireCoords(fire)
	return _in(0x4F256F49, fire, _f, _f, _f)
end

function GetScriptRendertargetRenderId(pRenderId)
	return _in(0x58296B19, _ii(pRenderId))
end

function GetScriptTaskStatus(ped, task, status)
	return _in(0x74C14D31, ped, task, _ii(status))
end

function GetSequenceProgress(seq, progress)
	return _in(0x1FBD3ACA, seq, _ii(progress))
end

function GetSequenceProgressRecursive()
	return _in(0x60BC4116, _r)
end

function GetServerId()
	return _in(0x51983F94, _ri)
end

function GetSimpleBlipId()
	return _in(0x047B0898, _ri)
end

function GetSortedNetworkRestartNode(Unk1025, Unk1026, Unk1027, Unk1028, Unk1029, Unk1030, Unk1031, Unk1032, Unk1033)
	return _in(0x5BF71B87, Unk1025, Unk1026, Unk1027, Unk1028, Unk1029, Unk1030, Unk1031, Unk1032, Unk1033, _ri)
end

function GetSortedNetworkRestartNodeExcludingGroup()
	return _in(0x55AC75E2, _r)
end

function GetSortedNetworkRestartNodeOfGroup()
	return _in(0x209F734C, _r)
end

function GetSortedNetworkRestartNodeUsingGroupList(Unk1034, Unk1035, Unk1036, Unk1037, Unk1038, Unk1039, Unk1040, Unk1041, Unk1042)
	return _in(0x22463E22, Unk1034, Unk1035, Unk1036, Unk1037, Unk1038, Unk1039, Unk1040, Unk1041, Unk1042, _ri)
end

function GetSoundId()
	return _in(0x6342018A, _ri)
end

function GetSoundLevelAtCoords(ped, x, y, z, level)
	return _in(0x433E74C6, ped, x, y, z, _ii(level))
end

function GetSpawnCoordinatesForCarNode(Unk918, Unk919, Unk920, Unk921, Unk922, Unk923)
	return _in(0x5B386B6C, Unk918, Unk919, Unk920, Unk921, Unk922, Unk923)
end

function GetSpeechForEmergencyServiceCall()
	return _in(0x1B915945, _s)
end

function GetStartFromFilterMenu()
	return _in(0x45073C46, _ri)
end

function GetStatFrontendDisplayType(stat)
	return _in(0x347C4300, stat, _ri)
end

function GetStatFrontendVisibility(stat)
	return _in(0x38905687, stat, _r)
end

function GetStateOfClosestDoorOfType(model, x, y, z)
	return _in(0x14007AC6, model, x, y, z, _i, _f)
end

function GetStaticEmitterPlaytime(StaticEmitterIndex)
	return _in(0x068774A4, StaticEmitterIndex, _ri)
end

function GetStationName(train, station)
	return _in(0x46F87F55, train, station, _s)
end

function GetStreamBeatInfo()
	return _in(0x6A3A2C88, _i, _i, _i)
end

function GetStreamPlaytime()
	return _in(0x4B6211F2, _ri)
end

function GetStringFromHashKey(hash)
	return _in(0x16E14EA4, hash, _s)
end

function GetStringFromString(str, startsymb, endsymb)
	return _in(0x434534BE, _ts(str), startsymb, endsymb, _s)
end

function GetStringFromTextFile(gxtentry)
	return _in(0x332F0E9A, _ts(gxtentry), _s)
end

function GetStringWidth(gxtName)
	return _in(0x64660709, _ts(gxtName), _ri)
end

function GetStringWidthWithNumber(gxtName, number)
	return _in(0x33E0601D, _ts(gxtName), number, _ri)
end

function GetStringWidthWithString(gxtName, literalString)
	return _in(0x48850E66, _ts(gxtName), _ts(literalString), _rf)
end

function GetStringWidthWithTextAndInt(gxtname, gxtnamenext, val)
	return _in(0x05267B97, _ts(gxtname), _ts(gxtnamenext), val, _ri)
end

function GetTaskPlaceCarBombUnsuccessful()
	return _in(0x0A4608E9, _r)
end

function GetTeamColour()
	return _in(0x4FC96A24, _r)
end

function GetTeamRgbColour(team)
	return _in(0x42F561F2, team, _i, _i, _i)
end

function GetTextInputActive()
	return _in(0x32A3647C, _r)
end

function GetTexture(dictionary, textureName)
	return _in(0x0F5D1937, dictionary, _ts(textureName), _ri)
end

function GetTextureFromStreamedTxd(txdName, textureName)
	return _in(0x32C24491, _ts(txdName), _ts(textureName), _ri)
end

function GetTextureResolution(texture)
	return _in(0x01A75F0C, texture, _f, _f)
end

function GetTimeOfDay()
	return _in(0x384B3876, _i, _i)
end

function GetTimeSinceLastArrest()
	return _in(0x475D2BEA, _ri)
end

function GetTimeSinceLastDeath()
	return _in(0x11162A93, _ri)
end

function GetTimeSincePlayerDroveAgainstTraffic(playerIndex)
	return _in(0x3B007E58, playerIndex, _ri)
end

function GetTimeSincePlayerDroveOnPavement(playerIndex)
	return _in(0x19610E35, playerIndex, _ri)
end

function GetTimeSincePlayerHitBuilding(playerIndex)
	return _in(0x126C0B99, playerIndex, _ri)
end

function GetTimeSincePlayerHitCar(playerIndex)
	return _in(0x58C01823, playerIndex, _ri)
end

function GetTimeSincePlayerHitObject(playerIndex)
	return _in(0x43C2796B, playerIndex, _ri)
end

function GetTimeSincePlayerHitPed(playerIndex)
	return _in(0x40602B66, playerIndex, _ri)
end

function GetTimeSincePlayerRanLight(playerIndex)
	return _in(0x65D95395, playerIndex, _ri)
end

function GetTimeTilNextStation(train)
	return _in(0x142E7C40, train, _rf)
end

function GetTotalDurationOfCarRecording(CarRec)
	return _in(0x5F8C3937, CarRec, _rf)
end

function GetTotalNumberOfStats()
	return _in(0x6D823703, _ri)
end

function GetTrainCaboose(train, caboose)
	return _in(0x3FB72D27, train, _ii(caboose))
end

function GetTrainCarriage(train, num, carriage)
	return _in(0x7F861E46, train, num, _ii(carriage))
end

function GetTrainPlayerWouldEnter(player, train)
	return _in(0x30481141, player, _ii(train))
end

function GetTxd(txdName)
	return _in(0x15D668D0, _ts(txdName), _ri)
end

function GetVehicleClass()
	return _in(0x6F796702, _r)
end

function GetVehicleComponentInfo(veh, component_id, flag)
	return _in(0x3B5D0F27, veh, component_id, _v, _v, _i, flag, _r)
end

function GetVehicleDirtLevel(vehicle, pIntensity)
	return _in(0x571152F5, vehicle, _fi(pIntensity))
end

function GetVehicleEngineRevs(veh)
	return _in(0x2FFA0249, veh, _rf)
end

function GetVehicleFromNetworkId(netid, vehicle)
	return _in(0x794E4A82, netid, _ii(vehicle))
end

function GetVehicleGear(veh)
	return _in(0x2D2F452D, veh, _ri)
end

function GetVehicleModelFromIndex(index)
	return _in(0x7E5C70BF, index, _ri)
end

function GetVehiclePlayerWouldEnter(player, veh)
	return _in(0x20430265, player, _ii(veh))
end

function GetVehicleQuaternion(veh)
	return _in(0x6C5871D6, veh, _f, _f, _f, _f)
end

function GetVehicleTypeOfModel(model)
	return _in(0x60F720F6, model, _ri)
end

function GetViewportPosAndSize(viewportid)
	return _in(0x4DDC6FB4, viewportid, _f, _f, _f, _f)
end

function GetViewportPositionOfCoord(x, y, z, viewportid)
	return _in(0x287A49A5, x, y, z, viewportid, _f, _f, _r)
end

function GetWaterHeight(x, y, z, pheight)
	return _in(0x2BB9620F, x, y, z, _fi(pheight), _r)
end

function GetWaterHeightNoWaves(x, y, z, height)
	return _in(0x67C82864, x, y, z, _fi(height), _r)
end

function GetWeapontypeModel(weapontype, model)
	return _in(0x4FE23F25, weapontype, _ii(model))
end

function GetWeapontypeSlot(weapon, slot)
	return _in(0x5E4F6DE3, weapon, _ii(slot))
end

function GetWebPageHeight(htmlviewport)
	return _in(0x09FD24F3, htmlviewport, _rf)
end

function GetWebPageLinkAtPosn(htmlviewport, x, y)
	return _in(0x0C1C5B1B, htmlviewport, x, y, _ri)
end

function GetWebPageLinkHref(htmlviewport, linkid)
	return _in(0x750C1CD7, htmlviewport, linkid, _s)
end

function GetWebPageLinkPosn(htmlviewport, linkid)
	return _in(0x717B5EFB, htmlviewport, linkid, _f, _f)
end

function GetWidthOfLiteralString(str)
	return _in(0x164B7363, _ts(str), _ri)
end

function GetWidthOfSubstringGivenTextLabel(gxtname, Unk611, Unk612, Unk613, Unk614)
	return _in(0x64E51535, _ts(gxtname), Unk611, Unk612, Unk613, Unk614, _ri)
end

function GiveDelayedWeaponToChar(ped, weapon, delaytime, flag)
	return _in(0x709154FC, ped, weapon, delaytime, flag)
end

function GivePedAmbientObject(ped, model)
	return _in(0x44AA71F9, ped, model)
end

function GivePedFakeNetworkName(ped, name, r, g, b, a)
	return _in(0x55E0158B, ped, _ts(name), r, g, b, a)
end

function GivePedHelmet(ped)
	return _in(0x07A0177D, ped)
end

function GivePedHelmetWithOpts(ped, Unk42)
	return _in(0x3B6E1D1E, ped, Unk42)
end

function GivePedPickupObject(ped, obj, flag)
	return _in(0x684D1517, ped, obj, flag)
end

function GivePlayerHelmet()
	return _in(0x463F190F, _r)
end

function GivePlayerRagdollControl(player, give)
	return _in(0x5A1D7A2F, player, give)
end

function GiveRemoteControlledModelToPlayer()
	return _in(0x663979D9, _r)
end

function GiveWeaponToChar(ped, weapon, ammo, unknown0)
	return _in(0x03E90416, ped, weapon, ammo, unknown0)
end

function GrabEntityOnRopeForObject(obj)
	return _in(0x309F1F4B, obj, _i, _i, _i)
end

function GrabNearbyObjectWithSpecialAttribute(attribute, obj)
	return _in(0x256472F1, attribute, _ii(obj))
end

function HandVehicleControlBackToPlayer(veh)
	return _in(0x6C654678, veh)
end

function HandleAudioAnimEvent(ped, AudioAnimEventName)
	return _in(0x56C15139, ped, _ts(AudioAnimEventName))
end

function HasAchievementBeenPassed(achievement)
	return _in(0x32765F37, achievement, _r)
end

function HasAdditionalTextLoaded(textIndex)
	return _in(0x4832644E, textIndex, _r)
end

function HasCarBeenDamagedByCar(vehicle, otherCar)
	return _in(0x119A668D, vehicle, otherCar, _r)
end

function HasCarBeenDamagedByChar(vehicle, ped)
	return _in(0x61487DBF, vehicle, ped, _r)
end

function HasCarBeenDamagedByWeapon(vehicle, weapon)
	return _in(0x0EE34390, vehicle, weapon, _r)
end

function HasCarBeenDroppedOff(car)
	return _in(0x024C3A6C, car, _r)
end

function HasCarBeenResprayed(vehicle)
	return _in(0x3D0432F2, vehicle, _r)
end

function HasCarRecordingBeenLoaded(CarRec)
	return _in(0x453F587D, CarRec, _r)
end

function HasCarStoppedBecauseOfLight(car)
	return _in(0x40CD2BD4, car, _r)
end

function HasCharAnimFinished(ped, AnimName0, AnimName1)
	return _in(0x53F34027, ped, _ts(AnimName0), _ts(AnimName1), _r)
end

function HasCharBeenArrested(ped)
	return _in(0x210A0879, ped, _r)
end

function HasCharBeenDamagedByCar(ped, vehicle)
	return _in(0x30A65021, ped, vehicle, _r)
end

function HasCharBeenDamagedByChar(ped, otherChar, unknownFalse)
	return _in(0x1DD624A0, ped, otherChar, unknownFalse, _r)
end

function HasCharBeenDamagedByWeapon(ped, weapon)
	return _in(0x6DB26E07, ped, weapon, _r)
end

function HasCharBeenPhotographed(ped)
	return _in(0x1F2928A6, ped, _r)
end

function HasCharGotWeapon(ped, weapon)
	return _in(0x11F759DE, ped, weapon, _r)
end

function HasCharSpottedChar(ped, otherChar)
	return _in(0x1ADD68E8, ped, otherChar, _r)
end

function HasCharSpottedCharInFront(ped, otherChar)
	return _in(0x156D5236, ped, otherChar, _r)
end

function HasClosestObjectOfTypeBeenDamagedByCar(x, y, z, radius, type_or_model, car)
	return _in(0x4D6B3E20, x, y, z, radius, type_or_model, car, _r)
end

function HasClosestObjectOfTypeBeenDamagedByChar(x, y, z, radius, objectModel, ped)
	return _in(0x1FC90C7C, x, y, z, radius, objectModel, ped, _r)
end

function HasCollisionForModelLoaded(model)
	return _in(0x7C3939E7, model, _r)
end

function HasControlOfNetworkId(netid)
	return _in(0x176C2DB5, netid, _r)
end

function HasCutsceneFinished()
	return _in(0x4ECE1AD2, _r)
end

function HasCutsceneLoaded()
	return _in(0x5DE43980, _r)
end

function HasDeatharrestExecuted()
	return _in(0x3B0C6738, _r)
end

function HasFragmentRootOfClosestObjectOfTypeBeenDamaged(x, y, z, radius, Unk70)
	return _in(0x31B64D2B, x, y, z, radius, Unk70, _r)
end

function HasGamerChangedNetworkModelSettings()
	return _in(0x7EBB00D7, _r)
end

function HasModelLoaded(model)
	return _in(0x4E61480A, model, _r)
end

function HasNetIdBeenCloned()
	return _in(0x1F0A3D73, _r)
end

function HasNetworkPlayerLeftGame(playerIndex)
	return _in(0x135154B0, playerIndex, _r)
end

function HasObjectBeenDamaged(obj)
	return _in(0x7E0D6CB8, obj, _r)
end

function HasObjectBeenDamagedByCar(obj, vehicle)
	return _in(0x50801274, obj, vehicle, _r)
end

function HasObjectBeenDamagedByChar(obj, ped)
	return _in(0x0B464BE8, obj, ped, _r)
end

function HasObjectBeenDamagedByWeapon(obj, Unk71)
	return _in(0x547C42B1, obj, Unk71, _r)
end

function HasObjectBeenPhotographed(obj)
	return _in(0x57895F38, obj, _r)
end

function HasObjectBeenUprooted(obj)
	return _in(0x58737620, obj, _r)
end

function HasObjectCollidedWithAnything(obj)
	return _in(0x106811E4, obj, _r)
end

function HasObjectFragmentRootBeenDamaged(obj)
	return _in(0x3162071D, obj, _r)
end

function HasOverridenSitIdleAnimFinished(ped)
	return _in(0x520A745D, ped, _r)
end

function HasPickupBeenCollected(pickup)
	return _in(0x2F2226E5, pickup, _r)
end

function HasPlayerCollectedPickup(playerIndex, pikcup)
	return _in(0x025D2170, playerIndex, pikcup, _r)
end

function HasPlayerDamagedAtLeastOnePed(playerIndex)
	return _in(0x64E06CBB, playerIndex, _r)
end

function HasPlayerDamagedAtLeastOneVehicle(playerIndex)
	return _in(0x674849B5, playerIndex, _r)
end

function HasPlayerRankBeenUpgraded()
	return _in(0x6A842382, _r)
end

function HasPoolObjectCollidedWithCushion(obj)
	return _in(0x3E8D7D3F, obj, _r)
end

function HasPoolObjectCollidedWithObject(obj, otherObj)
	return _in(0x24D70069, obj, otherObj, _r)
end

function HasReloadedWithMotionControl(ukn0, ukn)
	return _in(0x08C6502C, ukn0, _i --[[ actually bool ]], _r)
end

function HasResprayHappened()
	return _in(0x465574B0, _r)
end

function HasScriptLoaded(scriptName)
	return _in(0x2A171915, _ts(scriptName), _r)
end

function HasSoundFinished(sound)
	return _in(0x2CA53AA1, sound, _r)
end

function HasStreamedTxdLoaded(txdName)
	return _in(0x5F9C43D4, _ts(txdName), _r)
end

function HasThisAdditionalTextLoaded(textName, textIndex)
	return _in(0x6CF248FD, _ts(textName), textIndex, _r)
end

function HaveAnimsLoaded(animName)
	return _in(0x1D3F681D, _ts(animName), _r)
end

function HaveRequestedPathNodesBeenLoaded(requestId)
	return _in(0x54DD5868, requestId, _r)
end

function HeliAudioShouldSkipStartup(heli, skip)
	return _in(0x4CC001AC, heli, skip)
end

function HideCharWeaponForScriptedCutscene(ped, hide)
	return _in(0x2B7C5CFB, ped, hide)
end

function HideHelpTextThisFrame()
	return _in(0x16AF6DEB)
end

function HideHudAndRadarThisFrame()
	return _in(0x60320FEB)
end

function HighFallScream(ped)
	return _in(0x478976DB, ped)
end

function HighlightMenuItem(menuid, item, highlight)
	return _in(0x1ABE6A4C, menuid, item, highlight)
end

function HintCam(x, y, z, Unk559, Unk560, Unk561, Unk562)
	return _in(0x1B637A1C, x, y, z, Unk559, Unk560, Unk561, Unk562)
end

function HowLongHasNetworkPlayerBeenDeadFor(playerIndex)
	return _in(0x4E6120A9, playerIndex, _ri)
end

function ImproveLowPerformanceMissionPerFrameFlag()
	return _in(0x2B64229C)
end

function IncreasePlayerMaxArmour(player, armour)
	return _in(0x2232704D, player, armour)
end

function IncreasePlayerMaxHealth(player, maxhealth)
	return _in(0x40A703A6, player, maxhealth)
end

function IncrementFloatStat(stat, val)
	return _in(0x548E3AFC, stat, val)
end

function IncrementFloatStatNoMessage(stat, value)
	return _in(0x2C6564F2, stat, value)
end

function IncrementIntStat(stat, value)
	return _in(0x14D242D9, stat, value)
end

function IncrementIntStatNoMessage(stat, value)
	return _in(0x29827605, stat, value)
end

function InitCutscene(name)
	return _in(0x47E50BD3, _ts(name))
end

function InitDebugWidgets()
	return _in(0x73E911E8)
end

function InitFrontendHelperText()
	return _in(0x617B191D)
end

function Is2playerGameGoingOn()
	return _in(0x604E1C46, _r)
end

function IsAmbientSpeechDisabled(ped)
	return _in(0x563F4CC2, ped, _r)
end

function IsAmbientSpeechPlaying(ped)
	return _in(0x032F24CB, ped, _r)
end

function IsAnyCharShootingInArea(x0, y0, z0, x1, y1, z1, flag)
	return _in(0x19D16ACE, x0, y0, z0, x1, y1, z1, flag, _r)
end

function IsAnyPickupAtCoords(x, y, z)
	return _in(0x75DC4737, x, y, z, _r)
end

function IsAnySpeechPlaying(ped)
	return _in(0x170F7E75, ped, _r)
end

function IsAreaOccupied(x1, y1, z1, x2, y2, z2, unknownFalse1, unknownTrue, unknownFalse2, unknownFalse3, unknownFalse4)
	return _in(0x5BE1238D, x1, y1, z1, x2, y2, z2, unknownFalse1, unknownTrue, unknownFalse2, unknownFalse3, unknownFalse4, _r)
end

function IsAttachedPlayerHeadingAchieved()
	return _in(0x487A1886, _r)
end

function IsAutoAimingOn()
	return _in(0x366B0444, _r)
end

function IsAutoSaveInProgress()
	return _in(0x601A5770, _r)
end

function IsBigVehicle(vehicle)
	return _in(0x60305168, vehicle, _r)
end

function IsBitSet(val, bitnum)
	return _in(0x5373544E, val, bitnum, _r)
end

function IsBlipShortRange(blip)
	return _in(0x32E84B6A, blip, _r)
end

function IsBulletInArea(x, y, z, radius, unknownTrue)
	return _in(0x58493B8E, x, y, z, radius, unknownTrue, _r)
end

function IsBulletInBox(x1, y1, z1, x2, y2, z2, unknown)
	return _in(0x60964DB8, x1, y1, z1, x2, y2, z2, unknown, _r)
end

function IsButtonJustPressed(padIndex, button)
	return _in(0x016C37CD, padIndex, button, _r)
end

function IsButtonPressed(padIndex, button)
	return _in(0x7FF21081, padIndex, button, _r)
end

function IsCamActive(camera)
	return _in(0x348D7AF5, camera, _r)
end

function IsCamColliding()
	return _in(0x39595CE1, _r)
end

function IsCamHappy(cam)
	return _in(0x7D95313B, cam, _r)
end

function IsCamInterpolating()
	return _in(0x1AE118F4, _r)
end

function IsCamPropagating(camera)
	return _in(0x7EAC3387, camera, _r)
end

function IsCamSequenceComplete(Unk535)
	return _in(0x55727056, Unk535, _r)
end

function IsCamShaking()
	return _in(0x089C57D7, _r)
end

function IsCarAMissionCar(vehicle)
	return _in(0x7A422E14, vehicle, _r)
end

function IsCarAttached(vehicle)
	return _in(0x6BDC40EB, vehicle, _r)
end

function IsCarDead(vehicle)
	return _in(0x2AAB340A, vehicle, _r)
end

function IsCarDoorDamaged(vehicle, door)
	return _in(0x5AFE791F, vehicle, door, _r)
end

function IsCarDoorFullyOpen(vehicle, door)
	return _in(0x55444602, vehicle, door, _r)
end

function IsCarHealthGreater(car, health)
	return _in(0x63F07A46, car, health, _r)
end

function IsCarInAirProper(vehicle)
	return _in(0x37BF18AC, vehicle, _r)
end

function IsCarInAngledArea2d()
	return _in(0x74290BCB, _r)
end

function IsCarInAngledArea3d()
	return _in(0x3521612F, _r)
end

function IsCarInArea2d(vehicle, x1, y1, x2, y2, unknownFalse)
	return _in(0x7EA03481, vehicle, x1, y1, x2, y2, unknownFalse, _r)
end

function IsCarInArea3d(vehicle, x1, y1, z1, x2, y2, z2, unknownFalse)
	return _in(0x289D3888, vehicle, x1, y1, z1, x2, y2, z2, unknownFalse, _r)
end

function IsCarInGarageArea(garageName, vehicle)
	return _in(0x005868E2, _ts(garageName), vehicle, _r)
end

function IsCarInWater(vehicle)
	return _in(0x0FF342B2, vehicle, _r)
end

function IsCarLowRider(car)
	return _in(0x6B3D5D45, car, _r)
end

function IsCarModel(vehicle, model)
	return _in(0x03D16145, vehicle, model, _r)
end

function IsCarOnFire(vehicle)
	return _in(0x189A2BB1, vehicle, _r)
end

function IsCarOnScreen(vehicle)
	return _in(0x59E3553F, vehicle, _r)
end

function IsCarPassengerSeatFree(vehicle, seatIndex)
	return _in(0x1BDA0DA5, vehicle, seatIndex, _r)
end

function IsCarPlayingAnim(car, animname0, animname1)
	return _in(0x49F619F1, car, _ts(animname0), _ts(animname1), _r)
end

function IsCarSirenOn(vehicle)
	return _in(0x129A1569, vehicle, _r)
end

function IsCarStopped(vehicle)
	return _in(0x4A000F52, vehicle, _r)
end

function IsCarStoppedAtTrafficLights(vehicle)
	return _in(0x141B23A9, vehicle, _r)
end

function IsCarStoppedInArea2d()
	return _in(0x2ED27636, _r)
end

function IsCarStreetRacer(car)
	return _in(0x24DF32CC, car, _r)
end

function IsCarStuck(car)
	return _in(0x0CD276B4, car, _r)
end

function IsCarStuckOnRoof(vehicle)
	return _in(0x46892D07, vehicle, _r)
end

function IsCarTouchingCar(vehicle, otherCar)
	return _in(0x7B014306, vehicle, otherCar, _r)
end

function IsCarTyreBurst(vehicle, tyre)
	return _in(0x1DF623F9, vehicle, tyre, _r)
end

function IsCarUpright(vehicle)
	return _in(0x1A212500, vehicle, _r)
end

function IsCarUpsidedown(vehicle)
	return _in(0x2E291239, vehicle, _r)
end

function IsCarWaitingForWorldCollision(vehicle)
	return _in(0x6EA72622, vehicle, _r)
end

function IsCharArmed(ped, slot)
	return _in(0x046A4720, ped, slot, _r)
end

function IsCharDead(ped)
	return _in(0x6A6B4F18, ped, _r)
end

function IsCharDucking(ped)
	return _in(0x495D6021, ped, _r)
end

function IsCharFacingChar(ped, otherChar, angle)
	return _in(0x05AD758A, ped, otherChar, angle, _r)
end

function IsCharFatallyInjured(ped)
	return _in(0x4A7802CB, ped, _r)
end

function IsCharGesturing(ped)
	return _in(0x07025A4A, ped, _r)
end

function IsCharGettingInToACar(ped)
	return _in(0x5C8C2E39, ped, _r)
end

function IsCharGettingUp(ped)
	return _in(0x4A906237, ped, _r)
end

function IsCharHealthGreater(ped, health)
	return _in(0x7B75036E, ped, health, _r)
end

function IsCharInAir(ped)
	return _in(0x23C15141, ped, _r)
end

function IsCharInAngledArea2d(ped, x1, y1, x2, y2, unknown, unknownFalse)
	return _in(0x7D591EAD, ped, x1, y1, x2, y2, unknown, unknownFalse, _r)
end

function IsCharInAngledArea3d(ped, x1, y1, z1, x2, y2, z2, unknown, unknownFalse)
	return _in(0x610157C9, ped, x1, y1, z1, x2, y2, z2, unknown, unknownFalse, _r)
end

function IsCharInAnyBoat(ped)
	return _in(0x210A4F1D, ped, _r)
end

function IsCharInAnyCar(ped)
	return _in(0x71184DA3, ped, _r)
end

function IsCharInAnyHeli(ped)
	return _in(0x0FC40275, ped, _r)
end

function IsCharInAnyPlane(ped)
	return _in(0x4BAC2912, ped, _r)
end

function IsCharInAnyPoliceVehicle(ped)
	return _in(0x4414660B, ped, _r)
end

function IsCharInAnyTrain(ped)
	return _in(0x22434C20, ped, _r)
end

function IsCharInAreaOnFoot2d(ped, x1, y1, x2, y2, unknownFalse)
	return _in(0x3F2D7D06, ped, x1, y1, x2, y2, unknownFalse, _r)
end

function IsCharInArea2d(ped, x1, y1, x2, y2, unknownFalse)
	return _in(0x7F371477, ped, x1, y1, x2, y2, unknownFalse, _r)
end

function IsCharInArea3d(ped, x1, y1, z1, x2, y2, z2, unknownFalse)
	return _in(0x44A30283, ped, x1, y1, z1, x2, y2, z2, unknownFalse, _r)
end

function IsCharInCar(ped, vehicle)
	return _in(0x7D037B40, ped, vehicle, _r)
end

function IsCharInFlyingVehicle(ped)
	return _in(0x7FA763E8, ped, _r)
end

function IsCharInMeleeCombat(ped)
	return _in(0x68855BE7, ped, _r)
end

function IsCharInModel(ped, model)
	return _in(0x45DB5FE9, ped, model, _r)
end

function IsCharInTaxi(ped)
	return _in(0x28A73BCA, ped, _r)
end

function IsCharInWater(ped)
	return _in(0x7B1F0130, ped, _r)
end

function IsCharInZone(ped, zonename)
	return _in(0x435054B3, ped, _ts(zonename), _r)
end

function IsCharInjured(ped)
	return _in(0x4ECB2267, ped, _r)
end

function IsCharMale(ped)
	return _in(0x7D76127F, ped, _r)
end

function IsCharModel(ped, model)
	return _in(0x6C403ACC, ped, model, _r)
end

function IsCharOnAnyBike(ped)
	return _in(0x0FB44F54, ped, _r)
end

function IsCharOnFire(ped)
	return _in(0x358E21C5, ped, _r)
end

function IsCharOnFoot(ped)
	return _in(0x10A86CF4, ped, _r)
end

function IsCharOnPlayerMachine()
	return _in(0x1BFE7952, _r)
end

function IsCharOnScreen(ped)
	return _in(0x59471B11, ped, _r)
end

function IsCharPlayingAnim(ped, animSet, animName)
	return _in(0x673E4CD2, ped, _ts(animSet), _ts(animName), _r)
end

function IsCharRespondingToAnyEvent(ped)
	return _in(0x5DDB09F8, ped, _r)
end

function IsCharRespondingToEvent(ped, eventid)
	return _in(0x32653482, ped, eventid, _r)
end

function IsCharShooting(ped)
	return _in(0x324D1594, ped, _r)
end

function IsCharShootingInArea(ped, x1, y1, x2, y2, unknownFalse)
	return _in(0x42941472, ped, x1, y1, x2, y2, unknownFalse, _r)
end

function IsCharSittingIdle(ped)
	return _in(0x064621F1, ped, _r)
end

function IsCharSittingInAnyCar(ped)
	return _in(0x1DBD7385, ped, _r)
end

function IsCharSittingInCar(ped, vehicle)
	return _in(0x309C265B, ped, vehicle, _r)
end

function IsCharStopped(ped)
	return _in(0x0CA614E6, ped, _r)
end

function IsCharStuckUnderCar(ped)
	return _in(0x70BB021A, ped, _r)
end

function IsCharSwimming(ped)
	return _in(0x75D21B78, ped, _r)
end

function IsCharTouchingChar(ped, otherChar)
	return _in(0x03FB6DED, ped, otherChar, _r)
end

function IsCharTouchingObject(ped, obj)
	return _in(0x3AB06137, ped, obj, _r)
end

function IsCharTouchingObjectOnFoot(ped, obj)
	return _in(0x7C0B46C8, ped, obj, _r)
end

function IsCharTouchingVehicle(ped, vehicle)
	return _in(0x307A4B8E, ped, vehicle, _r)
end

function IsCharTryingToEnterALockedCar(ped)
	return _in(0x1C132038, ped, _r)
end

function IsCharUsingAnyScenario(ped)
	return _in(0x64BD4664, ped, _r)
end

function IsCharUsingMapAttractor(ped)
	return _in(0x60B26D74, ped, _r)
end

function IsCharUsingScenario(ped, scenarioName)
	return _in(0x62842540, ped, _ts(scenarioName), _r)
end

function IsCharVisible(ped)
	return _in(0x0A0F19D1, ped, _r)
end

function IsCharWaitingForWorldCollision(ped)
	return _in(0x51453EA2, ped, _r)
end

function IsClosestObjectOfTypeSmashedOrDamaged(x, y, z, radius, type_or_model, flag0, flag1)
	return _in(0x788026F4, x, y, z, radius, type_or_model, flag0, flag1, _r)
end

function IsControlJustPressed(Unk822, controlid)
	return _in(0x4CB729F1, Unk822, controlid, _r)
end

function IsControlPressed(Unk823, controlid)
	return _in(0x0E635761, Unk823, controlid, _r)
end

function IsCopPedInArea3dNoSave(x0, y0, z0, x1, y1, z1)
	return _in(0x01866CB5, x0, y0, z0, x1, y1, z1, _r)
end

function IsCopVehicleInArea3dNoSave(x0, y0, z0, x1, y1, z1)
	return _in(0x72F81072, x0, y0, z0, x1, y1, z1, _r)
end

function IsDamageTrackerActiveOnNetworkId(Unk882)
	return _in(0x5A2F2DD1, Unk882, _r)
end

function IsDebugCameraOn()
	return _in(0x4E26149C, _r)
end

function IsEmergencyServicesVehicle(veh)
	return _in(0x6AFF0587, veh, _r)
end

function IsEpisodeAvailable(episode)
	return _in(0x232800BD, episode, _r)
end

function IsEpisodicDiscBuild()
	return _in(0x511A2EC9, _r)
end

function IsExplosionInArea(expnum, x0, y0, z0, x1, y1, z1)
	return _in(0x676B6BCA, expnum, x0, y0, z0, x1, y1, z1, _r)
end

function IsExplosionInSphere(expnum, x, y, z, radius)
	return _in(0x47A77D2E, expnum, x, y, z, radius, _r)
end

function IsFollowVehicleCamOffsetActive()
	return _in(0x40072120, _r)
end

function IsFontLoaded(font)
	return _in(0x69B53ADA, font, _r)
end

function IsFrontendFading()
	return _in(0x09FD7668, _r)
end

function IsGameInControlOfMusic()
	return _in(0x4FF71989, _r)
end

function IsGameKeyboardKeyJustPressed(key)
	return _in(0x540D127D, key, _r)
end

function IsGameKeyboardKeyPressed(key)
	return _in(0x5FA96262, key, _r)
end

function IsGameKeyboardNavDownPressed(Unk824)
	return _in(0x45E45B1D, Unk824, _r)
end

function IsGameKeyboardNavLeftPressed(Unk825)
	return _in(0x793F238A, Unk825, _r)
end

function IsGameKeyboardNavRightPressed(Unk826)
	return _in(0x3C156533, Unk826, _r)
end

function IsGameKeyboardNavUpPressed(Unk827)
	return _in(0x14AB75AE, Unk827, _r)
end

function IsGarageClosed(garageName)
	return _in(0x26BC1939, _ts(garageName), _r)
end

function IsGarageOpen(garageName)
	return _in(0x65A80992, _ts(garageName), _r)
end

function IsGroupLeader(ped, group)
	return _in(0x2CEC22DA, ped, group, _r)
end

function IsGroupMember(ped, group)
	return _in(0x674D6F8E, ped, group, _r)
end

function IsHeliPartBroken(heli, flag0, flag1, flag2)
	return _in(0x1E2D5A7B, heli, flag0, flag1, flag2, _r)
end

function IsHelpMessageBeingDisplayed()
	return _in(0x6E4E1BEC, _r)
end

function IsHintRunning()
	return _in(0x323806B1, _r)
end

function IsHudPreferenceSwitchedOn()
	return _in(0x69604AE2, _r)
end

function IsHudReticuleComplex()
	return _in(0x4DDB5D59, _r)
end

function IsInCarFireButtonPressed()
	return _in(0x63B70F7C, _r)
end

function IsInLanMode()
	return _in(0x1B8E7EED, _r)
end

function IsInMpTutorial()
	return _in(0x13750991, _r)
end

function IsInPlayerSettingsMenu()
	return _in(0x18CA2D3A, _r)
end

function IsInSpectatorMode()
	return _in(0x07CC3F86, _r)
end

function IsInteriorScene()
	return _in(0x61DA102E, _r)
end

function IsJapaneseVersion()
	return _in(0x37D022E0, _r)
end

function IsKeyboardKeyJustPressed(key)
	return _in(0x75C9772B, key, _r)
end

function IsKeyboardKeyPressed(key)
	return _in(0x1D334237, key, _r)
end

function IsLazlowStationLocked()
	return _in(0x1CB80079, _r)
end

function IsLcpdDataValid()
	return _in(0x611D69BC, _r)
end

function IsLookInverted()
	return _in(0x1817000B, _r)
end

function IsMemoryCardInUse()
	return _in(0x38F61531, _r)
end

function IsMessageBeingDisplayed()
	return _in(0x68EA6EBE, _r)
end

function IsMinigameInProgress()
	return _in(0x68F06A02, _r)
end

function IsMissionCompletePlaying()
	return _in(0x6C3B5917, _r)
end

function IsMobilePhoneCallOngoing()
	return _in(0x698F6172, _r)
end

function IsMobilePhoneRadioActive()
	return _in(0x4AF14146, _r)
end

function IsModelInCdimage(model)
	return _in(0x771C2838, model, _r)
end

function IsMoneyPickupAtCoords(x, y, z)
	return _in(0x43167C6E, x, y, z, _r)
end

function IsMouseButtonJustPressed(Unk828)
	return _in(0x27323E51, Unk828, _r)
end

function IsMouseButtonPressed(Unk829)
	return _in(0x39E600D0, Unk829, _r)
end

function IsMouseUsingVerticalInversion()
	return _in(0x64655F10, _r)
end

function IsNetworkConnected()
	return _in(0x43945A83, _r)
end

function IsNetworkGamePending()
	return _in(0x7563071D, _r)
end

function IsNetworkGameRunning()
	return _in(0x1CF773D4, _r)
end

function IsNetworkPlayerActive(playerIndex)
	return _in(0x4E237943, playerIndex, _r)
end

function IsNetworkPlayerVisible()
	return _in(0x1031625F, _r)
end

function IsNetworkSession()
	return _in(0x6E2B38F3, _r)
end

function IsNextStationAllowed(veh)
	return _in(0x7B8B1D10, veh, _r)
end

function IsNonFragObjectSmashed(x, y, z, radius, model)
	return _in(0x5C723F31, x, y, z, radius, model, _r)
end

function IsNumlockEnabled()
	return _in(0x39487FB9, _r)
end

function IsObjectAttached(obj)
	return _in(0x701F4004, obj, _r)
end

function IsObjectInAngledArea2d()
	return _in(0x9B37544, _r)
end

function IsObjectInAngledArea3d(obj, x0, y0, z0, x1, y1, z1, Unk72, flag)
	return _in(0x5D5A06F7, obj, x0, y0, z0, x1, y1, z1, Unk72, flag, _r)
end

function IsObjectInArea2d(obj, x0, y0, x1, y2, flag)
	return _in(0x2C6D65AD, obj, x0, y0, x1, y2, flag, _r)
end

function IsObjectInArea3d(obj, x0, y0, z0, x1, y1, z1, flag)
	return _in(0x6D717883, obj, x0, y0, z0, x1, y1, z1, flag, _r)
end

function IsObjectInWater(obj)
	return _in(0x7BF7646F, obj, _r)
end

function IsObjectOnFire(obj)
	return _in(0x7A240412, obj, _r)
end

function IsObjectOnPlayerMachine()
	return _in(0x736569, _r)
end

function IsObjectOnScreen(obj)
	return _in(0x6A9A3B1F, obj, _r)
end

function IsObjectPlayingAnim(obj, animname0, animname1)
	return _in(0x4D2E58D5, obj, _ts(animname0), _ts(animname1), _r)
end

function IsObjectReassignmentInProgress()
	return _in(0x7D0D6779, _r)
end

function IsObjectStatic(obj)
	return _in(0x7B181EB0, obj, _r)
end

function IsObjectTouchingObject(obj0, obj1)
	return _in(0x6A2E514F, obj0, obj1, _r)
end

function IsObjectUpright(obj, angle)
	return _in(0x1EE13E29, obj, angle, _r)
end

function IsObjectWithinBrainActivationRange(obj)
	return _in(0x472C710B, obj, _r)
end

function IsOurPlayerHigherPriorityForCarGeneration(playerIndex)
	return _in(0x504E03FC, playerIndex, _r)
end

function IsPainPlaying(ped)
	return _in(0x32422759, ped, _r)
end

function IsPartyMode()
	return _in(0x2A3A77FD, _r)
end

function IsPauseMenuActive()
	return _in(0x6C4568A7, _r)
end

function IsPayNSprayActive()
	return _in(0x1EE70376, _r)
end

function IsPcUsingJoypad()
	return _in(0x7E8E06F8, _r)
end

function IsPedAMissionPed(ped)
	return _in(0x05801768, ped, _r)
end

function IsPedAttachedToAnyCar(ped)
	return _in(0x78DC034E, ped, _r)
end

function IsPedAttachedToObject(ped, obj)
	return _in(0x0BCE3423, ped, obj, _r)
end

function IsPedBeingJacked(ped)
	return _in(0x68B829C7, ped, _r)
end

function IsPedClimbing(ped)
	return _in(0x66F5118F, ped, _r)
end

function IsPedDoingDriveby(ped)
	return _in(0x080F3B37, ped, _r)
end

function IsPedFleeing(ped)
	return _in(0x5E486AA1, ped, _r)
end

function IsPedHoldingAnObject(ped)
	return _in(0x22811897, ped, _r)
end

function IsPedInCombat(ped)
	return _in(0x020106D6, ped, _r)
end

function IsPedInCover(ped)
	return _in(0x5C825D83, ped, _r)
end

function IsPedInCutsceneBlockingBounds(ped)
	return _in(0x55916D7A, ped, _r)
end

function IsPedInGroup(ped)
	return _in(0x365054A7, ped, _r)
end

function IsPedJacking(ped)
	return _in(0x676F0004, ped, _r)
end

function IsPedLookingAtCar(ped, car)
	return _in(0x4859273F, ped, car, _r)
end

function IsPedLookingAtObject(ped, obj)
	return _in(0x5DD231A2, ped, obj, _r)
end

function IsPedLookingAtPed(ped, otherChar)
	return _in(0x7F206A7F, ped, otherChar, _r)
end

function IsPedPinnedDown(ped)
	return _in(0x03B13377, ped, _r)
end

function IsPedRagdoll(ped)
	return _in(0x3E251ADE, ped, _r)
end

function IsPedRetreating(ped)
	return _in(0x7A0B156B, ped, _r)
end

function IsPedsVehicleHot(ped)
	return _in(0x470A7CBD, ped, _r)
end

function IsPlaceCarBombActive()
	return _in(0x775F6665, _r)
end

function IsPlaybackGoingOnForCar(car)
	return _in(0x375F145D, car, _r)
end

function IsPlayerBeingArrested()
	return _in(0x79A95BF9, _r)
end

function IsPlayerClimbing(playerIndex)
	return _in(0x3BF5404E, playerIndex, _r)
end

function IsPlayerControlOn(playerIndex)
	return _in(0x30CD2F1F, playerIndex, _r)
end

function IsPlayerDead(playerIndex)
	return _in(0x12AE0E27, playerIndex, _r)
end

function IsPlayerFreeAimingAtChar(playerIndex, ped)
	return _in(0x30D427B4, playerIndex, ped, _r)
end

function IsPlayerFreeForAmbientTask(playerIndex)
	return _in(0x63E7509E, playerIndex, _r)
end

function IsPlayerInInfoZone(player, zoneid)
	return _in(0x66133D7, player, zoneid, _r)
end

function IsPlayerInRemoteMode(player)
	return _in(0x526B7BA9, player, _r)
end

function IsPlayerInShortcutTaxi()
	return _in(0x44052D59, _r)
end

function IsPlayerOnline()
	return _in(0x61C65FDE, _r)
end

function IsPlayerPerformingStoppie(player)
	return _in(0x2E815A94, player, _r)
end

function IsPlayerPerformingWheelie(player)
	return _in(0x613510D0, player, _r)
end

function IsPlayerPlaying(playerIndex)
	return _in(0x08274BA4, playerIndex, _r)
end

function IsPlayerPressingHorn(playerIndex)
	return _in(0x583A7A8B, playerIndex, _r)
end

function IsPlayerReadyForCutscene(player)
	return _in(0x29D46FF4, player, _r)
end

function IsPlayerScriptControlOn(player)
	return _in(0x38861F3A, player, _r)
end

function IsPlayerSignedInLocally()
	return _in(0x547523EE, _r)
end

function IsPlayerTargettingAnything(playerIndex)
	return _in(0x665F6BB7, playerIndex, _r)
end

function IsPlayerTargettingChar(playerIndex, ped)
	return _in(0x58A6457C, playerIndex, ped, _r)
end

function IsPlayerTargettingObject(playerIndex, obj)
	return _in(0x679934F9, playerIndex, obj, _r)
end

function IsPlayerVehicleEntryDisabled(player)
	return _in(0x4908091D, player, _r)
end

function IsPointObscuredByAMissionEntity(pX, pY, pZ, sizeX, sizeY, sizeZ)
	return _in(0x7FBC713E, pX, pY, pZ, sizeX, sizeY, sizeZ, _r)
end

function IsPosInCutsceneBlockingBounds(x, y, z)
	return _in(0x593A553B, x, y, z, _r)
end

function IsProjectileInArea(x0, y0, z0, x1, y1, z1)
	return _in(0x7BB35FCF, x0, y0, z0, x1, y1, z1, _r)
end

function IsRadioHudOn()
	return _in(0x45F249B7, _r)
end

function IsRadioRetuning()
	return _in(0x45C344AA, _r)
end

function IsRelationshipSet(Unk493, Unk494, Unk495)
	return _in(0x4C076B40, Unk493, Unk494, Unk495, _r)
end

function IsReplaySaving()
	return _in(0x78021D03, _r)
end

function IsReplaySystemSaving()
	return _in(0x318F65E6, _r)
end

function IsScoreGreater(playerIndex, score)
	return _in(0x517B7068, playerIndex, score, _r)
end

function IsScreenFadedIn()
	return _in(0x5E0713B2, _r)
end

function IsScreenFadedOut()
	return _in(0x59EE3A11, _r)
end

function IsScreenFading()
	return _in(0x73700561, _r)
end

function IsScreenFadingIn()
	return _in(0x5D1425DF, _r)
end

function IsScreenFadingOut()
	return _in(0x0A940E03, _r)
end

function IsScriptFireExtinguished(fire)
	return _in(0x394C1E55, fire, _r)
end

function IsScriptedConversationOngoing()
	return _in(0x3CA23254, _r)
end

function IsScriptedSpeechPlaying(ped)
	return _in(0x12D71B44, ped, _r)
end

function IsSittingObjectNear(x, y, z, Unk73)
	return _in(0x120B4F15, x, y, z, Unk73, _r)
end

function IsSniperBulletInArea(x0, y0, z0, x1, y1, z1)
	return _in(0x6E435BDE, x0, y0, z0, x1, y1, z1, _ri)
end

function IsSniperInverted()
	return _in(0x50DC54B3, _r)
end

function IsSpecificCamInterpolating(cam)
	return _in(0x17C37E6D, cam, _r)
end

function IsSphereVisibleToAnotherMachine(Unk1043, Unk1044, Unk1045, Unk1046)
	return _in(0x11EE28D5, Unk1043, Unk1044, Unk1045, Unk1046, _ri)
end

function IsStreamingAdditionalText(textIndex)
	return _in(0x23B00129, textIndex, _r)
end

function IsStreamingPriorityRequests()
	return _in(0x64342B55, _r)
end

function IsStreamingThisAdditionalText(str0, Unk597, Unk598)
	return _in(0x4D077DBA, _ts(str0), Unk597, Unk598, _r)
end

function IsStringNull(str)
	return _in(0x49A75618, _ts(str), _r)
end

function IsSystemUiShowing()
	return _in(0x5F643EE6, _r)
end

function IsThisAMinigameScript()
	return _in(0x219A3AF6, _r)
end

function IsThisHelpMessageBeingDisplayed(gxtentry)
	return _in(0x505D37D8, _ts(gxtentry), _r)
end

function IsThisHelpMessageWithNumberBeingDisplayed(gxtentry, number)
	return _in(0x09E878A4, _ts(gxtentry), number, _r)
end

function IsThisHelpMessageWithStringBeingDisplayed(gxtentry, str)
	return _in(0x4D155EE8, _ts(gxtentry), _ts(str), _r)
end

function IsThisMachineTheServer()
	return _in(0x2E5E1600, _r)
end

function IsThisModelABike(model)
	return _in(0x57F46B33, model, _r)
end

function IsThisModelABoat(model)
	return _in(0x43CC0913, model, _r)
end

function IsThisModelACar(model)
	return _in(0x6EA92FD5, model, _r)
end

function IsThisModelAHeli(model)
	return _in(0x62EA75E0, model, _r)
end

function IsThisModelAPed(model)
	return _in(0x0E2438E5, model, _r)
end

function IsThisModelAPlane(model)
	return _in(0x176F4D4C, model, _r)
end

function IsThisModelATrain(model)
	return _in(0x7B8537F7, model, _r)
end

function IsThisModelAVehicle(model)
	return _in(0x62BC0AEE, model, _r)
end

function IsThisPedAPlayer(ped)
	return _in(0x37C85316, ped, _r)
end

function IsThisPrintBeingDisplayed(gxtentry, Unk615, Unk616, Unk617, Unk618, Unk619, Unk620, Unk621, Unk622, Unk623, Unk624)
	return _in(0x459A7F23, _ts(gxtentry), Unk615, Unk616, Unk617, Unk618, Unk619, Unk620, Unk621, Unk622, Unk623, Unk624, _ri)
end

function IsThreadActive(threadId)
	return _in(0x052A30F7, threadId, _r)
end

function IsUsingController()
	return _in(0x669D053F, _r)
end

function IsVehDriveable(vehicle)
	return _in(0x17BC668D, vehicle, _r)
end

function IsVehStuck(veh, time, flag0, flag1, flag2)
	return _in(0x460D2EBB, veh, time, flag0, flag1, flag2, _r)
end

function IsVehWindowIntact(vehicle, window)
	return _in(0x1D0B131A, vehicle, window, _r)
end

function IsVehicleExtraTurnedOn(vehicle, extra)
	return _in(0x4B920E81, vehicle, extra, _r)
end

function IsVehicleOnAllWheels(vehicle)
	return _in(0x4D460265, vehicle, _r)
end

function IsVehicleOnPlayerMachine()
	return _in(0x2CFE78F5, _r)
end

function IsVehicleTouchingObject(veh, obj)
	return _in(0x06CD4EB4, veh, obj, _r)
end

function IsViewportActive(viewportid)
	return _in(0x5D2B2A9A, viewportid, _r)
end

function IsWantedLevelGreater(playerIndex, level)
	return _in(0x7DA4736D, playerIndex, level, _r)
end

function IsWorldPointWithinBrainActivationRange()
	return _in(0x5E7B0F23, _r)
end

function KnockPedOffBike(vehicle)
	return _in(0x6CA57960, vehicle)
end

function LaunchLocalPlayerInNetworkGame()
	return _in(0x70FE415C)
end

function LcpdFirstTime()
	return _in(0x6C82562E, _r)
end

function LcpdHasBeenConfigured()
	return _in(0x23254427, _r)
end

function LimitAngle(angle, anglelimited)
	return _in(0x4CAE3B65, angle, _fi(anglelimited))
end

function LimitTwoPlayerDistance(distance)
	return _in(0x50AD1F3E, distance)
end

function Line(x0, y0, z0, x1, y1, z1)
	return _in(0x6C6F6052, x0, y0, z0, x1, y1, z1)
end

function ListenToPlayerGroupCommands(ped, set)
	return _in(0x34AC73D6, ped, set)
end

function LoadAdditionalText(textName, textIndex)
	return _in(0x28897EBD, _ts(textName), textIndex)
end

function LoadAllObjectsNow()
	return _in(0x4BF36A32)
end

function LoadAllPathNodes(value)
	return _in(0x356C2DDB, value, _ri)
end

function LoadCharDecisionMaker(type, pDM)
	return _in(0x7F7B4FC5, type, _ii(pDM))
end

function LoadCombatDecisionMaker(type, pDM)
	return _in(0x0C7B14D9, type, _ii(pDM))
end

function LoadPathNodesInArea(x, y, z, radius)
	return _in(0x44640C28, x, y, z, radius)
end

function LoadScene(x, y, z)
	return _in(0x39F62BFB, x, y, z)
end

function LoadSceneForRoomByKey(interior, roomhash)
	return _in(0x6E904C1A, interior, roomhash)
end

function LoadSettings()
	return _in(0x77745390)
end

function LoadTextFont(font)
	return _in(0x2D371601, font)
end

function LoadTxd(txdName)
	return _in(0x52FC763A, _ts(txdName), _ri)
end

function LoadWebPage(htmlviewport, webaddress)
	return _in(0x78C17971, htmlviewport, _ts(webaddress))
end

function LocalPlayerIsReadyToStartPlaying()
	return _in(0x5C03585C, _r)
end

function LocateCar2d(car, x0, y0, xUnk48, yUnk49, flag)
	return _in(0x36F70AF6, car, x0, y0, xUnk48, yUnk49, flag, _r)
end

function LocateCar3d(car, x, y, z, xa, ya, za, flag)
	return _in(0x2A221E97, car, x, y, z, xa, ya, za, flag, _r)
end

function LocateCharAnyMeansCar2d(ped, car, x, y, flag)
	return _in(0x1A455E51, ped, car, x, y, flag, _r)
end

function LocateCharAnyMeansCar3d(ped, car, x, y, z, flag)
	return _in(0x58DD4CCC, ped, car, x, y, z, flag, _r)
end

function LocateCharAnyMeansChar2d(ped, pednext, x, y, flag)
	return _in(0x18EA4926, ped, pednext, x, y, flag, _r)
end

function LocateCharAnyMeansChar3d(ped, pednext, x, y, z, flag)
	return _in(0x3E441A58, ped, pednext, x, y, z, flag, _r)
end

function LocateCharAnyMeansObject2d(ped, obj, x, y, flag)
	return _in(0x4FD34079, ped, obj, x, y, flag, _r)
end

function LocateCharAnyMeansObject3d(ped, obj, x, y, z, flag)
	return _in(0x6D0E1BCE, ped, obj, x, y, z, flag, _r)
end

function LocateCharAnyMeans2d(ped, x0, y0, x1, y1, flag)
	return _in(0x5BB767AD, ped, x0, y0, x1, y1, flag, _r)
end

function LocateCharAnyMeans3d(ped, x0, y0, z0, x1, y1, z1, flag)
	return _in(0x0437222B, ped, x0, y0, z0, x1, y1, z1, flag, _r)
end

function LocateCharInCarCar2d(ped, car, x, y, flag)
	return _in(0x53B429F9, ped, car, x, y, flag, _r)
end

function LocateCharInCarCar3d(ped, car, x, y, z, flag)
	return _in(0x4D3547D1, ped, car, x, y, z, flag, _r)
end

function LocateCharInCarChar2d(ped, pednext, x, y, flag)
	return _in(0x17BC4531, ped, pednext, x, y, flag, _r)
end

function LocateCharInCarChar3d(ped, pednext, x, y, z, flag)
	return _in(0x014F234F, ped, pednext, x, y, z, flag, _r)
end

function LocateCharInCarObject2d(ped, obj, x, y, flag)
	return _in(0x6CCB719D, ped, obj, x, y, flag, _r)
end

function LocateCharInCarObject3d(ped, obj, x, y, z, flag)
	return _in(0x0C26452D, ped, obj, x, y, z, flag, _r)
end

function LocateCharInCar2d(ped, x0, y0, x1, y1, flag)
	return _in(0x1DDA54EF, ped, x0, y0, x1, y1, flag, _r)
end

function LocateCharInCar3d(ped, x0, y0, z0, x1, y1, z, flag)
	return _in(0x0AC92D36, ped, x0, y0, z0, x1, y1, z, flag, _r)
end

function LocateCharOnFootCar2d(ped, car, x, y, flag)
	return _in(0x78A75EF4, ped, car, x, y, flag, _r)
end

function LocateCharOnFootCar3d(ped, car, x, y, z, flag)
	return _in(0x3C3E5FA0, ped, car, x, y, z, flag, _r)
end

function LocateCharOnFootChar2d(ped, pednext, x, y, flag)
	return _in(0x191E2F12, ped, pednext, x, y, flag, _r)
end

function LocateCharOnFootChar3d(ped, pednext, x, y, z, flag)
	return _in(0x4DA362B0, ped, pednext, x, y, z, flag, _r)
end

function LocateCharOnFootObject2d(ped, obj, x, y, flag)
	return _in(0x67F518F0, ped, obj, x, y, flag, _r)
end

function LocateCharOnFootObject3d(ped, obj, x, y, z, flag)
	return _in(0x4A8E429A, ped, obj, x, y, z, flag, _r)
end

function LocateCharOnFoot2d(ped, x0, y0, x1, y1, flag)
	return _in(0x50EE161F, ped, x0, y0, x1, y1, flag, _r)
end

function LocateCharOnFoot3d(ped, x0, y0, z0, x1, y1, z1, flag)
	return _in(0x3D003090, ped, x0, y0, z0, x1, y1, z1, flag, _r)
end

function LocateDeadCar3d(car, x, y, z, xa, ya, za, flag)
	return _in(0x584D0C79, car, x, y, z, xa, ya, za, flag, _r)
end

function LocateObject2d(obj, x0, y0, x1, y1, flag)
	return _in(0x59A57BA8, obj, x0, y0, x1, y1, flag, _r)
end

function LocateObject3d(obj, x, y, z, xr, yr, zr, flag)
	return _in(0x6DB47487, obj, x, y, z, xr, yr, zr, flag, _r)
end

function LockCarDoors(vehicle, value)
	return _in(0x6702757C, vehicle, value)
end

function LockLazlowStation()
	return _in(0x1B215A3B)
end

function LockPlayerSettingsGenreChange(lock_bit_mask)
	return _in(0x33F4498E, lock_bit_mask)
end

function LookAtNearbyEntityWithSpecialAttribute(Unk98)
	return _in(0x6EB639E8, Unk98, _v, _f, _i, _i, _i, _r)
end

function LoopRaceTrack(loop)
	return _in(0x77FD5097, loop)
end

function MaintainFlashingStarAfterOffence(player, maintain)
	return _in(0x68880DCD, player, maintain)
end

function MakeObjectTargettable(obj, targettable)
	return _in(0x228F1801, obj, targettable)
end

function MakePlayerFireProof(player, proof)
	return _in(0x38293796, player, proof)
end

function MakePlayerGangDisappear()
	return _in(0x34211CDA)
end

function MakePlayerGangReappear()
	return _in(0x295A652A)
end

function MakePlayerSafeForCutscene(player)
	return _in(0x45852A03, player)
end

function MakeRoomInPlayerGangForMissionPeds()
	return _in(0x210E265E, _r)
end

function MarkCarAsConvoyCar(vehicle, convoyCar)
	return _in(0x79274447, vehicle, convoyCar)
end

function MarkCarAsNoLongerNeeded(pVehicle)
	return _in(0x20C76FD1, _ii(pVehicle))
end

function MarkCharAsNoLongerNeeded(pPed)
	return _in(0x0B774604, _ii(pPed))
end

function MarkMissionTrainAsNoLongerNeeded(train)
	return _in(0x37AC2A95, train)
end

function MarkMissionTrainsAsNoLongerNeeded()
	return _in(0x07E7104E)
end

function MarkModelAsNoLongerNeeded(model)
	return _in(0x00FA0E33, model)
end

function MarkObjectAsNoLongerNeeded(pObj)
	return _in(0x493B655B, _ii(pObj))
end

function MarkRoadNodeAsDontWander(x, y, z)
	return _in(0x4C2621B6, x, y, z)
end

function MarkScriptAsNoLongerNeeded(scriptName)
	return _in(0x09E405DB, _ts(scriptName))
end

function MarkStreamedTxdAsNoLongerNeeded(txdName)
	return _in(0x70EA2B89, _ts(txdName))
end

function MissionAudioBankNoLongerNeeded()
	return _in(0x12C42F66)
end

function ModifyCharMoveBlendRatio(ped, Unk6)
	return _in(0x3E657606, ped, Unk6)
end

function ModifyCharMoveState(ped, state)
	return _in(0x5CD32071, ped, state)
end

function MpGetAmountOfAnchorPoints(ped, id)
	return _in(0x6C7566F3, ped, id, _ri)
end

function MpGetAmountOfVariationComponent(ped, componentid)
	return _in(0x54DD6ACF, ped, componentid, _ri)
end

function MpGetPreferenceValue(prefid)
	return _in(0x54F61C99, prefid, _ri)
end

function MpGetPropSetup(ped, ukn0, ukn1, ukn2, ukn3)
	return _in(0x1C00658B, ped, ukn0, ukn1, ukn2, ukn3, _ri)
end

function MpGetVariationSetup(ped, Unk890, Unk891, Unk892, Unk893)
	return _in(0x3775138E, ped, Unk890, Unk891, Unk892, Unk893, _ri)
end

function MpSetPreferenceValue(prefid, value)
	return _in(0x216804D3, prefid, value)
end

function MuteGameworldAndPositionedRadioForTv(mute)
	return _in(0x79974E04, mute)
end

function MuteGameworldAudio(mute)
	return _in(0x446677C6, mute)
end

function MutePositionedRadio(mute)
	return _in(0x32C75195, mute)
end

function MuteStaticEmitter(StaticEmitterIndex, mute)
	return _in(0x0FCC0410, StaticEmitterIndex, mute)
end

function NetworkAcceptInvite(playerIndex)
	return _in(0x4FDD00CE, playerIndex, _ri)
end

function NetworkAdvertiseSession(advertise)
	return _in(0x1B9E5D07, advertise)
end

function NetworkAllPartyMembersPresent()
	return _in(0x59C53FBA, _r)
end

function NetworkAmIBlockedByPlayer(playerIndex)
	return _in(0x4FAF2007, playerIndex, _r)
end

function NetworkAmIMutedByPlayer(playerIndex)
	return _in(0x448F486A, playerIndex, _r)
end

function NetworkChangeExtendedGameConfig(Unk924)
	return _in(0x4CFE3998, Unk924)
end

function NetworkChangeGameMode(Unk1047, Unk1048, Unk1049, Unk1050)
	return _in(0x3F054F44, Unk1047, Unk1048, Unk1049, Unk1050, _ri)
end

function NetworkChangeGameModePending()
	return _in(0x379930F3, _r)
end

function NetworkChangeGameModeSucceeded()
	return _in(0x6D302DA9, _r)
end

function NetworkCheckInviteArrival()
	return _in(0x308E3719, _r)
end

function NetworkClearInviteArrival()
	return _in(0x37282D4F)
end

function NetworkClearSummons()
	return _in(0x6289239F)
end

function NetworkDidInviteFriend(FRIENDNAME)
	return _in(0x3CAA1340, _ts(FRIENDNAME), _r)
end

function NetworkDisplayHostGamerCard()
	return _in(0x414E4E7F, _r)
end

function NetworkEndSession()
	return _in(0x75291BEC)
end

function NetworkEndSessionPending()
	return _in(0x489B0BB9, _r)
end

function NetworkExpandTo32Players()
	return _in(0x36511E0A)
end

function NetworkFindGame(GameMode, ukn0, ukn1, ukn2)
	return _in(0x5D4D0C86, GameMode, ukn0, ukn1, ukn2)
end

function NetworkFindGamePending()
	return _in(0x23D60810, _r)
end

function NetworkFinishExtendedSearch()
	return _in(0x1E0A7AD8)
end

function NetworkGetFindResult(Unk925, Unk926)
	return _in(0x282D2CAA, Unk925, Unk926)
end

function NetworkGetFriendCount()
	return _in(0x5EEA3F25, _ri)
end

function NetworkGetFriendName(id)
	return _in(0x17FD0934, id, _s)
end

function NetworkGetFriendlyFireOption()
	return _in(0x577144A0, _r)
end

function NetworkGetGameMode()
	return _in(0x29A75D1F, _ri)
end

function NetworkGetHealthReticuleOption()
	return _in(0x546F581F, _r)
end

function NetworkGetHostAverageRank(host)
	return _in(0x04261E4C, host, _ri)
end

function NetworkGetHostLatency(host)
	return _in(0x74093768, host, _ri)
end

function NetworkGetHostMatchProgress(host)
	return _in(0x59AA0635, host, _ri)
end

function NetworkGetHostName()
	return _in(0x4A8048F8, _r)
end

function NetworkGetHostServerName(host)
	return _in(0x031D740F, host, _s)
end

function NetworkGetLanSession()
	return _in(0x48A723C1, _r)
end

function NetworkGetMaxPrivateSlots()
	return _in(0x2EF80425, _ri)
end

function NetworkGetMaxSlots()
	return _in(0x524F7543, _ri)
end

function NetworkGetMetPlayerName(Unk1051)
	return _in(0x01F35F5C, Unk1051, _ri)
end

function NetworkGetNextTextChat()
	return _in(0x314E106A, _s)
end

function NetworkGetNumOpenPublicSlots()
	return _in(0x4E323A0A, _ri)
end

function NetworkGetNumPartyMembers()
	return _in(0x27F65637, _ri)
end

function NetworkGetNumPlayersMet()
	return _in(0x33500089, _ri)
end

function NetworkGetNumUnacceptedInvites()
	return _in(0x13244634, _ri)
end

function NetworkGetNumUnfilledReservations()
	return _in(0x043C3B0B, _ri)
end

function NetworkGetNumberOfGames()
	return _in(0x10DF4CED, _ri)
end

function NetworkGetPlayerIdOfNextTextChat()
	return _in(0x145B50AF, _ri)
end

function NetworkGetRendezvousHostPlayerId()
	return _in(0x282D29FE, _ri)
end

function NetworkGetServerName()
	return _in(0x03665B8D, _ri)
end

function NetworkGetTeamOption()
	return _in(0x52152E04, _r)
end

function NetworkGetUnacceptedInviteEpisode(Unk894)
	return _in(0x3432536A, Unk894, _ri)
end

function NetworkGetUnacceptedInviteGameMode(Unk1052)
	return _in(0x5E44065D, Unk1052, _ri)
end

function NetworkGetUnacceptedInviterName(Unk886)
	return _in(0x1A7B3125, Unk886, _s)
end

function NetworkHasStrictNat()
	return _in(0x2704460E, _r)
end

function NetworkHaveAcceptedInvite()
	return _in(0x0BC86FA7, _r)
end

function NetworkHaveOnlinePrivileges()
	return _in(0x4B907716, _r)
end

function NetworkHaveSummons()
	return _in(0x48726B45, _r)
end

function NetworkHostGameCnc()
	return _in(0x26CF21AF, _r)
end

function NetworkHostGameE1(Gamemode, Ranked, Slots, Private, Episode, MaxTeams)
	return _in(0x5BEA05E2, Gamemode, Ranked, Slots, Private, Episode, MaxTeams, _r)
end

function NetworkHostGamePending()
	return _in(0x391E4575, _r)
end

function NetworkHostGameSucceeded()
	return _in(0x1CA77E94, _r)
end

function NetworkHostRendezvousE1(Gamemode, Slots, Episode)
	return _in(0x48032420, Gamemode, Slots, Episode, _r)
end

function NetworkInviteFriend(friendname, ukn)
	return _in(0x62B15CD7, _ts(friendname), _ts(ukn))
end

function NetworkIsBeingKicked()
	return _in(0x52364369, _r)
end

function NetworkIsCommonEpisode(id)
	return _in(0x26094A53, id, _r)
end

function NetworkIsFindResultUpdated(ukn0)
	return _in(0x7ED34379, ukn0, _r)
end

function NetworkIsFindResultValid(Unk883)
	return _in(0x51DF00D8, Unk883, _r)
end

function NetworkIsFriendInSameTitle(friendid)
	return _in(0x4B5C4957, friendid, _r)
end

function NetworkIsFriendOnline(Unk896)
	return _in(0x04783029, Unk896, _ri)
end

function NetworkIsGameRanked()
	return _in(0x50C72493, _r)
end

function NetworkIsInviteeOnline()
	return _in(0x772B01CC, _r)
end

function NetworkIsLinkConnected()
	return _in(0x14332DE0, _r)
end

function NetworkIsNetworkAvailable()
	return _in(0x04E11812, _r)
end

function NetworkIsOperationPending()
	return _in(0x71AE456A, _r)
end

function NetworkIsPlayerBlockedByMe(playerIndex)
	return _in(0x23B76F88, playerIndex, _r)
end

function NetworkIsPlayerMutedByMe(playerIndex)
	return _in(0x120962E7, playerIndex, _r)
end

function NetworkIsPlayerTalking(playerIndex)
	return _in(0x544625D9, playerIndex, _r)
end

function NetworkIsPlayerTyping(playerIndex)
	return _in(0x5AE1245E, playerIndex, _r)
end

function NetworkIsRendezvous()
	return _in(0x60560DAE, _r)
end

function NetworkIsRendezvousHost()
	return _in(0x6EB3047F, _r)
end

function NetworkIsRockstartSessionIdValid()
	return _in(0x6C434E0B, _r)
end

function NetworkIsSessionAdvertise()
	return _in(0x1B6716B8, _r)
end

function NetworkIsSessionInvitable()
	return _in(0x4A8245F1, _r)
end

function NetworkIsSessionStarted()
	return _in(0x65B83AFB, _r)
end

function NetworkIsTvt()
	return _in(0x73D87A5F, _r)
end

function NetworkJoinGame(Unk1053)
	return _in(0x60806A0C, Unk1053, _ri)
end

function NetworkJoinGameCnc()
	return _in(0x358F40E9, _r)
end

function NetworkJoinGamePending()
	return _in(0x76C53927, _r)
end

function NetworkJoinGameSucceeded()
	return _in(0x59F24327, _r)
end

function NetworkJoinSummons()
	return _in(0x360751AE, _r)
end

function NetworkKickPlayer(playerIndex, value)
	return _in(0x7E8C1C45, playerIndex, value)
end

function NetworkLeaveGame()
	return _in(0x55D66E24)
end

function NetworkLeaveGamePending()
	return _in(0x497E6745, _r)
end

function NetworkLimitTo16Players()
	return _in(0x0A1D6E36)
end

function NetworkPlayerHasCommPrivs()
	return _in(0x2854024A, _r)
end

function NetworkPlayerHasDiedRecently(playerIndex)
	return _in(0x75CD1A28, playerIndex, _r)
end

function NetworkPlayerHasHeadset(Unk884)
	return _in(0x408E2F70, Unk884, _r)
end

function NetworkPlayerHasKeyboard(playerIndex)
	return _in(0x04FE5C34, playerIndex, _r)
end

function NetworkRestoreGameConfig(Unk1054)
	return _in(0x1E1B5C26, Unk1054, _ri)
end

function NetworkResultMatchesSearchCriteria(result)
	return _in(0x767F1E44, result, _r)
end

function NetworkReturnToRendezvous()
	return _in(0x00031EC6, _r)
end

function NetworkReturnToRendezvousPending()
	return _in(0x6A66149A, _r)
end

function NetworkReturnToRendezvousSucceeded()
	return _in(0x208F671C, _r)
end

function NetworkSendTextChat(playerIndex, Unk1055)
	return _in(0x18C67E6D, playerIndex, Unk1055, _ri)
end

function NetworkSetFriendlyFireOption(Unk927)
	return _in(0x5AC43965, Unk927)
end

function NetworkSetHealthReticuleOption(Unk928)
	return _in(0x3998154E, Unk928)
end

function NetworkSetLanSession(Unk929)
	return _in(0x6FDA43A3, Unk929)
end

function NetworkSetLocalPlayerCanTalk()
	return _in(0x4CC379D0, _r)
end

function NetworkSetLocalPlayerIsTyping(playerIndex)
	return _in(0x141D24A6, playerIndex)
end

function NetworkSetMatchProgress(Unk930)
	return _in(0x5C8D66EA, Unk930)
end

function NetworkSetPlayerMuted(playerIndex, value)
	return _in(0x0B1562DF, playerIndex, value, _r)
end

function NetworkSetScriptLobbyState(Unk931)
	return _in(0x17767D95, Unk931)
end

function NetworkSetServerName(name)
	return _in(0x580E1C3D, _ts(name), _ri)
end

function NetworkSetSessionInvitable(invitable)
	return _in(0x5FB15E81, invitable)
end

function NetworkSetTalkerFocus(Unk932)
	return _in(0x753714F8, Unk932)
end

function NetworkSetTalkerProximity(Unk933)
	return _in(0x2F542797, Unk933)
end

function NetworkSetTeamOnlyChat(Unk934)
	return _in(0x31492174, Unk934)
end

function NetworkSetTextChatRecipients(Unk935)
	return _in(0x3A2246BB, Unk935)
end

function NetworkShowFriendProfileUi(Unk936)
	return _in(0x696021E6, Unk936)
end

function NetworkShowMetPlayerFeedbackUi(metPlayerIndex)
	return _in(0x2CD73270, metPlayerIndex)
end

function NetworkShowMetPlayerProfileUi(Unk937)
	return _in(0x1B183AFE, Unk937)
end

function NetworkShowPlayerFeedbackUi(payerIndex)
	return _in(0x6FC54C6B, payerIndex)
end

function NetworkShowPlayerProfileUi(playerIndex)
	return _in(0x6F2A5430, playerIndex)
end

function NetworkStartExtendedSearch(Unk938)
	return _in(0x07FD3C35, Unk938)
end

function NetworkStartSession()
	return _in(0x58802CE5)
end

function NetworkStartSessionPending()
	return _in(0x7F853FF4, _r)
end

function NetworkStartSessionSucceeded()
	return _in(0x5873667B, _r)
end

function NetworkStoreGameConfig(Unk939)
	return _in(0x30D373DF, Unk939)
end

function NetworkStoreSinglePlayerGame()
	return _in(0x08181609, _ri)
end

function NetworkStringVerifyPending()
	return _in(0x44AA32A7, _r)
end

function NetworkStringVerifySucceeded()
	return _in(0x3F1D4677, _r)
end

function NetworkVerifyUserString(Unk940)
	return _in(0x59884407, Unk940)
end

function NewMobilePhoneCall()
	return _in(0x720E7EA6)
end

function NewScriptedConversation()
	return _in(0x6C213305)
end

function ObfuscateInt(Unk941, Unk942)
	return _in(0x31A219FA, Unk941, Unk942)
end

function ObfuscateIntArray(Unk943, Unk944)
	return _in(0x3EF15B6A, Unk943, Unk944)
end

function ObfuscateString(str)
	return _in(0x04F12617, _ts(str), _s)
end

function OnFireScream(ped)
	return _in(0x6BE062DF, ped)
end

function OpenCarDoor(vehicle, door)
	return _in(0x1E352CEF, vehicle, door)
end

function OpenDebugFile()
	return _in(0x7A2B266D)
end

function OpenGarage(name)
	return _in(0x5086785F, _ts(name))
end

function OpenSequenceTask(pTaskSequence)
	return _in(0x14A67125, _ii(pTaskSequence))
end

function OverrideFreezeFlags(Unk504)
	return _in(0x710E6D16, Unk504)
end

function OverrideNextRestart(x, y, z, heading)
	return _in(0x27636B69, x, y, z, heading)
end

function OverrideNumberOfParkedCars(num)
	return _in(0x7F483739, num)
end

function PanicScream(ped)
	return _in(0x4F8B4507, ped)
end

function PauseGame()
	return _in(0x7FB41425)
end

function PausePlaybackRecordedCar(car)
	return _in(0x24256EFB, car)
end

function PauseScriptedConversation(pause)
	return _in(0x2A491A70, pause)
end

function PedQueueConsiderPedsWithFlagFalse(flagid)
	return _in(0x555213B4, flagid)
end

function PedQueueConsiderPedsWithFlagTrue(flagid)
	return _in(0x489C3A48, flagid)
end

function PedQueueRejectPedsWithFlagFalse(flagid)
	return _in(0x61A812F5, flagid)
end

function PedQueueRejectPedsWithFlagTrue(flagid)
	return _in(0x79E5237B, flagid)
end

function PickupsPassTime(time)
	return _in(0x59DA4975, time)
end

function PlaceObjectRelativeToCar(obj, car, x, y, z)
	return _in(0x21DE7496, obj, car, x, y, z)
end

function PlaneStartsInAir(plane)
	return _in(0x0E1645CD, plane)
end

function PlayAudioEvent(name)
	return _in(0x486F3D93, _ts(name))
end

function PlayAudioEventFromObject(EventName, obj)
	return _in(0x4BB9178A, _ts(EventName), obj)
end

function PlayAudioEventFromPed(name, ped)
	return _in(0x61064783, _ts(name), ped)
end

function PlayAudioEventFromVehicle(name, veh)
	return _in(0x2F4B2A8B, _ts(name), veh)
end

function PlayCarAnim(car, animname0, animname1, Unk50, flag0, flag1)
	return _in(0x03EE5F1C, car, _ts(animname0), _ts(animname1), Unk50, flag0, flag1, _r)
end

function PlayFireSoundFromPosition(sound_id, x, y, z)
	return _in(0x4B6135E8, sound_id, x, y, z)
end

function PlayMovie()
	return _in(0x3CD60F11)
end

function PlayObjectAnim(obj, animname0, animname1, Unk74, flag0, flag1)
	return _in(0x5D3241E4, obj, _ts(animname0), _ts(animname1), Unk74, flag0, flag1, _r)
end

function PlayScriptedConversationFrontend(play)
	return _in(0x001B1E5A, play)
end

function PlaySound(SoundId, SoundName)
	return _in(0x47CA7C53, SoundId, _ts(SoundName))
end

function PlaySoundFromObject(sound_id, name, obj)
	return _in(0x60AE0867, sound_id, _ts(name), obj)
end

function PlaySoundFromPed(SoundId, SoundName, ped)
	return _in(0x56F37A81, SoundId, _ts(SoundName), ped)
end

function PlaySoundFromPosition(sound_id, name, x, y, z)
	return _in(0x65752C65, sound_id, _ts(name), x, y, z)
end

function PlaySoundFromVehicle(SoundId, SoundName, veh)
	return _in(0x763274B7, SoundId, _ts(SoundName), veh)
end

function PlaySoundFrontend(sound, soundName)
	return _in(0x4DAF2C87, sound, _ts(soundName))
end

function PlayStreamFromObject(obj)
	return _in(0x4AA86394, obj)
end

function PlayStreamFromPed(ped)
	return _in(0x0C47057F, ped)
end

function PlayStreamFrontend()
	return _in(0x133C257F)
end

function PlayerHasChar(playerIndex)
	return _in(0x22545844, playerIndex, _r)
end

function PlayerHasFlashingStarAfterOffence()
	return _in(0x70F287A, _r)
end

function PlayerHasFlashingStarsAboutToDrop(playerIndex)
	return _in(0x69804B35, playerIndex, _r)
end

function PlayerHasGreyedOutStars(playerIndex)
	return _in(0x2B670CD0, playerIndex, _r)
end

function PlayerIsInteractingWithGarage()
	return _in(0x2B446480, _r)
end

function PlayerIsNearFirstPigeon(x, y, z)
	return _in(0x6D631CED, x, y, z, _r)
end

function PlayerIsPissedOff(player)
	return _in(0x7FA21A1E, player, _r)
end

function PlayerWantsToJoinNetworkGame(Unk885)
	return _in(0x7D99343C, Unk885, _r)
end

function PlaystatsCheat(stat)
	return _in(0x0F9B3A1C, stat)
end

function PlaystatsFloat(Unk785, Unk786)
	return _in(0x06B735ED, Unk785, Unk786)
end

function PlaystatsInt(Unk787, Unk788)
	return _in(0x41FA2D0C, Unk787, Unk788)
end

function PlaystatsIntFloat(Unk789, Unk790, Unk791)
	return _in(0x511200C7, Unk789, Unk790, Unk791)
end

function PlaystatsIntInt(Unk792, Unk793, Unk794)
	return _in(0x07F35BFE, Unk792, Unk793, Unk794)
end

function PlaystatsMissionCancelled(Unk795)
	return _in(0x60D94FA7, Unk795)
end

function PlaystatsMissionFailed(Unk796)
	return _in(0x50BB02F7, Unk796)
end

function PlaystatsMissionPassed(str0)
	return _in(0x437D3E19, _ts(str0))
end

function PlaystatsMissionStarted(Unk797)
	return _in(0x26747EBE, Unk797)
end

function PointCamAtCam(cam, camnext)
	return _in(0x44717CF9, cam, camnext)
end

function PointCamAtCoord(cam, x, y, z)
	return _in(0x4496175C, cam, x, y, z)
end

function PointCamAtObject(cam, obj)
	return _in(0x5E627D20, cam, obj)
end

function PointCamAtPed(cam, ped)
	return _in(0x495B0B6F, cam, ped)
end

function PointCamAtVehicle(cam, veh)
	return _in(0x69F02BA0, cam, veh)
end

function PointFixedCam(x, y, z, Unk563)
	return _in(0x04FF3F49, x, y, z, Unk563)
end

function PointFixedCamAtObj(obj, cam)
	return _in(0x02326335, obj, cam)
end

function PointFixedCamAtPed(ped, cam)
	return _in(0x3D3B5D94, ped, cam)
end

function PointFixedCamAtPos(x, y, z, cam)
	return _in(0x6D4E2A4A, x, y, z, cam)
end

function PointFixedCamAtVehicle(veh, cam)
	return _in(0x52FF28DF, veh, cam)
end

function PopCarBoot(vehicle)
	return _in(0x3C78449F, vehicle)
end

function PopulateNow()
	return _in(0x7E3A7E2A)
end

function Pow(base, power)
	return _in(0x5ADD1F46, base, power, _rf)
end

function PreloadStream(name)
	return _in(0x39DE515D, _ts(name), _r)
end

function PreloadStreamWithStartOffset(StreamName, StartOffset)
	return _in(0x2B8836A6, _ts(StreamName), StartOffset, _r)
end

function PreviewRingtone(RingtoneId)
	return _in(0x79660015, RingtoneId)
end

function Print(gxtName, timeMS, enable)
	return _in(0x0A491CFF, _ts(gxtName), timeMS, enable)
end

function PrintBig(gxtName, timeMS, enable)
	return _in(0x2C8A5404, _ts(gxtName), timeMS, enable)
end

function PrintBigQ(gxtentry, time, flag)
	return _in(0x2B2E39BB, _ts(gxtentry), time, flag)
end

function PrintHelp(gxtName)
	return _in(0x71076BBA, _ts(gxtName))
end

function PrintHelpForever(gxtName)
	return _in(0x43F7517D, _ts(gxtName))
end

function PrintHelpForeverWithNumber(gxtName, value)
	return _in(0x19836A5B, _ts(gxtName), value)
end

function PrintHelpForeverWithString(gxtName, gxtText)
	return _in(0x36D60616, _ts(gxtName), _ts(gxtText))
end

function PrintHelpForeverWithStringNoSound(gxtName, gxtText)
	return _in(0x55687797, _ts(gxtName), _ts(gxtText))
end

function PrintHelpForeverWithTwoNumbers(gxtentry, Unk658, Unk659)
	return _in(0x795227EE, _ts(gxtentry), Unk658, Unk659)
end

function PrintHelpOverFrontend(gxtentry)
	return _in(0x1C334022, _ts(gxtentry))
end

function PrintHelpWithNumber(gxtName, value)
	return _in(0x4475789E, _ts(gxtName), value)
end

function PrintHelpWithString(gxtName, gxtText)
	return _in(0x521035AA, _ts(gxtName), _ts(gxtText))
end

function PrintHelpWithStringNoSound(gxtName, gxtText)
	return _in(0x15734852, _ts(gxtName), _ts(gxtText))
end

function PrintHelpWithTwoNumbers(gxtentry, Unk660, Unk661)
	return _in(0x076D157A, _ts(gxtentry), Unk660, Unk661)
end

function PrintMissionDescription()
	return _in(0x65712730, _r)
end

function PrintNow(gxtName, timeMS, enable)
	return _in(0x73B01573, _ts(gxtName), timeMS, enable)
end

function PrintStringInString(gxtName, gxtText, timeMS, enable)
	return _in(0x4DAA221F, _ts(gxtName), _ts(gxtText), timeMS, enable)
end

function PrintStringInStringNow(gxtName, gxtText, timeMS, enable)
	return _in(0x2BB65467, _ts(gxtName), _ts(gxtText), timeMS, enable)
end

function PrintStringWithLiteralString(gxtentry, string, time, flag)
	return _in(0x3F89280B, _ts(gxtentry), _ts(string), time, flag)
end

function PrintStringWithLiteralStringNow(gxtName, text, timeMS, enable)
	return _in(0x0CA539D6, _ts(gxtName), _ts(text), timeMS, enable)
end

function PrintStringWithSubstringGivenHashKeyNow(gxtkey0, gxtkey1, time, style)
	return _in(0x00FD3647, _ts(gxtkey0), gxtkey1, time, style)
end

function PrintStringWithTwoLiteralStrings(gxtentry, string1, string2, time, flag)
	return _in(0x19486759, _ts(gxtentry), _ts(string1), _ts(string2), time, flag)
end

function PrintStringWithTwoLiteralStringsNow(gxtentry, string1, string2, time, flag)
	return _in(0x7DE7708E, _ts(gxtentry), _ts(string1), _ts(string2), time, flag)
end

function PrintWithNumber(gxtName, value, timeMS, enable)
	return _in(0x76A63B4C, _ts(gxtName), value, timeMS, enable)
end

function PrintWithNumberBig(gxtName, value, timeMS, enable)
	return _in(0x49850843, _ts(gxtName), value, timeMS, enable)
end

function PrintWithNumberNow(gxtName, value, timeMS, enable)
	return _in(0x3BDA562E, _ts(gxtName), value, timeMS, enable)
end

function PrintWith2Numbers(gxtName, value1, value2, timeMS, enable)
	return _in(0x230A740F, _ts(gxtName), value1, value2, timeMS, enable)
end

function PrintWith2NumbersBig(gxtentry, Unk662, Unk663, time, flag)
	return _in(0x43197215, _ts(gxtentry), Unk662, Unk663, time, flag)
end

function PrintWith2NumbersNow(gxtName, value1, value2, timeMS, enable)
	return _in(0x5D251D72, _ts(gxtName), value1, value2, timeMS, enable)
end

function PrintWith3Numbers(gxtentry, Unk664, Unk665, Unk666, time, flag)
	return _in(0x5FE61572, _ts(gxtentry), Unk664, Unk665, Unk666, time, flag)
end

function PrintWith3NumbersNow(gxtentry, Unk667, Unk668, Unk669, time, flag)
	return _in(0x1A4D0C60, _ts(gxtentry), Unk667, Unk668, Unk669, time, flag)
end

function PrintWith4Numbers(gxtentry, Unk670, Unk671, Unk672, Unk673, time, flag)
	return _in(0x4D4F65AE, _ts(gxtentry), Unk670, Unk671, Unk672, Unk673, time, flag)
end

function PrintWith4NumbersNow(gxtentry, Unk674, Unk675, Unk676, Unk677, time, flag)
	return _in(0x5CCD150B, _ts(gxtentry), Unk674, Unk675, Unk676, Unk677, time, flag)
end

function PrintWith5Numbers(gxtentry, Unk678, Unk679, Unk680, Unk681, Unk682, time, flag)
	return _in(0x2CC356D0, _ts(gxtentry), Unk678, Unk679, Unk680, Unk681, Unk682, time, flag)
end

function PrintWith5NumbersNow(gxtentry, Unk683, Unk684, Unk685, Unk686, Unk687, time, flag)
	return _in(0x5EC2479B, _ts(gxtentry), Unk683, Unk684, Unk685, Unk686, Unk687, time, flag)
end

function PrintWith6Numbers(gxtentry, Unk688, Unk689, Unk690, Unk691, Unk692, Unk693, time, flag)
	return _in(0x03A01F39, _ts(gxtentry), Unk688, Unk689, Unk690, Unk691, Unk692, Unk693, time, flag)
end

function PrintWith6NumbersNow(gxtentry, Unk694, Unk695, Unk696, Unk697, Unk698, Unk699, time, flag)
	return _in(0x156E12CA, _ts(gxtentry), Unk694, Unk695, Unk696, Unk697, Unk698, Unk699, time, flag)
end

function Printfloat(value)
	return _in(0x2F206763, value)
end

function Printfloat2()
	return _in(0x108A527F, _r)
end

function Printint(value)
	return _in(0x20421014, value)
end

function Printint2()
	return _in(0x49B35C2D, _r)
end

function Printnl()
	return _in(0x4013147B)
end

function Printstring(value)
	return _in(0x616F492C, _ts(value))
end

function Printvector(x, y, z)
	return _in(0x61965EB3, x, y, z)
end

function PrioritizeStreamingRequest()
	return _in(0x1DD926BA)
end

function ProcessMissionDeletionList()
	return _in(0x33565078)
end

function ProstituteCamActivate(activate)
	return _in(0x346D76E8, activate)
end

function ReadKillFrenzyStatus()
	return _in(0x3F9F0CF5, _ri)
end

function ReadLobbyPreference()
	return _in(0x177A3DA4, _r)
end

function RegisterBestPosition(Unk505, position)
	return _in(0x0C051FE2, Unk505, position)
end

function RegisterClientBroadcastVariables(Unk945, Unk946, Unk947)
	return _in(0x499B6DB6, Unk945, Unk946, Unk947)
end

function RegisterFloatStat(stat, val)
	return _in(0x347E05F3, stat, val)
end

function RegisterHatedTargetsAroundPed(ped, radius)
	return _in(0x70A62140, ped, radius)
end

function RegisterHatedTargetsInArea(ped, x, y, z, radius)
	return _in(0x619E7657, ped, x, y, z, radius)
end

function RegisterHostBroadcastVariables(Unk948, ukn0, ukn1)
	return _in(0x18DB4CAF, Unk948, ukn0, ukn1)
end

function RegisterIntStat(stat, val)
	return _in(0x609D07DB, stat, val)
end

function RegisterKillInMultiplayerGame(playerIndex, id, ukn)
	return _in(0x7D6D0A6C, playerIndex, id, ukn)
end

function RegisterMissionPassed(str)
	return _in(0x5FBE5F52, _ts(str))
end

function RegisterMod()
	return _in(0x327866F6, _r)
end

function RegisterModelForRankPoints()
	return _in(0x39E61536, _r)
end

function RegisterMultiplayerGameWin(playerIndex, Unk949)
	return _in(0x43E41D81, playerIndex, Unk949)
end

function RegisterNetworkBestGameScores(playerIndex, Unk950, Unk951)
	return _in(0x4ADB10A4, playerIndex, Unk950, Unk951)
end

function RegisterOddjobMissionPassed()
	return _in(0x1B0963AF)
end

function RegisterPlayerRespawnCoords(playerIndex, x, y, z)
	return _in(0x001954A2, playerIndex, x, y, z)
end

function RegisterSaveHouse(x, y, z, unkf, name, unk0)
	return _in(0x7DF45001, x, y, z, unkf, _ts(name), unk0, _ri)
end

function RegisterScriptWithAudio(reg)
	return _in(0x5B4452F3, reg)
end

function RegisterStringForFrontendStat(stat, str)
	return _in(0x3C295451, stat, _ts(str))
end

function RegisterTarget(ped, target)
	return _in(0x5F456B53, ped, target)
end

function RegisterTrackNumber(number)
	return _in(0x4D7E12A7, number)
end

function RegisterWorldPointScriptBrain(ScriptName, radius)
	return _in(0x32563E09, _ts(ScriptName), radius)
end

function ReleaseEntityFromRopeForObject()
	return _in(0x7A575AC9, _r)
end

function ReleaseMovie()
	return _in(0x55C84CB7)
end

function ReleasePathNodes()
	return _in(0x2CE231DC)
end

function ReleaseScriptControlledMicrophone()
	return _in(0x2F907FF2)
end

function ReleaseSoundId(sound)
	return _in(0x211D390A, sound)
end

function ReleaseTexture(texture)
	return _in(0x58524B04, texture)
end

function ReleaseTimeOfDay()
	return _in(0x2AD2206E)
end

function ReleaseTwoPlayerDistance()
	return _in(0x6423636D, _r)
end

function ReleaseWeather()
	return _in(0x3A115D9D)
end

function ReloadWebPage(htmlviewport)
	return _in(0x565B0C3E, htmlviewport)
end

function RemoveAdditionalPopulationModel(model)
	return _in(0x602112FC, model)
end

function RemoveAllCharWeapons(ped)
	return _in(0x6BA520F0, ped)
end

function RemoveAllNetworkRestartPoints()
	return _in(0x3FC034EB, _r)
end

function RemoveAllInactiveGroupsFromCleanupList()
	return _in(0x622E3D34)
end

function RemoveAllPickupsOfType(type)
	return _in(0x03622640, type)
end

function RemoveAllScriptFires()
	return _in(0xCA7507B, _r)
end

function RemoveAnims(animName)
	return _in(0x55E00E7E, _ts(animName))
end

function RemoveBlip(blip)
	return _in(0x7BBF3625, blip)
end

function RemoveBlipAndClearIndex(blip)
	return _in(0x66385B6C, blip)
end

function RemoveCarRecording(CarRec)
	return _in(0x484964FE, CarRec)
end

function RemoveCarWindow(car, windnum)
	return _in(0x038A7526, car, windnum)
end

function RemoveCarsFromGeneratorsInArea(x0, y0, z0, x1, y1, z1)
	return _in(0x2BEE5F97, x0, y0, z0, x1, y1, z1)
end

function RemoveCharDefensiveArea(ped)
	return _in(0x2BC44D7D, ped)
end

function RemoveCharElegantly(ped)
	return _in(0x5731084A, ped)
end

function RemoveCharFromCarMaintainPosition(ped, car)
	return _in(0x3DA4533F, ped, car)
end

function RemoveCharFromGroup(ped)
	return _in(0x649316B7, ped)
end

function RemoveCloseMicPed(ped)
	return _in(0x72B73FBA, ped)
end

function RemoveCoverPoint(coverPoint)
	return _in(0x4371502A, coverPoint)
end

function RemoveDecisionMaker(dm)
	return _in(0x47147EC5, dm)
end

function RemoveFakeNetworkNameFromPed(ped)
	return _in(0x37A86FBD, ped)
end

function RemoveGroup(group)
	return _in(0x250C2D39, group)
end

function RemoveIpl(iplName)
	return _in(0x787F38B5, _ts(iplName))
end

function RemoveIplDiscreetly(iplname)
	return _in(0x658F21AF, _ts(iplname))
end

function RemoveNavmeshRequiredRegion(Unk599, Unk600)
	return _in(0x772660D7, Unk599, Unk600, _r)
end

function RemovePedHelmet(ped, removed)
	return _in(0x15F033A6, ped, removed)
end

function RemovePedQueue()
	return _in(0x2FB410E4, _r)
end

function RemovePickup(pickup)
	return _in(0x2119007F, pickup)
end

function RemovePlayerHelmet(playerIndex, remove)
	return _in(0x5CF1303D, playerIndex, remove)
end

function RemoveProjtexFromObject(obj)
	return _in(0x7330132C, obj)
end

function RemoveProjtexInRange(x, y, z, radius)
	return _in(0x170F0D58, x, y, z, radius)
end

function RemovePtfx(ptfx)
	return _in(0x4AF643D5, ptfx)
end

function RemovePtfxFromObject(obj)
	return _in(0x4D7775BA, obj)
end

function RemovePtfxFromPed(ped)
	return _in(0x2FC9782A, ped)
end

function RemovePtfxFromVehicle(veh)
	return _in(0x3FB14EC5, veh)
end

function RemoveRcBuggy()
	return _in(0x48BC2249, _r)
end

function RemoveScriptFire(fire)
	return _in(0x0E633C13, fire)
end

function RemoveScriptMic()
	return _in(0x4307784F)
end

function RemoveSphere(sphere)
	return _in(0x12A909C9, sphere)
end

function RemoveStuckCarCheck(vehicle)
	return _in(0x213308DB, vehicle)
end

function RemoveTemporaryRadarBlipsForPickups()
	return _in(0x6F797AF3)
end

function RemoveTxd(txd)
	return _in(0x44C27071, txd)
end

function RemoveUpsidedownCarCheck(vehicle)
	return _in(0x6A1244E9, vehicle)
end

function RemoveUser3dMarker(marker)
	return _in(0xC607EB8, marker)
end

function RemoveWeaponFromChar(ped, weapon)
	return _in(0x2485231E, ped, weapon)
end

function RenderLoadingClock()
	return _in(0xCD70514, _r)
end

function RenderRaceTrack(render)
	return _in(0x5062055B, render)
end

function RenderRadiohudSpriteInLobby()
	return _in(0x11887D84, _r)
end

function RenderRadiohudSpriteInMobilePhone()
	return _in(0x704D5747, _r)
end

function RenderWeaponPickupsBigger(value)
	return _in(0x003B6B13, value)
end

function ReportCrime(x, y, z, name)
	return _in(0x076B4C7C, x, y, z, _ts(name))
end

function ReportDispatch(id, x, y, z)
	return _in(0x388D6B44, id, x, y, z)
end

function ReportPoliceSpottingSuspect(veh)
	return _in(0x07D97F81, veh)
end

function ReportSuspectArrested()
	return _in(0x008932D3)
end

function ReportSuspectDown()
	return _in(0x6A660231)
end

function ReportTaggedRadioTrack(TrackTextId)
	return _in(0x0ED8621F, TrackTextId)
end

function RequestAdditionalText(textName, textIndex)
	return _in(0x6A9F01AF, _ts(textName), textIndex)
end

function RequestAllSlodsInWorld()
	return _in(0x39264921)
end

function RequestAmbientAudioBank(name)
	return _in(0x754E1999, _ts(name), _r)
end

function RequestAnims(animName)
	return _in(0x65F874DE, _ts(animName))
end

function RequestCarRecording(CarRecId)
	return _in(0x041D045B, CarRecId)
end

function RequestCollisionAtPosn(x, y, z)
	return _in(0x12ED0BC9, x, y, z)
end

function RequestCollisionForModel(model)
	return _in(0x66E93537, model)
end

function RequestControlOfNetworkId(netid)
	return _in(0x29926B20, netid, _r)
end

function RequestInteriorModels(model, interiorName)
	return _in(0x302E113D, model, _ts(interiorName))
end

function RequestIpl(iplName)
	return _in(0x59FD4E83, _ts(iplName))
end

function RequestMissionAudioBank(name)
	return _in(0x335E603B, _ts(name), _r)
end

function RequestModel(model)
	return _in(0x502B5185, model)
end

function RequestScript(scriptName)
	return _in(0x6FFE0DFD, _ts(scriptName))
end

function RequestStreamedTxd(txdName, unknown)
	return _in(0x7C7B1237, _ts(txdName), unknown)
end

function ReserveNetworkMissionObjectsForHost(count)
	return _in(0x2F7508E7, count)
end

function ReserveNetworkMissionPedsForHost(Unk952)
	return _in(0x557C7C4A, Unk952)
end

function ReserveNetworkMissionVehicles(Unk953)
	return _in(0x15652DC1, Unk953)
end

function ReserveNetworkMissionVehiclesForHost(Unk954)
	return _in(0x3E9C7CD3, Unk954)
end

function ResetAchievementsAward()
	return _in(0x11E22D1B)
end

function ResetArmourPickupNetworkRegenTime()
	return _in(0x5B4F27F9, _r)
end

function ResetCamInterpCustomSpeedGraph()
	return _in(0x779F3EC6)
end

function ResetCamSplineCustomSpeedGraph()
	return _in(0x13135C95)
end

function ResetCarWheels(car, reset)
	return _in(0x78CE659D, car, reset)
end

function ResetConsoleCommand()
	return _in(0x26B6430B, _r)
end

function ResetHealthPickupNetworkRegenTime()
	return _in(0x8237C10, _r)
end

function ResetLatestConsoleCommand()
	return _in(0x6F94DB7, _r)
end

function ResetLocalPlayerWeaponStat(wtype, wid)
	return _in(0x6C1344C6, wtype, wid)
end

function ResetMoneyPickupNetworkRegenTime()
	return _in(0x12FB7D2A, _r)
end

function ResetNetworkRestartNodeGroupMapping()
	return _in(0x8C12FAE, _r)
end

function ResetNoLawVehiclesDestroyedByLocalPlayer()
	return _in(0x63615A6D)
end

function ResetNumOfModelsKilledByPlayer(model)
	return _in(0x0FB17679, model)
end

function ResetStuckTimer(car, timer_num)
	return _in(0x73260714, car, timer_num)
end

function ResetVisiblePedDamage(ped)
	return _in(0x2A7247EF, ped)
end

function ResetWeaponPickupNetworkRegenTime()
	return _in(0x5F3459B2, _r)
end

function RestartScriptedConversation()
	return _in(0x43A67F1B)
end

function RestoreScriptArrayFromScratchpad(Unk955, Unk956, Unk957, Unk958)
	return _in(0x522B182B, Unk955, Unk956, Unk957, Unk958)
end

function RestoreScriptValuesForNetworkGame(Unk1056)
	return _in(0x37CD55AA, Unk1056, _ri)
end

function ResurrectNetworkPlayer(playerIndex, x, y, z, ukn0)
	return _in(0x17901684, playerIndex, x, y, z, ukn0)
end

function RetuneRadioDown()
	return _in(0x0E843CEA)
end

function RetuneRadioToStationIndex(radioStation)
	return _in(0x48ED6432, radioStation)
end

function RetuneRadioToStationName(name)
	return _in(0x58BA4401, _ts(name))
end

function RetuneRadioUp()
	return _in(0x6B1C6027)
end

function ReviveInjuredPed(ped)
	return _in(0x54EB576A, ped)
end

function RotateObject(obj, x, y, flag)
	return _in(0x12B524B7, obj, x, y, flag, _r)
end

function Round(Unk1085)
	return _in(0x7CA5476A, Unk1085, _ri)
end

function SaveFloatToDebugFile(Unk1117)
	return _in(0x66317064, Unk1117)
end

function SaveIntToDebugFile(Unk1118)
	return _in(0x65EF0CB8, Unk1118)
end

function SaveNewlineToDebugFile()
	return _in(0x69D90F11)
end

function SaveScriptArrayInScratchpad(Unk959, Unk960, Unk961, Unk962)
	return _in(0x331F7E6F, Unk959, Unk960, Unk961, Unk962)
end

function SaveSettings()
	return _in(0x584C3830)
end

function SaveStringToDebugFile(Unk1119)
	return _in(0x27FA32D4, Unk1119)
end

function SayAmbientSpeech(ped, phraseName, flag0, flag1, style)
	return _in(0x5CF149C8, ped, _ts(phraseName), flag0, flag1, style)
end

function SayAmbientSpeechWithVoice(ped, SpeechName, VoiceName, flag0, flag1, style)
	return _in(0x2FA55669, ped, _ts(SpeechName), _ts(VoiceName), flag0, flag1, style)
end

function ScriptAssert(text)
	return _in(0x10C75BDA, _ts(text))
end

function ScriptIsMovingMobilePhoneOffscreen(set)
	return _in(0x04804149, set)
end

function ScriptIsUsingMobilePhone(set)
	return _in(0x1B0741BA, set)
end

function SearchCriteriaConsiderPedsWithFlagFalse(flagid)
	return _in(0x2A860E89, flagid)
end

function SearchCriteriaConsiderPedsWithFlagTrue(flagId)
	return _in(0x20EC5B84, flagId)
end

function SearchCriteriaRejectPedsWithFlagFalse(flagid)
	return _in(0x0A0444B3, flagid)
end

function SearchCriteriaRejectPedsWithFlagTrue(flagId)
	return _in(0x27211B1A, flagId)
end

function SecuromSpotCheck1()
	return _in(0x63576E53, _r)
end

function SecuromSpotCheck2()
	return _in(0x1F40505C, _r)
end

function SecuromSpotCheck3()
	return _in(0x5D1C0A6A, _r)
end

function SecuromSpotCheck4()
	return _in(0x764236CE, _r)
end

function SelectWeaponsForVehicle(veh, weapon)
	return _in(0x7AD71A55, veh, weapon)
end

function SendClientBroadcastVariablesNow()
	return _in(0x36B40989)
end

function SendHostBroadcastVariablesNow()
	return _in(0xE4741E1, _r)
end

function SendNmMessage(ped)
	return _in(0x75AC2519, ped)
end

function SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(obj, set)
	return _in(0x378531F8, obj, set)
end

function SetAdvancedBoolInDecisionMaker(dm, Unk844, Unk845, Unk846, Unk847)
	return _in(0x709D2036, dm, Unk844, Unk845, Unk846, Unk847)
end

function SetAllCarGeneratorsBackToActive()
	return _in(0x399E1A43)
end

function SetAllCarsCanBeDamaged(set)
	return _in(0x3EA5269D, set)
end

function SetAllPedsSpawnedAreCops()
	return _in(0x632630C5, _r)
end

function SetAllPickupsOfTypeCollectableByCar(pickuptype, set)
	return _in(0x54B054D0, pickuptype, set)
end

function SetAllRandomPedsFlee(player, set)
	return _in(0x110957EF, player, set)
end

function SetAllowDummyConversions(set)
	return _in(0x08AB2787, set)
end

function SetAlternativeHeadForPedQueue()
	return _in(0x5B814784, _r)
end

function SetAlwaysDisplayWeaponPickupMessage(set)
	return _in(0x3F0A2A72, set)
end

function SetAmbientPlanesSpeedMultiplier(multiplier)
	return _in(0x4B470947, multiplier)
end

function SetAmbientVoiceName(ped, name)
	return _in(0x426A4ED8, ped, _ts(name))
end

function SetAmmoInClip(ped, weapon, ammo)
	return _in(0x6E1A0A84, ped, weapon, ammo, _ri)
end

function SetAnimGroupForChar(ped, grname)
	return _in(0x4CD43E46, ped, _ts(grname))
end

function SetAreaName()
	return _in(0x3C3879C6, _r)
end

function SetArmourPickupNetworkRegenTime(timeMS)
	return _in(0x53CC1D3C, timeMS)
end

function SetBikeRiderWillPutFootDownWhenStopped(bike, set)
	return _in(0x6E77153D, bike, set)
end

function SetBit(bit)
	return _in(0x39551B76, _i, bit)
end

function SetBitsInRange(rangebegin, rangeend, val)
	return _in(0x14DD5F87, _i, rangebegin, rangeend, val)
end

function SetBlipAsFriendly(blip, value)
	return _in(0x0580462A, blip, value)
end

function SetBlipAsShortRange(blip, value)
	return _in(0x2ED90276, blip, value)
end

function SetBlipCoordinates(blip, x, y, z)
	return _in(0x3D91564E, blip, x, y, z)
end

function SetBlipMarkerLongDistance(blip, set)
	return _in(0x150A6532, blip, set)
end

function SetBlipThrottleRandomly(veh, set)
	return _in(0x12A619E9, veh, set)
end

function SetBlockCameraToggle(set)
	return _in(0x45C63B22, set)
end

function SetBlockingOfNonTemporaryEvents(ped, value)
	return _in(0x76247429, ped, value)
end

function SetBriansMood(mood)
	return _in(0x34F128F9, mood)
end

function SetCamActive(camera, value)
	return _in(0x43E42686, camera, value)
end

function SetCamAttachOffset(cam, x, y, z)
	return _in(0x72E93E13, cam, x, y, z)
end

function SetCamAttachOffsetIsRelative(cam, set)
	return _in(0x44984033, cam, set)
end

function SetCamBehindPed(ped)
	return _in(0x48740598, ped)
end

function SetCamComponentShake(cam, componentid, Unk564, time, x, y, z)
	return _in(0x52CE5D9F, cam, componentid, Unk564, time, x, y, z)
end

function SetCamDofFocuspoint(cam, x, y, z, Unk565)
	return _in(0x39DC5AEB, cam, x, y, z, Unk565)
end

function SetCamFarClip(cam, clip)
	return _in(0x181F6B00, cam, clip)
end

function SetCamFarDof(cam, fardof)
	return _in(0x52F543A3, cam, fardof)
end

function SetCamFov(camera, fov)
	return _in(0x55D470C2, camera, fov)
end

function SetCamInFrontOfPed(ped)
	return _in(0x423661A7, ped)
end

function SetCamInheritRollObject(cam, obj)
	return _in(0x208B4A6A, cam, obj)
end

function SetCamInheritRollPed(cam, ped)
	return _in(0x09A34209, cam, ped)
end

function SetCamInheritRollVehicle(cam, veh)
	return _in(0x51AD2993, cam, veh)
end

function SetCamInterpCustomSpeedGraph(speed)
	return _in(0x03102FEE, speed)
end

function SetCamInterpDetailRotStyleAngles(Unk566)
	return _in(0x5F7307F4, Unk566)
end

function SetCamInterpDetailRotStyleQuats(Unk567)
	return _in(0x439C47D5, Unk567)
end

function SetCamInterpStyleCore(cam0, cam1, cam2, time, flag)
	return _in(0x72297CDC, cam0, cam1, cam2, time, flag)
end

function SetCamInterpStyleDetailed(cam, Unk568, Unk569, Unk570, Unk571)
	return _in(0x683927F5, cam, Unk568, Unk569, Unk570, Unk571)
end

function SetCamMotionBlur(cam, blur)
	return _in(0x693D7B21, cam, blur)
end

function SetCamName(cam, camname)
	return _in(0x2AE87B02, cam, _ts(camname))
end

function SetCamNearClip(cam, clip)
	return _in(0x298827FC, cam, clip)
end

function SetCamNearDof(cam, dof)
	return _in(0x60AD2FE0, cam, dof)
end

function SetCamPointDampingParams(cam, x, y, z)
	return _in(0x57AC39F5, cam, x, y, z)
end

function SetCamPointOffset(cam, x, y, z)
	return _in(0x1C887939, cam, x, y, z)
end

function SetCamPointOffsetIsRelative(cam, set)
	return _in(0x12F20552, cam, set)
end

function SetCamPos(camera, pX, pY, pZ)
	return _in(0x152F6314, camera, pX, pY, pZ)
end

function SetCamPropagate(camera, value)
	return _in(0x44414E60, camera, value)
end

function SetCamRoll(cam, roll)
	return _in(0x4C5142C0, cam, roll)
end

function SetCamRot(camera, angleX, angleY, angleZ)
	return _in(0x746744D1, camera, angleX, angleY, angleZ)
end

function SetCamShake(cam, Unk572, shakeval)
	return _in(0x686B6395, cam, Unk572, shakeval)
end

function SetCamSplineCustomSpeedGraph(speed)
	return _in(0x391B5A76, speed)
end

function SetCamSplineDuration(cam, duration)
	return _in(0x4ADB6F79, cam, duration)
end

function SetCamSplineProgress(cam, progress)
	return _in(0x5A712F63, cam, progress)
end

function SetCamSplineSpeedConstant(cam, set)
	return _in(0x2CF72EB7, cam, set)
end

function SetCamSplineSpeedGraph(cam, Unk573)
	return _in(0x47AC289C, cam, Unk573)
end

function SetCamTargetPed(camera, ped)
	return _in(0x50E21E4C, camera, ped)
end

function SetCameraAutoScriptActivation(set)
	return _in(0x31D53B3D, set)
end

function SetCameraBeginCamCommandsRequired(set)
	return _in(0x03B12ED0, set)
end

function SetCameraControlsDisabledWithPlayerControls(value)
	return _in(0x3C714F12, value)
end

function SetCameraState(cam, state)
	return _in(0x4ED45146, cam, state)
end

function SetCanBurstCarTyres(car, set)
	return _in(0x24DE2039, car, set)
end

function SetCanResprayCar(car, can)
	return _in(0x76A2739D, car, can)
end

function SetCanTargetCharWithoutLos(ped, set)
	return _in(0x3FA651A7, ped, set)
end

function SetCarAllowedToDrown(car, allowed)
	return _in(0x31026CE0, car, allowed)
end

function SetCarAlwaysCreateSkids(car, set)
	return _in(0x0B9F0356, car, set)
end

function SetCarAnimCurrentTime(car, animname0, animname1, time)
	return _in(0x04485574, car, _ts(animname0), _ts(animname1), time)
end

function SetCarAnimSpeed(car, animname0, animname1, speed)
	return _in(0x74CD7D1F, car, _ts(animname0), _ts(animname1), speed)
end

function SetCarAsMissionCar(car)
	return _in(0x210A33B2, car)
end

function SetCarCanBeDamaged(vehicle, value)
	return _in(0x394E733E, vehicle, value)
end

function SetCarCanBeVisiblyDamaged(vehicle, value)
	return _in(0x4727446B, vehicle, value)
end

function SetCarCollision(car, set)
	return _in(0x6A9033B3, car, set)
end

function SetCarColourCombination(car, combination)
	return _in(0x0B823C8D, car, combination)
end

function SetCarCoordinates(vehicle, pX, pY, pZ)
	return _in(0x567B6C56, vehicle, pX, pY, pZ)
end

function SetCarCoordinatesNoOffset(car, x, y, z)
	return _in(0x12D64378, car, x, y, z)
end

function SetCarDensityMultiplier(density)
	return _in(0x0AA73A12, density)
end

function SetCarDistanceAheadMultiplier(car, multiplier)
	return _in(0x071B6690, car, multiplier)
end

function SetCarDoorLatched(car, door, flag0, flag1)
	return _in(0x0EAD6CFB, car, door, flag0, flag1)
end

function SetCarEngineOn(car, flag0, flag1)
	return _in(0x0CAA42D0, car, flag0, flag1)
end

function SetCarExistsOnAllMachines(vehicle, exists)
	return _in(0x7BAC73DF, vehicle, exists)
end

function SetCarForwardSpeed(vehicle, speed)
	return _in(0x65BB0060, vehicle, speed)
end

function SetCarFovFadeMult(multiplier)
	return _in(0x5EEE6ADB, multiplier)
end

function SetCarFovMax(maxfov)
	return _in(0x3FBF13BD, maxfov)
end

function SetCarFovMin(minfov)
	return _in(0x068F59E3, minfov)
end

function SetCarFovRate(rate)
	return _in(0x536B4F4A, rate)
end

function SetCarFovStartSpeed(speed)
	return _in(0x3CF41D47, speed)
end

function SetCarFovStartSpeedBoat(speed)
	return _in(0x40FC5520, speed)
end

function SetCarGeneratorsActiveInArea(x0, y0, z0, x1, y1, z1, set)
	return _in(0x69CE154F, x0, y0, z0, x1, y1, z1, set)
end

function SetCarHeading(vehicle, dir)
	return _in(0x75E40528, vehicle, dir)
end

function SetCarHealth(vehicle, Value)
	return _in(0x49B6525C, vehicle, Value)
end

function SetCarInCutscene(car, set)
	return _in(0x32593711, car, set)
end

function SetCarLaneShift(car, shift)
	return _in(0x10FD2442, car, shift)
end

function SetCarLightMultiplier(car, multiplier)
	return _in(0x74824ADA, car, multiplier)
end

function SetCarLivery(car, livery)
	return _in(0x2E9E149D, car, livery)
end

function SetCarMotionBlurEffectBoat(blur)
	return _in(0x7D106167, blur)
end

function SetCarNotDamagedByRelationshipGroup(car, set, group)
	return _in(0x3AAD447A, car, set, group)
end

function SetCarOnGroundProperly(vehicle)
	return _in(0x0E717E98, vehicle, _ri)
end

function SetCarOnlyDamagedByPlayer(car, set)
	return _in(0x2880077C, car, set)
end

function SetCarOnlyDamagedByRelationshipGroup(car, set, group)
	return _in(0x783F287A, car, set, group)
end

function SetCarProofs(vehicle, bulletProof, fireProof, explosionProof, collisionProof, meleeProof)
	return _in(0x137C35BA, vehicle, bulletProof, fireProof, explosionProof, collisionProof, meleeProof)
end

function SetCarRandomRouteSeed(car, seed)
	return _in(0x19D302AE, car, seed)
end

function SetCarStayInFastLane(car, set)
	return _in(0x5EAD47E8, car, set)
end

function SetCarStayInSlowLane(car, set)
	return _in(0x1B8B3973, car, set)
end

function SetCarStopCloning()
	return _in(0x407371FF, _r)
end

function SetCarStrong(vehicle, strong)
	return _in(0x61F40670, vehicle, strong)
end

function SetCarTraction(car, traction)
	return _in(0x278F2D0A, car, traction)
end

function SetCarVisible(vehicle, value)
	return _in(0x02D13D06, vehicle, value)
end

function SetCarWatertight(car, set)
	return _in(0x31017E6E, car, set)
end

function SetCellphoneRanked(toggle)
	return _in(0x47E03E87, toggle)
end

function SetCharAccuracy(ped, value)
	return _in(0x1958471A, ped, value)
end

function SetCharAllAnimsSpeed(ped, speed)
	return _in(0x5BDB7E2C, ped, speed)
end

function SetCharAllowedToDuck(ped, set)
	return _in(0x6E2E55B5, ped, set)
end

function SetCharAllowedToRunOnBoats(ped, set)
	return _in(0x662235A5, ped, set)
end

function SetCharAmmo(ped, weapon, ammo)
	return _in(0x437D247E, ped, weapon, ammo)
end

function SetCharAngledDefensiveArea(ped, x0, y0, z0, x1, y1, z1, angle)
	return _in(0x0DBD5654, ped, x0, y0, z0, x1, y1, z1, angle)
end

function SetCharAnimBlendOutDelta(ped, AnimName0, AnimName1, delta)
	return _in(0x000A1FCE, ped, _ts(AnimName0), _ts(AnimName1), delta)
end

function SetCharAnimCurrentTime(ped, AnimName0, AnimName1, time)
	return _in(0x245F424F, ped, _ts(AnimName0), _ts(AnimName1), time)
end

function SetCharAnimPlayingFlag(ped, AnimName0, AnimName1, flag)
	return _in(0x52DA430A, ped, _ts(AnimName0), _ts(AnimName1), flag, _r)
end

function SetCharAnimSpeed(ped, AnimName0, AnimName1, speed)
	return _in(0x3C2A3334, ped, _ts(AnimName0), _ts(AnimName1), speed)
end

function SetCharAsEnemy(ped, value)
	return _in(0x1C35407F, ped, value)
end

function SetCharAsMissionChar(ped)
	return _in(0x60EC0540, ped)
end

function SetCharBleeding(ped, set)
	return _in(0x38330B4A, ped, set)
end

function SetCharBulletproofVest(ped, set)
	return _in(0x076A7E4E, ped, set)
end

function SetCharCanBeKnockedOffBike(ped, value)
	return _in(0x30C54CD2, ped, value)
end

function SetCharCanBeShotInVehicle(ped, enabled)
	return _in(0x79912ADC, ped, enabled)
end

function SetCharCanSmashGlass(ped, set)
	return _in(0x0F634F9D, ped, set)
end

function SetCharCantBeDraggedOut(ped, enabled)
	return _in(0x2E5C36C0, ped, enabled)
end

function SetCharClimbAnimRate(ped, rate)
	return _in(0x68AB2DD9, ped, rate)
end

function SetCharCollision(ped, set)
	return _in(0x2A7413EB, ped, set)
end

function SetCharComponentVariation(ped, component, modelVariation, textureVariation)
	return _in(0x71A52973, ped, component, modelVariation, textureVariation)
end

function SetCharCoordinates(ped, x, y, z)
	return _in(0x689D0F5F, ped, x, y, z)
end

function SetCharCoordinatesDontClearPlayerTasks(ped, x, y, z)
	return _in(0x3458600C, ped, x, y, z)
end

function SetCharCoordinatesDontWarpGang(ped, x, y, z)
	return _in(0x624E5833, ped, x, y, z)
end

function SetCharCoordinatesDontWarpGangNoOffset(ped, x, y, z)
	return _in(0x355F3FEB, ped, x, y, z)
end

function SetCharCoordinatesNoOffset(ped, x, y, z)
	return _in(0x57C758F0, ped, x, y, z)
end

function SetCharCurrentWeaponVisible(ped, visble)
	return _in(0x6DAB7270, ped, visble)
end

function SetCharDecisionMaker(ped, dm)
	return _in(0x01F8116C, ped, dm)
end

function SetCharDecisionMakerToDefault(ped)
	return _in(0x73CB1489, ped)
end

function SetCharDefaultComponentVariation(ped)
	return _in(0x4FB30DB6, ped)
end

function SetCharDefensiveAreaAttachedToCar()
	return _in(0x7191562B, _r)
end

function SetCharDefensiveAreaAttachedToPed(ped, pednext, x0, y0, z0, x1, y1, z1, Unk7, Unk8)
	return _in(0x51C00627, ped, pednext, x0, y0, z0, x1, y1, z1, Unk7, Unk8)
end

function SetCharDesiredHeading(ped, heading)
	return _in(0x6EF64079, ped, heading)
end

function SetCharDiesInstantlyInWater(ped, allow)
	return _in(0x0CCA5CFC, ped, allow)
end

function SetCharDropsWeaponsWhenDead(ped, value)
	return _in(0x2D43113A, ped, value)
end

function SetCharDrownsInSinkingVehicle(ped, set)
	return _in(0x1E805412, ped, set)
end

function SetCharDrownsInWater(ped, set)
	return _in(0x0C2A7847, ped, set)
end

function SetCharDruggedUp(ped, drugged)
	return _in(0x458C333D, ped, drugged)
end

function SetCharDucking(ped, set)
	return _in(0x64302F16, ped, set, _ri)
end

function SetCharDuckingTimed(ped, timed)
	return _in(0x003A7647, ped, timed)
end

function SetCharFireDamageMultiplier(ped, multiplier)
	return _in(0x29AE70A8, ped, multiplier)
end

function SetCharForceDieInCar(ped, set)
	return _in(0x54AF2F7A, ped, set)
end

function SetCharGestureGroup(ped, AnimGroup)
	return _in(0x1106579B, ped, _ts(AnimGroup))
end

function SetCharGetOutUpsideDownCar(ped, set)
	return _in(0x1AAF54BE, ped, set)
end

function SetCharGravity(ped, value)
	return _in(0x602C46E7, ped, value)
end

function SetCharHeading(ped, heading)
	return _in(0x46B5523B, ped, heading)
end

function SetCharHealth(ped, health)
	return _in(0x575E2880, ped, health)
end

function SetCharInCutscene(ped, set)
	return _in(0x12850007, ped, set)
end

function SetCharInvincible(ped, enable)
	return _in(0x2A58578B, ped, enable)
end

function SetCharIsTargetPriority(ped, enable)
	return _in(0x163A1D77, ped, enable)
end

function SetCharKeepTask(ped, value)
	return _in(0x264009D3, ped, value)
end

function SetCharMaxHealth(ped, value)
	return _in(0x08A453C9, ped, value)
end

function SetCharMaxMoveBlendRatio(ped, ratio)
	return _in(0x640E7764, ped, ratio)
end

function SetCharMaxTimeInWater(ped, time)
	return _in(0x45F32596, ped, time)
end

function SetCharMaxTimeUnderwater(ped, time)
	return _in(0x7110790B, ped, time)
end

function SetCharMeleeActionFlag0(ped, set)
	return _in(0x771F3D7D, ped, set)
end

function SetCharMeleeActionFlag1(ped, set)
	return _in(0x2EF60AA6, ped, set)
end

function SetCharMeleeActionFlag2(ped, set)
	return _in(0x265E37E1, ped, set)
end

function SetCharMeleeMovementConstaintBox(ped, x0, y0, z0, x1, y1, z1)
	return _in(0x5A7D2C3C, ped, x0, y0, z0, x1, y1, z1)
end

function SetCharMoney(ped, amount)
	return _in(0x7B44224F, ped, amount)
end

function SetCharMoveAnimSpeedMultiplier(ped, multiplier)
	return _in(0x5DC456DE, ped, multiplier)
end

function SetCharMovementAnimsBlocked(ped, set)
	return _in(0x346B4FE7, ped, set)
end

function SetCharNameDebug(ped, debugName)
	return _in(0x751967FD, ped, _ts(debugName))
end

function SetCharNeverLeavesGroup(ped, value)
	return _in(0x0F4C513E, ped, value)
end

function SetCharNeverTargetted(ped, set)
	return _in(0x5EA84115, ped, set)
end

function SetCharNotDamagedByRelationshipGroup(ped, relationshipGroup, enable)
	return _in(0x077A0221, ped, relationshipGroup, enable)
end

function SetCharOnlyDamagedByPlayer(ped, set)
	return _in(0x440D0A91, ped, set)
end

function SetCharOnlyDamagedByRelationshipGroup(ped, set, relgroup)
	return _in(0x506C2898, ped, set, relgroup)
end

function SetCharProofs(ped, unknown0, fallingDamage, unknown1, unknown2, unknown3)
	return _in(0x76F25B4B, ped, unknown0, fallingDamage, unknown1, unknown2, unknown3)
end

function SetCharPropIndex(ped, propType, index)
	return _in(0x5FE95249, ped, propType, index)
end

function SetCharPropIndexTexture(ped, Unk9, Unk10, Unk11)
	return _in(0x57390041, ped, Unk9, Unk10, Unk11)
end

function SetCharProvideCoveringFire(ped, set)
	return _in(0x1A827B2C, ped, set)
end

function SetCharRandomComponentVariation(ped)
	return _in(0x47D9437C, ped)
end

function SetCharReadyToBeExecuted(ped, set)
	return _in(0x5F58606A, ped, set)
end

function SetCharReadyToBeStunned(ped, set)
	return _in(0x2B416A06, ped, set)
end

function SetCharRelationship(ped, relationshipLevel, relationshipGroup)
	return _in(0x6D9538E1, ped, relationshipLevel, relationshipGroup)
end

function SetCharRelationshipGroup(ped, relationshipGroup)
	return _in(0x61822A3C, ped, relationshipGroup)
end

function SetCharRotation(ped, xr, yr, zr)
	return _in(0x70E13826, ped, xr, yr, zr)
end

function SetCharShootRate(ped, rate)
	return _in(0x2AE979DC, ped, rate)
end

function SetCharSignalAfterKill(ped, set)
	return _in(0x6C6C1CF3, ped, set)
end

function SetCharSphereDefensiveArea(ped, x, y, z, radius)
	return _in(0x56AD2409, ped, x, y, z, radius)
end

function SetCharStayInCarWhenJacked(ped, set)
	return _in(0x1A02748F, ped, set)
end

function SetCharSuffersCriticalHits(ped, value)
	return _in(0x154E450E, ped, value)
end

function SetCharUsesDeafultAnimGroupWhenFleeing(ped, set)
	return _in(0x0DD71BA9, ped, set)
end

function SetCharUsesUpperbodyDamageAnimsOnly(ped, set)
	return _in(0x268F1413, ped, set)
end

function SetCharVelocity(ped, x, y, z)
	return _in(0x07C76803, ped, x, y, z)
end

function SetCharVisible(ped, value)
	return _in(0x04CF0105, ped, value)
end

function SetCharWalkAlongsideLeaderWhenAppropriate(ped, set)
	return _in(0x41121D51, ped, set)
end

function SetCharWantedByPolice(ped, wanted)
	return _in(0x05C619D7, ped, wanted)
end

function SetCharWatchMelee(ped, set)
	return _in(0x142A5E83, ped, set)
end

function SetCharWeaponSkill(ped, skill)
	return _in(0x441B1EAF, ped, skill)
end

function SetCharWillCowerInsteadOfFleeing(ped, set)
	return _in(0x58FB0BC1, ped, set)
end

function SetCharWillDoDrivebys(ped, value)
	return _in(0x2C9E0483, ped, value)
end

function SetCharWillFlyThroughWindscreen(ped, value)
	return _in(0x6FC75ABD, ped, value)
end

function SetCharWillLeaveCarInCombat(ped, set)
	return _in(0x7CFC39CB, ped, set)
end

function SetCharWillMoveWhenInjured(ped, value)
	return _in(0x1EF36397, ped, value)
end

function SetCharWillOnlyFireWithClearLos(ped, set)
	return _in(0x4458184A, ped, set)
end

function SetCharWillRemainOnBoatAfterMissionEnds(ped, set)
	return _in(0x5E8D08CE, ped, set)
end

function SetCharWillTryToLeaveBoatAfterLeader(ped, set)
	return _in(0x62AB2AB4, ped, set)
end

function SetCharWillTryToLeaveWater(ped, set)
	return _in(0x1D1B6750, ped, set)
end

function SetCharWillUseCarsInCombat(ped, value)
	return _in(0x2FD83FB5, ped, value)
end

function SetCharWillUseCover(ped, value)
	return _in(0x5F2F1680, ped, value)
end

function SetCinematicButtonEnabled(set)
	return _in(0x0F13355A, set)
end

function SetClearHelpInMissionCleanup(set)
	return _in(0x4371559F, set)
end

function SetClearManifolds(set)
	return _in(0x5B7A738C, set)
end

function SetCollectable1Total(total)
	return _in(0x79574B3B, total)
end

function SetCollideWithPeds(set)
	return _in(0x5FDF1493, set)
end

function SetCombatDecisionMaker(ped, dm)
	return _in(0x526B048C, ped, dm)
end

function SetContentsOfTextWidget(Unk1115, Unk1116)
	return _in(0x6B9C6127, Unk1115, Unk1116)
end

function SetConvertibleRoof(car, set)
	return _in(0x3A9A0869, car, set)
end

function SetCreateRandomCops(set)
	return _in(0x5C832C1F, set)
end

function SetCreditsToRenderBeforeFade(set)
	return _in(0x35FA026D, set)
end

function SetCurrentCharWeapon(ped, w, unknownTrue)
	return _in(0x6CF44DD6, ped, w, unknownTrue)
end

function SetCurrentMovie(filename)
	return _in(0x5AF23F31, _ts(filename))
end

function SetCutsceneExtraRoomPos(x, y, z)
	return _in(0x226A7227, x, y, z)
end

function SetDanceShakeActiveThisUpdate(shake)
	return _in(0x1E880709, shake)
end

function SetDanceShakeInactiveImmediately()
	return _in(0x2DAE50C0)
end

function SetDeadCharCoordinates(ped, x, y, z)
	return _in(0x68C57282, ped, x, y, z)
end

function SetDeadPedsDropWeapons(set)
	return _in(0x2A5262C0, set)
end

function SetDeathWeaponsPersist(ped, set)
	return _in(0x49F86791, ped, set)
end

function SetDebugTextVisible(Unk1120)
	return _in(0x39D87BD6, Unk1120)
end

function SetDecisionMakerAttributeCanChangeTarget(dm, value)
	return _in(0x51F54148, dm, value)
end

function SetDecisionMakerAttributeCaution(dm, value)
	return _in(0x6BAC2781, dm, value)
end

function SetDecisionMakerAttributeFireRate(dm, value)
	return _in(0x31FC3392, dm, value)
end

function SetDecisionMakerAttributeLowHealth(dm, value)
	return _in(0x2FFA6C89, dm, value)
end

function SetDecisionMakerAttributeMovementStyle(dm, value)
	return _in(0x0273134E, dm, value)
end

function SetDecisionMakerAttributeNavigationStyle(dm, value)
	return _in(0x26A1722C, dm, value)
end

function SetDecisionMakerAttributeRetreatingBehaviour(dm, value)
	return _in(0x67890049, dm, value)
end

function SetDecisionMakerAttributeSightRange(dm, value)
	return _in(0x2F444F95, dm, value)
end

function SetDecisionMakerAttributeStandingStyle(dm, value)
	return _in(0x7D767108, dm, value)
end

function SetDecisionMakerAttributeTargetInjuredReaction(dm, value)
	return _in(0x7CAE2557, dm, value)
end

function SetDecisionMakerAttributeTargetLossResponse(dm, value)
	return _in(0x65490A3D, dm, value)
end

function SetDecisionMakerAttributeTeamwork(dm, value)
	return _in(0x7EAE7F2F, dm, value)
end

function SetDecisionMakerAttributeWeaponAccuracy(dm, value)
	return _in(0x21B8337F, dm, value)
end

function SetDefaultGlobalInstancePriority()
	return _in(0x58E835E4)
end

function SetDefaultTargetScoringFunction(ped, Unk132)
	return _in(0x0B164EF2, ped, Unk132)
end

function SetDisablePlayerShoveAnimation(ped, disable)
	return _in(0x73F869CF, ped, disable)
end

function SetDisplayPlayerNameAndIcon(playerIndex, set)
	return _in(0x07370330, playerIndex, set)
end

function SetDitchPoliceModels(set)
	return _in(0x25AC586E, set)
end

function SetDoNotSpawnParkedCarsOnTop(pickup, set)
	return _in(0x7A93645C, pickup, set)
end

function SetDontActivateRagdollFromPlayerImpact(ped, set)
	return _in(0x5A676BCD, ped, set)
end

function SetDoorState(door, flag, Unk95)
	return _in(0x7E3D3430, door, flag, Unk95)
end

function SetDrawPlayerComponent(component, set)
	return _in(0x3EFE3DC8, component, set)
end

function SetDriveTaskCruiseSpeed(ped, speed)
	return _in(0x499700EF, ped, speed)
end

function SetDrunkCam(cam, val, time)
	return _in(0x74B90C48, cam, val, time)
end

function SetEnableNearClipScan(set)
	return _in(0x35CC3267, set)
end

function SetEnableRcDetonate(set)
	return _in(0x1FC96A99, set)
end

function SetEnableRcDetonateOnContact(set)
	return _in(0x7BD06E31, set)
end

function SetEngineHealth(vehicle, health)
	return _in(0x3F413561, vehicle, health)
end

function SetEventPrecedence()
	return _in(0x40C54978, _r)
end

function SetEveryoneIgnorePlayer(playerIndex, value)
	return _in(0x059901B9, playerIndex, value)
end

function SetExtraCarColours(vehicle, colour1, colour2)
	return _in(0x6CB14354, vehicle, colour1, colour2)
end

function SetExtraHospitalRestartPoint(x, y, z, Unk489, Unk490)
	return _in(0x4B6E368D, x, y, z, Unk489, Unk490)
end

function SetExtraPoliceStationRestartPoint(x, y, z, Unk491, Unk492)
	return _in(0x1C4E7A79, x, y, z, Unk491, Unk492)
end

function SetFadeInAfterLoad(set)
	return _in(0x5384065B, set)
end

function SetFakeWantedCircle(x, y, radius)
	return _in(0x3CEE0376, x, y, radius)
end

function SetFakeWantedLevel(lvl)
	return _in(0x29D91F3D, lvl)
end

function SetFilterMenuOn(toggle)
	return _in(0x18F43649, toggle)
end

function SetFilterSaveSetting(filterid, setting)
	return _in(0x47F971E8, filterid, setting)
end

function SetFixedCamPos(x, y, z)
	return _in(0x511A3B01, x, y, z)
end

function SetFloatStat(stat, value)
	return _in(0x5213511B, stat, value)
end

function SetFollowPedPitchLimitDown(pitchdownlim)
	return _in(0x31DB4020, pitchdownlim)
end

function SetFollowPedPitchLimitUp(pitchuplim)
	return _in(0x360E2977, pitchuplim)
end

function SetFollowVehicleCamOffset(Unk574, x, y, z)
	return _in(0x56507469, Unk574, x, y, z)
end

function SetFollowVehicleCamSubmode(mode)
	return _in(0x20BC708E, mode)
end

function SetFollowVehiclePitchLimitDown(pitchdownlim)
	return _in(0x02F65CB2, pitchdownlim)
end

function SetFollowVehiclePitchLimitUp(pitchuplim)
	return _in(0x5567728E, pitchuplim)
end

function SetForceLookBehind(set)
	return _in(0x64961488, set)
end

function SetForcePlayerToEnterThroughDirectDoor(ped, set)
	return _in(0x79B73666, ped, set)
end

function SetFovChannelScript(set)
	return _in(0x68AB6E72, set)
end

function SetFreeHealthCare(player, set)
	return _in(0x30BE3463, player, set)
end

function SetFreeResprays(set)
	return _in(0x00710A49, set)
end

function SetFreebiesInVehicle(veh, set)
	return _in(0x25541DBE, veh, set)
end

function SetGameCamHeading(heading)
	return _in(0x45FB5CE1, heading)
end

function SetGameCamPitch(pitch)
	return _in(0x1BC772AC, pitch)
end

function SetGameCameraControlsActive(active)
	return _in(0x57952546, active)
end

function SetGangCar(car, set)
	return _in(0x3A8531E8, car, set)
end

function SetGarageLeaveCameraAlone(garageName, set)
	return _in(0x5BC10979, _ts(garageName), set)
end

function SetGfwlHasSafeHouse(ukn)
	return _in(0x06136B6A, ukn)
end

function SetGfwlIsReturningToSinglePlayer(Unk963)
	return _in(0x755F292D, Unk963)
end

function SetGlobalInstancePriority(priority)
	return _in(0x573F5B48, priority)
end

function SetGlobalRenderFlags(Unk507, Unk508, Unk509, Unk510)
	return _in(0x4FE23851, Unk507, Unk508, Unk509, Unk510)
end

function SetGpsRemainsWhenTargetReachedFlag(set)
	return _in(0x4C9B749F, set)
end

function SetGpsTestIn3dFlag(set)
	return _in(0x28D17798, set)
end

function SetGpsVoiceForVehicle(veh, VoiceId)
	return _in(0x356876BF, veh, VoiceId)
end

function SetGravityOff(set)
	return _in(0x3CDA1A07, set)
end

function SetGroupCharDecisionMaker(group, dm)
	return _in(0x14166075, group, dm)
end

function SetGroupCharDucksWhenAimedAt(ped, value)
	return _in(0x5C8C7F9E, ped, value)
end

function SetGroupCombatDecisionMaker(group, dm)
	return _in(0x58123F7A, group, dm)
end

function SetGroupFollowStatus(group, status)
	return _in(0x64B9757E, group, status)
end

function SetGroupFormation(group, formation)
	return _in(0x6D05484F, group, formation)
end

function SetGroupFormationSpacing(group, space)
	return _in(0x69315157, group, space)
end

function SetGroupLeader(group, leader)
	return _in(0x04C85E23, group, leader)
end

function SetGroupMember(group, member)
	return _in(0x5E0F611E, group, member)
end

function SetGroupSeparationRange(group, seperation)
	return _in(0x22DD329E, group, seperation)
end

function SetGunshotSenseRangeForRiot2(range)
	return _in(0x1A081F78, range)
end

function SetHasBeenOwnedByPlayer(car, set)
	return _in(0x25750E4F, car, set)
end

function SetHasBeenOwnedForCarGenerator(CarGen, set)
	return _in(0x60E335FA, CarGen, set)
end

function SetHeadingForAttachedPlayer()
	return _in(0x6B247B9E, _r)
end

function SetHeadingLimitForAttachedPed(ped, heading0, heading1)
	return _in(0x15B07D4D, ped, heading0, heading1)
end

function SetHeadingOfClosestObjectOfType(x, y, z, radius, type_or_model, heading)
	return _in(0x7ABD4D4D, x, y, z, radius, type_or_model, heading)
end

function SetHealthPickupNetworkRegenTime(timeMS)
	return _in(0x072516B4, timeMS)
end

function SetHeliBladesFullSpeed(heli)
	return _in(0x557C3641, heli)
end

function SetHeliForceEngineOn(heli, set)
	return _in(0x3B8F5E20, heli, set, _ri)
end

function SetHeliStabiliser(heli, set)
	return _in(0x4E653BCC, heli, set)
end

function SetHelpMessageBoxSize(Unk773)
	return _in(0x4FB069ED, Unk773)
end

function SetHelpMessageBoxSizeF(size)
	return _in(0x7A521650, size)
end

function SetHideWeaponIcon(set)
	return _in(0x0F1B1AA1, set)
end

function SetHintAdvancedParams(Unk575, Unk576, Unk577, Unk578, Unk579)
	return _in(0x2E096356, Unk575, Unk576, Unk577, Unk578, Unk579)
end

function SetHintFov(fov)
	return _in(0x2F9751E2, fov)
end

function SetHintMoveInDist(dist)
	return _in(0x661A0CCC, dist)
end

function SetHintMoveInDistDefault()
	return _in(0x449264B6)
end

function SetHintTimes(Unk580, Unk581, Unk582)
	return _in(0x4CC81FCB, Unk580, Unk581, Unk582)
end

function SetHintTimesDefault()
	return _in(0x6ADF2929)
end

function SetHostMatchOn(Unk964)
	return _in(0x2C41421A, Unk964)
end

function SetHotWeaponSwap(set)
	return _in(0x7FF260D0, set)
end

function SetIgnoreLowPriorityShockingEvents(ped, value)
	return _in(0x05CC3DA1, ped, value)
end

function SetIgnoreNoGpsFlag(set)
	return _in(0x1FC06A1B, set)
end

function SetIgnoreServerUpdate()
	return _in(0x6B2F6234, _r)
end

function SetIkDisabledForNetworkPlayer(playerIndex, Unk965)
	return _in(0x13B27FFE, playerIndex, Unk965)
end

function SetInMpTutorial(set)
	return _in(0x1AEB793A, set)
end

function SetInSpectatorMode(spectate)
	return _in(0x40035D5D, spectate)
end

function SetInformRespectedFriends(ped, Unk43, Unk44)
	return _in(0x509F236D, ped, Unk43, Unk44)
end

function SetInstantWidescreenBorders(set)
	return _in(0x728C1CC0, set)
end

function SetIntStat(stat, value)
	return _in(0x1B64665B, stat, value)
end

function SetInterpFromGameToScript(Unk604, Unk605)
	return _in(0x45CE21CA, Unk604, Unk605)
end

function SetInterpFromScriptToGame(Unk606, Unk607)
	return _in(0x69B140F6, Unk606, Unk607)
end

function SetInterpInOutVehicleEnabledThisFrame(set)
	return _in(0x120D3155, set)
end

function SetInvincibilityTimerDuration()
	return _in(0x3E4233F7, _r)
end

function SetKillstreak()
	return _in(0x7D070604)
end

function SetLcpdCopScore()
	return _in(0x39C6699D, _r)
end

function SetLcpdCriminalScore()
	return _in(0x7457458C, _r)
end

function SetLoadCollisionForCarFlag(car, set)
	return _in(0x1E5C50B5, car, set)
end

function SetLoadCollisionForCharFlag(ped, set)
	return _in(0x4AA762A4, ped, set)
end

function SetLoadCollisionForObjectFlag(obj, set)
	return _in(0x70D13342, obj, set)
end

function SetLobbyMuteOverride(set)
	return _in(0x10800FD6, set)
end

function SetLocalPlayerPainVoice(name)
	return _in(0x1DDD0073, _ts(name))
end

function SetLocalPlayerVoice(name)
	return _in(0x07092DC4, _ts(name))
end

function SetLoudVehicleRadio(veh, set)
	return _in(0x34686B92, veh, set)
end

function SetMask(Unk774, Unk775, Unk776, Unk777)
	return _in(0x0D3A3160, Unk774, Unk775, Unk776, Unk777)
end

function SetMaxFireGenerations(max)
	return _in(0x03BA036B, max)
end

function SetMaxWantedLevel(lvl)
	return _in(0x5D622498, lvl)
end

function SetMenuColumn(menuid, Unk866, Unk867, Unk868, Unk869, Unk870, Unk871, Unk872, Unk873, Unk874, Unk875, Unk876, Unk877, Unk878, Unk879)
	return _in(0x4D317353, menuid, Unk866, Unk867, Unk868, Unk869, Unk870, Unk871, Unk872, Unk873, Unk874, Unk875, Unk876, Unk877, Unk878, Unk879)
end

function SetMenuColumnOrientation(menuid, column, orientation)
	return _in(0x7CC63464, menuid, column, orientation)
end

function SetMenuColumnWidth(menuid, column, width)
	return _in(0x0DBF663C, menuid, column, width)
end

function SetMenuItemWithNumber(menuid, item, Unk881, gxtkey, number)
	return _in(0x32E45138, menuid, item, Unk881, _ts(gxtkey), number)
end

function SetMenuItemWith2Numbers(menuid, item, Unk880, gxtkey, number0, number1)
	return _in(0x7C4E54ED, menuid, item, Unk880, _ts(gxtkey), number0, number1)
end

function SetMessageFormatting(Unk700, Unk701, Unk702)
	return _in(0x679A474E, Unk700, Unk701, Unk702)
end

function SetMessagesWaiting(set)
	return _in(0x7DC061F5, set)
end

function SetMinMaxPedAccuracy(ped, min, max)
	return _in(0x74627538, ped, min, max)
end

function SetMinigameInProgress(set)
	return _in(0x3ED135AD, set)
end

function SetMissionFlag(isMission)
	return _in(0x4FE923DC, isMission)
end

function SetMissionPassedCash(add, cash, Unk511)
	return _in(0x60DC6E25, add, cash, Unk511)
end

function SetMissionPickupSound(model, SoundName)
	return _in(0x3F0F4E0C, model, _ts(SoundName))
end

function SetMissionRespectTotal(respect)
	return _in(0x3FA46EB8, respect)
end

function SetMissionTrainCoordinates(train, x, y, z)
	return _in(0x2A3F654A, train, x, y, z)
end

function SetMobilePhonePosition(x, y, z)
	return _in(0x463832F7, x, y, z)
end

function SetMobilePhoneRadioState(state)
	return _in(0x52C83902, state)
end

function SetMobilePhoneRotation(x, y, z)
	return _in(0x7E7E4879, x, y, z)
end

function SetMobilePhoneScale(scale)
	return _in(0x61C921EF, scale)
end

function SetMobileRadioEnabledDuringGameplay(set)
	return _in(0x688557E4, set)
end

function SetMobileRingType(type)
	return _in(0x24885050, type)
end

function SetMoneyCarriedByAllNewPeds(money)
	return _in(0x64CA2868, money)
end

function SetMoneyCarriedByPedWithModel(model, m0, m1)
	return _in(0x047D3BD6, model, m0, m1)
end

function SetMoneyPickupNetworkRegenTime()
	return _in(0x61243F34, _r)
end

function SetMovieTime(time)
	return _in(0x37871A37, time)
end

function SetMovieVolume(volume)
	return _in(0x32486214, volume)
end

function SetMsgForLoadingScreen(label)
	return _in(0x4E4C2F92, _ts(label))
end

function SetMultiplayerBrief()
	return _in(0x1F5A6C94, _r)
end

function SetMultiplayerHudCash(cash)
	return _in(0x051742D5, cash)
end

function SetMultiplayerHudTime(str)
	return _in(0x3A820D46, _ts(str))
end

function SetNeedsToBeHotwired(veh, set)
	return _in(0x40A708A6, veh, set)
end

function SetNetworkIdCanMigrate(netid, value)
	return _in(0x2FA5601D, netid, value)
end

function SetNetworkIdExistsOnAllMachines(netID, set)
	return _in(0x4E2C764D, netID, set)
end

function SetNetworkIdStopCloning(id, Unk966)
	return _in(0x086452E7, id, Unk966)
end

function SetNetworkIdStopCloningForEnemies()
	return _in(0x320B3D0C, _r)
end

function SetNetworkJoinFail(ukn0)
	return _in(0x5849311B, ukn0)
end

function SetNetworkPedUsingParachute(ped)
	return _in(0x6E8B7611, ped)
end

function SetNetworkPlayerAsVip(playerIndex, Unk967)
	return _in(0x28251E62, playerIndex, Unk967)
end

function SetNetworkVehicleRespotTimer(id, ukn4000)
	return _in(0x266F327C, id, ukn4000)
end

function SetNetworkVisibility()
	return _in(0x24403F44, _r)
end

function SetNextDesiredMoveState(state)
	return _in(0x02033258, state)
end

function SetNmAnimPose(ped, AnimName0, AnimName1, pose)
	return _in(0x50311928, ped, _ts(AnimName0), _ts(AnimName1), pose)
end

function SetNmMessageBool(id, value)
	return _in(0x202F384E, id, value)
end

function SetNmMessageFloat(id, value)
	return _in(0x6CE00370, id, value)
end

function SetNmMessageInstanceIndex(id, ped, car, obj)
	return _in(0x48543AED, id, ped, car, obj)
end

function SetNmMessageInt(id, value)
	return _in(0x49105005, id, value)
end

function SetNmMessageString(id, string)
	return _in(0x3F296F78, id, _ts(string))
end

function SetNmMessageVec3(id, x, y, z)
	return _in(0x6E8F7FA4, id, x, y, z)
end

function SetNoResprays(set)
	return _in(0x418D0889, set)
end

function SetObjectAlpha(obj, alpha)
	return _in(0x7F0040DE, obj, alpha)
end

function SetObjectAnimCurrentTime(obj, animname0, animname1, time)
	return _in(0x368274DA, obj, _ts(animname0), _ts(animname1), time)
end

function SetObjectAnimPlayingFlag(obj, animname0, animname1, flag)
	return _in(0x6A7236C9, obj, _ts(animname0), _ts(animname1), flag)
end

function SetObjectAnimSpeed(obj, animname0, animname1, speed)
	return _in(0x168B18ED, obj, _ts(animname0), _ts(animname1), speed)
end

function SetObjectAsStealable(obj, set)
	return _in(0x2DDE3785, obj, set)
end

function SetObjectCcd(obj, set)
	return _in(0x677861E1, obj, set)
end

function SetObjectCollision(obj, value)
	return _in(0x24A40229, obj, value)
end

function SetObjectCoordinates(obj, pX, pY, pZ)
	return _in(0x52FD30EB, obj, pX, pY, pZ)
end

function SetObjectDrawLast(obj, set)
	return _in(0x19DD44F2, obj, set)
end

function SetObjectDynamic(obj, set)
	return _in(0x2C591CCD, obj, set)
end

function SetObjectExistsOnAllMachines(obj, exists)
	return _in(0x672139F0, obj, exists)
end

function SetObjectHeading(obj, value)
	return _in(0x4F5D027C, obj, value)
end

function SetObjectHealth(obj, health)
	return _in(0x46C41EA8, obj, health)
end

function SetObjectInitialRotationVelocity(obj, x, y, z)
	return _in(0x1C7C4B89, obj, x, y, z)
end

function SetObjectInitialVelocity(obj, x, y, z)
	return _in(0x41ED206B, obj, x, y, z)
end

function SetObjectInvincible(obj, set)
	return _in(0x1D2F46AE, obj, set)
end

function SetObjectLights(obj, lights)
	return _in(0x45D71590, obj, lights)
end

function SetObjectOnlyDamagedByPlayer(obj, set)
	return _in(0x2E321155, obj, set)
end

function SetObjectPhysicsParams(obj, Unk96, Unk97, v0x, v0y, v0z, v1x, v1y, v1z, flag0, flag1)
	return _in(0x1B9A44D4, obj, Unk96, Unk97, v0x, v0y, v0z, v1x, v1y, v1z, flag0, flag1)
end

function SetObjectProofs(obj, unknown0, fallingDamage, unknown1, unknown2, unknown3)
	return _in(0x352865D2, obj, unknown0, fallingDamage, unknown1, unknown2, unknown3)
end

function SetObjectQuaternion(obj, qx, qy, qz, qw)
	return _in(0x71270D73, obj, qx, qy, qz, qw)
end

function SetObjectRecordsCollisions(obj, set)
	return _in(0x0CA93513, obj, set)
end

function SetObjectRenderScorched(obj, set)
	return _in(0x1AD3394A, obj, set)
end

function SetObjectRotation(obj, Pitch, Roll, Yaw)
	return _in(0x081D549C, obj, Pitch, Roll, Yaw)
end

function SetObjectScale(obj, scale)
	return _in(0x145B13C7, obj, scale)
end

function SetObjectStopCloning()
	return _in(0x2F400F5F, _r)
end

function SetObjectUsedInPoolGame(obj, set)
	return _in(0x07B23203, obj, set)
end

function SetObjectVisible(obj, value)
	return _in(0x372C7B2A, obj, value)
end

function SetOnlineLan(Unk968)
	return _in(0x7E113020, Unk968)
end

function SetOnlineScore(Unk1059, Unk1060)
	return _in(0x6B9C7392, Unk1059, Unk1060)
end

function SetOnscreenCounterFlashWhenFirstDisplayed(counterid, flash)
	return _in(0x06F54963, counterid, flash)
end

function SetOverrideNoSprintingOnPhoneInMultiplayer(Unk969)
	return _in(0x75F85826, Unk969)
end

function SetParkedCarDensityMultiplier(multiplier)
	return _in(0x010C7044, multiplier)
end

function SetPedAllowMissionOnlyDrivebyUse(ped, set)
	return _in(0x6E7C6687, ped, set)
end

function SetPedAlpha(ped, alpha)
	return _in(0x5AA1795C, ped, alpha)
end

function SetPedComponentsToNetworkPlayersettingsModel(ped)
	return _in(0x5C3053C0, ped)
end

function SetPedDensityMultiplier(density)
	return _in(0x540F2DF7, density)
end

function SetPedDiesWhenInjured(ped, value)
	return _in(0x3BF93ED7, ped, value)
end

function SetPedDontDoEvasiveDives(ped, value)
	return _in(0x1EAD1D7D, ped, value)
end

function SetPedDontUseVehicleSpecificAnims(ped, set)
	return _in(0x0B6E6107, ped, set)
end

function SetPedEnableLegIk(ped, set)
	return _in(0x695C429D, ped, set)
end

function SetPedExistsOnAllMachines(ped, exists)
	return _in(0x79700852, ped, exists)
end

function SetPedFallOffBikesWhenShot(ped, set)
	return _in(0x78E00C86, ped, set)
end

function SetPedFireFxLodScaler(scale)
	return _in(0x679C4276, scale)
end

function SetPedForceFlyThroughWindscreen(ped, set)
	return _in(0x6E354B41, ped, set)
end

function SetPedForceVisualiseHeadDamageFromBullets(ped, set)
	return _in(0x2BA92322, ped, set)
end

function SetPedGeneratesDeadBodyEvents(ped, set)
	return _in(0x3DBF53E0, ped, set)
end

function SetPedHeedsTheEveryoneIgnorePlayerFlag(ped, set)
	return _in(0x3BBE6DBE, ped, set)
end

function SetPedHeliPilotRespectsMinimummHeight(ped, set)
	return _in(0x20BB5507, ped, set)
end

function SetPedHelmetTextureIndex(ped, index)
	return _in(0x6AC14091, ped, index)
end

function SetPedInstantBlendsWeaponAnims(ped, set)
	return _in(0x2CB572B5, ped, set)
end

function SetPedIsBlindRaging(ped, value)
	return _in(0x05D800A4, ped, value)
end

function SetPedIsDrunk(ped, value)
	return _in(0x67CC007C, ped, value)
end

function SetPedMobileRingType(ped, RingtoneId)
	return _in(0x7E1C01D7, ped, RingtoneId)
end

function SetPedMotionBlur(ped, set)
	return _in(0x73E6005B, ped, set)
end

function SetPedNonCreationArea(x0, y0, z0, x1, y1, z1)
	return _in(0x3DAB7D72, x0, y0, z0, x1, y1, z1)
end

function SetPedNonRemovalArea(x0, y0, z0, x1, y1, z1)
	return _in(0x52D34ED3, x0, y0, z0, x1, y1, z1)
end

function SetPedPathMayDropFromHeight(ped, value)
	return _in(0x4F37648C, ped, value)
end

function SetPedPathMayUseClimbovers(ped, value)
	return _in(0x34BD72D7, ped, value)
end

function SetPedPathMayUseLadders(ped, value)
	return _in(0x6B2838C7, ped, value)
end

function SetPedPathWillAvoidDynamicObjects(ped, set)
	return _in(0x1E901BB6, ped, set)
end

function SetPedQueueMembershipList()
	return _in(0x2BD46BB, _r)
end

function SetPedSkipsComplexCoverCollisionChecks(ped, set)
	return _in(0x2CD33526, ped, set)
end

function SetPedSteersAroundObjects(ped, set)
	return _in(0x7D071EE0, ped, set)
end

function SetPedSteersAroundPeds(ped, set)
	return _in(0x57A236F0, ped, set)
end

function SetPedStopCloning()
	return _in(0x74C55395, _r)
end

function SetPedWindyClothingScale(ped, scale)
	return _in(0x12865550, ped, scale)
end

function SetPedWithBrainCanBeConvertedToDummyPed(ped, set)
	return _in(0x1461418C, ped, set)
end

function SetPedWontAttackPlayerWithoutWantedLevel(ped, set)
	return _in(0x3BF06336, ped, set)
end

function SetPetrolTankHealth(vehicle, value)
	return _in(0x17E2319C, vehicle, value)
end

function SetPetrolTankWeakpoint(car, set)
	return _in(0x667517AB, car, set)
end

function SetPhoneHudItem(id, gxttext, Unk800)
	return _in(0x43A13718, id, _ts(gxttext), Unk800)
end

function SetPhysCcdHandlesRotation(set)
	return _in(0x0C7B7CF4, set)
end

function SetPickupCollectableByCar(pickup, set)
	return _in(0x6DA91393, pickup, set)
end

function SetPickupsFixCars(set)
	return _in(0x59DC6B9A, set)
end

function SetPlaneThrottle(plane, throttle)
	return _in(0x05B2442A, plane, throttle)
end

function SetPlaneUndercarriageUp(plain, set)
	return _in(0x7953702C, plain, set)
end

function SetPlaybackSpeed(car, speed)
	return _in(0x0EAF6A68, car, speed)
end

function SetPlayerAsCop(player, set)
	return _in(0x1D161BB8, player, set)
end

function SetPlayerAsDamagedPlayer(playerIndex, Unk1057, Unk1058)
	return _in(0x633A012B, playerIndex, Unk1057, Unk1058)
end

function SetPlayerCanBeHassledByGangs(playerIndex, value)
	return _in(0x09C5648C, playerIndex, value)
end

function SetPlayerCanDoDriveBy(playerIndex, value)
	return _in(0x561471FB, playerIndex, value)
end

function SetPlayerCanDropWeaponsInCar(set)
	return _in(0x4F884E33, set)
end

function SetPlayerCanUseCover(playerIndex, value)
	return _in(0x4AC023C4, playerIndex, value)
end

function SetPlayerColour()
	return _in(0x6C8F2EEE, _r)
end

function SetPlayerControl(playerIndex, value)
	return _in(0x1A6203EA, playerIndex, value)
end

function SetPlayerControlAdvanced(playerIndex, unknown1, unknown2, unknown3)
	return _in(0x31E25160, playerIndex, unknown1, unknown2, unknown3)
end

function SetPlayerControlForAmbientScript(player, flag0, flag1)
	return _in(0x647E2BF7, player, flag0, flag1)
end

function SetPlayerControlForNetwork(playerIndex, unknownTrue, unknownFalse)
	return _in(0x2AF07CC8, playerIndex, unknownTrue, unknownFalse)
end

function SetPlayerControlForTextChat(player, set)
	return _in(0x13267663, player, set)
end

function SetPlayerControlOnInMissionCleanup(set)
	return _in(0x06F271B2, set)
end

function SetPlayerDisableCrouch(player, set)
	return _in(0x3BB57426, player, set)
end

function SetPlayerDisableJump(player, set)
	return _in(0x4B5832BE, player, set)
end

function SetPlayerFastReload(playerIndex, value)
	return _in(0x29B53DFF, playerIndex, value)
end

function SetPlayerForcedAim(player, set)
	return _in(0x7E603872, player, set)
end

function SetPlayerGroupRecruitment(player, set)
	return _in(0x7A9B6E17, player, set)
end

function SetPlayerGroupToFollowAlways(playerIndex, value)
	return _in(0x700165C2, playerIndex, value)
end

function SetPlayerGroupToFollowNever(player, set)
	return _in(0x4F29072E, player, set)
end

function SetPlayerIconColour(colour)
	return _in(0x689D5EEE, colour)
end

function SetPlayerInvincible(playerIndex, value)
	return _in(0x7E9E02E1, playerIndex, value)
end

function SetPlayerInvisibleToAi(set)
	return _in(0x68083431, set)
end

function SetPlayerIsInStadium(set)
	return _in(0x349D5C27, set)
end

function SetPlayerKeepsWeaponsWhenRespawned(set)
	return _in(0x6C321179, set)
end

function SetPlayerMayOnlyEnterThisVehicle(player, veh)
	return _in(0x6BC05942, player, veh)
end

function SetPlayerMoodNormal(playerIndex)
	return _in(0x546F5326, playerIndex)
end

function SetPlayerMoodPissedOff(playerIndex, unknown150)
	return _in(0x5E061170, playerIndex, unknown150)
end

function SetPlayerMpModifier(player, Unk12, modifier)
	return _in(0x2B111E69, player, Unk12, modifier)
end

function SetPlayerNeverGetsTired(playerIndex, value)
	return _in(0x0DDC19F4, playerIndex, value)
end

function SetPlayerPainRootBankName(name)
	return _in(0x70AF1D38, _ts(name))
end

function SetPlayerPlayerTargetting(set)
	return _in(0x46920944, set)
end

function SetPlayersCanBeInSeparateCars()
	return _in(0x58704CAD, _r)
end

function SetPlayerSettingsGenre(ped)
	return _in(0x379B0A8F, ped)
end

function SetPlayerTeam(Player, team)
	return _in(0x3E733990, Player, team)
end

function SetPlayersDropMoneyInNetworkGame(toggle)
	return _in(0x01651FBA, toggle)
end

function SetPlayersettingsModelVariationsChoice(playerIndex)
	return _in(0x27650F37, playerIndex)
end

function SetPoliceFocusWillTrackCar(car, set)
	return _in(0x0D374615, car, set)
end

function SetPoliceIgnorePlayer(playerIndex, value)
	return _in(0x619D51D3, playerIndex, value)
end

function SetPoliceRadarBlips(set)
	return _in(0x14790F9F, set)
end

function SetPtfxCamInsideVehicle(set)
	return _in(0x137E6800, set)
end

function SetRadarAsInteriorThisFrame()
	return _in(0x5C3F7E39)
end

function SetRadarScale(scale)
	return _in(0x75ED39CF, scale)
end

function SetRadarZoom(zoom)
	return _in(0x35E37826, zoom)
end

function SetRailtrackResistanceMult(resistance)
	return _in(0x3D7B10E7, resistance)
end

function SetRandomCarDensityMultiplier(density)
	return _in(0x073505E0, density)
end

function SetRandomSeed(seed)
	return _in(0x1BA8350B, seed)
end

function SetRecordingToPointNearestToCoors(cat, x, y, z)
	return _in(0x7B732460, cat, x, y, z)
end

function SetReducePedModelBudget(set)
	return _in(0x44474526, set)
end

function SetReduceVehicleModelBudget(set)
	return _in(0x71F965B4, set)
end

function SetRelationship(relationshipLevel, relationshipGroup1, relationshipGroup2)
	return _in(0x03D916E4, relationshipLevel, relationshipGroup1, relationshipGroup2)
end

function SetRenderTrainAsDerailed(train, set)
	return _in(0x08240FB7, train, set)
end

function SetReturnToFilterMenu(Unk970)
	return _in(0x733846D5, Unk970)
end

function SetRichPresence(Unk971, Unk972, Unk973, Unk974, Unk975)
	return _in(0x73AB2028, Unk971, Unk972, Unk973, Unk974, Unk975)
end

function SetRichPresenceTemplatefilter()
	return _in(0x6B434D0D)
end

function SetRichPresenceTemplatelobby(Unk976)
	return _in(0x77D72045, Unk976)
end

function SetRichPresenceTemplatemp1(Unk977, Unk978, Unk979, Unk980)
	return _in(0x6C236A54, Unk977, Unk978, Unk979, Unk980)
end

function SetRichPresenceTemplatemp2(Unk981)
	return _in(0x5AFA67D7, Unk981)
end

function SetRichPresenceTemplatemp3(Unk982, Unk983)
	return _in(0x612062DB, Unk982, Unk983)
end

function SetRichPresenceTemplatemp4(Unk984, Unk985)
	return _in(0x2BF8368E, Unk984, Unk985)
end

function SetRichPresenceTemplatemp5(Unk986, Unk987, Unk988)
	return _in(0x314F6DD3, Unk986, Unk987, Unk988)
end

function SetRichPresenceTemplatemp6(Unk989, Unk990, Unk991)
	return _in(0x05D70FE8, Unk989, Unk990, Unk991)
end

function SetRichPresenceTemplateparty()
	return _in(0x422055C7)
end

function SetRichPresenceTemplatesp1(Unk992, Unk993, Unk994)
	return _in(0x00132487, Unk992, Unk993, Unk994)
end

function SetRichPresenceTemplatesp2(Unk995)
	return _in(0x09766174, Unk995)
end

function SetRocketLauncherFreebieInHeli(set)
	return _in(0x77A97169, set)
end

function SetRomansMood(moood)
	return _in(0x126F1175, moood)
end

function SetRoomForCarByKey(car, roomkey)
	return _in(0x1E106A88, car, roomkey)
end

function SetRoomForCarByName(car, roomname)
	return _in(0x2667609A, car, _ts(roomname))
end

function SetRoomForCharByKey(ped, key)
	return _in(0x620C26D8, ped, key)
end

function SetRoomForCharByName(ped, roomname)
	return _in(0x2E9B1F77, ped, _ts(roomname))
end

function SetRoomForDummyCharByKey(dummyPed, roomkey)
	return _in(0x29907BEF, dummyPed, roomkey)
end

function SetRoomForDummyCharByName(dummyPed, roomname)
	return _in(0x75B024C6, dummyPed, _ts(roomname))
end

function SetRoomForViewportByKey(viewportid, roomkey)
	return _in(0x07EE2A45, viewportid, roomkey)
end

function SetRoomForViewportByName(viewportid, roomname)
	return _in(0x3DAF3F94, viewportid, _ts(roomname))
end

function SetRopeHeightForObject()
	return _in(0x3D79554A, _r)
end

function SetRotOrder(order)
	return _in(0x662E4376, order)
end

function SetRotationForAttachedPed(ped, xr, yr, zr)
	return _in(0x1FE21CF0, ped, xr, yr, zr)
end

function SetRoute(blip, value)
	return _in(0x7B8D68E7, blip, value)
end

function SetScenarioPedDensityMultiplier(density, densitynext)
	return _in(0x3F0022F7, density, densitynext)
end

function SetScreenFade(viewportid, Unk778, Unk779, Unk780, r, g, b, a, Unk781, Unk782, Unk783)
	return _in(0x188E0FAC, viewportid, Unk778, Unk779, Unk780, r, g, b, a, Unk781, Unk782, Unk783)
end

function SetScriptFireAudio()
	return _in(0x40A50C8D, _r)
end

function SetScriptLimitToGangSize(size)
	return _in(0x352921C4, size)
end

function SetScriptMicLookAt(x, y, z)
	return _in(0x4DD43FFD, x, y, z)
end

function SetScriptMicPosition(x, y, z)
	return _in(0x295D3A87, x, y, z)
end

function SetScriptedAnimSeatOffset(ped, offset)
	return _in(0x718939EF, ped, offset)
end

function SetScriptedConversionCentre(x, y, z)
	return _in(0x40F61D4A, x, y, z)
end

function SetSelectedMenuItem(menuid, item)
	return _in(0x70291096, menuid, item)
end

function SetSenseRange(ped, value)
	return _in(0x44D56F66, ped, value)
end

function SetSequenceToRepeat(seq, repeat_)
	return _in(0x22E91F1F, seq, repeat_)
end

function SetServerId(id)
	return _in(0x575136AC, id)
end

function SetSirenWithNoDriver(car, set)
	return _in(0x47FD2517, car, set)
end

function SetSleepModeActive(set)
	return _in(0x1C5552E9, set)
end

function SetSniperZoomFactor(factor)
	return _in(0x42690F6B, factor)
end

function SetSpecificPassengerIndexToUseInGroups(ped, index)
	return _in(0x0EA118D0, ped, index)
end

function SetSpriteHdrMultiplier(multiplier)
	return _in(0x523F11FD, multiplier)
end

function SetSpritesDrawBeforeFade(set)
	return _in(0x615959BA, set)
end

function SetStartFromFilterMenu(Unk996)
	return _in(0x3F6B5975, Unk996)
end

function SetStatFrontendAlwaysVisible(set)
	return _in(0x656F1A7A, set)
end

function SetStatFrontendDisplayType(stat, type)
	return _in(0x10436A86, stat, type)
end

function SetStatFrontendNeverVisible(stat)
	return _in(0x3A6B0308, stat)
end

function SetStatFrontendVisibility(stat, set)
	return _in(0x45D23711, stat, set)
end

function SetStatFrontendVisibleAfterIncremented(stat)
	return _in(0x12D67ADA, stat)
end

function SetStateOfClosestDoorOfType(model, x, y, z, state, Unk601)
	return _in(0x10974B70, model, x, y, z, state, Unk601)
end

function SetStreamParams(rolloff, UnkTime)
	return _in(0x16CB4F86, rolloff, UnkTime)
end

function SetStreamingRequestListTime(time)
	return _in(0x01FF6618, time)
end

function SetSuppressHeadlightSwitch(set)
	return _in(0x43EF56EE, set)
end

function SetSwimSpeed(ped, speed)
	return _in(0x32B4293B, ped, speed)
end

function SetSyncWeatherAndGameTime(Unk997)
	return _in(0x51112E95, Unk997)
end

function SetTargetCarForMissionGarage(garage, car)
	return _in(0x6EF667A4, garage, car)
end

function SetTaxiGarageRadioState(radiostate)
	return _in(0x299C5EBC, radiostate)
end

function SetTaxiLights(car, set)
	return _in(0x460837F9, car, set)
end

function SetTeamColour()
	return _in(0x22780707, _r)
end

function SetTelescopeCamAngleLimits(Unk583, Unk584, Unk585, Unk586, Unk587, Unk588)
	return _in(0x6680196B, Unk583, Unk584, Unk585, Unk586, Unk587, Unk588)
end

function SetTextBackground(value)
	return _in(0x768F5140, value)
end

function SetTextCentre(value)
	return _in(0x204A6AA4, value)
end

function SetTextCentreWrapx(wrapx)
	return _in(0x716308C6, wrapx)
end

function SetTextColour(r, g, b, a)
	return _in(0x19C967B5, r, g, b, a)
end

function SetTextDrawBeforeFade(value)
	return _in(0x6CFD0610, value)
end

function SetTextDropshadow(displayShadow, r, g, b, a)
	return _in(0x58F5023F, displayShadow, r, g, b, a)
end

function SetTextEdge(displayEdge, r, g, b, a)
	return _in(0x2D7A725D, displayEdge, r, g, b, a)
end

function SetTextFont(font)
	return _in(0x75363BB5, font)
end

function SetTextInputActive(set)
	return _in(0x2A28684C, set)
end

function SetTextJustify(value)
	return _in(0x049D23F9, value)
end

function SetTextLineDisplay(unk1, unk2)
	return _in(0x1F6A54B6, unk1, unk2)
end

function SetTextLineHeightMult(lineHeight)
	return _in(0x5BF53817, lineHeight)
end

function SetTextProportional(value)
	return _in(0x15585A65, value)
end

function SetTextRenderId(renderId)
	return _in(0x2B1B0290, renderId)
end

function SetTextRightJustify(value)
	return _in(0x748B78B6, value)
end

function SetTextScale(w, h)
	return _in(0x02C069E5, w, h)
end

function SetTextToUseTextFileColours(value)
	return _in(0x52CE650B, value)
end

function SetTextUseUnderscore(value)
	return _in(0x0AD54D75, value)
end

function SetTextViewportId(id)
	return _in(0x3F9B2DD6, id)
end

function SetTextWrap(unk1, unk2)
	return _in(0x19D006EB, unk1, unk2)
end

function SetThisMachineRunningServerScript(host)
	return _in(0x382A19BE, host)
end

function SetThisScriptCanRemoveBlipsCreatedByAnyScript(allow)
	return _in(0x29D64E72, allow)
end

function SetTimeCycleFarClipDisabled(set)
	return _in(0x13C75E16, set)
end

function SetTimeOfDay(hour, minute)
	return _in(0x52100540, hour, minute)
end

function SetTimeOfNextAppointment(time)
	return _in(0x0A7D3AF9, time)
end

function SetTimeOneDayBack()
	return _in(0x18136217)
end

function SetTimeOneDayForward()
	return _in(0x79CF27AC)
end

function SetTimeScale(scale)
	return _in(0x24D467CC, scale)
end

function SetTimecycleModifier(name)
	return _in(0x3C997E4C, _ts(name))
end

function SetTimerBeepCountdownTime(timerid, beeptime)
	return _in(0x66B93E8C, timerid, beeptime)
end

function SetTotalNumberOfMissions(floatstatval)
	return _in(0x09DE74E5, floatstatval)
end

function SetTrainAudioRolloff(train, rolloff)
	return _in(0x01C21158, train, rolloff)
end

function SetTrainCruiseSpeed(train, speed)
	return _in(0x02E93A3E, train, speed)
end

function SetTrainForcedToSlowDown(train, set)
	return _in(0x475267B0, train, set)
end

function SetTrainIsStoppedAtStation(train)
	return _in(0x270C7AB3, train)
end

function SetTrainSpeed(train, speed)
	return _in(0x3F4950AC, train, speed)
end

function SetTrainStopsForStations(train, set)
	return _in(0x5D154995, train, set)
end

function SetUpsidedownCarNotDamaged(car, set)
	return _in(0x353317C7, car, set)
end

function SetUpTripSkipAfterMission()
	return _in(0x6C3D04C3, _r)
end

function SetUpTripSkipForSpecificVehicle(Unk1, Unk2, Unk3, Unk4, veh)
	return _in(0x65A428F2, Unk1, Unk2, Unk3, Unk4, veh)
end

function SetUpTripSkipForVehicleFinishedByScript()
	return _in(0x4D5068A6, _r)
end

function SetUpTripSkipToBeFinishedByScript()
	return _in(0x5CEB0360, _r)
end

function SetUseHighdof(set)
	return _in(0x4A1D15D5, set)
end

function SetUseLegIk(player, set)
	return _in(0x4F705478, player, set)
end

function SetUsePoolGamePhysicsSettings(set)
	return _in(0x5C162D0D, set)
end

function SetUsesCollisionOfClosestObjectOfType(x, y, z, radius, type_or_model, flag)
	return _in(0x07BC4223, x, y, z, radius, type_or_model, flag)
end

function SetVariableOnSound(sound, varname, value)
	return _in(0x39200B83, sound, _ts(varname), value)
end

function SetVehAlarm(veh, set)
	return _in(0x0CF76EE0, veh, set)
end

function SetVehAlarmDuration(veh, duration)
	return _in(0x5FFE33EC, veh, duration)
end

function SetVehHasStrongAxles(veh, set)
	return _in(0x63DE7A05, veh, set)
end

function SetVehHazardlights(vehicle, on)
	return _in(0x24B42ED2, vehicle, on)
end

function SetVehIndicatorlights(veh, set)
	return _in(0x71D72486, veh, set)
end

function SetVehInteriorlight(veh, set)
	return _in(0x49EA22C8, veh, set)
end

function SetVehicleAlpha(veh, alpha)
	return _in(0x0C4B7DD3, veh, alpha)
end

function SetVehicleAlwaysRender(veh)
	return _in(0x4A4B0F18, veh)
end

function SetVehicleCanBeTargetted(veh, set)
	return _in(0x2B9B35C3, veh, set)
end

function SetVehicleDeformationMult(veh, multiplier)
	return _in(0x7B65266B, veh, multiplier)
end

function SetVehicleDirtLevel(vehicle, intensity)
	return _in(0x02A57428, vehicle, intensity)
end

function SetVehicleExplodesOnHighExplosionDamage(veh, set)
	return _in(0x7B4A7CD6, veh, set)
end

function SetVehicleIsConsideredByPlayer(veh, set)
	return _in(0x720673D9, veh, set)
end

function SetVehicleQuaternion(veh, qx, qy, qz, qw)
	return _in(0x43573596, veh, qx, qy, qz, qw)
end

function SetVehicleRenderScorched(veh, set)
	return _in(0x07205796, veh, set)
end

function SetVehicleSteerBias(veh, val)
	return _in(0x091D1480, veh, val)
end

function SetViewport(viewportid, Unk589, Unk590, Unk591, Unk592)
	return _in(0x0EE87310, viewportid, Unk589, Unk590, Unk591, Unk592)
end

function SetViewportDestination(viewportid, x, y, z, Unk593, Unk594, Unk595)
	return _in(0x1C810358, viewportid, x, y, z, Unk593, Unk594, Unk595)
end

function SetViewportMirrored(viewportid, set)
	return _in(0x61784349, viewportid, set)
end

function SetViewportPriority(viewportid, priority)
	return _in(0x5DA1752F, viewportid, priority)
end

function SetViewportShape(cam, shape)
	return _in(0x43ED66E3, cam, shape)
end

function SetVisibilityOfClosestObjectOfType(x, y, z, radius, type_or_model, set)
	return _in(0x20A04BEE, x, y, z, radius, type_or_model, set)
end

function SetVisibilityOfNearbyEntityWithSpecialAttribute(attribute, set)
	return _in(0x6DDD201D, attribute, set)
end

function SetVoiceIdFromHeadComponent(ped, VoiceId, IsMale)
	return _in(0x02794E6B, ped, VoiceId, IsMale)
end

function SetWantedMultiplier(multiplier)
	return _in(0x51E14C1B, multiplier)
end

function SetWeaponPickupNetworkRegenTime(weaponType, timeMS)
	return _in(0x40D01439, weaponType, timeMS)
end

function SetWebPageLinkActive(htmlviewport, linkid, active)
	return _in(0x5F5E7F39, htmlviewport, linkid, active)
end

function SetWebPageScroll(htmlviewport, scroll)
	return _in(0x55DE40EE, htmlviewport, scroll)
end

function SetWidescreenBorders(set)
	return _in(0x06C71148, set)
end

function SetWidescreenFormat(wideformatid)
	return _in(0x7BDE2CAF, wideformatid)
end

function SetZoneNoCops(name, set)
	return _in(0x64F37F05, _ts(name), set)
end

function SetZonePopulationType(zone, poptype)
	return _in(0x70582D53, _ts(zone), poptype)
end

function SetZoneScumminess(zone, scumminess)
	return _in(0x5E5E4252, _ts(zone), scumminess)
end

function Settimera(value)
	return _in(0x32501B1E, value)
end

function Settimerb(value)
	return _in(0x3B4C2E2E, value)
end

function Settimerc(Unk1088)
	return _in(0x499852DB, Unk1088)
end

function ShakePad(Unk838, Unk839, Unk840)
	return _in(0x66CC16BD, Unk838, Unk839, Unk840)
end

function ShakePadInCutscene(Unk841, Unk842, Unk843)
	return _in(0x2D040DA9, Unk841, Unk842, Unk843)
end

function ShakePlayerpadWhenControllerDisabled()
	return _in(0x691970FD)
end

function ShiftLeft(val, shifts)
	return _in(0x102A0A6C, val, shifts, _ri)
end

function ShiftRight(val, shifts)
	return _in(0x64DD173C, val, shifts, _ri)
end

function ShowBlipOnAltimeter(blip, show)
	return _in(0x1DD86C2A, blip, show)
end

function ShowSigninUi()
	return _in(0x72397ECD)
end

function ShowUpdateStats(show)
	return _in(0x59486829, show)
end

function ShutCarDoor(vehicle, door)
	return _in(0x5E7A620E, vehicle, door)
end

function ShutdownAndLaunchNetworkGame(episode)
	return _in(0x1BC5050E, episode)
end

function ShutdownAndLaunchSinglePlayerGame()
	return _in(0x49FD2621)
end

function SimulateUpdateLoadScene()
	return _in(0x246D47CE)
end

function Sin(value)
	return _in(0x1EC10CE1, value, _rf)
end

function SkipInPlaybackRecordedCar(car, time)
	return _in(0x2C8C61BA, car, time)
end

function SkipRadioForward()
	return _in(0x12A86E89)
end

function SkipTimeInPlaybackRecordedCar(CarRec, time)
	return _in(0x255059BB, CarRec, time)
end

function SkipToEndAndStopPlaybackRecordedCar(car)
	return _in(0x0D192F80, car)
end

function SkipToNextAllowedStation(train)
	return _in(0x653B5374, train)
end

function SkipToNextScriptedConversationLine()
	return _in(0x294C35B0)
end

function SlideObject(obj, x, y, z, xs, ys, zs, flag)
	return _in(0x11B76EDF, obj, x, y, z, xs, ys, zs, flag, _r)
end

function SmashCarWindow(car, windownum)
	return _in(0x2CDF628C, car, windownum)
end

function SmashGlassOnObject(x, y, z, Unk75, model, Unk76)
	return _in(0x2F877E8A, x, y, z, Unk75, model, Unk76, _r)
end

function SnapshotCam(cam, Unk596)
	return _in(0x34BF456A, cam, Unk596)
end

function SoundCarHorn(vehicle, duration)
	return _in(0x024859B5, vehicle, duration)
end

function SpecifyScriptPopulationZoneArea(Unk848, Unk849, Unk850, Unk851, Unk852, Unk853)
	return _in(0x5A07394A, Unk848, Unk849, Unk850, Unk851, Unk852, Unk853)
end

function SpecifyScriptPopulationZoneGroups(Unk854, Unk855, Unk856, Unk857, Unk858)
	return _in(0x70F0538F, Unk854, Unk855, Unk856, Unk857, Unk858)
end

function SpecifyScriptPopulationZoneNumCars(num)
	return _in(0x1B886584, num)
end

function SpecifyScriptPopulationZoneNumParkedCars(num)
	return _in(0x2EB751CC, num)
end

function SpecifyScriptPopulationZoneNumPeds(num)
	return _in(0x159A4ED4, num)
end

function SpecifyScriptPopulationZoneNumScenarioPeds(num)
	return _in(0x6A733E6C, num)
end

function SpecifyScriptPopulationZonePercentageCops(percentage)
	return _in(0x49FF799A, percentage)
end

function SpotCheck5()
	return _in(0x6B4D6FC6, _r)
end

function SpotCheck6()
	return _in(0x52277FB2, _r)
end

function SpotCheck7()
	return _in(0x46CC31B4, _r)
end

function SpotCheck8()
	return _in(0x7B1B14BD, _r)
end

function Sqrt(value)
	return _in(0x2C297C5D, value, _rf)
end

function StartCarFire(vehicle)
	return _in(0x3D703ED7, vehicle, _ri)
end

function StartCharFire(ped)
	return _in(0x5FB31295, ped, _ri)
end

function StartCredits()
	return _in(0x7F3222FD)
end

function StartCustomMobilePhoneRinging(RingtoneId)
	return _in(0x59406EB1, RingtoneId)
end

function StartCutscene()
	return _in(0x5F752F19)
end

function StartCutsceneNow(name)
	return _in(0x53591DD7, _ts(name))
end

function StartEndCreditsMusic()
	return _in(0x587E55D3)
end

function StartFiringAmnesty()
	return _in(0x5DB83661)
end

function StartGpsRaceTrack(trackid)
	return _in(0x422C1818, trackid)
end

function StartKillFrenzy(gxtname, Unk512, Unk513, Unk514, Unk515, Unk516, Unk517, Unk518, Unk519)
	return _in(0x077B17B5, _ts(gxtname), Unk512, Unk513, Unk514, Unk515, Unk516, Unk517, Unk518, Unk519)
end

function StartKillTracking()
	return _in(0xEF143D, _r)
end

function StartLoadScene(x, y, z)
	return _in(0x54320B58, x, y, z)
end

function StartMobilePhoneCall(callfrom, callfromvoice, callto, calltovoice, flag0, flag1)
	return _in(0x7939764F, callfrom, _ts(callfromvoice), callto, _ts(calltovoice), flag0, flag1)
end

function StartMobilePhoneCalling()
	return _in(0x67114B98)
end

function StartMobilePhoneRinging()
	return _in(0x372C0DF1)
end

function StartNewScript(scriptName, stacksize)
	return _in(0x4E2260B9, _ts(scriptName), stacksize, _ri)
end

function StartNewScriptWithArgs(scriptname, paramcount, stacksize)
	return _in(0x706707E6, _ts(scriptname), _i, paramcount, stacksize, _ri)
end

function StartNewWidgetCombo()
	return _in(0x03893A3A)
end

function StartObjectFire(obj)
	return _in(0x2D7D5DD2, obj, _ri)
end

function StartPedMobileRinging(ped, Unk801)
	return _in(0x79A12A52, ped, Unk801)
end

function StartPlaybackRecordedCar(car, CarRec)
	return _in(0x53335A45, car, CarRec)
end

function StartPlaybackRecordedCarLooped(car, Unk69)
	return _in(0x01E33E33, car, Unk69)
end

function StartPlaybackRecordedCarUsingAi(car, CarRec)
	return _in(0x5D900560, car, CarRec)
end

function StartPlaybackRecordedCarWithOffset(car, CarRec, x, y, z)
	return _in(0x02491769, car, CarRec, x, y, z)
end

function StartProfileTimer()
	return _in(0x78EE47F9, _r)
end

function StartPtfx(name, x, y, z, yaw, pitch, roll, scale)
	return _in(0x3A774777, _ts(name), x, y, z, yaw, pitch, roll, scale, _ri)
end

function StartPtfxOnObj(name, obj, x, y, z, yaw, pitch, roll, scale)
	return _in(0x0D8407E9, _ts(name), obj, x, y, z, yaw, pitch, roll, scale, _ri)
end

function StartPtfxOnObjBone(name, obj, x, y, z, yaw, pitch, roll, objbone, scale)
	return _in(0x60980323, _ts(name), obj, x, y, z, yaw, pitch, roll, objbone, scale, _ri)
end

function StartPtfxOnPed(name, ped, x, y, z, yaw, pitch, roll, scale)
	return _in(0x381C1F1C, _ts(name), ped, x, y, z, yaw, pitch, roll, scale, _ri)
end

function StartPtfxOnPedBone(name, ped, x, y, z, yaw, pitch, roll, pedbone, scale)
	return _in(0x2209116C, _ts(name), ped, x, y, z, yaw, pitch, roll, pedbone, scale, _ri)
end

function StartPtfxOnVeh(name, veh, x, y, z, yaw, pitch, roll, scale)
	return _in(0x5C4B1A8A, _ts(name), veh, x, y, z, yaw, pitch, roll, scale, _ri)
end

function StartScriptConversation(flag0, flag1)
	return _in(0x288E50A3, flag0, flag1)
end

function StartScriptFire(x, y, z, numGenerationsAllowed, strength)
	return _in(0x24742BB9, x, y, z, numGenerationsAllowed, strength, _ri)
end

function StartStreamingRequestList(name)
	return _in(0x7858750E, _ts(name))
end

function StopCarBreaking(car, stop)
	return _in(0x29305D67, car, stop)
end

function StopCredits()
	return _in(0x4F0F2AA8)
end

function StopCutscene()
	return _in(0x50FF1428)
end

function StopEndCreditsMusic()
	return _in(0x47E93CB8)
end

function StopKillTracking()
	return _in(0x28CA0AFE, _r)
end

function StopMobilePhoneRinging()
	return _in(0x27356F3A)
end

function StopMovie()
	return _in(0x2E6F4C82)
end

function StopPedDoingFallOffTestsWhenShot(ped)
	return _in(0x4E386C7B, ped)
end

function StopPedMobileRinging(ped)
	return _in(0x07827AE1, ped)
end

function StopPedSpeaking(ped, stopspeaking)
	return _in(0x710B2BD3, ped, stopspeaking)
end

function StopPedWeaponFiringWhenDropped(ped)
	return _in(0x6E0026EF, ped)
end

function StopPlaybackRecordedCar(car)
	return _in(0x71C91921, car)
end

function StopPreviewRingtone()
	return _in(0x5B1D57EF)
end

function StopProfileTimer()
	return _in(0x1C5C19E8, _r)
end

function StopPtfx(ptfx)
	return _in(0x0EAA4429, ptfx)
end

function StopSound(sound)
	return _in(0x09DB00B9, sound)
end

function StopStream()
	return _in(0x66915CE9)
end

function StopSyncingScriptAnimations(Unk1061)
	return _in(0x47F430BE, Unk1061)
end

function StopVehicleAlwaysRender(veh)
	return _in(0x7CDD7B0E, veh)
end

function StoreCarCharIsInNoSave(ped, car)
	return _in(0x21CC647F, ped, _ii(car))
end

function StoreDamageTrackerForNetworkPlayer(playerIndex, ukn57, Unk895)
	return _in(0x68373878, playerIndex, ukn57, Unk895, _ri)
end

function StoreScore(playerIndex, value)
	return _in(0x1E203014, playerIndex, _ii(value))
end

function StoreScriptValuesForNetworkGame(Unk998)
	return _in(0x1DFF5B06, Unk998)
end

function StoreWantedLevel(playerIndex, value)
	return _in(0x12AA6D71, playerIndex, _ii(value))
end

function StreamCutscene()
	return _in(0x0F0D2025)
end

function StringDifference(str0, str1)
	return _in(0x25204F8B, _ts(str0), _ts(str1), _ri)
end

function StringString(str0, str1)
	return _in(0x6C0E191F, _ts(str0), _ts(str1), _ri)
end

function StringToInt(str, intval)
	return _in(0x5C3248B5, _ts(str), _ii(intval), _r)
end

function SuppressCarModel(model)
	return _in(0x768F640F, model)
end

function SuppressFadeInAfterDeathArrest(set)
	return _in(0x3FB83379, set)
end

function SuppressPedModel(model)
	return _in(0x4C5475E3, model)
end

function SwapNearestBuildingModel(x, y, z, radius, modelfrom, modelto)
	return _in(0x5E077484, x, y, z, radius, modelfrom, modelto)
end

function SwitchAmbientPlanes(on)
	return _in(0x4E637988, on)
end

function SwitchArrowAboveBlippedPickups(on)
	return _in(0x3A323C67, on)
end

function SwitchCarGenerator(handle, type)
	return _in(0x7CE83A30, handle, type)
end

function SwitchCarSiren(car, siren)
	return _in(0x7781290F, car, siren)
end

function SwitchGarbageTrucks(on)
	return _in(0x060669FE, on)
end

function SwitchMadDrivers(on)
	return _in(0x34CB6291, on)
end

function SwitchObjectBrains(brain, switchstate)
	return _in(0x35213375, brain, switchstate)
end

function SwitchOffWaypoint()
	return _in(0x1B5B4ED9)
end

function SwitchPedPathsOff(x0, y0, z0, x1, y1, z1)
	return _in(0x008A2256, x0, y0, z0, x1, y1, z1)
end

function SwitchPedPathsOn(x0, y0, z0, x1, y1, z1)
	return _in(0x67D908DF, x0, y0, z0, x1, y1, z1)
end

function SwitchPedRoadsBackToOriginal(x0, y0, z0, x1, y1, z1)
	return _in(0x6AA20B7E, x0, y0, z0, x1, y1, z1)
end

function SwitchPedToAnimated(ped, unknownTrue)
	return _in(0x762301C8, ped, unknownTrue)
end

function SwitchPedToRagdoll(ped, Unk14, time, flag0, flag1, flag2, flag3)
	return _in(0x1A0F56C5, ped, Unk14, time, flag0, flag1, flag2, flag3, _r)
end

function SwitchPedToRagdollWithFall(ped, Unk15, Unk16, Unk17, Unk18, Unk19, Unk20, Unk21, Unk22, Unk23, Unk24, Unk25, Unk26, Unk27)
	return _in(0x13E4042D, ped, Unk15, Unk16, Unk17, Unk18, Unk19, Unk20, Unk21, Unk22, Unk23, Unk24, Unk25, Unk26, Unk27, _r)
end

function SwitchPoliceHelis(set)
	return _in(0x0CA46B08, set)
end

function SwitchRandomBoats(on)
	return _in(0x7FC65855, on)
end

function SwitchRandomTrains(on)
	return _in(0x0FFD1A92, on)
end

function SwitchRoadsBackToOriginal(x0, y0, z0, x1, y1, z1)
	return _in(0x6251618F, x0, y0, z0, x1, y1, z1)
end

function SwitchRoadsOff(x0, y0, z0, x1, y1, z1)
	return _in(0x4C3C1F3C, x0, y0, z0, x1, y1, z1)
end

function SwitchRoadsOn(x0, y0, z0, x1, y1, z1)
	return _in(0x56553F38, x0, y0, z0, x1, y1, z1)
end

function SwitchStreaming(on)
	return _in(0x6E397D96, on)
end

function SynchAmbientPlanes(Unk520, Unk521)
	return _in(0x5AFD2049, Unk520, Unk521)
end

function SynchRecordingWithWater()
	return _in(0x018A0EE0, _r)
end

function TakeCarOutOfParkedCarsBudget(car, out)
	return _in(0x60EF0519, car, out)
end

function TakeRemoteControlOfCar()
	return _in(0x5DEA7140, _r)
end

function TakeScreenShot()
	return _in(0x76BB510A, _r)
end

function Tan(value)
	return _in(0x24CC682B, value, _rf)
end

function TaskAchieveHeading(ped, heading)
	return _in(0x6D6A1261, ped, heading)
end

function TaskAimGunAtChar(ped, targetPed, duration)
	return _in(0x4437501B, ped, targetPed, duration)
end

function TaskAimGunAtCoord(ped, tX, tY, tZ, duration)
	return _in(0x0AA202B0, ped, tX, tY, tZ, duration)
end

function TaskCarDriveToCoord(ped, veh, Unk133, Unk134, Unk135, Unk136, Unk137, Unk138, Unk139, Unk140, Unk141)
	return _in(0x69715285, ped, veh, Unk133, Unk134, Unk135, Unk136, Unk137, Unk138, Unk139, Unk140, Unk141)
end

function TaskCarDriveToCoordNotAgainstTraffic(ped, Unk142, Unk143, Unk144, Unk145, Unk146, Unk147, Unk148, Unk149, Unk150, Unk151)
	return _in(0x483A62AB, ped, Unk142, Unk143, Unk144, Unk145, Unk146, Unk147, Unk148, Unk149, Unk150, Unk151)
end

function TaskCarDriveWander(ped, vehicle, speed, drivingStyle)
	return _in(0x1E9635A9, ped, vehicle, speed, drivingStyle)
end

function TaskCarMission(ped, vehicle, targetEntity, missionType, speed, drivingStyle, unknown6_10, unknown7_5)
	return _in(0x36273536, ped, vehicle, targetEntity, missionType, speed, drivingStyle, unknown6_10, unknown7_5)
end

function TaskCarMissionCoorsTarget(ped, vehicle, x, y, z, unknown0_4, speed, unknown2_1, unknown3_5, unknown4_10)
	return _in(0x36D51DDF, ped, vehicle, x, y, z, unknown0_4, speed, unknown2_1, unknown3_5, unknown4_10)
end

function TaskCarMissionCoorsTargetNotAgainstTraffic(ped, vehicle, x, y, z, unknown0_4, speed, unknown2_1, unknown3_5, unknown4_10)
	return _in(0x3CB4693B, ped, vehicle, x, y, z, unknown0_4, speed, unknown2_1, unknown3_5, unknown4_10)
end

function TaskCarMissionNotAgainstTraffic(ped, vehicle, targetEntity, missionType, speed, drivingStyle, unknown6_10, unknown7_5)
	return _in(0x3BE7444A, ped, vehicle, targetEntity, missionType, speed, drivingStyle, unknown6_10, unknown7_5)
end

function TaskCarMissionPedTarget(ped, vehicle, target, unknown0_4, speed, unknown2_1, unknown3_5, unknown4_10)
	return _in(0x39C2663E, ped, vehicle, target, unknown0_4, speed, unknown2_1, unknown3_5, unknown4_10)
end

function TaskCarMissionPedTargetNotAgainstTraffic(ped, Unk152, Unk153, Unk154, Unk155, Unk156, Unk157, Unk158)
	return _in(0x178332FF, ped, Unk152, Unk153, Unk154, Unk155, Unk156, Unk157, Unk158)
end

function TaskCarTempAction(ped, vehicle, action, duration)
	return _in(0x11612815, ped, vehicle, action, duration)
end

function TaskCharArrestChar(ped0, ped1)
	return _in(0x71A05FF1, ped0, ped1)
end

function TaskCharSlideToCoord(ped, Unk159, Unk160, Unk161, Unk162, Unk163)
	return _in(0x04962F82, ped, Unk159, Unk160, Unk161, Unk162, Unk163)
end

function TaskCharSlideToCoordAndPlayAnim(ped, Unk164, Unk165, Unk166, Unk167, Unk168, Unk169, Unk170, Unk171, Unk172, Unk173, Unk174, Unk175, Unk176)
	return _in(0x79BB1D64, ped, Unk164, Unk165, Unk166, Unk167, Unk168, Unk169, Unk170, Unk171, Unk172, Unk173, Unk174, Unk175, Unk176)
end

function TaskCharSlideToCoordAndPlayAnimHdgRate()
	return _in(0x4E069A8, _r)
end

function TaskCharSlideToCoordHdgRate(ped, Unk177, Unk178, Unk179, Unk180, Unk181, Unk182)
	return _in(0x33D756A0, ped, Unk177, Unk178, Unk179, Unk180, Unk181, Unk182)
end

function TaskChatWithChar(ped, pednext, Unk183, Unk184)
	return _in(0x5C9807CA, ped, pednext, Unk183, Unk184)
end

function TaskClearLookAt(ped)
	return _in(0x05745ACA, ped)
end

function TaskClimb(ped, Unk185)
	return _in(0x4678769C, ped, Unk185)
end

function TaskClimbLadder(ped, Unk186)
	return _in(0x0ABE3FA8, ped, Unk186)
end

function TaskCombat(ped, target)
	return _in(0x1F157FD3, ped, target)
end

function TaskCombatHatedTargetsAroundChar(ped, radius)
	return _in(0x127669D3, ped, radius)
end

function TaskCombatHatedTargetsAroundCharTimed(ped, radius, duration)
	return _in(0x15012850, ped, radius, duration)
end

function TaskCombatHatedTargetsInArea(ped, Unk187, Unk188, Unk189, Unk190)
	return _in(0x06B840F1, ped, Unk187, Unk188, Unk189, Unk190)
end

function TaskCombatRoll(ped, Unk191)
	return _in(0x131A0C84, ped, Unk191)
end

function TaskCombatTimed(ped, target, duration)
	return _in(0x56F04A05, ped, target, duration)
end

function TaskCower(ped)
	return _in(0x29103E08, ped)
end

function TaskDead(ped)
	return _in(0x3E1051E0, ped)
end

function TaskDestroyCar(ped, car)
	return _in(0x787A3D4C, ped, car)
end

function TaskDie(ped)
	return _in(0x7EED364B, ped)
end

function TaskDriveBy(ped, pednext, Unk192, x, y, z, angle, Unk193, Unk194, Unk195)
	return _in(0x3FB22EE2, ped, pednext, Unk192, x, y, z, angle, Unk193, Unk194, Unk195)
end

function TaskDrivePointRoute(ped, point, radius)
	return _in(0x2C18736E, ped, point, radius)
end

function TaskDrivePointRouteAdvanced(ped, Unk197, Unk198, Unk199, Unk200, Unk201)
	return _in(0x7A0A1063, ped, Unk197, Unk198, Unk199, Unk200, Unk201)
end

function TaskDuck(ped, Unk202)
	return _in(0x72BF79F1, ped, Unk202)
end

function TaskEnterCarAsDriver(ped, vehicle, duration)
	return _in(0x5BF03315, ped, vehicle, duration)
end

function TaskEnterCarAsPassenger(ped, vehicle, duration, seatIndex)
	return _in(0x0A2C70AF, ped, vehicle, duration, seatIndex)
end

function TaskEveryoneLeaveCar(vehicle)
	return _in(0x41E45BE5, vehicle)
end

function TaskExtendRoute(ped, Unk203, Unk204)
	return _in(0x75353EA4, ped, Unk203, Unk204)
end

function TaskFallAndGetUp(ped, Unk205, Unk206)
	return _in(0x069433A8, ped, Unk205, Unk206)
end

function TaskFleeCharAnyMeans(ped, Unk207, Unk208, Unk209, Unk210, Unk211, Unk212, Unk213)
	return _in(0x32517AE2, ped, Unk207, Unk208, Unk209, Unk210, Unk211, Unk212, Unk213)
end

function TaskFlushRoute()
	return _in(0x760E0A0F)
end

function TaskFollowFootsteps(ped, Unk214)
	return _in(0x45DF7CCA, ped, Unk214)
end

function TaskFollowNavMeshAndSlideToCoord(ped, x, y, z, Unk215, Unk216, Unk217, angle)
	return _in(0x36537CE1, ped, x, y, z, Unk215, Unk216, Unk217, angle)
end

function TaskFollowNavMeshAndSlideToCoordHdgRate(ped, x, y, z, Unk218, Unk219, Unk220, angle, rate)
	return _in(0x38824BFE, ped, x, y, z, Unk218, Unk219, Unk220, angle, rate)
end

function TaskFollowNavMeshToCoord(ped, x, y, z, unknown0_2, unknown1_minus1, unknown2_1)
	return _in(0x1B31390E, ped, x, y, z, unknown0_2, unknown1_minus1, unknown2_1)
end

function TaskFollowNavMeshToCoordNoStop(ped, x, y, z, unknown0_2, unknown1_minus1, unknown2_1)
	return _in(0x1BF67441, ped, x, y, z, unknown0_2, unknown1_minus1, unknown2_1)
end

function TaskFollowPatrolRoute()
	return _in(0x72F02B67, _r)
end

function TaskFollowPointRoute(ped, Unk1, Unk2)
	return _in(0x1C430F41, ped, Unk1, Unk2)
end

function TaskGetOffBoat(ped, timeout)
	return _in(0x6C63251D, ped, timeout)
end

function TaskGoStraightToCoord(ped, x, y, z, unknown2, unknown45000)
	return _in(0x19591255, ped, x, y, z, unknown2, unknown45000)
end

function TaskGoStraightToCoordRelativeToCar(ped, Unk227, Unk228, Unk229, Unk230, Unk231, Unk232)
	return _in(0x498B3BE4, ped, Unk227, Unk228, Unk229, Unk230, Unk231, Unk232)
end

function TaskGoToChar(ped, Unk233, Unk234, Unk235)
	return _in(0x664D06FF, ped, Unk233, Unk234, Unk235)
end

function TaskGoToCoordAnyMeans(ped, Unk236, Unk237, Unk238, Unk239, Unk240)
	return _in(0x04F72E4C, ped, Unk236, Unk237, Unk238, Unk239, Unk240)
end

function TaskGoToCoordWhileAiming(ped, Unk241, Unk242, Unk243, Unk244, Unk245, Unk246, Unk247, Unk248, Unk249, Unk250, Unk251)
	return _in(0x2A2959DA, ped, Unk241, Unk242, Unk243, Unk244, Unk245, Unk246, Unk247, Unk248, Unk249, Unk250, Unk251)
end

function TaskGoToCoordWhileShooting(ped, Unk252, Unk253, Unk254, Unk255, Unk256, Unk257, Unk258, Unk259)
	return _in(0x10CB1413, ped, Unk252, Unk253, Unk254, Unk255, Unk256, Unk257, Unk258, Unk259)
end

function TaskGoToObject(ped, Unk260, Unk261, Unk262)
	return _in(0x5B1B2699, ped, Unk260, Unk261, Unk262)
end

function TaskGotoCar(ped, Unk221, Unk222, Unk223)
	return _in(0x3EA116F7, ped, Unk221, Unk222, Unk223)
end

function TaskGotoCharAiming(ped, Unk224, Unk225, Unk226)
	return _in(0x65EB71CC, ped, Unk224, Unk225, Unk226)
end

function TaskGotoCharOffset(ped, target, duration, offsetRight, offsetFront)
	return _in(0x658028BA, ped, target, duration, offsetRight, offsetFront)
end

function TaskGuardAngledDefensiveArea(ped, Unk263, Unk264, Unk265, Unk266, Unk267, Unk268, Unk269, Unk270, Unk271, Unk272, Unk273, Unk274, Unk275)
	return _in(0x030E0224, ped, Unk263, Unk264, Unk265, Unk266, Unk267, Unk268, Unk269, Unk270, Unk271, Unk272, Unk273, Unk274, Unk275)
end

function TaskGuardAssignedDefensiveArea(ped, Unk276, Unk277, Unk278, Unk279, Unk280, Unk281)
	return _in(0x07E21C28, ped, Unk276, Unk277, Unk278, Unk279, Unk280, Unk281)
end

function TaskGuardCurrentPosition(ped, unknown0_15, unknown1_10, unknown2_1)
	return _in(0x3E6137CB, ped, unknown0_15, unknown1_10, unknown2_1)
end

function TaskGuardSphereDefensiveArea(ped, Unk282, Unk283, Unk284, Unk285, Unk286, Unk287, Unk288, Unk289, Unk290, Unk291)
	return _in(0x01795753, ped, Unk282, Unk283, Unk284, Unk285, Unk286, Unk287, Unk288, Unk289, Unk290, Unk291)
end

function TaskHandsUp(ped, duration)
	return _in(0x68232D31, ped, duration)
end

function TaskHeliMission(ped, heli, uk0_0, uk1_0, pX, pY, pZ, uk2_4, speed, uk3_5, uk4_minus1, uk5_round_z_plus_1, uk6_40)
	return _in(0x0F227D5A, ped, heli, uk0_0, uk1_0, pX, pY, pZ, uk2_4, speed, uk3_5, uk4_minus1, uk5_round_z_plus_1, uk6_40)
end

function TaskJetpack()
	return _in(0x690233B1, _r)
end

function TaskJump(ped, flag)
	return _in(0x5E97106E, ped, flag)
end

function TaskLeaveAnyCar(ped)
	return _in(0x1114089D, ped)
end

function TaskLeaveCar(ped, vehicle)
	return _in(0x6B85214E, ped, vehicle)
end

function TaskLeaveCarAndFlee(ped, Unk292, Unk293, Unk294, Unk295)
	return _in(0x6CEA50D8, ped, Unk292, Unk293, Unk294, Unk295)
end

function TaskLeaveCarDontCloseDoor(ped, vehicle)
	return _in(0x1C9A376D, ped, vehicle)
end

function TaskLeaveCarImmediately(ped, vehicle)
	return _in(0x7BFB484F, ped, vehicle)
end

function TaskLeaveCarInDirection(ped, car, direction)
	return _in(0x18740B3D, ped, car, direction)
end

function TaskLeaveGroup(ped)
	return _in(0x1905109F, ped)
end

function TaskLookAtChar(ped, targetPed, duration, unknown_0)
	return _in(0x2DD35B3F, ped, targetPed, duration, unknown_0)
end

function TaskLookAtCoord(ped, x, y, z, duration, unknown_0)
	return _in(0x26E27605, ped, x, y, z, duration, unknown_0)
end

function TaskLookAtObject(ped, targetObject, duration, unknown_0)
	return _in(0x27C740D0, ped, targetObject, duration, unknown_0)
end

function TaskLookAtVehicle(ped, targetVehicle, duration, unknown_0)
	return _in(0x4A2C5544, ped, targetVehicle, duration, unknown_0)
end

function TaskMobileConversation(ped, Unk296)
	return _in(0x64903364, ped, Unk296)
end

function TaskOpenDriverDoor(ped, vehicle, unknown0)
	return _in(0x1FA41244, ped, vehicle, unknown0)
end

function TaskOpenPassengerDoor(ped, vehicle, seatIndex, unknown0)
	return _in(0x58F814C4, ped, vehicle, seatIndex, unknown0)
end

function TaskPause(ped, duration)
	return _in(0x5E702E2C, ped, duration)
end

function TaskPerformSequence(ped, taskSequence)
	return _in(0x36A33C21, ped, taskSequence)
end

function TaskPerformSequenceFromProgress(ped, Unk297, Unk298, Unk299)
	return _in(0x62701AF8, ped, Unk297, Unk298, Unk299)
end

function TaskPerformSequenceLocally(ped, Unk300)
	return _in(0x326B576F, ped, Unk300)
end

function TaskPickupAndCarryObject(ped, Unk301, Unk302, Unk303, Unk304, Unk305)
	return _in(0x76D72D89, ped, Unk301, Unk302, Unk303, Unk304, Unk305)
end

function TaskPlayAnim(ped, Unk306, Unk307, Unk308, Unk309, Unk310, Unk311, Unk312, Unk313)
	return _in(0x28EE78D8, ped, Unk306, Unk307, Unk308, Unk309, Unk310, Unk311, Unk312, Unk313)
end

function TaskPlayAnimFacial(ped, Unk314, Unk315, Unk316, Unk317, Unk318, Unk319)
	return _in(0x71F001D2, ped, Unk314, Unk315, Unk316, Unk317, Unk318, Unk319)
end

function TaskPlayAnimNonInterruptable(ped, animname0, animname1, Unk320, Unk321, Unk322, Unk323, Unk324, Unk325)
	return _in(0x52202E76, ped, _ts(animname0), _ts(animname1), Unk320, Unk321, Unk322, Unk323, Unk324, Unk325)
end

function TaskPlayAnimOnClone(ped, Unk326, Unk327, Unk328, Unk329, Unk330, Unk331, Unk332, Unk333)
	return _in(0x10FB7B5F, ped, Unk326, Unk327, Unk328, Unk329, Unk330, Unk331, Unk332, Unk333)
end

function TaskPlayAnimReadyToBeExecuted(ped, Unk334, Unk335, Unk336)
	return _in(0x040A0537, ped, Unk334, Unk335, Unk336)
end

function TaskPlayAnimSecondary(ped, Unk337, Unk338, Unk339, Unk340, Unk341, Unk342, Unk343, Unk344)
	return _in(0x273C2D35, ped, Unk337, Unk338, Unk339, Unk340, Unk341, Unk342, Unk343, Unk344)
end

function TaskPlayAnimSecondaryInCar(ped, Unk345, Unk346, Unk347, Unk348, Unk349, Unk350, Unk351, Unk352)
	return _in(0x482B2B74, ped, Unk345, Unk346, Unk347, Unk348, Unk349, Unk350, Unk351, Unk352)
end

function TaskPlayAnimSecondaryNoInterrupt(ped, Unk353, Unk354, Unk355, Unk356, Unk357, Unk358, Unk359, Unk360)
	return _in(0x56524B94, ped, Unk353, Unk354, Unk355, Unk356, Unk357, Unk358, Unk359, Unk360)
end

function TaskPlayAnimSecondaryUpperBody(ped, Unk361, Unk362, Unk363, Unk364, Unk365, Unk366, Unk367, Unk368)
	return _in(0x34574B2A, ped, Unk361, Unk362, Unk363, Unk364, Unk365, Unk366, Unk367, Unk368)
end

function TaskPlayAnimUpperBody(ped, Unk369, Unk370, Unk371, Unk372, Unk373, Unk374, Unk375, Unk376)
	return _in(0x02534709, ped, Unk369, Unk370, Unk371, Unk372, Unk373, Unk374, Unk375, Unk376)
end

function TaskPlayAnimWithAdvancedFlags(ped, Unk377, Unk378, Unk379, Unk380, Unk381, Unk382, Unk383, Unk384, Unk385, Unk386, Unk387)
	return _in(0x30BA2716, ped, Unk377, Unk378, Unk379, Unk380, Unk381, Unk382, Unk383, Unk384, Unk385, Unk386, Unk387)
end

function TaskPlayAnimWithFlags(ped, animName, animSet, unknown0_8, unknown1_0, flags)
	return _in(0x75533E74, ped, _ts(animName), _ts(animSet), unknown0_8, unknown1_0, flags)
end

function TaskPlayAnimWithFlagsAndStartPhase(ped, Unk388, Unk389, Unk390, Unk391, Unk392, Unk393)
	return _in(0x1A122D03, ped, Unk388, Unk389, Unk390, Unk391, Unk392, Unk393)
end

function TaskPutCharDirectlyIntoCover(Unk394, Unk395, Unk396, Unk397, Unk398)
	return _in(0x1FDD4860, Unk394, Unk395, Unk396, Unk397, Unk398)
end

function TaskSay()
	return _in(0x4C624B9B, _r)
end

function TaskSeekCoverFromPed(ped, Unk399, Unk400)
	return _in(0x2D9C3D5E, ped, Unk399, Unk400)
end

function TaskSeekCoverFromPos(ped, Unk401, Unk402, Unk403, Unk404)
	return _in(0x2BDF7B7E, ped, Unk401, Unk402, Unk403, Unk404)
end

function TaskSeekCoverToCoords(ped, Unk405, Unk406, Unk407, Unk408, Unk409, Unk410, Unk411)
	return _in(0x142F31EF, ped, Unk405, Unk406, Unk407, Unk408, Unk409, Unk410, Unk411)
end

function TaskSeekCoverToCoverPoint(ped, Unk412, Unk413, Unk414, Unk415, Unk416)
	return _in(0x143358D3, ped, Unk412, Unk413, Unk414, Unk415, Unk416)
end

function TaskSeekCoverToObject(ped, Unk417, Unk418, Unk419, Unk420, Unk421)
	return _in(0x4DB55DF5, ped, Unk417, Unk418, Unk419, Unk420, Unk421)
end

function TaskSetCharDecisionMaker(ped, dm)
	return _in(0x1CB2670D, ped, dm)
end

function TaskSetCombatDecisionMaker(ped, dm)
	return _in(0x499C0C01, ped, dm)
end

function TaskSetIgnoreWeaponRangeFlag(ped, ignore)
	return _in(0x6CE277E7, ped, ignore)
end

function TaskShakeFist(ped)
	return _in(0x0F7F3837, ped)
end

function TaskShimmy(ped, Unk422)
	return _in(0x53230256, ped, Unk422)
end

function TaskShimmyClimbUp(ped)
	return _in(0x36AD6480, ped, _r)
end

function TaskShimmyInDirection(ped, Unk109)
	return _in(0x7B1A5333, ped, Unk109, _r)
end

function TaskShimmyLetGo(ped)
	return _in(0x1AA32729, ped, _r)
end

function TaskShootAtChar(shooter, victim, time, shootmode)
	return _in(0x08022967, shooter, victim, time, shootmode)
end

function TaskShootAtCoord(ped, Unk423, Unk424, Unk425, Unk426, Unk427)
	return _in(0x705231A9, ped, Unk423, Unk424, Unk425, Unk426, Unk427)
end

function TaskShuffleToNextCarSeat(ped, Unk428)
	return _in(0x011D360D, ped, Unk428)
end

function TaskSitDown(ped, Unk429, Unk430, Unk431)
	return _in(0x264C5448, ped, Unk429, Unk430, Unk431)
end

function TaskSitDownInstantly(ped, Unk432, Unk433, Unk434)
	return _in(0x6CC1560F, ped, Unk432, Unk433, Unk434)
end

function TaskSitDownOnNearestObject(ped, Unk435, Unk436, Unk437, Unk438, Unk439, Unk440, Unk441, Unk442, Unk443)
	return _in(0x725654F4, ped, Unk435, Unk436, Unk437, Unk438, Unk439, Unk440, Unk441, Unk442, Unk443)
end

function TaskSitDownOnObject(ped, Unk444, Unk445, Unk446, Unk447, Unk448, Unk449, Unk450, Unk451, Unk452)
	return _in(0x515C3218, ped, Unk444, Unk445, Unk446, Unk447, Unk448, Unk449, Unk450, Unk451, Unk452)
end

function TaskSitDownOnSeat(ped, Unk453, Unk454, Unk455, Unk456, Unk457, Unk458, Unk459)
	return _in(0x2CBE4DAF, ped, Unk453, Unk454, Unk455, Unk456, Unk457, Unk458, Unk459)
end

function TaskSitDownPlayAnim()
	return _in(0x6B5500A5, _r)
end

function TaskSmartFleeChar(ped, fleeFromPed, unknown0_100, duration)
	return _in(0x1880639C, ped, fleeFromPed, unknown0_100, duration)
end

function TaskSmartFleeCharPreferringPavements(ped, fleeFromPed, unknown0_100, duration)
	return _in(0x57AC66E9, ped, fleeFromPed, unknown0_100, duration)
end

function TaskSmartFleePoint(ped, x, y, z, unknown0_100, duration)
	return _in(0x7381337A, ped, x, y, z, unknown0_100, duration)
end

function TaskSmartFleePointPreferringPavements(ped, x, y, z, radius, time_prob)
	return _in(0x3CEB6C7B, ped, x, y, z, radius, time_prob)
end

function TaskSpaceShipGoToCoord()
	return _in(0x2960330A, _r)
end

function TaskStandGuard(ped, x, y, z, Unk460, Unk461, Unk462, Unk463)
	return _in(0x59523479, ped, x, y, z, Unk460, Unk461, Unk462, Unk463)
end

function TaskStandStill(ped, duration)
	return _in(0x524C4CB5, ped, duration)
end

function TaskStartScenarioAtPosition(ped, Unk464, Unk465, Unk466, Unk467, Unk468)
	return _in(0x0F296C2E, ped, Unk464, Unk465, Unk466, Unk467, Unk468)
end

function TaskStartScenarioInPlace(ped, Unk469, Unk470)
	return _in(0x261F18A3, ped, Unk469, Unk470)
end

function TaskSwapWeapon(ped, weapon)
	return _in(0x72AE63C8, ped, weapon)
end

function TaskSwimToCoord(ped, x, y, z)
	return _in(0x098D5DA6, ped, x, y, z)
end

function TaskTired(ped, Unk471)
	return _in(0x702041F2, ped, Unk471)
end

function TaskToggleDuck(ped, Unk472)
	return _in(0x319E3A87, ped, Unk472)
end

function TaskTogglePedThreatScanner(ped, Unk473, Unk474, Unk475)
	return _in(0x5D515C4D, ped, Unk473, Unk474, Unk475)
end

function TaskTurnCharToFaceChar(ped, targetPed)
	return _in(0x0A462B7A, ped, targetPed)
end

function TaskTurnCharToFaceCoord(ped, x, y, z)
	return _in(0x51517B11, ped, x, y, z)
end

function TaskUseMobilePhone(ped, use)
	return _in(0x417F6EBD, ped, use)
end

function TaskUseMobilePhoneTimed(ped, duration)
	return _in(0x0BAD1A62, ped, duration)
end

function TaskUseNearestScenarioToPos(ped, Unk476, Unk477, Unk478, Unk479)
	return _in(0x743F30B3, ped, Unk476, Unk477, Unk478, Unk479)
end

function TaskUseNearestScenarioToPosWarp(ped, Unk480, Unk481, Unk482, Unk483)
	return _in(0x47787A40, ped, Unk480, Unk481, Unk482, Unk483)
end

function TaskWanderStandard(ped)
	return _in(0x43F5151F, ped)
end

function TaskWarpCharIntoCarAsDriver(ped, vehicle)
	return _in(0x6F363A21, ped, vehicle)
end

function TaskWarpCharIntoCarAsPassenger(ped, vehicle, seatIndex)
	return _in(0x06B30CBF, ped, vehicle, seatIndex)
end

function TeleportNetworkPlayer()
	return _in(0x2EE310C5, _r)
end

function TellNetPlayerToStartPlaying(playerIndex, Unk999)
	return _in(0x465D424D, playerIndex, Unk999)
end

function TerminateAllScriptsForNetworkGame()
	return _in(0x2CEA47E9)
end

function TerminateAllScriptsWithThisName(name)
	return _in(0x72452672, _ts(name))
end

function TerminateThisScript()
	return _in(0x2BCD1ECA)
end

function ThisScriptIsSafeForNetworkGame()
	return _in(0x63AB65DC)
end

function ThisScriptShouldBeSaved()
	return _in(0x48573CF7)
end

function Timera()
	return _in(0x75706300, _ri)
end

function Timerb()
	return _in(0x62984AB7, _ri)
end

function Timerc()
	return _in(0x1BF55D6F, _ri)
end

function Timestep()
	return _in(0x35694DDC, _ri)
end

function Timestepunwarped()
	return _in(0x49283645, _rf)
end

function ToFloat(value)
	return _in(0x259E305F, value, _rf)
end

function ToggleCharDucking(ped)
	return _in(0x265544F9, ped, _ri)
end

function ToggleToplevelSprite(toggle)
	return _in(0x51643697, toggle)
end

function TrainLeaveStation(train)
	return _in(0x37890B14, train)
end

function TriggerLoadingMusicOnNextFade()
	return _in(0x1C4B1189)
end

function TriggerMissionCompleteAudio(id)
	return _in(0x4BAF0213, id)
end

function TriggerPoliceReport(name)
	return _in(0x78D01893, _ts(name))
end

function TriggerPtfx(name, x, y, z, Unk1062, Unk1063, Unk1064, flags)
	return _in(0x21C44026, _ts(name), x, y, z, Unk1062, Unk1063, Unk1064, flags, _r)
end

function TriggerPtfxOnObj(name, obj, x, y, z, Unk1065, Unk1066, Unk1067, flags)
	return _in(0x50307F63, _ts(name), obj, x, y, z, Unk1065, Unk1066, Unk1067, flags, _r)
end

function TriggerPtfxOnObjBone(name, obj, x, y, z, Unk1068, Unk1069, Unk1070, objbone, flags)
	return _in(0x3A2A77F9, _ts(name), obj, x, y, z, Unk1068, Unk1069, Unk1070, objbone, flags, _r)
end

function TriggerPtfxOnPed(name, ped, x, y, z, Unk1071, Unk1072, Unk1073, flags)
	return _in(0x0A76502F, _ts(name), ped, x, y, z, Unk1071, Unk1072, Unk1073, flags, _r)
end

function TriggerPtfxOnPedBone(name, ped, x, y, z, Unk1074, Unk1075, Unk1076, pedbone, flags)
	return _in(0x7D3C3C9D, _ts(name), ped, x, y, z, Unk1074, Unk1075, Unk1076, pedbone, flags, _r)
end

function TriggerPtfxOnVeh(name, veh, x, y, z, Unk1077, Unk1078, Unk1079, Unk1080)
	return _in(0x3C7B6092, _ts(name), veh, x, y, z, Unk1077, Unk1078, Unk1079, Unk1080, _r)
end

function TriggerVehAlarm(car)
	return _in(0x5E5047AC, car)
end

function TriggerVigilanteCrime(id, x, y, z)
	return _in(0x195D582E, id, x, y, z)
end

function TurnCarToFaceCoord(car, x, y)
	return _in(0x16184716, car, x, y)
end

function TurnOffRadiohudInLobby()
	return _in(0x4ED6764C)
end

function TurnOffVehicleExtra(veh, extra, turnoff)
	return _in(0x05966824, veh, extra, turnoff)
end

function TurnOnRadiohudInLobby()
	return _in(0x331411D9, _r)
end

function UnattachCam(cam)
	return _in(0x278305AE, cam)
end

function UnfreezeRadioStation(radiostation)
	return _in(0x3E5B7E59, _ts(radiostation))
end

function UninheritCamRoll(cam)
	return _in(0x38AD2830, cam)
end

function UnloadTextFont()
	return _in(0x3E0229EB)
end

function UnlockGenericNewsStory(StoryId)
	return _in(0x06BE0DD3, StoryId)
end

function UnlockLazlowStation()
	return _in(0x7B6F4B91)
end

function UnlockMissionNewsStory(id)
	return _in(0x2F0718CA, id)
end

function UnlockRagdoll(ped, value)
	return _in(0x2F2F51E9, ped, value)
end

function UnmarkAllRoadNodesAsDontWander()
	return _in(0x2BBA7BF0)
end

function UnobfuscateInt(count, val)
	return _in(0x118D1AA3, count, _ii(val))
end

function UnobfuscateIntArray(Unk1000, Unk1001)
	return _in(0x6314421A, Unk1000, Unk1001)
end

function UnobfuscateString(str)
	return _in(0x2186777E, _ts(str), _s)
end

function UnpauseGame()
	return _in(0x2A783A43)
end

function UnpausePlaybackRecordedCar(car)
	return _in(0x361A01AD, car)
end

function UnpauseRadio()
	return _in(0x78F7286F)
end

function UnpointCam(cam)
	return _in(0x212B4014, cam)
end

function UnregisterScriptWithAudio()
	return _in(0x698F762E)
end

function UnsetCharMeleeMovementConstaintBox(ped)
	return _in(0x3AC90796, ped)
end

function UpdateLoadScene()
	return _in(0x513D68DB, _r)
end

function UpdateNetworkRelativeScore(Unk1002, Unk1003, Unk1004)
	return _in(0x384E3F3A, Unk1002, Unk1003, Unk1004)
end

function UpdateNetworkStatistics(playerIndex, ukn0, ukn1, ukn2)
	return _in(0x70B45E01, playerIndex, ukn0, ukn1, ukn2)
end

function UpdatePedPhysicalAttachmentPosition(ped, x0, y0, z0, x1, y1)
	return _in(0x10A62603, ped, x0, y0, z0, x1, y1)
end

function UpdatePlayerLcpdScore()
	return _in(0x49EC44CA, _r)
end

function UpdatePtfxOffsets(ptfx, x, y, z, Unk1081, Unk1082, Unk1083)
	return _in(0x45472E9D, ptfx, x, y, z, Unk1081, Unk1082, Unk1083)
end

function UpdatePtfxTint(ptfx, r, g, b, a)
	return _in(0x42FC2C31, ptfx, r, g, b, a)
end

function UseDetonator()
	return _in(0x29742C66, _r)
end

function UseMask(use)
	return _in(0x6A9B79D8, use)
end

function UsePlayerColourInsteadOfTeamColour(Unk1005)
	return _in(0x759B6BBE, Unk1005)
end

function UsePreviousFontSettings()
	return _in(0x36FC5CFB)
end

function UsingStandardControls()
	return _in(0x5F4571E5, _r)
end

function Vdist(x0, y0, z0, x1, y1, z1)
	return _in(0x4674049B, x0, y0, z0, x1, y1, z1, _rf)
end

function Vdist2(x0, y0, z0, x1, y1, z1)
	return _in(0x69AE0805, x0, y0, z0, x1, y1, z1, _rf)
end

function VehicleCanBeTargettedByHsMissile(car, set)
	return _in(0x27607F64, car, set)
end

function VehicleDoesProvideCover(veh, cover)
	return _in(0x0C4F5021, veh, cover)
end

function Vmag(x, y, z)
	return _in(0x405B02B7, x, y, z, _rf)
end

function Vmag2(x, y, z)
	return _in(0x787206F8, x, y, z, _rf)
end

function Wait(timeMS)
	return _in(0x266716AC, timeMS)
end

function Waitunpaused()
	return _in(0x3F0434E5, _r)
end

function Waitunwarped()
	return _in(0x771A298A, _r)
end

function WantedStarsAreFlashing()
	return _in(0x00746EDF, _r)
end

function WarpCharFromCarToCar(ped, vehicle, seatIndex)
	return _in(0x3AE77439, ped, vehicle, seatIndex)
end

function WarpCharFromCarToCoord(ped, x, y, z)
	return _in(0x6A77506A, ped, x, y, z)
end

function WarpCharIntoCar(ped, vehicle)
	return _in(0x73D3504A, ped, vehicle)
end

function WarpCharIntoCarAsPassenger(ped, vehicle, seatIndex)
	return _in(0x172376FE, ped, vehicle, seatIndex)
end

function WasCutsceneSkipped()
	return _in(0x18F01E80, _r)
end

function WasPedKilledByHeadshot(ped)
	return _in(0x084F7B9F, ped, _r)
end

function WasPedSkeletonUpdated(ped)
	return _in(0x3E8443E0, ped, _r)
end

function WashVehicleTextures(vehicle, intensity)
	return _in(0x69491CFA, vehicle, intensity)
end

function WhatWillPlayerPickup(player)
	return _in(0x2F9B0583, player, _ri)
end

function WinchCanPickObjectUp(obj, can)
	return _in(0x73246FC0, obj, can)
end

function WriteLobbyPreference()
	return _in(0x10431377, _r)
end

function m(cam, heading)
	return _in(0x3970702E, cam, heading)
end