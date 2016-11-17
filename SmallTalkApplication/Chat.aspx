<%@ Page Title="SmallTalk" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" EnableEventValidation="false"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.js"></script>
    <script type="text/javascript">
        $(function () {
            var isJoin = localStorage.getItem("isJoin");
            var con = $.hubConnection();
            var hub = con.createHubProxy('ChatServer');
            hub.on('AddMessage', function (username, message) {
                var currentVal = $('#chatBox').val();
                $('#chatBox').val("Hello" + "\n");
                $('#chatBox').val(currentVal + username + message + "\n");
            });

            hub.on('UpdateMembers', function (clients) {
                document.getElementById("<%= memberList.ClientID %>").innerHTML="";
                $.each(clients, function () {
                    var client = this;
                    var option = document.createElement("OPTION");
                    option.innerHTML = client;
                    option.value = client;
                    document.getElementById("<%= memberList.ClientID %>").appendChild(option);
                })
            });

            var addMember = function () {
                hub.invoke('addClient', localStorage.getItem("username"), localStorage.getItem("roomname"));
                hub.invoke('updateClients', localStorage.getItem("roomname"));
            }

            var sndFunc = function () {
                var msg = $("#<%= messageBox.ClientID %>").val();
                var username = localStorage.getItem("username");
                var roomname = localStorage.getItem("roomname");
                $("#<%= messageBox.ClientID %>").val(""); //clear the message box after sending message
                hub.invoke('BroadCastMessage', roomname, username, ": " + msg);
            };

            if (isJoin === "false") {
                con.start().done(function () {
                    var username = localStorage.getItem("username");
                    var roomname = localStorage.getItem("roomname");
                    hub.invoke('CreateRoom', roomname, username);
                    addMember();
                });
            }
            else {
                con.start().done(function () {
                    var roomname = localStorage.getItem("roomname");
                    var username = localStorage.getItem("username");
                    hub.invoke('JoinRoom', roomname, username);
                    <%if (!ChatHub.Exists) {%>
                    //send error message
                    alert('Error: This chat does not exist!');
                    window.location = "ChatLobby.aspx";
                    <%}%>
                    addMember();
                });
            }

            con.start().done(function () {
                $('#<%=send.ClientID %>').click(sndFunc);
            });
            con.start().done(function () {
                $(document).keypress(function (e) {
                    if (e.keyCode === 13) {
                         e.preventDefault();
                         sndFunc();
                    }
                });
            });
        })
    </script>
        <div class ="chat">
            <h2>SmallTalk</h2>
            <asp:TextBox ID="chatBox" class="chatBox" runat="server" ReadOnly="true" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
             <br /> 
            <div class ="message">
                <asp:Label runat="server" Text="Message:"></asp:Label>
                <asp:TextBox ID="messageBox" class="messageBox" AutoComplete="off" runat="server"></asp:TextBox>
            </div>
            <div class ="chatButtons">
                <asp:Button ID="emoji" class="button green small" runat="server" Text="Emoji" />
                <asp:Button ID="gif" class="button green small" runat="server" Text="Gif" />
                <asp:Button ID="send" class="button blue small float-right" runat="server" Text="Send" onClientClick="return false;"/>
            </div>
        </div>
        <div class="members">
            <h2>Members
                <asp:Button ID="shareBtn" class="button blue small" runat="server" Text="Share" />
            </h2>
            <asp:ListBox ID="memberList" class="memberList" runat="server" ClientIDMode="Static"></asp:ListBox>
        </div>
</asp:Content>