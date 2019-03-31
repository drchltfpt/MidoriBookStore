using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using MidoriBookStore.Models;
using PagedList;

namespace MidoriBookStore.Controllers
{
    public class HomeController : Controller
    {
        private BookStoreDBEntities1 db = new BookStoreDBEntities1();

        // GET: Home
        //public ActionResult Index()
        //{
        //    var books = db.Books.Include(b => b.Author).Include(b => b.Publisher);
        //    return View(books.ToList());
        //}

        public ActionResult Index(int page = 0)
        {
            const int PageSize = 6; // you can always do something more elegant to set this

            var count = db.Books.Count();

            var data = this.db.Books.OrderBy(Book =>Book.BookID).Skip(page * PageSize).Take(PageSize).ToList();

            this.ViewBag.MaxPage = (count / PageSize) - (count % PageSize == 0 ? 1 : 0);

            this.ViewBag.Page = page;

            return this.View(data);
        }

        // GET: Home/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            return View(book);
        }

        // GET: Home/Create
        public ActionResult Create()
        {
            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName");
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName");
            return View();
        }

        // POST: Home/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "BookID,PublisherID,AuthorID,BookTitle,Notes,BookPrice,BookType,Status,Url")] Book book)
        {
            if (ModelState.IsValid)
            {
                db.Books.Add(book);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName", book.AuthorID);
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // GET: Home/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName", book.AuthorID);
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // POST: Home/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "BookID,PublisherID,AuthorID,BookTitle,Notes,BookPrice,BookType,Status,Url")] Book book)
        {
            if (ModelState.IsValid)
            {
                db.Entry(book).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AuthorID = new SelectList(db.Authors, "AuthorID", "AuthorName", book.AuthorID);
            ViewBag.PublisherID = new SelectList(db.Publishers, "PublisherID", "PublisherName", book.PublisherID);
            return View(book);
        }

        // GET: Home/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Book book = db.Books.Find(id);
            if (book == null)
            {
                return HttpNotFound();
            }
            return View(book);
        }

        // POST: Home/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Book book = db.Books.Find(id);
            db.Books.Remove(book);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public ActionResult Search(string bookGenre, string searchString)
        {
            var GenreLst = new List<string>();

            var GenreQry = from d in db.Books
                           orderby d.BookType
                           select d.BookType;

            GenreLst.AddRange(GenreQry.Distinct());
            ViewBag.bookGenre = new SelectList(GenreLst);

            var books = from m in db.Books
                         select m;

            if (!String.IsNullOrEmpty(searchString))
            {
                books = books.Where(s => s.BookTitle.Contains(searchString));
            }
            if (!string.IsNullOrEmpty(bookGenre))
            {
                books = books.Where(x => x.BookType == bookGenre);
            }

            return View(books);
        }

        public ActionResult About()
        {
            return View();
        }

        // GET: Home/Feedback
        public ActionResult Feedback()
        {
            return View();
        }

        // POST: Home/Feedback
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Feedback([Bind(Include = "ResponseID,UserID,Username,Title,Email,Contents,IsActive,Reply")] UserResponse userResponse)
        {
            if (ModelState.IsValid)
            {
                db.UserResponses.Add(userResponse);
                db.SaveChanges();
                return RedirectToAction("Feedback");
            }

            ViewBag.UserID = new SelectList(db.Users, "UserID", "Username", userResponse.UserID);
            return View(userResponse);
        }

    }
}
