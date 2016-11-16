<%@ Page Title="SmallTalk" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" EnableEventValidation="false"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.js"></script>
    <script type="text/javascript"> 
        $(function () {
            var con = $.hubConnection();
            var hub = con.createHubProxy('chatServer');
            hub.on('RecieveMessage', function (message) {
                var currentVal = $('#chatBox').val();
                var username = localStorage.getItem("username");
                $('#chatBox').val(currentVal + username + message + "\n");      
            });
            con.start().done(function () {
                if (localStorage.getItem("username") == null) {
                    window.location = "Default.aspx";
                }
                else {
                    hub.invoke('BroadCastMessage', " joined the chat! ");
                    hub.invoke('addClient', localStorage.getItem("username"));

                    var memberList = $("#<%= memberList.ClientID %>");
                    if (document.getElementById("MainContent_memberList") != null) {
                        hub.invoke('getClients').done(function(clients) { $.each(clients, function () {
                            var client = this;
                            var option = document.createElement("OPTION");
                            option.innerHTML = client;
                            option.value = client;
                            document.getElementById("MainContent_memberList").appendChild(option);
                            })
                        });
                        hub.invoke('BroadCastMessage', " tried to add to member list");
                    }
                }
            });
            con.start().done(function () {
                $('#<%=send.ClientID %>').click(function () {
                    var messageBox = $("#<%= messageBox.ClientID %>");
                    hub.invoke('BroadCastMessage', ": " + messageBox.val());
                    messageBox.val("");
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
            <asp:ListBox ID="memberList" class="memberList" runat="server"></asp:ListBox>
        </div>
</asp:Content>