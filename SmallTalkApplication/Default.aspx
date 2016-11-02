<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" EnableEventValidation="false"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function validateData() {

            var displayName = document.getElementById('<%=displayName.ClientID%>').value;

            if (displayName === "" || !displayName) {
                document.getElementById('<%=displayNameValidation.ClientID%>').style.color = 'red';
                document.getElementById('<%=displayNameValidation.ClientID%>').style.display = 'inherit';
                return false;

            } else {
                return true;
            }
        }
    </script>
     <div class='container horizontal-layout'>
         <div class='horizontal-inline'>
             <h1>Small Talk</h1>
             <asp:Button ID="CreateBtn" class="button green" runat="server" Text="Create" Enabled="true" OnClick="onButtonClick"/>
             <asp:Button ID="JoinBtn" class="button blue" runat="server" Text="Join" Enabled="true" OnClick="onButtonClick"/>
             <asp:Button ID="hdnField" runat="server" style="visibility:hidden" />
         </div>
         <div class='horizontal-inline'>
             <img src="Content/Images/chatbubble.png"/>         
         </div>
         <asp:Panel ID="Panel1" runat="server"> 
             <div>
                 <h2> Choose your display name: 
                    <asp:TextBox id="displayName" runat="server" type="text" autofocus MaxLength="20"/>
                    &nbsp;
                    <asp:Label id="displayNameValidation" runat="server" type="text" Text="Required!" style="display: none; float: right;"/>
                 </h2>
                 <% if(ViewState["buttonClicked"].Equals("JoinBtn")) { %>
                    <h2> Enter the chat code:
                        <input id="chat-code" type="text" />
                    </h2>
                 <% } %> 
             </div>
             <asp:Button ID="OK" Text="OK" runat="server" class="button green" onClientClick="return validateData();"/>
             <asp:Button ID="Cancel" Text="Cancel" runat="server" class="button blue"/>
         </asp:Panel>
         <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" OkControlID="OK" PopupControlID="Panel1" TargetControlID="hdnField" BackgroundCssClass="modalBackground">
         </ajaxToolkit:ModalPopupExtender>
     </div>

</asp:Content>
