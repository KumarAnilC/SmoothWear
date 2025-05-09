using SmoothWear.Models;
using System;
using System.Linq;
using System.Web.Mvc;

public class CartController : Controller
{
    private SmoothWear_DBEntities db = new SmoothWear_DBEntities();

    // AJAX Add to Cart
    [HttpPost]
    public JsonResult AddToCartAjax(int productId, int quantity)
    {
        string userName = Session["UserName"]?.ToString();
        string email = Session["UserEmail"]?.ToString();

        if (!string.IsNullOrEmpty(userName) && !string.IsNullOrEmpty(email))
        {
            var existingCartItem = db.Tbl_Cart.FirstOrDefault(c => c.UserName == userName && c.ProductId == productId);

            if (existingCartItem != null)
            {
                existingCartItem.Quantity += quantity;
            }
            else
            {
                db.Tbl_Cart.Add(new Tbl_Cart
                {
                    ProductId = productId,
                    Quantity = quantity,
                    UserName = userName,
                    Email = email,
                    DateAdded = DateTime.Now
                });
            }

            db.SaveChanges();

            // Update session cart count
            var cartCount = db.Tbl_Cart.Where(c => c.UserName == userName).Sum(c => (int?)c.Quantity) ?? 0;
            Session["CartCount"] = cartCount;

            return Json(new { success = true, cartCount });
        }

        return Json(new { success = false, redirectUrl = Url.Action("Index", "Login") });
    }

    //public ActionResult Index()
    //{
    //    string userName = Session["UserName"]?.ToString();

    //    if (!string.IsNullOrEmpty(userName))
    //    {
    //        var cartItems = db.Tbl_Cart
    //                          .Where(c => c.UserName == userName)
    //                          .Join(db.Tbl_ProductDetails,
    //                                cart => cart.ProductId,
    //                                product => product.ProductId,
    //                                (cart, product) => new CartViewModel
    //                                {
    //                                    ProductId = product.ProductId,
    //                                    ProductName = product.ProductName,
    //                                    ProductImage = product.ProductImage,
    //                                    Cost = product.Cost,
    //                                    Quantity = cart.Quantity
    //                                }).ToList();

    //        return View(cartItems);
    //    }

    //    return RedirectToAction("Index", "Login");
    //}

    public ActionResult Index()
    {
        string userName = Session["UserName"]?.ToString();
        string userId=Session["UserId"]?.ToString();
        string userEmail = Session["UserEmail"]?.ToString();
        if (userName != null)
        {
            var cartItems = db.Tbl_Cart
                .Include("Tbl_ProductDetails") // Eager load the related product
                .Where(c => c.Email == userEmail)
                .ToList();

            return View(cartItems);
        }

        return RedirectToAction("Index", "Login");
    }


    [HttpPost]
    public ActionResult UpdateCart(int productId, int quantity)
    {
        string userName = Session["UserName"]?.ToString();

        if (!string.IsNullOrEmpty(userName) && quantity > 0)
        {
            var cartItem = db.Tbl_Cart.FirstOrDefault(c => c.UserName == userName && c.ProductId == productId);
            if (cartItem != null)
            {
                cartItem.Quantity = quantity;
                db.SaveChanges();
            }
        }

        return RedirectToAction("Index");
    }

    [HttpPost]
    public ActionResult RemoveFromCart(int productId)
    {
        string userName = Session["UserName"]?.ToString();

        if (!string.IsNullOrEmpty(userName))
        {
            var cartItem = db.Tbl_Cart.FirstOrDefault(c => c.UserName == userName && c.ProductId == productId);
            if (cartItem != null)
            {
                db.Tbl_Cart.Remove(cartItem);
                db.SaveChanges();
            }
        }

        return RedirectToAction("Index");
    }

    public class CartViewModel
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public decimal Cost { get; set; }
        public int Quantity { get; set; }
    }
}
