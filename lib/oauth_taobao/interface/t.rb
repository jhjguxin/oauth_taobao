# encoding: utf-8
module OauthTaobao
  module Interface

    # t API
    #
    # @see http://open.weibo.com/wiki/API%E6%96%87%E6%A1%A3_V2#.E5.BE.AE.E5.8D.9A
    class T < Base

      # 返回最新的公共微博
      #
      # @param [Hash] opts
      # @option opts [int] :count    单页返回的记录条数，默认为50
      # @option opts [int] :page     返回结果的页码，默认为1
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/public_timeline
      def public_timeline(opts={})
        get 't/public_timeline.json', :params => opts.merge(@client.request_params)
      end

      # 获取当前登录用户及其所关注用户的最新微博
      #
      # @param [Hash] opts
      # @option opts [int64] :since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
      # @option opts [int64] :max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
      # @option opts [int] :count    单页返回的记录条数，默认为50
      # @option opts [int] :page     返回结果的页码，默认为1
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      # @option opts [int] :feature  过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/friends_timeline
      def friends_timeline(opts={})
        get 't/friends_timeline.json', :params => opts.merge(@client.request_params)
      end

      # 获取当前登录用户及其所关注用户的最新微博
      #
      # @param [Hash] opts
      # @option opts [int64] :since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
      # @option opts [int64] :max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
      # @option opts [int] :count    单页返回的记录条数，默认为50
      # @option opts [int] :page     返回结果的页码，默认为1
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      # @option opts [int] :feature  过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/home_timeline
      def home_timeline(opts={})
        get 't/home_timeline.json', :params => opts.merge(@client.request_params)
      end

      # 获取某个用户最新发表的微博列表
      #
      # @param [Hash] opts
      # @option opts [int64] :uid      需要查询的用户ID
      # @option opts [String] :screen_name 需要查询的用户昵称
      # @option opts [int64] :since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
      # @option opts [int64] :max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
      # @option opts [int] :count    单页返回的记录条数，默认为50
      # @option opts [int] :page     返回结果的页码，默认为1
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      # @option opts [int] :feature  过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0
      # @option opts [int] :trim_user 返回值中user信息开关，0：返回完整的user信息、1：user字段仅返回user_id，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/user_timeline
      def user_timeline(opts={})
        get 't/user_timeline.json', :params => opts.merge(@client.request_params)
      end

      # 批量获取指定的一批用户的微博列表 [Privilege]
      #
      # @option opts [String] :uids 需要查询的用户ID，用半角逗号分隔，一次最多20个
      # @option opts [String] :screen_name 需要查询的用户昵称，用半角逗号分隔，一次最多20个
      # @option opts [int] :count    单页返回的记录条数，默认为20
      # @option opts [int] :page     返回结果的页码，默认为1
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      # @option opts [int] :feature  过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0
      # @see http://open.weibo.com/wiki/2/t/timeline_batch
      def timeline_batch(opts={})
        get 't/timeline_batch.json', :params => opts.merge(@client.request_params)
      end

      # 获取指定微博的转发微博列表
      #
      # @param [int64] id 需要查询的微博ID
      # @param [Hash] opts
      # @option opts [int64] :since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
      # @option opts [int64] :max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
      # @option opts [int] :count    单页返回的记录条数，默认为50
      # @option opts [int] :page     返回结果的页码，默认为1
      # @option opts [int] :filter_by_author 作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/repost_timeline
      def repost_timeline(id, opts={})
        get 't/repost_timeline.json', :params => {:id => id}.merge(opts).merge(@client.request_params)
      end

      # 获取当前用户最新转发的微博列表
      #
      # @param [Hash] opts
      # @option opts [int64] :since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
      # @option opts [int64] :max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
      # @option opts [int] :count    单页返回的记录条数，默认为50
      # @option opts [int] :page     返回结果的页码，默认为1
      #
      # @see http://open.weibo.com/wiki/2/t/repost_by_me
      def repost_by_me(opts={})
        get 't/repost_by_me.json', :params => opts.merge(@client.request_params)
      end

      # 获取最新的提到登录用户的微博列表，即@我的微博
      #
      # @param [Hash] opts
      # @option opts [int64] :since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
      # @option opts [int64] :max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
      # @option opts [int] :count    单页返回的记录条数，默认为50
      # @option opts [int] :page     返回结果的页码，默认为1
      # @option opts [int] :filter_by_author 作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0
      # @option opts [int] :filter_by_source 来源筛选类型，0：全部、1：来自微博、2：来自微群，默认为0
      # @option opts [int] :filter_by_type   原创筛选类型，0：全部微博、1：原创的微博，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/mentions
      def mentions(opts={})
        get 't/mentions.json', :params => opts.merge(@client.request_params)
      end

      # 根据微博ID获取单条微博内容
      #
      # @param [int] id 需要获取的微博ID
      #
      # @see http://open.weibo.com/wiki/2/t/show
      def show(id)
        get 't/show.json', :params => {:id => id}.merge(@client.request_params)
      end

      # 根据微博ID批量获取微博信息 [Privilege]
      #
      # @param [String] ids 需要查询的微博ID，用半角逗号分隔，最多不超过50个
      #
      # @see http://open.weibo.com/wiki/2/t/show_batch
      def show_batch(ids)
        get 't/show_batch.json', :params => {:ids => ids}
      end

      # 通过微博（评论、私信）ID获取其MID
      #
      # @param [int64] id 需要查询的微博（评论、私信）ID，批量模式下，用半角逗号分隔，最多不超过20个
      # @param [int] type 获取类型，1：微博、2：评论、3：私信，默认为1
      # @param [Hash] opts
      # @option opts [int] :is_batch 是否使用批量模式，0：否、1：是，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/querymid
      def querymid(id, type=1, opts={})
        get 't/querymid.json', :params => {:id => id, :type => type}.merge(opts).merge(@client.request_params)
      end

      # test failed
      # 通过微博（评论、私信）MID获取其ID
      #
      # @param [String] mid 需要查询的微博（评论、私信）MID，批量模式下，用半角逗号分隔，最多不超过20个
      # @param [int] type   获取类型，1：微博、2：评论、3：私信，默认为1
      # @param [Hash] opts
      # @option opts [int] :is_batch 是否使用批量模式，0：否、1：是，默认为0
      # @option opts [int] :inbox    仅对私信有效，当MID类型为私信时用此参数，0：发件箱、1：收件箱，默认为0
      # @option opts [int] :isBase62 MID是否是base62编码，0：否、1：是，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/queryid
      def queryid(mid, type=1, opts={})
        get 't/queryid.json', :params => {:mid => mid, :type => type}.merge(opts).merge(@client.request_params)
      end

      # 按天返回热门微博转发榜的微博列表
      #
      # @param [Hash] opts
      # @option opts [int] :count    返回的记录条数，最大不超过50，默认为20
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/hot/repost_daily
      def hot_repost_daily(opts={})
        get 't/hot/repost_daily.json', :params => opts.merge(@client.request_params)
      end

      # 按周返回热门微博转发榜的微博列表
      #
      # @param [Hash] opts
      # @option opts [int] :count    返回的记录条数，最大不超过50，默认为20
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/hot/repost_weekly
      def hot_repost_weekly(opts={})
        get 't/hot/repost_weekly.json', :params => opts.merge(@client.request_params)
      end

      # 按天返回热门微博评论榜的微博列表
      #
      # @param [Hash] opts
      # @option opts [int] :count    返回的记录条数，最大不超过50，默认为20
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/hot/comments_daily
      def hot_comments_daily(opts={})
        get 't/hot/comments_daily.json', :params => opts.merge(@client.request_params)
      end

      # 按周返回热门微博评论榜的微博列表
      #
      # @param [Hash] opts
      # @option opts [int] :count    返回的记录条数，最大不超过50，默认为20
      # @option opts [int] :base_app 是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/hot/comments_weekly
      def hot_comments_weekly(opts={})
        get 't/hot/comments_weekly.json', :params => opts.merge(@client.request_params)
      end


      #
      # write
      #

      # 转发一条微博
      #
      # @param [int64] id 要转发的微博ID
      # @param [Hash] opts
      # @option opts [String] :status  添加的转发文本，必须做URLencode，内容不超过140个汉字，不填则默认为“转发微博”
      # @option opts [int] :is_comment 是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论，默认为0
      #
      # @see http://open.weibo.com/wiki/2/t/repost
      def repost(id, opts={})
        post 't/repost.json', :body => {:id => id}.merge(opts).merge(@client.request_params)
      end

      # 根据微博ID删除指定微博
      #
      # @param [int64] id 需要删除的微博ID
      #
      # @see http://open.weibo.com/wiki/2/t/destroy
      def destroy(id)
        post 't/destroy.json', :body => {:id => id}.merge(@client.request_params)
      end

      # no tested
      # 发布一条新微博
      #
      # @param [String] status 要发布的微博文本内容，内容不超过140个汉字
      # @param [Hash] opts
      # @option opts [float] :lat  纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0
      # @option opts [float] :long 经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0
      # @option opts [String] :annotations 元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博
      #               可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定
      #
      # @see http://wiki.open.t.qq.com/index.php/API%E6%96%87%E6%A1%A3/%E5%BE%AE%E5%8D%9A%E7%9B%B8%E5%85%B3/%E5%8F%91%E8%A1%A8%E4%B8%80%E6%9D%A1%E5%BE%AE%E5%8D%9A
=begin
    def tqq_status_update(auth = nil, message = nil)
      if auth.present? and auth.provider.eql? "tqq"
        client = OauthTaobao::Client.from_hash(access_token: auth.access_token)
        message ||= "it's a test message ... by francis, from #{root_url}"
        #message ||= "it's a test message ... by francis, from #{app.root_url(host: "bbtang.com")}"
        clientip = Setting.server_ip
        clientip ||= "xxx.xxx.xxx.xxx"
        client.t.add(message, {clientip: Setting.server_ip, content: message, "openid" => auth.uid})
      end
    end
=end
      def add(content, opts={ format: :json })
        post 'api/t/add', :body => {:content => content}.merge(opts), :params => @client.request_params
      end

      # no tested
      # 上传图片并发布一条新微博
      #
      # @param [String] status 要发布的微博文本内容，内容不超过140个汉字
      # @param [binary] pic    要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M
      # @param [Hash] opts
      # @option opts [float] :lat  纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0
      # @option opts [float] :long 经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0
      # @option opts [String] :annotations 元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博
      #               可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定
      #
      # @see http://open.weibo.com/wiki/2/t/upload
      def upload(status, pic, opts={})
        post 't/upload.json', :body => {:status => status, :pic => pic}.merge(opts), :params => @client.request_params
      end

      # 指定一个图片URL地址抓取后上传并同时发布一条新微博 [Privilege]
      #
      # @param [Hash] opts
      # @option opts [String] :status 要发布的微博文本内容，内容不超过140个汉字
      # @option opts [String] :url 图片的URL地址，必须以http开头
      # @option opts [float] :lat  纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0
      # @option opts [float] :long 经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0
      # @option opts [String] :annotations 元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博
      #               可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定
      #
      # @see http://open.weibo.com/wiki/2/t/upload_url_text
      def upload_url_text(opts={})
        post 't/upload_url_text.json', :body => opts, :params => @client.request_params
      end

      # 获取微博官方表情的详细信息
      #
      # @param [Hash] opts
      # @option opts [String] :type     表情类别，face：普通表情、ani：魔法表情、cartoon：动漫表情，默认为face
      # @option opts [String] :language 语言类别，cnname：简体、twname：繁体，默认为cnname
      #
      # @see http://open.weibo.com/wiki/2/emotions
      def emotions(opts={})
        get 'emotions.json', :params => opts, :params => @client.request_params
      end
    end
  end
end
