using Microsoft.Owin;
using Owin;

[assembly: OwinStartup("StartUpChat",typeof(SmallTalk.Startup))]
namespace SmallTalk
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            app.MapSignalR();
            ConfigureAuth(app);
        }
    }
}
