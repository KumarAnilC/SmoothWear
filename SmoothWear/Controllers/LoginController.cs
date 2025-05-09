using SmoothWear.Models;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;

namespace SmoothWear.Controllers
{
    public class LoginController : Controller
    {
        SmoothWear_DBEntities db = new SmoothWear_DBEntities();

        public ActionResult Index()
        {
            return View(new LoginViewModel());
        }


        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Login(LoginViewModel model)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        var user = db.Tbl_UserDetails
        //                     .FirstOrDefault(u => u.Email == model.Email && u.Password == model.Password);

        //        if (user != null)
        //        {
        //            Session["UserId"] = user.Id;
        //            Session["UserName"] = user.Name;
        //            return RedirectToAction("Index", "Home");
        //        }
        //        else
        //        {
        //            ModelState.AddModelError("", "Invalid Email or Password.");
        //        }
        //    }

        //    return View("Index", model);

        //}

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = db.Tbl_UserDetails
                             .FirstOrDefault(u => u.Email == model.Email && u.Password == model.Password);

                if (user != null)
                {
                    Session["UserId"] = user.Id;
                    Session["UserName"] = user.Name;
                    Session["UserEmail"] = user.Email;

                    // Check if this email is in the admin list
                    var adminEmails = ConfigurationManager.AppSettings["AdminEmails"]
                                         .Split(',')
                                         .Select(e => e.Trim().ToLower())
                                         .ToList();

                    Session["IsAdmin"] = adminEmails.Contains(user.Email.ToLower());

                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("", "Invalid Email or Password.");
                }
            }

            return View("Index", model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }


        public class LoginViewModel
        {
            [Required(ErrorMessage = "Email is required")]
            [EmailAddress(ErrorMessage = "Invalid email address")]
            public string Email { get; set; }

            [Required(ErrorMessage = "Password is required")]
            [DataType(DataType.Password)]
            public string Password { get; set; }
        }

    }
}
