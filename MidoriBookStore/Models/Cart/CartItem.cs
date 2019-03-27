using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HaNgok.Models
{
    public class CartItem
    {
        public int ProductId { get; set; }

        public string ProductName { get; set; }

        public int Quantity { get; set; }

        public double Price { get; set; }

        public double Total
        {
            get
            {
                return Price * Quantity;
            }
            set{}
        }

        public System.DateTime DateCreated { get; set; }

        public CartItem(int productID, string productName, double price)
        {
            ProductId = productID;
            ProductName = productName;
            Quantity = 1;
            Price = price;
        }

        public override bool Equals(object obj)
        {
            CartItem ci = (CartItem)obj;
            return ProductId.Equals(ci.ProductId);
        }

    }
}
