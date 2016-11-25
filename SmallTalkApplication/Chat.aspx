<%@ Page Title="SmallTalk" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" EnableEventValidation="false" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.js"></script>
    <script src="//twemoji.maxcdn.com/twemoji.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var isJoin = localStorage.getItem("isJoin");
            var con = $.hubConnection();
            con.connectionSlow(function () {
                console.log('We are currently experiencing difficulties with the connection.')
            });
            var hub = con.createHubProxy('ChatServer');
            hub.on('AddMessage', function (username, message, server) {
                /*
                var currentVal = $('#chatBox').val();
                $('#chatBox').val(currentVal + username + message + "\n");
                */
                var side = "left";
                if (username == localStorage.getItem("username")) {
                    side = "right"
                }

                if (server) {
                    $('#chatBox').append("<div class = 'messageFrame'><div class = 'serverMessage'>"+ username + message +"</div></div>");
                } else {
                    $('#chatBox').append("<div class = 'messageFrame " + side + "'><div class = 'chatMessage'><div class = 'name'>" + username + "</div><div class = 'message'>" + message + "</div></div></div>");
                }
                var objDiv = document.getElementById("chatBox");
                objDiv.scrollTop = objDiv.scrollHeight;
            });
            hub.on('UpdateMembers', function (clients) {
                document.getElementById("<%= memberList.ClientID %>").innerHTML = "";
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
            }

            var removeMember = function(){
                hub.invoke('removeClient', localStorage.getItem("username"), localStorage.getItem("roomname"));
            }

            var sndFunc = function () {
                var msg = $("#<%= messageBox.ClientID %>").val();
                var username = localStorage.getItem("username");
                var roomname = localStorage.getItem("roomname");
                $("#<%= messageBox.ClientID %>").val(""); //clear the message box after sending message
                hub.invoke('BroadCastMessage', roomname, username, msg, false);
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
                    <%if (!ChatHub.Exists)
        {%>
                    //send error message
                    alert('Error: This chat does not exist!');
                    window.location = "ChatLobby.aspx";
                    <%}%>
                    addMember();
                });
            }

            con.start().done(function () {
                document.getElementById('<%=chatID.ClientID%>').innerHTML = "Chat Code: " + localStorage.getItem("roomname");
                $('#<%=send.ClientID %>').click(sndFunc);
                //disconnect event 
                var roomname = localStorage.getItem("roomname");
                var username = localStorage.getItem("username");
                $(window).on('beforeunload', function () {
                    return " "; //creates a popup to warn user before disconnecting
                });
                $(window).unload(function () {
                    hub.invoke('BroadCastMessage', roomname, username, " left the chatroom!", true);
                    removeMember();
                    //Release all our data from localhost
                    localStorage.removeItem("roomname");
                    localStorage.removeItem("username");
                    localStorage.removeItem("isJoin");
                    return "Handler for .unload() called.";
                });
            });
            con.start().done(function () {
                $(document).keypress(function (e) {
                    if (e.keyCode === 13) {
                        e.preventDefault();
                        sndFunc();
                    }
                });
            });
            $(document).on('click', '#emoji', function (e) {
                $('#<%= emojiDiv.ClientID %>').toggle();
                $('.emojiOuter').css({
                    'left': $(this).offset().left + $(this).outerWidth() + 12,
                    'top': $(this).offset().top + $(this).height() - $('.emojiOuter').outerHeight() + 12,
                    'z-index': 1
                })
            });

            $.ajax({
                type: "GET",
                url: "../allEmojis.xml",
                dataType: "xml",
                success: function (xml) {
                    var row = 0; column = 0;
                    for (i = 0; i < 88; i++) {
                        $('.emojiTable').append('<tr></tr>');
                        for (j = 0; j < 10; j++) {
                            $(".emojiTable tr:last").append('<td></td>');
                        }
                    }
                    $(xml).find('Emoji').each(function () {
                        var id = $(this).find('ID').text();
                        $(".emojiTable tr:eq(" + row + ") > td:eq(" + column + ")").append(id);
                        console.log(id);
                        
                        if(column == 9) {
                            row++;
                            column = 0;
                        } else {
                            column++;
                        }
                    });
                },
                error: function () {
                    alert("The XML File could not be processed correctly.");
                }
            });

            $('.emojiTable').on('click', 'td', function () {
                var mm = $(this).text();
                var textVal = $("#messageBox").val();
                $("#messageBox").val(textVal + mm);
            });

            $('#shareBtn').click(function (e) {
                $('.pop').toggleClass('popOut');
                $('.popOut').css({
                    'left': $(this).offset().left + $(this).outerWidth() - $('.popOut').width(),
                    'top': $(this).offset().top + $(this).height() + $('.popOut').height() / 2
                })

            });
        })
    </script>
    <div class="chat">
        <h2>SmallTalk</h2>
        <!--<asp:TextBox ID="chatBox" class="chatBox" runat="server" ReadOnly="true" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
        -->
        <div id="chatBox" class ="chatBox"></div>
        <div class="emojiOuter">
            <div runat="server" id="emojiDiv" class="emoji-list">
                <table class="emojiTable">
                </table>
            </div>
        </div>
        <asp:Label runat="server" Text="Message:"></asp:Label>

        <div class="message">
            <asp:TextBox ID="messageBox" class="messageBox" runat="server" autocomplete="off" ClientIDMode="Static"></asp:TextBox>
            <asp:Button ID="send" class="button blue small" runat="server" Text="Send" OnClientClick="return false;" />
            <div class="chatButtons">
                <input type="button" id="emoji" class="button blue smaller" value="Emoji" />
                <asp:Button ID="gif" class="button blue smaller" runat="server" Text="Gif" />
            </div>
        </div>
    </div>
    <div class="members">
        <h2>Members
                <input type="button" id="shareBtn" class="button blue smaller" value="Share" />
        </h2>
        <div class="pop">
            <asp:Label ID="chatID" runat="server" ClientIDMode="Static"></asp:Label>
        </div>
        <asp:ListBox ID="memberList" class="memberList" runat="server" ClientIDMode="Static"></asp:ListBox>
    </div>
</asp:Content>
