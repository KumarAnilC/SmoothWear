using SmoothWear.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SmoothWear.Controllers
{
    public class OrdersController : Controller
    {
        SmoothWear_DBEntities db = new SmoothWear_DBEntities();


        [HttpGet]
        public ActionResult Index()
        {
            return View(new Tbl_Orders());
        }

        //[HttpPost]
        //public ActionResult PlaceOrder(Tbl_Orders order)
        //{
        //    if (Session["UserId"] != null)
        //    {
        //        order.UserId = Convert.ToInt32(Session["UserId"]);
        //        order.UserEmail = Session["UserEmail"].ToString();
        //        order.Status = "Placed";
        //        order.PaymentStatus = order.PaymentMode == "Online" ? "Pending" : "NotRequired";
        //        order.OrderDate = DateTime.Now;

        //        db.Tbl_Orders.Add(order);
        //        db.SaveChanges();

        //        // Clear cart logic here if needed

        //        return RedirectToAction("Success");
        //    }
        //    else
        //    {
        //        return RedirectToAction("Index", "Login");
        //    }
        //}

        /*
    [HttpPost]
    public ActionResult PlaceOrder(Tbl_Orders model)
    {
        string userEmail = Session["UserEmail"].ToString();  // or from User.Identity.Name, etc.
        string userId = Session["UserId"].ToString();

        // 1. Save the Order details


        Tbl_Orders newOrder = new Tbl_Orders
        {
            UserEmail = userEmail,
            UserId = Convert.ToInt32(userId),
            PhoneNo = model.PhoneNo,
            Address = model.Address,
            City = model.City,
            Zip = model.Zip,
            Status = "Placed",
            PreferredPickupSlot = model.PreferredPickupSlot,
            PaymentMode = model.PaymentMode,
            PaymentStatus = "Pending", // Or "Paid" based on payment mode
            OrderDate = DateTime.Now
        };
        db.Tbl_Orders.Add(newOrder);
        db.SaveChanges();

        int orderId = newOrder.OrderId;

        // 2. Get all cart items for the user
        var cartItems = db.Tbl_Cart
            .Include("Tbl_ProductDetails")
            .Where(c => c.Email == userEmail)
            .ToList();

        // 3. Insert into Tbl_OrderedItems
        foreach (var item in cartItems)
        {
            db.Tbl_OrderedItems.Add(new Tbl_OrderedItems
            {
                OrderId = orderId,
                ProductId = item.ProductId,
                ProductName = item.Tbl_ProductDetails.ProductName,
                ProductImage = item.Tbl_ProductDetails.ProductImage,
                PricePerItem = item.Tbl_ProductDetails.Cost,
                Quantity = item.Quantity,
                TotalPrice = item.Quantity * item.Tbl_ProductDetails.Cost,
                UserName = item.UserName,
                Email = item.Email,
                CreatedAt = DateTime.Now
            });
        }

        // 4. Remove cart items
        db.Tbl_Cart.RemoveRange(cartItems);
        db.SaveChanges();

        //return RedirectToAction("Success");
        return RedirectToAction("Success", new { orderId = orderId });
    }*/

        [HttpPost]
        public ActionResult PlaceOrder(Tbl_Orders model)
        {
            string userEmail = Session["UserEmail"].ToString();
            string userId = Session["UserId"].ToString();

            Tbl_Orders newOrder = new Tbl_Orders
            {
                UserEmail = userEmail,
                UserId = Convert.ToInt32(userId),
                PhoneNo = model.PhoneNo,
                Address = model.Address,
                City = model.City,
                Zip = model.Zip,
                Status = "Placed",
                PreferredPickupSlot = model.PreferredPickupSlot,
                PaymentMode = model.PaymentMode,
                PaymentStatus = model.PaymentMode == "Online" ? "Pending" : "NotRequired",
                OrderDate = DateTime.Now
            };

            db.Tbl_Orders.Add(newOrder);
            db.SaveChanges();

            int orderId = newOrder.OrderId;

            var cartItems = db.Tbl_Cart
                .Include("Tbl_ProductDetails")
                .Where(c => c.Email == userEmail)
                .ToList();

            foreach (var item in cartItems)
            {
                db.Tbl_OrderedItems.Add(new Tbl_OrderedItems
                {
                    OrderId = orderId,
                    ProductId = item.ProductId,
                    ProductName = item.Tbl_ProductDetails.ProductName,
                    ProductImage = item.Tbl_ProductDetails.ProductImage,
                    PricePerItem = item.Tbl_ProductDetails.Cost,
                    Quantity = item.Quantity,
                    TotalPrice = item.Quantity * item.Tbl_ProductDetails.Cost,
                    UserName = item.UserName,
                    Email = item.Email,
                    CreatedAt = DateTime.Now
                });
            }

            db.Tbl_Cart.RemoveRange(cartItems);
            db.SaveChanges();

            // Redirect to Razorpay simulation if Online
            if (model.PaymentMode == "Online")
            {
                return RedirectToAction("PayWithRazorpay", new { orderId = orderId });
            }

            return RedirectToAction("Success", new { orderId = orderId });
        }


        //public ActionResult Success()
        //{
        //    return View();
        //}

        public ActionResult Success(int orderId)
        {
            var order = db.Tbl_Orders.FirstOrDefault(o => o.OrderId == orderId);
            if (order == null)
            {
                return RedirectToAction("Index", "Home");
            }
            return View(order);
        }


        // Show Orders to Admin
        public ActionResult AdminViewOrders()
        {
            var orders = db.Tbl_Orders
                       .Where(o => o.Status == "Placed") // Only Placed orders
                       .ToList();
            return View(orders);

        }

        public ActionResult AcceptOrder(int id)
        {
            var order = db.Tbl_Orders.Find(id);
            if (order != null)
            {
                order.Status = "Accepted";
                db.SaveChanges();
            }
            return RedirectToAction("AdminViewOrders");
        }

        public ActionResult RejectOrder(int id)
        {
            var order = db.Tbl_Orders.Find(id);
            if (order != null)
            {
                order.Status = "Rejected";
                db.SaveChanges();
            }
            return RedirectToAction("AdminViewOrders");
        }


        public ActionResult AdminViewAllOrders()
        {
           
                var orders = db.Tbl_Orders.ToList(); 
                return View(orders);
            
        }

        public ActionResult OrderHistory()
        {
            string userEmail = Session["UserEmail"].ToString();  // or from User.Identity.Name, etc.

            // Fetch all orders placed by the current user
            var orders = db.Tbl_Orders
                            .Where(o => o.UserEmail == userEmail)
                            .OrderByDescending(o => o.OrderDate)  // Optionally, order by date (most recent first)
                            .ToList();

            return View(orders);
        }

        //public ActionResult OrderDetails(int orderId)
        //{
        //    //var order = db.Tbl_Orders
        //    //                .Include(order => order.Tbl_OrderedItems)
        //    //                .FirstOrDefault(o => o.OrderId == orderId);

        //    var orderDetails = db.Tbl_Orders
        //                .Include(o => o.Tbl_OrderedItems)
        //                .ThenInclude(oi => oi.Tbl_ProductDetails)
        //                .FirstOrDefault(o => o.OrderId == orderId);

        //    if (orderDetails == null)
        //    {
        //        return RedirectToAction("OrderHistory");
        //    }

        //    return View(orderDetails);
        //}

        public ActionResult OrderDetails(int orderId)
        {
            var order = db.Tbl_Orders
              .Where(o => new[] { "Placed", "Rejected", "Accepted" }.Contains(o.Status))
              .FirstOrDefault(o => o.OrderId == orderId);

            if (order == null)
            {
                return HttpNotFound();
            }

            decimal totalPrice = 0;
            if (order.Tbl_OrderedItems != null && order.Tbl_OrderedItems.Any())
            {
                totalPrice = order.Tbl_OrderedItems.Sum(item => item.TotalPrice);
            }

            ViewBag.TotalPrice = totalPrice;

            return View(order);
        }

        public ActionResult PayWithRazorpay(int orderId)
        {
            var order = db.Tbl_Orders.FirstOrDefault(o => o.OrderId == orderId);
            if (order == null)
            {
                return RedirectToAction("Index", "Home");
            }

            // Calculate total
            decimal total = db.Tbl_OrderedItems
                .Where(i => i.OrderId == orderId)
                .Sum(i => i.TotalPrice);

            ViewBag.TotalAmount = total;
            ViewBag.OrderId = orderId;
            return View();
        }

        public ActionResult PaymentSuccess(int orderId)
        {
            var order = db.Tbl_Orders.Find(orderId);
            if (order != null)
            {
                order.PaymentStatus = "Paid";
                db.SaveChanges();
            }

            return RedirectToAction("Success", new { orderId = orderId });
        }




    }
}