<%@ Page Title="SmallTalk" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" EnableEventValidation="false"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.js"></script>
    <link href="http://emojicss.com/emoji.css" rel="stylesheet">
    <script src="//twemoji.maxcdn.com/twemoji.min.js"></script>
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
                }
            });
            con.start().done(function () {
                $('#<%=send.ClientID %>').click(function () {
                    var msg = $("#<%= messageBox.ClientID %>").val();
                    hub.invoke('BroadCastMessage', ": " + msg);
                });
            });
            $(document).on('click', '#emoji', function () {
                $('#<%= emojiDiv.ClientID %>').toggle();
            });
            $("#emoji").click(function () {
                $("#emojiDiv").toggle();
            });
            $("tr.emojis td").click(function (e) {
                var mm = $(this).text();
                var textVal = $("#messageBox").val();
                $("#messageBox").val(textVal + mm);
                e.stopPropagation();
            });
        })
    </script>
        <div class ="chat">
            <h2>SmallTalk</h2>
            <asp:TextBox ID="chatBox" class="chatBox" runat="server" ReadOnly="true" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
            <div class="emojiOuter">
                <div runat="server" id="emojiDiv" class="emoji-list">
                    <table class="emojiTable">
                        <tr class="emojis">
	                        <td>&#x1F004;</td>
	                        <td>&#x1F0CF;</td>
	                        <td>&#x1F170;</td>
	                        <td>&#x1F171;</td>
	                        <td>&#x1F17E;</td>
	                        <td>&#x1F17F;</td>
	                        <td>&#x1F18E;</td>
	                        <td>&#x1F191;</td>
	                        <td>&#x1F192;</td>
	                        <td>&#x1F193;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F194;</td>
	                        <td>&#x1F195;</td>
	                        <td>&#x1F196;</td>
	                        <td>&#x1F197;</td>
	                        <td>&#x1F198;</td>
	                        <td>&#x1F199;</td>
	                        <td>&#x1F19A;</td>
	                        <td>&#x1F1E6;</td>
	                        <td>&#x1F1E7;</td>
	                        <td>&#x1F1E8;&#x1F1F3;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F1E8;</td>
	                        <td>&#x1F1E9;&#x1F1EA;</td>
	                        <td>&#x1F1E9;</td>
	                        <td>&#x1F1EA;&#x1F1F8;</td>
	                        <td>&#x1F1EA;</td>
	                        <td>&#x1F1EB;&#x1F1F7;</td>
	                        <td>&#x1F1EB;</td>
	                        <td>&#x1F1EC;&#x1F1E7;</td>
	                        <td>&#x1F1EC;</td>
	                        <td>&#x1F1ED;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F1EE;&#x1F1F9;</td>
	                        <td>&#x1F1EE;</td>
	                        <td>&#x1F1EF;&#x1F1F5;</td>
	                        <td>&#x1F1EF;</td>
	                        <td>&#x1F1F0;&#x1F1F7;</td>
	                        <td>&#x1F1F0;</td>
	                        <td>&#x1F1F1;</td>
	                        <td>&#x1F1F2;</td>
	                        <td>&#x1F1F3;</td>
	                        <td>&#x1F1F4;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F1F5;</td>
	                        <td>&#x1F1F6;</td>
	                        <td>&#x1F1F7;&#x1F1FA;</td>
	                        <td>&#x1F1F7;</td>
	                        <td>&#x1F1F8;</td>
	                        <td>&#x1F1F9;</td>
	                        <td>&#x1F1FA;&#x1F1F8;</td>
	                        <td>&#x1F1FA;</td>
	                        <td>&#x1F1FB;</td>
	                        <td>&#x1F1FC;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F1FD;</td>
	                        <td>&#x1F1FE;</td>
	                        <td>&#x1F1FF;</td>
	                        <td>&#x1F201;</td>
	                        <td>&#x1F202;</td>
	                        <td>&#x1F21A;</td>
	                        <td>&#x1F22F;</td>
	                        <td>&#x1F232;</td>
	                        <td>&#x1F233;</td>
	                        <td>&#x1F234;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F235;</td>
	                        <td>&#x1F236;</td>
	                        <td>&#x1F237;</td>
	                        <td>&#x1F238;</td>
	                        <td>&#x1F239;</td>
	                        <td>&#x1F23A;</td>
	                        <td>&#x1F250;</td>
	                        <td>&#x1F251;</td>
	                        <td>&#x1F300;</td>
	                        <td>&#x1F301;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F302;</td>
	                        <td>&#x1F303;</td>
	                        <td>&#x1F304;</td>
	                        <td>&#x1F305;</td>
	                        <td>&#x1F306;</td>
	                        <td>&#x1F307;</td>
	                        <td>&#x1F308;</td>
	                        <td>&#x1F309;</td>
	                        <td>&#x1F30A;</td>
	                        <td>&#x1F30B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F30C;</td>
	                        <td>&#x1F30D;</td>
	                        <td>&#x1F30E;</td>
	                        <td>&#x1F30F;</td>
	                        <td>&#x1F310;</td>
	                        <td>&#x1F311;</td>
	                        <td>&#x1F312;</td>
	                        <td>&#x1F313;</td>
	                        <td>&#x1F314;</td>
	                        <td>&#x1F315;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F316;</td>
	                        <td>&#x1F317;</td>
	                        <td>&#x1F318;</td>
	                        <td>&#x1F319;</td>
	                        <td>&#x1F31A;</td>
	                        <td>&#x1F31B;</td>
	                        <td>&#x1F31C;</td>
	                        <td>&#x1F31D;</td>
	                        <td>&#x1F31E;</td>
	                        <td>&#x1F31F;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F320;</td>
	                        <td>&#x1F330;</td>
	                        <td>&#x1F331;</td>
	                        <td>&#x1F332;</td>
	                        <td>&#x1F333;</td>
	                        <td>&#x1F334;</td>
	                        <td>&#x1F335;</td>
	                        <td>&#x1F337;</td>
	                        <td>&#x1F338;</td>
	                        <td>&#x1F339;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F33A;</td>
	                        <td>&#x1F33B;</td>
	                        <td>&#x1F33C;</td>
	                        <td>&#x1F33D;</td>
	                        <td>&#x1F33E;</td>
	                        <td>&#x1F33F;</td>
	                        <td>&#x1F340;</td>
	                        <td>&#x1F341;</td>
	                        <td>&#x1F342;</td>
	                        <td>&#x1F343;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F344;</td>
	                        <td>&#x1F345;</td>
	                        <td>&#x1F346;</td>
	                        <td>&#x1F347;</td>
	                        <td>&#x1F348;</td>
	                        <td>&#x1F349;</td>
	                        <td>&#x1F34A;</td>
	                        <td>&#x1F34B;</td>
	                        <td>&#x1F34C;</td>
	                        <td>&#x1F34D;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F34E;</td>
	                        <td>&#x1F34F;</td>
	                        <td>&#x1F350;</td>
	                        <td>&#x1F351;</td>
	                        <td>&#x1F352;</td>
	                        <td>&#x1F353;</td>
	                        <td>&#x1F354;</td>
	                        <td>&#x1F355;</td>
	                        <td>&#x1F356;</td>
	                        <td>&#x1F357;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F358;</td>
	                        <td>&#x1F359;</td>
	                        <td>&#x1F35A;</td>
	                        <td>&#x1F35B;</td>
	                        <td>&#x1F35C;</td>
	                        <td>&#x1F35D;</td>
	                        <td>&#x1F35E;</td>
	                        <td>&#x1F35F;</td>
	                        <td>&#x1F360;</td>
	                        <td>&#x1F361;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F362;</td>
	                        <td>&#x1F363;</td>
	                        <td>&#x1F364;</td>
	                        <td>&#x1F365;</td>
	                        <td>&#x1F366;</td>
	                        <td>&#x1F367;</td>
	                        <td>&#x1F368;</td>
	                        <td>&#x1F369;</td>
	                        <td>&#x1F36A;</td>
	                        <td>&#x1F36B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F36C;</td>
	                        <td>&#x1F36D;</td>
	                        <td>&#x1F36E;</td>
	                        <td>&#x1F36F;</td>
	                        <td>&#x1F370;</td>
	                        <td>&#x1F371;</td>
	                        <td>&#x1F372;</td>
	                        <td>&#x1F373;</td>
	                        <td>&#x1F374;</td>
	                        <td>&#x1F375;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F376;</td>
	                        <td>&#x1F377;</td>
	                        <td>&#x1F378;</td>
	                        <td>&#x1F379;</td>
	                        <td>&#x1F37A;</td>
	                        <td>&#x1F37B;</td>
	                        <td>&#x1F37C;</td>
	                        <td>&#x1F380;</td>
	                        <td>&#x1F381;</td>
	                        <td>&#x1F382;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F383;</td>
	                        <td>&#x1F384;</td>
	                        <td>&#x1F385;</td>
	                        <td>&#x1F386;</td>
	                        <td>&#x1F387;</td>
	                        <td>&#x1F388;</td>
	                        <td>&#x1F389;</td>
	                        <td>&#x1F38A;</td>
	                        <td>&#x1F38B;</td>
	                        <td>&#x1F38C;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F38D;</td>
	                        <td>&#x1F38E;</td>
	                        <td>&#x1F38F;</td>
	                        <td>&#x1F390;</td>
	                        <td>&#x1F391;</td>
	                        <td>&#x1F392;</td>
	                        <td>&#x1F393;</td>
	                        <td>&#x1F3A0;</td>
	                        <td>&#x1F3A1;</td>
	                        <td>&#x1F3A2;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F3A3;</td>
	                        <td>&#x1F3A4;</td>
	                        <td>&#x1F3A5;</td>
	                        <td>&#x1F3A6;</td>
	                        <td>&#x1F3A7;</td>
	                        <td>&#x1F3A8;</td>
	                        <td>&#x1F3A9;</td>
	                        <td>&#x1F3AA;</td>
	                        <td>&#x1F3AB;</td>
	                        <td>&#x1F3AC;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F3AD;</td>
	                        <td>&#x1F3AE;</td>
	                        <td>&#x1F3AF;</td>
	                        <td>&#x1F3B0;</td>
	                        <td>&#x1F3B1;</td>
	                        <td>&#x1F3B2;</td>
	                        <td>&#x1F3B3;</td>
	                        <td>&#x1F3B4;</td>
	                        <td>&#x1F3B5;</td>
	                        <td>&#x1F3B6;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F3B7;</td>
	                        <td>&#x1F3B8;</td>
	                        <td>&#x1F3B9;</td>
	                        <td>&#x1F3BA;</td>
	                        <td>&#x1F3BB;</td>
	                        <td>&#x1F3BC;</td>
	                        <td>&#x1F3BD;</td>
	                        <td>&#x1F3BE;</td>
	                        <td>&#x1F3BF;</td>
	                        <td>&#x1F3C0;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F3C1;</td>
	                        <td>&#x1F3C2;</td>
	                        <td>&#x1F3C3;</td>
	                        <td>&#x1F3C4;</td>
	                        <td>&#x1F3C6;</td>
	                        <td>&#x1F3C7;</td>
	                        <td>&#x1F3C8;</td>
	                        <td>&#x1F3C9;</td>
	                        <td>&#x1F3CA;</td>
	                        <td>&#x1F3E0;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F3E1;</td>
	                        <td>&#x1F3E2;</td>
	                        <td>&#x1F3E3;</td>
	                        <td>&#x1F3E4;</td>
	                        <td>&#x1F3E5;</td>
	                        <td>&#x1F3E6;</td>
	                        <td>&#x1F3E7;</td>
	                        <td>&#x1F3E8;</td>
	                        <td>&#x1F3E9;</td>
	                        <td>&#x1F3EA;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F3EB;</td>
	                        <td>&#x1F3EC;</td>
	                        <td>&#x1F3ED;</td>
	                        <td>&#x1F3EE;</td>
	                        <td>&#x1F3EF;</td>
	                        <td>&#x1F3F0;</td>
	                        <td>&#x1F400;</td>
	                        <td>&#x1F401;</td>
	                        <td>&#x1F402;</td>
	                        <td>&#x1F403;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F404;</td>
	                        <td>&#x1F405;</td>
	                        <td>&#x1F406;</td>
	                        <td>&#x1F407;</td>
	                        <td>&#x1F408;</td>
	                        <td>&#x1F409;</td>
	                        <td>&#x1F40A;</td>
	                        <td>&#x1F40B;</td>
	                        <td>&#x1F40C;</td>
	                        <td>&#x1F40D;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F40E;</td>
	                        <td>&#x1F40F;</td>
	                        <td>&#x1F410;</td>
	                        <td>&#x1F411;</td>
	                        <td>&#x1F412;</td>
	                        <td>&#x1F413;</td>
	                        <td>&#x1F414;</td>
	                        <td>&#x1F415;</td>
	                        <td>&#x1F416;</td>
	                        <td>&#x1F417;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F418;</td>
	                        <td>&#x1F419;</td>
	                        <td>&#x1F41A;</td>
	                        <td>&#x1F41B;</td>
	                        <td>&#x1F41C;</td>
	                        <td>&#x1F41D;</td>
	                        <td>&#x1F41E;</td>
	                        <td>&#x1F41F;</td>
	                        <td>&#x1F420;</td>
	                        <td>&#x1F421;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F422;</td>
	                        <td>&#x1F423;</td>
	                        <td>&#x1F424;</td>
	                        <td>&#x1F425;</td>
	                        <td>&#x1F426;</td>
	                        <td>&#x1F427;</td>
	                        <td>&#x1F428;</td>
	                        <td>&#x1F429;</td>
	                        <td>&#x1F42A;</td>
	                        <td>&#x1F42B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F42C;</td>
	                        <td>&#x1F42D;</td>
	                        <td>&#x1F42E;</td>
	                        <td>&#x1F42F;</td>
	                        <td>&#x1F430;</td>
	                        <td>&#x1F431;</td>
	                        <td>&#x1F432;</td>
	                        <td>&#x1F433;</td>
	                        <td>&#x1F434;</td>
	                        <td>&#x1F435;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F436;</td>
	                        <td>&#x1F437;</td>
	                        <td>&#x1F438;</td>
	                        <td>&#x1F439;</td>
	                        <td>&#x1F43A;</td>
	                        <td>&#x1F43B;</td>
	                        <td>&#x1F43C;</td>
	                        <td>&#x1F43D;</td>
	                        <td>&#x1F43E;</td>
	                        <td>&#x1F440;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F442;</td>
	                        <td>&#x1F443;</td>
	                        <td>&#x1F444;</td>
	                        <td>&#x1F445;</td>
	                        <td>&#x1F446;</td>
	                        <td>&#x1F447;</td>
	                        <td>&#x1F448;</td>
	                        <td>&#x1F449;</td>
	                        <td>&#x1F44A;</td>
	                        <td>&#x1F44B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F44C;</td>
	                        <td>&#x1F44D;</td>
	                        <td>&#x1F44E;</td>
	                        <td>&#x1F44F;</td>
	                        <td>&#x1F450;</td>
	                        <td>&#x1F451;</td>
	                        <td>&#x1F452;</td>
	                        <td>&#x1F453;</td>
	                        <td>&#x1F454;</td>
	                        <td>&#x1F455;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F456;</td>
	                        <td>&#x1F457;</td>
	                        <td>&#x1F458;</td>
	                        <td>&#x1F459;</td>
	                        <td>&#x1F45A;</td>
	                        <td>&#x1F45B;</td>
	                        <td>&#x1F45C;</td>
	                        <td>&#x1F45D;</td>
	                        <td>&#x1F45E;</td>
	                        <td>&#x1F45F;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F460;</td>
	                        <td>&#x1F461;</td>
	                        <td>&#x1F462;</td>
	                        <td>&#x1F463;</td>
	                        <td>&#x1F464;</td>
	                        <td>&#x1F465;</td>
	                        <td>&#x1F466;</td>
	                        <td>&#x1F467;</td>
	                        <td>&#x1F468;</td>
	                        <td>&#x1F469;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F46A;</td>
	                        <td>&#x1F46B;</td>
	                        <td>&#x1F46C;</td>
	                        <td>&#x1F46D;</td>
	                        <td>&#x1F46E;</td>
	                        <td>&#x1F46F;</td>
	                        <td>&#x1F470;</td>
	                        <td>&#x1F471;</td>
	                        <td>&#x1F472;</td>
	                        <td>&#x1F473;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F474;</td>
	                        <td>&#x1F475;</td>
	                        <td>&#x1F476;</td>
	                        <td>&#x1F477;</td>
	                        <td>&#x1F478;</td>
	                        <td>&#x1F479;</td>
	                        <td>&#x1F47A;</td>
	                        <td>&#x1F47B;</td>
	                        <td>&#x1F47C;</td>
	                        <td>&#x1F47D;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F47E;</td>
	                        <td>&#x1F47F;</td>
	                        <td>&#x1F480;</td>
	                        <td>&#x1F481;</td>
	                        <td>&#x1F482;</td>
	                        <td>&#x1F483;</td>
	                        <td>&#x1F484;</td>
	                        <td>&#x1F485;</td>
	                        <td>&#x1F486;</td>
	                        <td>&#x1F487;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F488;</td>
	                        <td>&#x1F489;</td>
	                        <td>&#x1F48A;</td>
	                        <td>&#x1F48B;</td>
	                        <td>&#x1F48C;</td>
	                        <td>&#x1F48D;</td>
	                        <td>&#x1F48E;</td>
	                        <td>&#x1F48F;</td>
	                        <td>&#x1F490;</td>
	                        <td>&#x1F491;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F492;</td>
	                        <td>&#x1F493;</td>
	                        <td>&#x1F494;</td>
	                        <td>&#x1F495;</td>
	                        <td>&#x1F496;</td>
	                        <td>&#x1F497;</td>
	                        <td>&#x1F498;</td>
	                        <td>&#x1F499;</td>
	                        <td>&#x1F49A;</td>
	                        <td>&#x1F49B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F49C;</td>
	                        <td>&#x1F49D;</td>
	                        <td>&#x1F49E;</td>
	                        <td>&#x1F49F;</td>
	                        <td>&#x1F4A0;</td>
	                        <td>&#x1F4A1;</td>
	                        <td>&#x1F4A2;</td>
	                        <td>&#x1F4A3;</td>
	                        <td>&#x1F4A4;</td>
	                        <td>&#x1F4A5;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4A6;</td>
	                        <td>&#x1F4A7;</td>
	                        <td>&#x1F4A8;</td>
	                        <td>&#x1F4A9;</td>
	                        <td>&#x1F4AA;</td>
	                        <td>&#x1F4AB;</td>
	                        <td>&#x1F4AC;</td>
	                        <td>&#x1F4AD;</td>
	                        <td>&#x1F4AE;</td>
	                        <td>&#x1F4AF;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4B0;</td>
	                        <td>&#x1F4B1;</td>
	                        <td>&#x1F4B2;</td>
	                        <td>&#x1F4B3;</td>
	                        <td>&#x1F4B4;</td>
	                        <td>&#x1F4B5;</td>
	                        <td>&#x1F4B6;</td>
	                        <td>&#x1F4B7;</td>
	                        <td>&#x1F4B8;</td>
	                        <td>&#x1F4B9;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4BA;</td>
	                        <td>&#x1F4BB;</td>
	                        <td>&#x1F4BC;</td>
	                        <td>&#x1F4BD;</td>
	                        <td>&#x1F4BE;</td>
	                        <td>&#x1F4BF;</td>
	                        <td>&#x1F4C0;</td>
	                        <td>&#x1F4C1;</td>
	                        <td>&#x1F4C2;</td>
	                        <td>&#x1F4C3;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4C4;</td>
	                        <td>&#x1F4C5;</td>
	                        <td>&#x1F4C6;</td>
	                        <td>&#x1F4C7;</td>
	                        <td>&#x1F4C8;</td>
	                        <td>&#x1F4C9;</td>
	                        <td>&#x1F4CA;</td>
	                        <td>&#x1F4CB;</td>
	                        <td>&#x1F4CC;</td>
	                        <td>&#x1F4CD;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4CE;</td>
	                        <td>&#x1F4CF;</td>
	                        <td>&#x1F4D0;</td>
	                        <td>&#x1F4D1;</td>
	                        <td>&#x1F4D2;</td>
	                        <td>&#x1F4D3;</td>
	                        <td>&#x1F4D4;</td>
	                        <td>&#x1F4D5;</td>
	                        <td>&#x1F4D6;</td>
	                        <td>&#x1F4D7;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4D8;</td>
	                        <td>&#x1F4D9;</td>
	                        <td>&#x1F4DA;</td>
	                        <td>&#x1F4DB;</td>
	                        <td>&#x1F4DC;</td>
	                        <td>&#x1F4DD;</td>
	                        <td>&#x1F4DE;</td>
	                        <td>&#x1F4DF;</td>
	                        <td>&#x1F4E0;</td>
	                        <td>&#x1F4E1;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4E2;</td>
	                        <td>&#x1F4E3;</td>
	                        <td>&#x1F4E4;</td>
	                        <td>&#x1F4E5;</td>
	                        <td>&#x1F4E6;</td>
	                        <td>&#x1F4E7;</td>
	                        <td>&#x1F4E8;</td>
	                        <td>&#x1F4E9;</td>
	                        <td>&#x1F4EA;</td>
	                        <td>&#x1F4EB;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4EC;</td>
	                        <td>&#x1F4ED;</td>
	                        <td>&#x1F4EE;</td>
	                        <td>&#x1F4EF;</td>
	                        <td>&#x1F4F0;</td>
	                        <td>&#x1F4F1;</td>
	                        <td>&#x1F4F2;</td>
	                        <td>&#x1F4F3;</td>
	                        <td>&#x1F4F4;</td>
	                        <td>&#x1F4F5;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F4F6;</td>
	                        <td>&#x1F4F7;</td>
	                        <td>&#x1F4F9;</td>
	                        <td>&#x1F4FA;</td>
	                        <td>&#x1F4FB;</td>
	                        <td>&#x1F4FC;</td>
	                        <td>&#x1F500;</td>
	                        <td>&#x1F501;</td>
	                        <td>&#x1F502;</td>
	                        <td>&#x1F503;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F504;</td>
	                        <td>&#x1F505;</td>
	                        <td>&#x1F506;</td>
	                        <td>&#x1F507;</td>
	                        <td>&#x1F508;</td>
	                        <td>&#x1F509;</td>
	                        <td>&#x1F50A;</td>
	                        <td>&#x1F50B;</td>
	                        <td>&#x1F50C;</td>
	                        <td>&#x1F50D;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F50E;</td>
	                        <td>&#x1F50F;</td>
	                        <td>&#x1F510;</td>
	                        <td>&#x1F511;</td>
	                        <td>&#x1F512;</td>
	                        <td>&#x1F513;</td>
	                        <td>&#x1F514;</td>
	                        <td>&#x1F515;</td>
	                        <td>&#x1F516;</td>
	                        <td>&#x1F517;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F518;</td>
	                        <td>&#x1F519;</td>
	                        <td>&#x1F51A;</td>
	                        <td>&#x1F51B;</td>
	                        <td>&#x1F51C;</td>
	                        <td>&#x1F51D;</td>
	                        <td>&#x1F51E;</td>
	                        <td>&#x1F51F;</td>
	                        <td>&#x1F520;</td>
	                        <td>&#x1F521;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F522;</td>
	                        <td>&#x1F523;</td>
	                        <td>&#x1F524;</td>
	                        <td>&#x1F525;</td>
	                        <td>&#x1F526;</td>
	                        <td>&#x1F527;</td>
	                        <td>&#x1F528;</td>
	                        <td>&#x1F529;</td>
	                        <td>&#x1F52A;</td>
	                        <td>&#x1F52B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F52C;</td>
	                        <td>&#x1F52D;</td>
	                        <td>&#x1F52E;</td>
	                        <td>&#x1F52F;</td>
	                        <td>&#x1F530;</td>
	                        <td>&#x1F531;</td>
	                        <td>&#x1F532;</td>
	                        <td>&#x1F533;</td>
	                        <td>&#x1F534;</td>
	                        <td>&#x1F535;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F536;</td>
	                        <td>&#x1F537;</td>
	                        <td>&#x1F538;</td>
	                        <td>&#x1F539;</td>
	                        <td>&#x1F53A;</td>
	                        <td>&#x1F53B;</td>
	                        <td>&#x1F53C;</td>
	                        <td>&#x1F53D;</td>
	                        <td>&#x1F550;</td>
	                        <td>&#x1F551;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F552;</td>
	                        <td>&#x1F553;</td>
	                        <td>&#x1F554;</td>
	                        <td>&#x1F555;</td>
	                        <td>&#x1F556;</td>
	                        <td>&#x1F557;</td>
	                        <td>&#x1F558;</td>
	                        <td>&#x1F559;</td>
	                        <td>&#x1F55A;</td>
	                        <td>&#x1F55B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F55C;</td>
	                        <td>&#x1F55D;</td>
	                        <td>&#x1F55E;</td>
	                        <td>&#x1F55F;</td>
	                        <td>&#x1F560;</td>
	                        <td>&#x1F561;</td>
	                        <td>&#x1F562;</td>
	                        <td>&#x1F563;</td>
	                        <td>&#x1F564;</td>
	                        <td>&#x1F565;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F566;</td>
	                        <td>&#x1F567;</td>
	                        <td>&#x1F5FB;</td>
	                        <td>&#x1F5FC;</td>
	                        <td>&#x1F5FD;</td>
	                        <td>&#x1F5FE;</td>
	                        <td>&#x1F5FF;</td>
	                        <td>&#x1F600;</td>
	                        <td>&#x1F601;</td>
	                        <td>&#x1F602;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F603;</td>
	                        <td>&#x1F604;</td>
	                        <td>&#x1F605;</td>
	                        <td>&#x1F606;</td>
	                        <td>&#x1F607;</td>
	                        <td>&#x1F608;</td>
	                        <td>&#x1F609;</td>
	                        <td>&#x1F60A;</td>
	                        <td>&#x1F60B;</td>
	                        <td>&#x1F60C;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F60D;</td>
	                        <td>&#x1F60E;</td>
	                        <td>&#x1F60F;</td>
	                        <td>&#x1F610;</td>
	                        <td>&#x1F611;</td>
	                        <td>&#x1F612;</td>
	                        <td>&#x1F613;</td>
	                        <td>&#x1F614;</td>
	                        <td>&#x1F615;</td>
	                        <td>&#x1F616;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F617;</td>
	                        <td>&#x1F618;</td>
	                        <td>&#x1F619;</td>
	                        <td>&#x1F61A;</td>
	                        <td>&#x1F61B;</td>
	                        <td>&#x1F61C;</td>
	                        <td>&#x1F61D;</td>
	                        <td>&#x1F61E;</td>
	                        <td>&#x1F61F;</td>
	                        <td>&#x1F620;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F621;</td>
	                        <td>&#x1F622;</td>
	                        <td>&#x1F623;</td>
	                        <td>&#x1F624;</td>
	                        <td>&#x1F625;</td>
	                        <td>&#x1F626;</td>
	                        <td>&#x1F627;</td>
	                        <td>&#x1F628;</td>
	                        <td>&#x1F629;</td>
	                        <td>&#x1F62A;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F62B;</td>
	                        <td>&#x1F62C;</td>
	                        <td>&#x1F62D;</td>
	                        <td>&#x1F62E;</td>
	                        <td>&#x1F62F;</td>
	                        <td>&#x1F630;</td>
	                        <td>&#x1F631;</td>
	                        <td>&#x1F632;</td>
	                        <td>&#x1F633;</td>
	                        <td>&#x1F634;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F635;</td>
	                        <td>&#x1F636;</td>
	                        <td>&#x1F637;</td>
	                        <td>&#x1F638;</td>
	                        <td>&#x1F639;</td>
	                        <td>&#x1F63A;</td>
	                        <td>&#x1F63B;</td>
	                        <td>&#x1F63C;</td>
	                        <td>&#x1F63D;</td>
	                        <td>&#x1F63E;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F63F;</td>
	                        <td>&#x1F640;</td>
	                        <td>&#x1F641;</td>
	                        <td>&#x1F642;</td>
	                        <td>&#x1F645;</td>
	                        <td>&#x1F646;</td>
	                        <td>&#x1F647;</td>
	                        <td>&#x1F648;</td>
	                        <td>&#x1F649;</td>
	                        <td>&#x1F64A;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F64B;</td>
	                        <td>&#x1F64C;</td>
	                        <td>&#x1F64D;</td>
	                        <td>&#x1F64E;</td>
	                        <td>&#x1F64F;</td>
	                        <td>&#x1F680;</td>
	                        <td>&#x1F681;</td>
	                        <td>&#x1F682;</td>
	                        <td>&#x1F683;</td>
	                        <td>&#x1F684;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F685;</td>
	                        <td>&#x1F686;</td>
	                        <td>&#x1F687;</td>
	                        <td>&#x1F688;</td>
	                        <td>&#x1F689;</td>
	                        <td>&#x1F68A;</td>
	                        <td>&#x1F68B;</td>
	                        <td>&#x1F68C;</td>
	                        <td>&#x1F68D;</td>
	                        <td>&#x1F68E;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F68F;</td>
	                        <td>&#x1F690;</td>
	                        <td>&#x1F691;</td>
	                        <td>&#x1F692;</td>
	                        <td>&#x1F693;</td>
	                        <td>&#x1F694;</td>
	                        <td>&#x1F695;</td>
	                        <td>&#x1F696;</td>
	                        <td>&#x1F697;</td>
	                        <td>&#x1F698;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F699;</td>
	                        <td>&#x1F69A;</td>
	                        <td>&#x1F69B;</td>
	                        <td>&#x1F69C;</td>
	                        <td>&#x1F69D;</td>
	                        <td>&#x1F69E;</td>
	                        <td>&#x1F69F;</td>
	                        <td>&#x1F6A0;</td>
	                        <td>&#x1F6A1;</td>
	                        <td>&#x1F6A2;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F6A3;</td>
	                        <td>&#x1F6A4;</td>
	                        <td>&#x1F6A5;</td>
	                        <td>&#x1F6A6;</td>
	                        <td>&#x1F6A7;</td>
	                        <td>&#x1F6A8;</td>
	                        <td>&#x1F6A9;</td>
	                        <td>&#x1F6AA;</td>
	                        <td>&#x1F6AB;</td>
	                        <td>&#x1F6AC;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F6AD;</td>
	                        <td>&#x1F6AE;</td>
	                        <td>&#x1F6AF;</td>
	                        <td>&#x1F6B0;</td>
	                        <td>&#x1F6B1;</td>
	                        <td>&#x1F6B2;</td>
	                        <td>&#x1F6B3;</td>
	                        <td>&#x1F6B4;</td>
	                        <td>&#x1F6B5;</td>
	                        <td>&#x1F6B6;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F6B7;</td>
	                        <td>&#x1F6B8;</td>
	                        <td>&#x1F6B9;</td>
	                        <td>&#x1F6BA;</td>
	                        <td>&#x1F6BB;</td>
	                        <td>&#x1F6BC;</td>
	                        <td>&#x1F6BD;</td>
	                        <td>&#x1F6BE;</td>
	                        <td>&#x1F6BF;</td>
	                        <td>&#x1F6C0;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x1F6C1;</td>
	                        <td>&#x1F6C2;</td>
	                        <td>&#x1F6C3;</td>
	                        <td>&#x1F6C4;</td>
	                        <td>&#x1F6C5;</td>
	                        <td>&#x203C;</td>
	                        <td>&#x2049;</td>
	                        <td>&#x2122;</td>
	                        <td>&#x2139;</td>
	                        <td>&#x2194;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x2195;</td>
	                        <td>&#x2196;</td>
	                        <td>&#x2197;</td>
	                        <td>&#x2198;</td>
	                        <td>&#x2199;</td>
	                        <td>&#x21A9;</td>
	                        <td>&#x21AA;</td>
	                        <td>&#x23;&#x20E3;</td>
	                        <td>&#x231A;</td>
	                        <td>&#x231B;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x23E9;</td>
	                        <td>&#x23EA;</td>
	                        <td>&#x23EB;</td>
	                        <td>&#x23EC;</td>
	                        <td>&#x23F0;</td>
	                        <td>&#x23F3;</td>
	                        <td>&#x24C2;</td>
	                        <td>&#x25AA;</td>
	                        <td>&#x25AB;</td>
	                        <td>&#x25B6;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x25C0;</td>
	                        <td>&#x25FB;</td>
	                        <td>&#x25FC;</td>
	                        <td>&#x25FD;</td>
	                        <td>&#x25FE;</td>
	                        <td>&#x2600;</td>
	                        <td>&#x2601;</td>
	                        <td>&#x260E;</td>
	                        <td>&#x2611;</td>
	                        <td>&#x2614;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x2615;</td>
	                        <td>&#x261D;</td>
	                        <td>&#x263A;</td>
	                        <td>&#x2648;</td>
	                        <td>&#x2649;</td>
	                        <td>&#x264A;</td>
	                        <td>&#x264B;</td>
	                        <td>&#x264C;</td>
	                        <td>&#x264D;</td>
	                        <td>&#x264E;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x264F;</td>
	                        <td>&#x2650;</td>
	                        <td>&#x2651;</td>
	                        <td>&#x2652;</td>
	                        <td>&#x2653;</td>
	                        <td>&#x2660;</td>
	                        <td>&#x2663;</td>
	                        <td>&#x2665;</td>
	                        <td>&#x2666;</td>
	                        <td>&#x2668;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x267B;</td>
	                        <td>&#x267F;</td>
	                        <td>&#x2693;</td>
	                        <td>&#x26A0;</td>
	                        <td>&#x26A1;</td>
	                        <td>&#x26AA;</td>
	                        <td>&#x26AB;</td>
	                        <td>&#x26BD;</td>
	                        <td>&#x26BE;</td>
	                        <td>&#x26C4;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x26C5;</td>
	                        <td>&#x26CE;</td>
	                        <td>&#x26D4;</td>
	                        <td>&#x26EA;</td>
	                        <td>&#x26F2;</td>
	                        <td>&#x26F3;</td>
	                        <td>&#x26F5;</td>
	                        <td>&#x26FA;</td>
	                        <td>&#x26FD;</td>
	                        <td>&#x2702;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x2705;</td>
	                        <td>&#x2708;</td>
	                        <td>&#x2709;</td>
	                        <td>&#x270A;</td>
	                        <td>&#x270B;</td>
	                        <td>&#x270C;</td>
	                        <td>&#x270F;</td>
	                        <td>&#x2712;</td>
	                        <td>&#x2714;</td>
	                        <td>&#x2716;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x2728;</td>
	                        <td>&#x2733;</td>
	                        <td>&#x2734;</td>
	                        <td>&#x2744;</td>
	                        <td>&#x2747;</td>
	                        <td>&#x274C;</td>
	                        <td>&#x274E;</td>
	                        <td>&#x2753;</td>
	                        <td>&#x2754;</td>
	                        <td>&#x2755;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x2757;</td>
	                        <td>&#x2764;</td>
	                        <td>&#x2795;</td>
	                        <td>&#x2796;</td>
	                        <td>&#x2797;</td>
	                        <td>&#x27A1;</td>
	                        <td>&#x27B0;</td>
	                        <td>&#x27BF;</td>
	                        <td>&#x2934;</td>
	                        <td>&#x2935;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x2B05;</td>
	                        <td>&#x2B06;</td>
	                        <td>&#x2B07;</td>
	                        <td>&#x2B1B;</td>
	                        <td>&#x2B1C;</td>
	                        <td>&#x2B50;</td>
	                        <td>&#x2B55;</td>
	                        <td>&#x30;&#x20E3;</td>
	                        <td>&#x3030;</td>
	                        <td>&#x303D;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x31;&#x20E3;</td>
	                        <td>&#x32;&#x20E3;</td>
	                        <td>&#x3297;</td>
	                        <td>&#x3299;</td>
	                        <td>&#x33;&#x20E3;</td>
	                        <td>&#x34;&#x20E3;</td>
	                        <td>&#x35;&#x20E3;</td>
	                        <td>&#x36;&#x20E3;</td>
	                        <td>&#x37;&#x20E3;</td>
	                        <td>&#x38;&#x20E3;</td>
                        </tr>
                        <tr class="emojis">
	                        <td>&#x39;&#x20E3;</td>
	                        <td>&#xA9;</td>
	                        <td>&#xAE;</td>
	                        <td>&#xE50A;</td>
                        </tr>
                    </table>
                </div>
            </div>
             <br /> 
            <div class ="message">
                <asp:Label runat="server" Text="Message:"></asp:Label>
                <asp:TextBox ID="messageBox" class="messageBox" runat="server" ClientIDMode="Static"></asp:TextBox>
            </div>
            <div class ="chatButtons">
                <input type="button" ID="emoji" class="button blue small" value="Emoji"/>
                <asp:Button ID="gif" class="button blue small" runat="server" Text="Gif" />
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