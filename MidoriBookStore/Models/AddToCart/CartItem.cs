using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MidoriBookStore.Models.AddToCart
{
    public class CartItem
    {
        public int BookId { get; set; }

        public string BookTitle { get; set; }

        public int Quantity { get; set; }

        public double BookPrice { get; set; }

        public double Total
        {
            get
            {
                return BookPrice * Quantity;
            }
            set{}
        }

        public System.DateTime DateCreated { get; set; }

        public CartItem(int bookId, string bookTitle, double price)
        {
            BookId = bookId;
            BookTitle = bookTitle;
            Quantity = 1;
            BookPrice = price;
        }

        public override bool Equals(object obj)
        {
            CartItem ci = (CartItem)obj;
            return BookId.Equals(ci.BookId);
        }

    }
}
