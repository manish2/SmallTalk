<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ChatLobby.aspx.cs" Inherits="_Default" EnableEventValidation="false" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--This function validates our the username and chat link before the user can enter the chatroom -->
    <script>
        function validateData() {
            function Trim(value) {
                return value.replace(/^\s+|\s+$/gm, '');
            }
            //CHAT KEY: FIZWIFAE
            //we get the user's chat name
            var displayName = Trim(document.getElementById('<%=displayName.ClientID%>').value);

            var chatCode = "";

            var valid = true;

            if (displayName === "" || !displayName) {
                document.getElementById('<%=displayNameValidation.ClientID%>').style.display = 'inherit';
                valid = false;
            } else {
                document.getElementById('<%=displayNameValidation.ClientID%>').style.display = 'none';
                localStorage["username"] = $('#displayName').val();
            }
            try {
                chatCode = Trim(document.getElementById('<%=chatCode.ClientID%>').value);
                if (chatCode === "" || !chatCode) {
                    document.getElementById('<%=chatCodeValidation.ClientID%>').style.color = 'red';
                    document.getElementById('<%=chatCodeValidation.ClientID%>').style.display = 'inherit';
                    valid = false;
                } else {
                    document.getElementById('<%=chatCodeValidation.ClientID%>').style.display = 'none';
                }
            } catch (err) { console.log(err); }
            //if all info is valid we load the Chat.aspx page
            if (valid) {
                var isJoin = localStorage.getItem("isJoin");
                if (isJoin === "true") {
                    var roomname = $('#chatCode').val();
                    localStorage.setItem("roomname", roomname);
                }
                else {
                    //generate a random alphanumeric string as the room name
                    localStorage.setItem("roomname", '<%=ChatHub.RandomString(8)%>');
                }
                window.location = "Chat.aspx";
            }
            return false;

        }
    </script>
    <div class='container'>
        <div>
            <h1>Small Talk</h1>
            <h2>The simple way to chat</h2>
            <asp:Button ID="CreateBtn" class="button green" runat="server" Text="Create a Room" Enabled="true" OnClick="onButtonClick" />
            <asp:Button ID="JoinBtn" class="button blue" runat="server" Text="Join a Room" Enabled="true" OnClick="onButtonClick" />
            <asp:Button ID="hdnField" runat="server" Style="visibility: hidden" />
        </div>
        <div>
            <img src="Content/Images/chatbubble.png" />
        </div>
        <asp:Panel ID="Dialog" runat="server">
            <div>
                <% if (ViewState["buttonClicked"].Equals("JoinBtn"))
                    {%>
                <h3>Join an Existing Chat Room</h3>
                <% }
                else {%>
                <h3>Create a New Chat Room</h3>
                <%} %>
                <h2>Choose your display name: 
                    <asp:TextBox ID="displayName" runat="server" type="text" autofocus MaxLength="20" ClientIDMode="Static" />
                    &nbsp;
                    <asp:Label ID="displayNameValidation" runat="server" type="text" Text="Required!" Style="display: none; float: right; color: red;" />
                </h2>
                <h2>
                    <% if (ViewState["buttonClicked"].Equals("JoinBtn"))
                        {
                            isJoin = true; %>
                            Enter the chat code:
                            <asp:TextBox ID="chatCode" type="text" runat="server" ClientIDMode="Static" />
                    <script>
                        localStorage.setItem("isJoin", "true");
                    </script>
                    <% }
                    else {%>
                    <script>
                        localStorage.setItem("isJoin", "false");
                    </script>
                    <%} %>
                    <asp:Label ID="chatCodeValidation" runat="server" type="text" Text="Required!" Style="display: none; float: right; color: red;" />
                </h2>
            </div>
            <div>
                <asp:HiddenField ClientIDMode="static" runat="server" ID="Hidden1" />
                <asp:Button ID="OK" Text="OK" runat="server" class="button green" OnClientClick="return validateData();" />
                <asp:Button ID="Cancel" Text="Cancel" runat="server" class="button blue" />
            </div>
        </asp:Panel>
        <ajaxToolkit:ModalPopupExtender ID="ModalDialog" runat="server" OkControlID="Cancel" PopupControlID="Dialog" TargetControlID="hdnField" BackgroundCssClass="modalBackground">
        </ajaxToolkit:ModalPopupExtender>
    </div>

</asp:Content>

