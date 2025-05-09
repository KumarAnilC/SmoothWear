using SmoothWear.Models;
using System;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web.Mvc;

namespace SmoothWear.Controllers
{
    public class ForgetPasswordController : Controller
    {
        SmoothWear_DBEntities db = new SmoothWear_DBEntities();

        // GET: ForgetPassword
        public ActionResult Index()
        {
            return View(new ForgotPasswordViewModel());
        }

        // POST: ForgetPassword
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(ForgotPasswordViewModel model)
        {
            try
            {
                var user = db.Tbl_UserDetails
                             .FirstOrDefault(u => u.Email == model.Email && u.PhoneNo == model.PhoneNumber);

                if (user == null)
                {
                    ModelState.AddModelError("", "User not found with the provided Email and Phone Number.");
                    return View(model);
                }

                user.Password = model.NewPassword;

                // Mark only the Password property as modified
                db.Entry(user).Property(u => u.Password).IsModified = true;

                db.Configuration.ValidateOnSaveEnabled = false;
                // Save your changes
                db.SaveChanges();
                db.Configuration.ValidateOnSaveEnabled = true;

                TempData["Success"] = "Password updated successfully. Please log in.";
                return RedirectToAction("Index", "Login");
            }
            catch (DbEntityValidationException ex)
            {
                foreach (var validationErrors in ex.EntityValidationErrors)
                {
                    foreach (var error in validationErrors.ValidationErrors)
                    {
                        ModelState.AddModelError(error.PropertyName, error.ErrorMessage);
                    }
                }
                return View(model);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred while updating the password.");
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                System.Diagnostics.Debug.WriteLine("Stack Trace: " + ex.StackTrace);
                return View(model);
            }
        }

        public class ForgotPasswordViewModel
        {
            [Required]
            [EmailAddress(ErrorMessage = "Enter a valid email")]
            public string Email { get; set; }

            [Required]
            [Phone(ErrorMessage = "Enter a valid phone number")]
            public string PhoneNumber { get; set; }

            [Required]
            [DataType(DataType.Password)]
            [StringLength(100, MinimumLength = 6, ErrorMessage = "Password must be at least 6 characters.")]
            public string NewPassword { get; set; }

            [Required]
            [DataType(DataType.Password)]
            [System.ComponentModel.DataAnnotations.Compare("NewPassword", ErrorMessage = "Passwords do not match.")]
            public string ConfirmPassword { get; set; }
        }
    }
}
