using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SmoothWear.Startup))]
namespace SmoothWear
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
