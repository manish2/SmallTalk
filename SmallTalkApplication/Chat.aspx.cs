using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Chat : Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        string script = "<script> if (localStorage.getItem('username') == null) { window.location = 'ChatLobby.aspx'; } </script>";
        Response.Write(script);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void Page_Unload(object sender, EventArgs e)
    {
       
    }
    public string UserName
    {
        get { return "anon"; }
    }
} 