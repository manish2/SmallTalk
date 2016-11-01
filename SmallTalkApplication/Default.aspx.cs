using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void onCreateClick(object sender, EventArgs e)
    {
       // var clientScript = Page.ClientScript;
        //clientScript.RegisterClientScriptBlock(this.GetType(), "AlertScript", "alert('ERROR')", true);
        Response.Write("<script>alert('hi')</script>");

    }
}