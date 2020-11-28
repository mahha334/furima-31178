class Shipping < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },   
    { id: 1, name: '１〜2日で発送' },
    { id: 2, name: '２〜３日で発送' },
    { id: 3, name: '４〜７日で発送' }
  ]
 
   include ActiveHash::Associations
   has_many :item
 
end
