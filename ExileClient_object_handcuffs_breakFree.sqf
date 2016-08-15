/*
	*[EXP]	Gaming 
	*Dayz Stle Break Free
	*By Metalman10
	*Thanks john for helping
	* Version 1.0	8/15
*/
 try
{
    if !(ExileClientIsHandcuffed) then
    {
        throw "You are not handcuffed!";
    };
    if !(isNull ExileClientHostageTaker) then
    {
        if ((player distance ExileClientHostageTaker) < 20) then
        {
            throw "Your hostage taker is nearby!";
        };
    };
    if (!(player call ExileClient_object_handcuffs_hasFreeItems) && (random 1 > 0.05)) then	// 5% to prevent spammers getting it quick
    { 
        throw "You tried to break free but failed, sharp tools can help!";      
    };
 
    ["breakFreeRequest", []] call ExileClient_system_network_send;
}
catch
{
    ["ErrorTitleOnly", [_exception]] call ExileClient_gui_toaster_addTemplateToast;
};
//EXP
