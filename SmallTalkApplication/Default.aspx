<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" EnableEventValidation="false"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
    <script>
        function validateData() {

            var displayName = document.getElementById('<%=displayName.ClientID%>').value;

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
                chatCode = document.getElementById('<%=chatCode.ClientID%>').value;
                if (chatCode === "" || !chatCode) {
                    document.getElementById('<%=chatCodeValidation.ClientID%>').style.display = 'inherit';
                    valid = false;
                    
                } else {
                    document.getElementById('<%=chatCodeValidation.ClientID%>').style.display = 'none';
                }
            } catch (err) { }
            
            if (valid) {
                window.location = 'Chat.aspx';
            }

            return false;
        }
    </script>
     <div class='container'>
         <div>
             <h1>Small Talk</h1>
             <asp:Button ID="CreateBtn" class="button green" runat="server" Text="Create" Enabled="true" OnClick="onButtonClick"/>
             <asp:Button ID="JoinBtn" class="button blue" runat="server" Text="Join" Enabled="true" OnClick="onButtonClick"/>
             <asp:Button ID="hdnField" runat="server" style="visibility:hidden" />
         </div>
         <div>
             <img src="Content/Images/chatbubble.png"/>         
         </div>
         <asp:Panel ID="Panel1" runat="server"> 
             <div>
                 <h2> Choose your display name: 
                    <asp:TextBox id="displayName" runat="server" type="text" autofocus MaxLength="20" ClientIDMode="Static"/>
                    &nbsp;
                    <asp:Label id="displayNameValidation" runat="server" type="text" Text="Required!" style="display: none; float: right; color: red;"/>
                    
                 </h2>
                 <h2> 
                 <% if(ViewState["buttonClicked"].Equals("JoinBtn")) {
                         isJoin = true; %>
                        Enter the chat code:
                        <asp:TextBox id="chatCode" type="text" runat="server"  />
                        
                 <% } %> 
                    <asp:Label id="chatCodeValidation" runat="server" type="text" Text="Required!" style="display: none; float: right; color: red;"/>
                </h2>
             </div>
             <asp:Button ID="OK" Text="OK" runat="server" class="button green" onClientClick="return validateData();"/>
             <asp:Button ID="Cancel" Text="Cancel" runat="server" class="button blue"/>
         </asp:Panel>
         <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" OkControlID="Cancel" PopupControlID="Panel1" TargetControlID="hdnField" BackgroundCssClass="modalBackground">
         </ajaxToolkit:ModalPopupExtender>
     </div>

</asp:Content>

