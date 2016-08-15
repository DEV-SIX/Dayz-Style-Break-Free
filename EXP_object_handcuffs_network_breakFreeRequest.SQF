
/*
	*[EXP]	Gaming 
	*Dayz Stle Break Free
	*By Metalman10
	*Thanks john for helping
	* Version 1.0	8/15
*/
private["_sessionID","_victim","_hostageTakerNetID","_hostageTaker","_respect","_newScore"];
_sessionID = _this select 0;
try
{
    _victim = _sessionID call ExileServer_system_session_getPlayerObject;
    if (isNull _victim) then
    {
        throw "Unknown player cannot break free!";
    };
    if !(alive _victim) then
    {
        throw "The dead cannot break free!";
    };
    if !(_victim getVariable ["ExileIsHandcuffed", false]) then
    {
        throw "Cannot break free if not handcuffed!";
    };
    _hostageTakerNetID = _victim getVariable ["ExileHostageTakerNetID", ""];
    _hostageTaker = objectFromNetId _hostageTakerNetID;
    if !(isNull _hostageTaker) then
    {
        if ((_victim distance _hostageTaker) < 20) then
        {
            throw "Hostage taker is too close! Make sure hes at least 20 meters away!";
        };
    };
    _victim setVariable ["ExileIsHandcuffed", false, true];
    _victim setVariable ["ExileHostageTakerNetID", nil];
    _victim setVariable ["ExileHostageTakerUID", nil];
    ["switchMoveRequest", [netId _victim, "Acts_AidlPsitMstpSsurWnonDnon_out"]] call ExileServer_system_network_send_broadcast;
    _respect = getNumber (configFile >> "CfgSettings" >> "Respect" >> "Handcuffs" >> "breakingFree");
    [_victim, "breakFreeResponse", [str _respect]] call ExileServer_system_network_send_to;
    _newScore = _victim getVariable ["ExileScore", 0];
    _newScore = _newScore + _respect;
    _victim setVariable ["ExileScore", _newScore];
    format["setAccountScore:%1:%2", _newScore, getPlayerUID _victim] call ExileServer_system_database_query_fireAndForget;
}
catch
{
    _exception call ExileServer_util_log;
};
//EXP