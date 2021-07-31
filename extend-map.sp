#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_AUTHOR "Nairda" // Thank you deadwinter for your help with understanding the idiotic syntax
#define PLUGIN_VERSION "1.0"

ConVar gCV_TimeLimit;

int gI_NewTime;

public Plugin myinfo =
{
	name = "Extend map time",
	author = PLUGIN_AUTHOR,
	version = PLUGIN_VERSION,
}

public void OnPluginStart()
{
	RegAdminCmd("sm_extend", Command_Extend, ADMFLAG_GENERIC, "Extends the mp_timelimit CVAR by x minutes");

	gCV_TimeLimit = FindConVar("mp_timelimit");
}

public Action Command_Extend(int client, int args)
{
	if(!args)
	{
		ReplyToCommand(client, "Usage: !extend <minutes>");

		return Plugin_Handled;
	}

	char sArg[64];
	GetCmdArg(1, sArg, sizeof(sArg));

	int iMinutes = StringToInt(sArg);

	gI_NewTime = gCV_TimeLimit.IntValue + iMinutes;
	gCV_TimeLimit.SetInt(gI_NewTime);

	ReplyToCommand(client, "Extended by: %i minutes.", iMinutes);

	return Plugin_Handled;
}
