using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    public bool isJoin = false; 
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (ViewState["buttonClicked"] == null)
            ViewState["buttonClicked"] = "None";
    }
    protected void onButtonClick(object sender, EventArgs e)
    {
        Button button = (Button)sender;
        ViewState["buttonClicked"] = button.ID;
        ModalPopupExtender1.Show();
    }
  
 }