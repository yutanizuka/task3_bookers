class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  #能動的関係
  has_many :relationships
    #userモデルとrelationshipモデルと一対多の関係を表しています。
  has_many :followings, through: :relationships, source: :follow
    #has_many :followingsはこのタイミングで架空で作り出されたfollowingクラス(モデル) through: :relationships(オプション)は「中間テーブルはrelationshipsである」と設定している。source: followは、「following配列のもとはfollow_idの集合である」ということを明示的にRailsに伝えています。結果として、user.followingsと打つだけで、userが中間テーブルrelationshipsを取得し、その1つ１つのfollow idから、「フォローしているUser達」を取得しています。

  #受動的関係
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
     #has_many :reverse_of_relationshipsは、１行目のhas_many :relationshipsがフォローしている側と仮定して、その「逆方向」:フォローされている側を仮定する意味で命名しています。これもこのタイミングで命名したものであり、reverse_of_relationshipsという中間テーブルは存在しないため、これも補足を付け足す必要がある。class_name:'Relationship'で「reverse_of_relationshipsモデルの事だ」と設定
  has_many :followers, through: :reverse_of_relationships, source: :user
    #2行目と同じく架空で作り出された、followersクラス(モデル)に対して、through: :relationships(オプション)ｗ用いて「中間テーブルはrelationshipsである」と設定し、sourceオプションにて、「follower配列のもとはuser_idの集合である」ということを明示的にRailsに伝えています。ここで実は１行目の内容は一部省略されている内容があり、その内容は以下
    # has_many :relationships, foreign_key: 'user_id', dependent: :destroy


    # throughオプションによりrelationships経由でfollowings･followersにアクセスできるようになる
    # = 架空のモデルを介して、対象のモデルと多対多の関連付け　=> これにより情報抽出可能
    # sourceオプション = has_many :through関連付けの関連漬け元(従属するモデル※今回はモデルではないもの[follow]も含む)名を指定する
    # foreign_keyオプション = 関連付けるモデルを指す外部キーのカラム名を設定する。このオプションを使用しなければ、[belongs_toの引数_id]が指定される

  
  attachment :profile_image
  validates :name, presence: true #追記
  validates :name , length: {minimum: 2}
  validates :name , length: {maximum: 20}
  validates :introduction ,length: {maximum: 50}

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  #フォロー先が自分自身ではないか検証、selfにはuser.follow(other)を実行したときuserが代入されます。
  #つまり、実行したUserのインスタンスがselfです。
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end