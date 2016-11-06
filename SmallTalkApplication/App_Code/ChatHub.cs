using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

[HubName("chatServer")]
public class ChatHub : Hub
{
    public void Hello()
    {
        this.Clients.All.Hello("Hi");
    }
    public void JoinRoom(string roomName)
    {
        Groups.Add(Context.ConnectionId, roomName);
    }
    public void BroadCastMessage(string msgFrom, string msg)
    {
        Clients.All.RecieveMessage(msgFrom, msg);
    }
}
