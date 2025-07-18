using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using CitizenMP.Server.Commands;
using CitizenMP.Server.Resources;

namespace CitizenMP.Server.Game
{
	// Token: 0x0200002F RID: 47
	internal class GameServer
	{
		// Token: 0x060001B6 RID: 438 RVA: 0x00007EC0 File Offset: 0x000060C0
		public void BanIdentifier(string identifier, string reason)
		{
			GameServer.BanDetails details = default(GameServer.BanDetails);
			details.Reason = reason;
			details.Expiration = Time.CurrentTime + 1800000L;
			this.m_bannedIdentifiers.AddOrUpdate(identifier, details, (string key, GameServer.BanDetails oldValue) => details);
		}

		// Token: 0x060001B7 RID: 439 RVA: 0x00007F24 File Offset: 0x00006124
		public bool IsIdentifierBanned(string identifier, out string reason)
		{
			reason = string.Empty;
			GameServer.BanDetails banDetails;
			if (this.m_bannedIdentifiers.TryGetValue(identifier, out banDetails) && banDetails.Expiration >= Time.CurrentTime)
			{
				reason = banDetails.Reason;
				return true;
			}
			return false;
		}

		// Token: 0x17000065 RID: 101
		// (get) Token: 0x060001B8 RID: 440 RVA: 0x00007F62 File Offset: 0x00006162
		// (set) Token: 0x060001B9 RID: 441 RVA: 0x00007F6A File Offset: 0x0000616A
		public bool UseAsync { get; set; }

		// Token: 0x17000066 RID: 102
		// (get) Token: 0x060001BA RID: 442 RVA: 0x00007F73 File Offset: 0x00006173
		// (set) Token: 0x060001BB RID: 443 RVA: 0x00007F7B File Offset: 0x0000617B
		public CommandManager CommandManager { get; private set; }

		// Token: 0x17000067 RID: 103
		// (get) Token: 0x060001BC RID: 444 RVA: 0x00007F84 File Offset: 0x00006184
		public Configuration Configuration
		{
			get
			{
				return this.m_configuration;
			}
		}

		// Token: 0x17000068 RID: 104
		// (get) Token: 0x060001BD RID: 445 RVA: 0x00007F8C File Offset: 0x0000618C
		public ResourceManager ResourceManager
		{
			get
			{
				return this.m_resourceManager;
			}
		}

		// Token: 0x17000069 RID: 105
		// (get) Token: 0x060001BE RID: 446 RVA: 0x00007F94 File Offset: 0x00006194
		// (set) Token: 0x060001BF RID: 447 RVA: 0x00007F9C File Offset: 0x0000619C
		public string GameType { get; set; }

		// Token: 0x1700006A RID: 106
		// (get) Token: 0x060001C0 RID: 448 RVA: 0x00007FA5 File Offset: 0x000061A5
		// (set) Token: 0x060001C1 RID: 449 RVA: 0x00007FAD File Offset: 0x000061AD
		public string MapName { get; set; }

		// Token: 0x060001C2 RID: 450 RVA: 0x00007FB8 File Offset: 0x000061B8
		public GameServer(Configuration config, ResourceManager resManager, CommandManager commandManager)
		{
			this.m_configuration = config;
			commandManager.SetGameServer(this);
			this.CommandManager = commandManager;
			this.m_resourceManager = resManager;
			this.m_resourceManager.SetGameServer(this);
			foreach (IPAddress ipaddress in Dns.GetHostEntry("89.163.208.198").AddressList)
			{
				if (ipaddress.AddressFamily == AddressFamily.InterNetwork)
				{
					this.m_serverList = new IPEndPoint(ipaddress, 30110);
				}
			}
			this.UseAsync = true;
		}

		// Token: 0x060001C3 RID: 451 RVA: 0x00008070 File Offset: 0x00006270
		public void Start()
		{
			this.Log("Start", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 89).Info("[Server] Starting game server on port {0}.", new object[]
			{
				this.m_configuration.ListenPort
			});
			this.m_gameSocket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
			this.m_gameSocket.Bind(new IPEndPoint(IPAddress.Any, this.m_configuration.ListenPort));
			this.m_gameSocket.Blocking = false;
			try
			{
				this.m_gameSocket6 = new Socket(AddressFamily.InterNetworkV6, SocketType.Dgram, ProtocolType.Udp);
				this.m_gameSocket6.Bind(new IPEndPoint(IPAddress.IPv6Any, this.m_configuration.ListenPort));
				this.m_gameSocket6.Blocking = false;
			}
			catch (Exception ex)
			{
				Exception ex3;
				Exception ex2 = ex3;
				Exception ex = ex2;
				this.Log("Start", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 105).Error(() => "Couldn't create IPv6 socket. Exception message: " + ex.Message, ex);
				this.m_gameSocket6 = null;
			}
			this.m_receiveBuffer = new byte[2048];
			this.m_receiveBuffer6 = new byte[2048];
			if (this.UseAsync)
			{
				this.m_asyncEventArgs = this.CreateAsyncEventArgs(this.m_gameSocket, this.m_receiveBuffer);
				if (this.m_gameSocket6 != null)
				{
					this.m_asyncEventArgs6 = this.CreateAsyncEventArgs(this.m_gameSocket6, this.m_receiveBuffer6);
				}
			}
		}

		// Token: 0x060001C4 RID: 452 RVA: 0x000081DC File Offset: 0x000063DC
		private SocketAsyncEventArgs CreateAsyncEventArgs(Socket socket, byte[] receiveBuffer)
		{
			SocketAsyncEventArgs socketAsyncEventArgs = new SocketAsyncEventArgs();
			socketAsyncEventArgs.SetBuffer(receiveBuffer, 0, receiveBuffer.Length);
			socketAsyncEventArgs.RemoteEndPoint = new IPEndPoint((socket.AddressFamily == AddressFamily.InterNetworkV6) ? IPAddress.IPv6None : IPAddress.None, 0);
			socketAsyncEventArgs.Completed += this.m_asyncEventArgs_Completed;
			if (!socket.ReceiveFromAsync(socketAsyncEventArgs))
			{
				this.m_asyncEventArgs_Completed(socket, socketAsyncEventArgs);
			}
			return socketAsyncEventArgs;
		}

		// Token: 0x060001C5 RID: 453 RVA: 0x00008240 File Offset: 0x00006440
		private void ProcessOOB(IPEndPoint remoteEP, byte[] buffer, int length)
		{
			string @string = Encoding.UTF8.GetString(buffer, 4, length - 4);
			string a = @string.Split(new char[]
			{
				' '
			})[0];
			if (a == "connect")
			{
				this.Log("ProcessOOB", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 148).Info("[Connect] Authorizing connection for {0}.", new object[]
				{
					remoteEP
				});
				this.ProcessConnectCommand(remoteEP, @string);
				return;
			}
			if (a == "rcon")
			{
				this.ProcessRconCommand(remoteEP, @string);
				return;
			}
			if (a == "getinfo")
			{
				this.ProcessGetInfoCommand(remoteEP, @string);
				return;
			}
			if (a == "getstatus")
			{
				this.ProcessGetStatusCommand(remoteEP, @string);
			}
		}

		// Token: 0x060001C6 RID: 454 RVA: 0x000082F4 File Offset: 0x000064F4
		private void ProcessGetStatusCommand(IPEndPoint remoteEP, string commandText)
		{
			string[] array = Utils.Tokenize(commandText);
			if (array.Length < 1)
			{
				return;
			}
			string text = "statusResponse\n";
			text = text + this.GetServerInfoString((array.Length == 1) ? "" : array[1]) + "\n";
			string str = (from cl in ClientInstances.Clients
			select cl.Value into cl
			where cl.NetChannel != null
			select string.Concat(new string[]
			{
				"0 ",
				cl.Ping.ToString(),
				" \"",
				cl.Name,
				"\"\n"
			})).Aggregate("", (string a, string b) => a + b);
			text += str;
			this.SendOutOfBand(remoteEP, text, Array.Empty<object>());
		}

		// Token: 0x060001C7 RID: 455 RVA: 0x000083E8 File Offset: 0x000065E8
		private void ProcessGetInfoCommand(IPEndPoint remoteEP, string commandText)
		{
			string[] array = Utils.Tokenize(commandText);
			if (array.Length < 2)
			{
				return;
			}
			this.SendOutOfBand(remoteEP, "infoResponse\n{0}", new object[]
			{
				this.GetServerInfoString(array[1])
			});
			this.m_nextHeartbeatTime = this.m_serverTime + 120000;
		}

		// Token: 0x060001C8 RID: 456 RVA: 0x00008434 File Offset: 0x00006634
		private string GetServerInfoString(string challenge)
		{
			int num = 0;
			if (this.m_configuration.Password != null)
			{
				num = 1;
			}
			int num2 = 2;
			if (this.m_configuration.Branch == "beta")
			{
				num2 = 4;
			}
			int num3 = 0;
			if (this.m_configuration.ServerIcon != null)
			{
				num3 = 1;
			}
			string format = "\\sv_maxclients\\{0}\\clients\\{1}\\challenge\\{2}\\gamename\\{3}\\protocol\\{4}\\hostname\\{5}\\gametype\\{6}\\mapname\\{7}\\locked\\{8}\\language\\{9}\\servericon\\{10}";
			object[] array = new object[11];
			array[0] = this.m_configuration.MaxPlayers;
			array[1] = ClientInstances.Clients.Count((KeyValuePair<string, Client> cl) => cl.Value.RemoteEP != null);
			array[2] = challenge;
			array[3] = (this.m_configuration.Game ?? "GTA4");
			array[4] = num2;
			array[5] = (this.m_configuration.Hostname ?? "CitizenMP");
			array[6] = (this.GameType ?? "");
			array[7] = (this.MapName ?? "");
			array[8] = num;
			array[9] = (this.m_configuration.Language ?? "English");
			array[10] = num3;
			return string.Format(format, array);
		}

		// Token: 0x060001C9 RID: 457 RVA: 0x00008560 File Offset: 0x00006760
		private void ProcessRconCommand(IPEndPoint remoteEP, string commandText)
		{
			string[] array = Utils.Tokenize(commandText);
			if (array.Length < 3)
			{
				return;
			}
			if (this.m_lastRconTimes.ContainsKey(remoteEP))
			{
				int num = this.m_lastRconTimes[remoteEP];
				if (this.m_serverTime < num + 100)
				{
					return;
				}
			}
			RconPrint.StartRedirect(this, remoteEP);
			if (this.m_configuration.RconPassword != null)
			{
				if (this.m_configuration.RconPassword != array[1])
				{
					RconPrint.Print("Invalid rcon password.\n", Array.Empty<object>());
					this.Log("ProcessRconCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 243).Warn("[Warn] Bad rcon from {0}", new object[]
					{
						remoteEP
					});
					goto IL_15D;
				}
				List<string> list = array.Skip(3).ToList<string>();
				if (this.CommandManager.HandleCommand(array[2], list))
				{
					goto IL_15D;
				}
				try
				{
					if (this.m_resourceManager.TriggerEvent("rconCommand", -1, new object[]
					{
						array[2],
						list
					}))
					{
						RconPrint.Print("Unknown command: {0}\n", new object[]
						{
							array[2]
						});
					}
					goto IL_15D;
				}
				catch (Exception ex)
				{
					Exception e2 = ex;
					Exception e = e2;
					this.Log("ProcessRconCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 260).Error(() => "error handling rcon: " + e.Message, e);
					RconPrint.Print(e.Message, Array.Empty<object>());
					goto IL_15D;
				}
			}
			RconPrint.Print("No rcon password was set on this server.\n", Array.Empty<object>());
			IL_15D:
			RconPrint.EndRedirect();
		}

		// Token: 0x060001CA RID: 458 RVA: 0x000086E0 File Offset: 0x000068E0
		private void ProcessConnectCommand(IPEndPoint remoteEP, string commandText)
		{
			string query = commandText.Substring("connect ".Length);
			Dictionary<string, string> arguments = Utils.ParseQueryString(query);
			if (arguments.ContainsKey("token") && arguments.ContainsKey("guid"))
			{
				KeyValuePair<string, Client> keyValuePair = ClientInstances.Clients.FirstOrDefault((KeyValuePair<string, Client> cl) => cl.Value.Guid == arguments["guid"] && cl.Value.Token == arguments["token"]);
				if (keyValuePair.Equals(default(KeyValuePair<string, Client>)))
				{
					return;
				}
				if (ClientInstances.Clients.Count((KeyValuePair<string, Client> cl) => cl.Value.RemoteEP != null) >= this.Configuration.MaxPlayers)
				{
					return;
				}
				Client value = keyValuePair.Value;
				value.Touch();
				value.NetChannel = new NetChannel(value);
				value.NetID = ClientInstances.AssignNetID();
				value.RemoteEP = remoteEP;
				value.Socket = ((remoteEP.AddressFamily == AddressFamily.InterNetworkV6) ? this.m_gameSocket6 : this.m_gameSocket);
				this.SendOutOfBand(remoteEP, "connectOK {0} {1} {2}", new object[]
				{
					value.NetID,
					(this.m_host != null) ? ((int)this.m_host.NetID) : -1,
					(this.m_host != null) ? this.m_host.Base : -1
				});
				this.m_nextHeartbeatTime = this.m_serverTime + 500;
				this.TriggerClientEvent("onPlayerJoining", -1, new object[]
				{
					value.NetID,
					value.Name
				});
				this.Log("ProcessConnectCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 311).Info("[Connect] Authorization for {0} ({1}) complete.", new object[]
				{
					value.RemoteEP,
					value.Name
				});
				foreach (KeyValuePair<string, Client> keyValuePair2 in ClientInstances.Clients)
				{
					if (keyValuePair2.Value.NetID != value.NetID)
					{
						this.TriggerClientEvent("onPlayerJoining", (int)value.NetID, new object[]
						{
							keyValuePair2.Value.NetID,
							keyValuePair2.Value.Name
						});
					}
				}
			}
		}

		// Token: 0x060001CB RID: 459 RVA: 0x0000894C File Offset: 0x00006B4C
		public void SendOutOfBand(IPEndPoint remoteEP, string text, params object[] data)
		{
			string s = "    " + string.Format(text, data);
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			bytes[0] = byte.MaxValue;
			bytes[1] = byte.MaxValue;
			bytes[2] = byte.MaxValue;
			bytes[3] = byte.MaxValue;
			try
			{
				if (remoteEP.AddressFamily == AddressFamily.InterNetworkV6)
				{
					this.m_gameSocket6.SendTo(bytes, remoteEP);
				}
				else
				{
					this.m_gameSocket.SendTo(bytes, remoteEP);
				}
			}
			catch (SocketException)
			{
			}
		}

		// Token: 0x060001CC RID: 460 RVA: 0x000089D4 File Offset: 0x00006BD4
		private void ProcessClientMessage(Client client, BinaryReader reader)
		{
			client.Touch();
			uint num = reader.ReadUInt32();
			if (num != client.OutReliableAcknowledged)
			{
				for (int i = client.OutReliableCommands.Count - 1; i >= 0; i--)
				{
					if (client.OutReliableCommands[i].ID <= num)
					{
						client.OutReliableCommands.RemoveAt(i);
					}
				}
				client.OutReliableAcknowledged = num;
			}
			if (client.ProtocolVersion >= 2U)
			{
				uint num2 = reader.ReadUInt32();
				if (client.LastReceivedFrame != num2)
				{
					client.Frames[(int)(checked((IntPtr)(unchecked((ulong)num2 % (ulong)((long)client.Frames.Length)))))].AckedTime = Time.CurrentTime;
					client.LastReceivedFrame = num2;
				}
			}
			try
			{
				for (;;)
				{
					uint num3 = reader.ReadUInt32();
					if (num3 == 3394674275U)
					{
						break;
					}
					if (num3 == 3912778843U)
					{
						this.ProcessRoutingMessage(client, reader);
					}
					else if (num3 == 3018469598U)
					{
						this.ProcessIHostMessage(client, reader);
					}
					else
					{
						this.ProcessReliableMessage(client, num3, reader);
					}
				}
			}
			catch (EndOfStreamException)
			{
				this.Log("ProcessClientMessage", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 407).Debug("[Debug] end of stream for client {0}", new object[]
				{
					client.NetID
				});
			}
		}

		// Token: 0x060001CD RID: 461 RVA: 0x00008B08 File Offset: 0x00006D08
		private void ProcessRoutingMessage(Client client, BinaryReader reader)
		{
			client.SentData = true;
			ushort targetNetID = reader.ReadUInt16();
			ushort num = reader.ReadUInt16();
			byte[] array = reader.ReadBytes((int)num);
			if (array.Length != (int)num)
			{
				this.Log("ProcessRoutingMessage", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 425).Debug("[Debug] Incomplete routing packet.", Array.Empty<object>());
				return;
			}
			KeyValuePair<string, Client> keyValuePair = ClientInstances.Clients.FirstOrDefault((KeyValuePair<string, Client> c) => c.Value.NetID == targetNetID);
			if (keyValuePair.Equals(default(KeyValuePair<string, Client>)))
			{
				this.Log("ProcessRoutingMessage", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 435).Debug("[Debug] no target netID {0}", new object[]
				{
					targetNetID
				});
				return;
			}
			Client value = keyValuePair.Value;
			Client obj = value;
			lock (obj)
			{
				MemoryStream memoryStream = new MemoryStream();
				BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
				value.WriteReliableBuffer(binaryWriter);
				binaryWriter.Write(3912778843U);
				binaryWriter.Write(client.NetID);
				binaryWriter.Write(num);
				binaryWriter.Write(array);
				binaryWriter.Write(3394674275U);
				binaryWriter.Flush();
				value.NetChannel.Send(memoryStream.ToArray());
			}
		}

		// Token: 0x060001CE RID: 462 RVA: 0x00008C70 File Offset: 0x00006E70
		private void ProcessIHostMessage(Client client, BinaryReader reader)
		{
			int @base = reader.ReadInt32();
			bool flag = false;
			if (this.m_host == null)
			{
				flag = true;
			}
			else if (Time.CurrentTime - this.m_host.LastSeen >= 15000L)
			{
				flag = true;
			}
			if (flag)
			{
				client.Base = @base;
				this.SetNewHost(client);
			}
		}

		// Token: 0x060001CF RID: 463 RVA: 0x00008CC0 File Offset: 0x00006EC0
		private void SetNewHost(Client client)
		{
			this.m_host = client;
			MemoryStream memoryStream = new MemoryStream();
			BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
			binaryWriter.Write(client.NetID);
			binaryWriter.Write(client.Base);
			foreach (KeyValuePair<string, Client> keyValuePair in ClientInstances.Clients)
			{
				keyValuePair.Value.SendReliableCommand(3018469598U, memoryStream.ToArray());
			}
			this.m_hostVotes.Clear();
		}

		// Token: 0x060001D0 RID: 464 RVA: 0x00008D54 File Offset: 0x00006F54
		private void BeforeDropClient(Client client, string reason = "")
		{
			this.m_nextHeartbeatTime = this.m_serverTime + 500;
			if (client.NetChannel != null && reason != "Duplicate GUID")
			{
				this.m_resourceManager.TriggerEvent("playerDropped", (int)client.NetID, new object[]
				{
					reason
				});
			}
			if (this.m_host != null && client.NetID == this.m_host.NetID)
			{
				this.m_host = null;
				MemoryStream memoryStream = new MemoryStream();
				BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
				binaryWriter.Write(ushort.MaxValue);
				binaryWriter.Write(65535);
				foreach (KeyValuePair<string, Client> keyValuePair in ClientInstances.Clients)
				{
					keyValuePair.Value.SendReliableCommand(3018469598U, memoryStream.ToArray());
				}
			}
		}

		// Token: 0x060001D1 RID: 465 RVA: 0x00008E3C File Offset: 0x0000703C
		public void DropClient(Client client, string reason)
		{
			byte[] bytes = BitConverter.GetBytes(-1).Concat(Encoding.UTF8.GetBytes(string.Format("error {0}", reason))).ToArray<byte>();
			client.SendRaw(bytes);
			Task.Delay(100).ContinueWith(delegate(Task task)
			{
				client.SendRaw(bytes);
			});
			this.BeforeDropClient(client, reason);
			ClientInstances.RemoveClient(client);
		}

		// Token: 0x060001D2 RID: 466 RVA: 0x00008EC4 File Offset: 0x000070C4
		private void HandleReliableCommand(Client client, uint messageType, BinaryReader reader, int size)
		{
			if (messageType == 1378659793U)
			{
				this.Log("HandleReliableCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 562).Info("[Quit] {0} ({1}) left the server (Disconnected).", new object[]
				{
					client.Name,
					client.NetID
				});
				this.BeforeDropClient(client, "Disconnected");
				ClientInstances.RemoveClient(client);
				return;
			}
			if (messageType != 2263480443U)
			{
				if (messageType == 1933049210U || messageType == 4202130968U)
				{
					int targetNetID = (int)((messageType != 4202130968U) ? reader.ReadUInt16() : 0);
					ushort num = reader.ReadUInt16();
					string eventName = "";
					for (int i = 0; i < (int)(num - 1); i++)
					{
						eventName += ((char)reader.ReadByte()).ToString();
					}
					reader.ReadByte();
					int num2 = size - (int)num - 4;
					if (messageType == 1933049210U)
					{
						byte[] data = reader.ReadBytes(num2);
						this.TriggerClientEvent(eventName, data, targetNetID, (int)client.NetID);
						return;
					}
					byte[] array = reader.ReadBytes(num2 + 2);
					if (!this.m_whitelistedEvents.Contains(eventName))
					{
						this.Log("HandleReliableCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 663).Warn("[Warn] A client tried to send an event of type {0}, but it was not greenlit for client invocation. You may need to call RegisterServerEvent from your script.", new object[]
						{
							eventName
						});
						return;
					}
					StringBuilder dataSB = new StringBuilder(array.Length);
					foreach (byte value in array)
					{
						dataSB.Append((char)value);
					}
					this.QueueCallback(delegate
					{
						this.m_resourceManager.TriggerEvent(eventName, dataSB.ToString(), (int)client.NetID);
					});
				}
				return;
			}
			uint allegedNetID = reader.ReadUInt32();
			if (this.m_host != null && allegedNetID == (uint)this.m_host.NetID)
			{
				this.Log("HandleReliableCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 579).Debug("[Debug] Got a late vote for {0}; they are our current host", new object[]
				{
					allegedNetID
				});
				return;
			}
			int @base = reader.ReadInt32();
			int num3 = ClientInstances.Clients.Count((KeyValuePair<string, Client> c) => c.Value.SentData);
			int num4 = (num3 > 0) ? (num3 / 3 + ((num3 % 3 > 0) ? 1 : 0)) : 0;
			int num5;
			if (!this.m_hostVotes.TryGetValue(allegedNetID, out num5))
			{
				num5 = 1;
			}
			else
			{
				num5++;
			}
			this.Log("HandleReliableCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 601).Debug("[Debug] Received a vote for {0}; current votes {1}, needed {2}", new object[]
			{
				allegedNetID,
				num5,
				num4
			});
			if (num5 < num4)
			{
				this.m_hostVotes[allegedNetID] = num5;
				return;
			}
			KeyValuePair<string, Client> keyValuePair = ClientInstances.Clients.FirstOrDefault((KeyValuePair<string, Client> a) => (uint)a.Value.NetID == allegedNetID);
			if (keyValuePair.Equals(default(KeyValuePair<string, Client>)))
			{
				this.Log("HandleReliableCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 611).Debug("[Debug] The vote was rigged! Nobody is host! Bad politics!", Array.Empty<object>());
				return;
			}
			this.Log("HandleReliableCommand", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 616).Debug("[Debug] Net ID {0} won the election; they are the new host-elect.", new object[]
			{
				allegedNetID
			});
			keyValuePair.Value.Base = @base;
			this.SetNewHost(keyValuePair.Value);
		}

		// Token: 0x060001D3 RID: 467 RVA: 0x00009274 File Offset: 0x00007474
		public void TriggerClientEvent(string eventName, string data, int targetNetID, int sourceNetID)
		{
			byte[] array = new byte[data.Length];
			int num = 0;
			foreach (char c in data)
			{
				array[num] = (byte)c;
				num++;
			}
			this.TriggerClientEvent(eventName, array, targetNetID, sourceNetID);
		}

		// Token: 0x060001D4 RID: 468 RVA: 0x000092C0 File Offset: 0x000074C0
		public void TriggerClientEvent(string eventName, int targetNetID, params object[] arguments)
		{
			byte[] data = Utils.SerializeEvent(arguments);
			if (targetNetID >= 0)
			{
				this.TriggerClientEvent(eventName, data, targetNetID, -1);
				return;
			}
			foreach (KeyValuePair<string, Client> keyValuePair in ClientInstances.Clients)
			{
				if (keyValuePair.Value.NetChannel != null)
				{
					this.TriggerClientEvent(eventName, data, (int)keyValuePair.Value.NetID, -1);
				}
			}
		}

		// Token: 0x060001D5 RID: 469 RVA: 0x00009340 File Offset: 0x00007540
		public void TriggerClientEvent(string eventName, byte[] data, int targetNetID, int sourceNetID)
		{
			MemoryStream memoryStream = new MemoryStream();
			BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
			binaryWriter.Write((ushort)sourceNetID);
			binaryWriter.Write((ushort)(eventName.Length + 1));
			for (int i = 0; i < eventName.Length; i++)
			{
				binaryWriter.Write((byte)eventName[i]);
			}
			binaryWriter.Write(0);
			binaryWriter.Write(data);
			byte[] commandData = memoryStream.ToArray();
			if (targetNetID == 65535 || targetNetID == -1)
			{
				using (IEnumerator<KeyValuePair<string, Client>> enumerator = ClientInstances.Clients.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						KeyValuePair<string, Client> keyValuePair = enumerator.Current;
						keyValuePair.Value.SendReliableCommand(1933049210U, commandData);
					}
					return;
				}
			}
			Client client = (from a in ClientInstances.Clients
			where (int)a.Value.NetID == targetNetID
			select a.Value).FirstOrDefault<Client>();
			if (client != null)
			{
				client.SendReliableCommand(1933049210U, commandData);
			}
		}

		// Token: 0x060001D6 RID: 470 RVA: 0x00009470 File Offset: 0x00007670
		public void WhitelistEvent(string eventName)
		{
			if (!this.m_whitelistedEvents.Contains(eventName))
			{
				this.m_whitelistedEvents.Add(eventName);
			}
		}

		// Token: 0x060001D7 RID: 471 RVA: 0x00009490 File Offset: 0x00007690
		private void ProcessReliableMessage(Client client, uint messageType, BinaryReader reader)
		{
			uint num = reader.ReadUInt32();
			int num2;
			if ((num & 2147483648U) != 0U)
			{
				num2 = reader.ReadInt32();
				num &= 2147483647U;
			}
			else
			{
				num2 = (int)reader.ReadInt16();
			}
			long position = reader.BaseStream.Position;
			if (num > client.LastReceivedReliable)
			{
				this.HandleReliableCommand(client, messageType, reader, num2);
				client.LastReceivedReliable = num;
			}
			reader.BaseStream.Position = position + (long)num2;
		}

		// Token: 0x060001D8 RID: 472 RVA: 0x000094FC File Offset: 0x000076FC
		private void ProcessIncomingPacket(byte[] buffer, int length, IPEndPoint remoteEP)
		{
			using (MemoryStream memoryStream = new MemoryStream(buffer))
			{
				BinaryReader binaryReader = new BinaryReader(memoryStream);
				if (binaryReader.ReadUInt32() == 4294967295U)
				{
					this.ProcessOOB(remoteEP, buffer, length);
				}
				else
				{
					KeyValuePair<string, Client> keyValuePair = ClientInstances.Clients.FirstOrDefault((KeyValuePair<string, Client> c) => c.Value.RemoteEP != null && c.Value.RemoteEP.Equals(remoteEP));
					if (keyValuePair.Equals(default(KeyValuePair<string, Client>)))
					{
						this.Log("ProcessIncomingPacket", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 813).Debug("[Debug] Received a packet from an unknown source ({0})", new object[]
						{
							remoteEP
						});
					}
					else
					{
						Client value = keyValuePair.Value;
						if (value.NetChannel.Process(buffer, length, ref binaryReader))
						{
							this.ProcessClientMessage(value, binaryReader);
						}
					}
				}
			}
		}

		// Token: 0x060001D9 RID: 473 RVA: 0x000095E8 File Offset: 0x000077E8
		private void m_asyncEventArgs_Completed(object sender, SocketAsyncEventArgs e)
		{
			try
			{
				if (e.SocketError == SocketError.Success && e.BytesTransferred > 0)
				{
					this.ProcessIncomingPacket(e.Buffer, e.BytesTransferred, (IPEndPoint)e.RemoteEndPoint);
				}
			}
			catch (Exception exception)
			{
				this.Log("m_asyncEventArgs_Completed", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 838).Error(() => "incoming packet failed", exception);
			}
			if (!((Socket)sender).ReceiveFromAsync(e))
			{
				this.m_asyncEventArgs_Completed(sender, e);
			}
		}

		// Token: 0x060001DA RID: 474 RVA: 0x00009688 File Offset: 0x00007888
		public int GetHostID()
		{
			if (this.m_host == null)
			{
				return -1;
			}
			return (int)this.m_host.NetID;
		}

		// Token: 0x060001DB RID: 475 RVA: 0x000096A0 File Offset: 0x000078A0
		private void QueueCallback(Action cb)
		{
			Queue<Action> mainCallbacks = this.m_mainCallbacks;
			lock (mainCallbacks)
			{
				this.m_mainCallbacks.Enqueue(cb);
			}
		}

		// Token: 0x060001DC RID: 476 RVA: 0x000096E8 File Offset: 0x000078E8
		public void Tick(int msec)
		{
			if (!this.UseAsync)
			{
				EndPoint receiveEP = new IPEndPoint(IPAddress.None, 0);
				Action<Socket> action = delegate(Socket socket)
				{
					for (;;)
					{
						try
						{
							int num = socket.ReceiveFrom(this.m_receiveBuffer, ref receiveEP);
							if (num > 0)
							{
								this.ProcessIncomingPacket(this.m_receiveBuffer, num, (IPEndPoint)receiveEP);
								continue;
							}
						}
						catch (SocketException ex2)
						{
							if (ex2.SocketErrorCode != SocketError.WouldBlock)
							{
								this.Log("Tick", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 894).Warn("[Warn] socket error {0}", new object[]
								{
									ex2.Message
								});
							}
						}
						break;
					}
				};
				action(this.m_gameSocket);
				if (this.m_gameSocket6 != null)
				{
					action(this.m_gameSocket6);
				}
			}
			while (this.m_mainCallbacks.Count > 0)
			{
				Queue<Action> mainCallbacks = this.m_mainCallbacks;
				Action action2;
				lock (mainCallbacks)
				{
					action2 = this.m_mainCallbacks.Dequeue();
				}
				try
				{
					action2();
				}
				catch (Exception ex)
				{
					Exception e2 = ex;
					Exception e = e2;
					this.Log("Tick", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 925).Error(() => "Exception during queued callback: " + e.Message, e);
				}
			}
			this.m_residualTime += msec;
			while (this.m_residualTime > 50)
			{
				this.m_residualTime -= 50;
				this.m_serverTime += 50;
				this.ProcessServerFrame();
			}
		}

		// Token: 0x060001DD RID: 477 RVA: 0x00009834 File Offset: 0x00007A34
		private void SendHeartbeat()
		{
			this.Log("SendHeartbeat", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 948).Info("Sending heartbeat to https://citizeniv.net/.", Array.Empty<object>());
			this.SendOutOfBand(this.m_serverList, "heartbeat DarkPlaces\n", Array.Empty<object>());
		}

		// Token: 0x060001DE RID: 478 RVA: 0x00009870 File Offset: 0x00007A70
		private void ProcessServerFrame()
		{
			long currentTime = Time.CurrentTime;
			List<Client> list = new List<Client>();
			foreach (KeyValuePair<string, Client> keyValuePair in ClientInstances.Clients)
			{
				int num = keyValuePair.Value.SentData ? 15 : 90;
				num *= 1000;
				if (currentTime - keyValuePair.Value.LastSeen > (long)num)
				{
					if (keyValuePair.Value.NetChannel != null)
					{
						this.Log("ProcessServerFrame", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 971).Info("[Quit] {0} ({1}) left the server (Lost Connection).", new object[]
						{
							keyValuePair.Value.Name,
							keyValuePair.Value.NetID
						});
					}
					list.Add(keyValuePair.Value);
				}
			}
			foreach (Client client in list)
			{
				this.BeforeDropClient(client, "Lost Connection");
				ClientInstances.RemoveClient(client);
			}
			int serverTime = this.m_serverTime;
			int nextHeartbeatTime = this.m_nextHeartbeatTime;
			this.ResourceManager.Tick();
			foreach (KeyValuePair<string, Client> keyValuePair2 in ClientInstances.Clients)
			{
				Client value = keyValuePair2.Value;
				if (value.NetChannel != null)
				{
					keyValuePair2.Value.CalculatePing();
					Client obj = value;
					lock (obj)
					{
						MemoryStream memoryStream = new MemoryStream();
						BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
						value.WriteReliableBuffer(binaryWriter);
						if (value.ProtocolVersion >= 2U)
						{
							binaryWriter.Write(1409284671);
							binaryWriter.Write(keyValuePair2.Value.FrameNumber);
							if (value.ProtocolVersion >= 3U)
							{
								binaryWriter.Write(keyValuePair2.Value.Ping);
							}
							Client value2;
							uint frameNumber;
							checked
							{
								keyValuePair2.Value.Frames[(int)((IntPtr)(unchecked((ulong)keyValuePair2.Value.FrameNumber % (ulong)((long)keyValuePair2.Value.Frames.Length))))].SentTime = Time.CurrentTime;
								keyValuePair2.Value.Frames[(int)((IntPtr)(unchecked((ulong)keyValuePair2.Value.FrameNumber % (ulong)((long)keyValuePair2.Value.Frames.Length))))].AckedTime = -1L;
								value2 = keyValuePair2.Value;
								frameNumber = value2.FrameNumber;
							}
							value2.FrameNumber = frameNumber + 1U;
						}
						binaryWriter.Write(3394674275U);
						binaryWriter.Flush();
						value.NetChannel.Send(memoryStream.ToArray());
					}
				}
			}
			long num2 = Time.CurrentTime - currentTime;
			if (num2 > 25L)
			{
				this.Log("ProcessServerFrame", "C:\\Users\\Tiger\\Desktop\\CitizenIV\\Server\\CitizenMP.Server\\Game\\GameServer.cs", 1042).Info("[Info] Frame time warning: server frame took {0} msec.", new object[]
				{
					num2
				});
			}
		}

		// Token: 0x04000090 RID: 144
		private ConcurrentDictionary<string, GameServer.BanDetails> m_bannedIdentifiers = new ConcurrentDictionary<string, GameServer.BanDetails>();

		// Token: 0x04000091 RID: 145
		public const uint PROTOCOL_VERSION = 3U;

		// Token: 0x04000092 RID: 146
		private Socket m_gameSocket;

		// Token: 0x04000093 RID: 147
		private Socket m_gameSocket6;

		// Token: 0x04000094 RID: 148
		private SocketAsyncEventArgs m_asyncEventArgs;

		// Token: 0x04000095 RID: 149
		private SocketAsyncEventArgs m_asyncEventArgs6;

		// Token: 0x04000096 RID: 150
		private byte[] m_receiveBuffer;

		// Token: 0x04000097 RID: 151
		private byte[] m_receiveBuffer6;

		// Token: 0x04000098 RID: 152
		private Client m_host;

		// Token: 0x0400009A RID: 154
		private ResourceManager m_resourceManager;

		// Token: 0x0400009B RID: 155
		private Configuration m_configuration;

		// Token: 0x0400009D RID: 157
		private IPEndPoint m_serverList;

		// Token: 0x040000A0 RID: 160
		private Dictionary<IPEndPoint, int> m_lastRconTimes = new Dictionary<IPEndPoint, int>();

		// Token: 0x040000A1 RID: 161
		private Dictionary<uint, int> m_hostVotes = new Dictionary<uint, int>();

		// Token: 0x040000A2 RID: 162
		private HashSet<string> m_whitelistedEvents = new HashSet<string>();

		// Token: 0x040000A3 RID: 163
		private Queue<Action> m_mainCallbacks = new Queue<Action>();

		// Token: 0x040000A4 RID: 164
		private int m_residualTime;

		// Token: 0x040000A5 RID: 165
		private int m_serverTime;

		// Token: 0x040000A6 RID: 166
		private int m_lastSenselessReliableSent;

		// Token: 0x040000A7 RID: 167
		private int m_nextHeartbeatTime;

		// Token: 0x0200007B RID: 123
		private struct BanDetails
		{
			// Token: 0x17000093 RID: 147
			// (get) Token: 0x06000305 RID: 773 RVA: 0x0000E72C File Offset: 0x0000C92C
			// (set) Token: 0x06000306 RID: 774 RVA: 0x0000E734 File Offset: 0x0000C934
			public string Reason { get; set; }

			// Token: 0x17000094 RID: 148
			// (get) Token: 0x06000307 RID: 775 RVA: 0x0000E73D File Offset: 0x0000C93D
			// (set) Token: 0x06000308 RID: 776 RVA: 0x0000E745 File Offset: 0x0000C945
			public long Expiration { get; set; }
		}
	}
}
