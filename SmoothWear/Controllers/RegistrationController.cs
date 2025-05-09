using SmoothWear.Models;
using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Mvc;

namespace SmoothWear.Controllers
{
    public class RegistrationController : Controller
    {
        SmoothWear_DBEntities db = new SmoothWear_DBEntities();

        public ActionResult Index()
        {
            return View();
        }

        // AJAX method to check email existence
        [HttpGet]
        public JsonResult IsEmailExist(string email)
        {
            bool isExist = db.Tbl_UserDetails.Any(u => u.Email == email);
            return Json(!isExist, JsonRequestBehavior.AllowGet);
        }

        // POST Registration Method
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(Tbl_UserDetails model)
        {
            if (ModelState.IsValid)
            {
                // Ensure password and confirm password match
                //if (model.Password != ConfirmPassword)
                //{
                //    ModelState.AddModelError("ConfirmPassword", "Password and Confirm Password do not match.");
                //    return View(model);  // Return with validation error
                //}

                // Hash the password before saving to the database
                //model.Password = HashPassword(model.Password);

                // Save the model to the database
                db.Tbl_UserDetails.Add(model);
                db.SaveChanges();

                // Redirect to home page after successful registration
                return RedirectToAction("Index", "Login");
            }
            else
            {

                // If model validation fails, return to the registration page with errors
                return View(model);
            }
        }

        // Hash Password Function
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash = sha256.ComputeHash(bytes);
                return BitConverter.ToString(hash).Replace("-", "").ToLower();
            }
        }
    }
}
