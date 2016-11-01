<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .modalBackground 
        { 
            background-color:black;
            filter:alpha(opacity = 90);
            opacity : .8;
        }
        .modalPopup 
        { 
            background-color:black; 
        }
    </style>
     <div class='container horizontal-layout'>
         <div class='horizontal-inline'>
             <h1>Small Talk</h1>
             <asp:Button ID="JoinBtn" class="button green" runat="server" Text="Join"/>
             <asp:Button ID="CreateBtn" class="button blue" runat="server" Text="Create" Enabled="true" onclick="onCreateClick" />
         </div>
         <div class='horizontal-inline'>
             <img src="Content/Images/chatbubble.png"/>         
         </div>
         <asp:Panel ID="Panel1" runat="server"> 
             <div>
                 <h2> Choose your chat name:
                    <input id="user-name" type="text" />
                 </h2>
             </div>
             <asp:Button ID="OK" Text="OK" runat="server" class="button green"/>
             <asp:Button ID="Cancel" Text="Cancel" runat="server" class="button blue" />
         </asp:Panel>
         <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" OkControlID="OK" PopupControlID="Panel1" TargetControlID="CreateBtn" BackgroundCssClass="modalBackground">

         </ajaxToolkit:ModalPopupExtender>
     </div>

</asp:Content>
