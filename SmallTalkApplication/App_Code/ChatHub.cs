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
    
    private static Random random = new Random(); //loads the random class to generate room id
    private static List<string> roomInSession = new List<string>();
    private static bool exists = true; //Flag variable to check if room is already open
    //keeps track of the clients in the current room 
    private static Dictionary<string, List<string>> clientList = new Dictionary<string, List<string>>();
    private static string roomName;
    private static string userName;

    public static List<string> RoomsInSession
    {
        get
        {
            return roomInSession;
        }
    }
    public static bool Exists
    {
        get
        {
            return exists;
        }
        set
        {
            exists = value;
        }
    }
    public static string RoomName
    {
        get
        {
            return roomName;
        }
        set
        {
            roomName = value;
        }
    }
    public static string UserName
    {
        get
        {
            return userName;
        }
        set
        {
            userName = value;
        }
    }
    /// <summary>
    /// Adds the newly connected client to the ChatRoom 
    /// </summary>
    /// <param name="client"></param>
    /// <param name="roomName"></param>
    public void addClient(string client, string roomName)
    {
        if(!clientList.ContainsKey(roomName))
        {
            clientList.Add(roomName, new List<string>());
        }
        clientList[roomName].Add(client);

        Clients.Group(roomName).updateMembers(clientList[roomName]);
    }
    /// <summary>
    /// Removes the Client from the members list 
    /// </summary>
    /// <param name="client"></param>
    /// <param name="roomName"></param>
    public void removeClient(string client, string roomName)
    {
        clientList[roomName].Remove(client);

        Clients.Group(roomName).updateMembers(clientList[roomName]);
    }
    
    //Create room with random generated alphanumeric string as the room name
    public void CreateRoom(string roomName,string sender)
    {
        //If the generate room is not already in session
        if(!roomInSession.Contains(roomName))
        {
             //add to our list
             roomInSession.Add(roomName);
             Groups.Add(Context.ConnectionId, roomName); //add our client
             //send message to other clients a message that user has connected
             BroadCastMessage(roomName,sender, " created the room!", true); 
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
            BroadCastMessage(roomName, sender, " joined the room!" , true);
        }
    }
    /// <summary>
    /// Sends the message to clients in the current chatroom
    /// </summary>
    /// <param name="roomName"></param>
    /// <param name="sender"></param>
    /// <param name="msg"></param>
    /// <param name="server"></param>
    public void BroadCastMessage(string roomName,string sender,string msg, bool server)
    {
        Clients.Group(roomName).AddMessage(sender,msg, server);
    }
    /// <summary>
    /// This function generates the random chatroom id 
    /// </summary>
    /// <param name="length"></param>
    /// <returns></returns>
    public static string RandomString(int length)
    {
        const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        return new string(Enumerable.Repeat(chars, length)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }
}
