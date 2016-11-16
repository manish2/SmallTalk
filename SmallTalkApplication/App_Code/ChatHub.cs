using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System.Collections.Generic;

[HubName("chatServer")]
public class ChatHub : Hub
{
    private static List<string> clientList = new List<string>();
    
    public IEnumerable<string> getClients()
    {
        return clientList;
    }

    public void addClient(string client)
    {
        clientList.Add(client);
    }
    public void Hello()
    {
        this.Clients.All.Hello("Hi");
    }
    public void JoinRoom(string roomName)
    {
        Groups.Add(Context.ConnectionId, roomName);
    }
    public void BroadCastMessage(string msg)
    {
        Clients.All.RecieveMessage(msg);
    }
}
