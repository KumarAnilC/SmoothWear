using SmoothWear.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SmoothWear.Controllers
{
    public class ProductsController : Controller
    {
        SmoothWear_DBEntities db = new SmoothWear_DBEntities();


        // GET: Products
        //public ActionResult Index()
        //{
        //    return View();
        //}

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult AddProduct(ProductDetailsViewModel model)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        string imagePath = ""; // Save the image and get the path

        //        if (model.ProductImageFile != null && model.ProductImageFile.ContentLength > 0)
        //        {
        //            string fileName = Path.GetFileName(model.ProductImageFile.FileName);
        //            imagePath = Path.Combine(Server.MapPath("~/Uploads/Products"), fileName);
        //            model.ProductImageFile.SaveAs(imagePath);
        //        }

        //        var product = new Tbl_ProductDetails
        //        {
        //            ProdcutName = model.ProductName,
        //            ProdcutCategory = model.ProductCategory,
        //            Cost = model.Cost,
        //            Description = model.Description,
        //            ProductImage = "/Uploads/Products/" + Path.GetFileName(imagePath),
        //            CreatedAt = DateTime.Now,
        //            CreatedBy = Session["UserName"]?.ToString(),
        //            IsActive = true
        //        };

        //        db.Tbl_ProductDetails.Add(product);
        //        db.SaveChanges();

        //        TempData["Success"] = "Product added successfully.";
        //        return RedirectToAction("ProductDetails");
        //    }

        //    return View(model);
        //}

        //public ActionResult ProductDetails()
        //{
        //    return View();
        //}


        // GET: Products
        public ActionResult Index()
        {
            var products = db.Tbl_ProductDetails
                 //.Where(p => p.IsActive == true)
                 .OrderByDescending(p => p.CreatedAt)
                 .ToList();
            return View(products);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddProduct(ProductDetailsViewModel model)
        {
            if (ModelState.IsValid)
            {
                string imagePath = "";

                if (model.ProductImageFile != null && model.ProductImageFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(model.ProductImageFile.FileName);
                    imagePath = Path.Combine(Server.MapPath("~/Uploads/Products"), fileName);
                    model.ProductImageFile.SaveAs(imagePath);
                }

                var product = new Tbl_ProductDetails
                {
                    ProductName = model.ProductName,
                    ProductCategory = model.ProductCategory,
                    Cost = model.Cost,
                    Description = model.Description,
                    ProductImage = "/Uploads/Products/" + Path.GetFileName(imagePath),
                    CreatedAt = DateTime.Now,
                    CreatedBy = Session["UserName"]?.ToString(),
                    IsActive = true
                };

                db.Tbl_ProductDetails.Add(product);
                db.SaveChanges();

                TempData["Success"] = "Product added successfully.";
                return RedirectToAction("Index"); // 👈 Redirect to Index instead of ProductDetails
            }

            return View(model);
        }

        [HttpGet]
        public ActionResult AddProduct()
        {
            return View(new ProductDetailsViewModel());
        }

        public ActionResult EditProduct(int id)
        {
            var product = db.Tbl_ProductDetails.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditProduct(Tbl_ProductDetails model, HttpPostedFileBase ProductImageFile)
        {
            if (ModelState.IsValid)
            {
                var product = db.Tbl_ProductDetails.Find(model.ProductId);
                if (product != null)
                {
                    product.ProductName = model.ProductName;
                    product.ProductCategory = model.ProductCategory;
                    product.Cost = model.Cost;
                    product.Description = model.Description;

                    // Use same path as AddProduct: /Uploads/Products/
                    if (ProductImageFile != null && ProductImageFile.ContentLength > 0)
                    {
                        string fileName = Path.GetFileName(ProductImageFile.FileName);
                        string relativePath = "/Uploads/Products/" + fileName;
                        string physicalPath = Server.MapPath(relativePath);

                        ProductImageFile.SaveAs(physicalPath);
                        product.ProductImage = relativePath;
                    }

                    db.SaveChanges();
                    TempData["Success"] = "Product updated successfully!";
                    return RedirectToAction("Index");
                }
            }
            return View(model);
        }


        //public ActionResult EditProduct(int id)
        //{
        //    // Load product by id and pass to view
        //}

        [HttpGet]
        public ActionResult DeleteProduct(int id)
        {
            var product = db.Tbl_ProductDetails.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int productId)
        {
            var product = db.Tbl_ProductDetails.Find(productId);
            if (product != null)
            {
                db.Tbl_ProductDetails.Remove(product);
                db.SaveChanges();
                TempData["Success"] = "Product deleted successfully.";
            }

            return RedirectToAction("Index");
        }


        public ActionResult ToggleStatus(int id)
        {
            var product = db.Tbl_ProductDetails.Find(id);
            if (product != null)
            {
                product.IsActive = !(product.IsActive ?? true); // toggle status
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }




    }

    public class ProductDetailsViewModel
    {
        [Required]
        public string ProductName { get; set; }

        [Required]
        public string ProductCategory { get; set; }

        [Required]
        [Range(0, 9999.99, ErrorMessage = "Enter valid cost")]
        public decimal Cost { get; set; }

        public string Description { get; set; }

        [Required(ErrorMessage = "Please select an image")]
        public HttpPostedFileBase ProductImageFile { get; set; }

        public string ExistingImagePath { get; set; } // For edit scenario
    }
}