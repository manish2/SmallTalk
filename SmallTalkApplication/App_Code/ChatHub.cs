using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;

[HubName("ChatServer")]
public class ChatHub : Hub
{
    private static Random random = new Random();
    private static List<string> roomInSession = new List<string>();
    private static bool exists = true;
    //Create room with random generated alphanumeric string as the room name
    public static bool Exists {
        get {
            return exists;
        }
        set
        {
            exists = value; 
        }
    }
    public void CreateRoom(string roomName,string sender)
    {
        //If the generate room is not already in session
        if(!roomInSession.Contains(roomName))
        {
             //add to our list
             roomInSession.Add(roomName);
             Groups.Add(Context.ConnectionId, roomName); //add our client
             //send message to other clients a message that user has connected
             BroadCastMessage(roomName,sender, " created the room!"); 
         }
    }
    /// <summary>
    /// Joins a user to the chat room requested if it exists, 
    /// if not returns user to chat lobby 
    /// </summary>
    /// <param name="roomName"></param>
    /// <param name="sender"></param>
    public void JoinRoom(string roomName, string sender)
    {
        //if the room does not exist
        if (!roomInSession.Contains(roomName))
        {
            exists = false; //set our flag to false    
        }
        else
        {
            exists = true; //set our flag back to true 
            Groups.Add(Context.ConnectionId, roomName); //add our client
            //send message to other clients a message that user has connected
            BroadCastMessage(roomName, sender, " joined the room!");
        }
    }
    public void BroadCastMessage(string roomName,string sender,string msg)
    {
        Clients.Group(roomName).AddMessage(sender,msg);
        //Clients.All.AddMessage(sender, msg);
    }
    public static string RandomString(int length)
    {
        const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        return new string(Enumerable.Repeat(chars, length)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }
}
