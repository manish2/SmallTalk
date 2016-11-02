<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" EnableEventValidation="false"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <div class='container'>
         <div>
             <h1>Small Talk</h1>
             <asp:Button ID="CreateBtn" class="button blue" runat="server" Text="Create" Enabled="true" OnClick="onButtonClick"/>
             <asp:Button ID="JoinBtn" class="button green" runat="server" Text="Join" Enabled="true" OnClick="onButtonClick"/>
             <asp:Button ID="hdnField" runat="server" style="visibility:hidden" />
         </div>
         <div>
             <img src="Content/Images/chatbubble.png"/>         
         </div>
         <asp:Panel ID="Panel1" runat="server"> 
             <div>
                 <h2> Choose your chat name:
                    <input id="user-name" type="text" />
                 </h2>
                 <% if(ViewState["buttonClicked"].Equals("JoinBtn")) { %>
                    <h2> Enter the chat code:
                        <input id="chat-code" type="text" />
                    </h2>
                 <% } %> 
             </div>
             <asp:Button ID="OK" Text="OK" runat="server" class="button green"/>
             <asp:Button ID="Cancel" Text="Cancel" runat="server" class="button blue" />
         </asp:Panel>
         <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" OkControlID="OK" PopupControlID="Panel1" TargetControlID="hdnField" BackgroundCssClass="modalBackground">
         </ajaxToolkit:ModalPopupExtender>
     </div>

</asp:Content>
