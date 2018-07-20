<%@page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<style type="text/css">
p{margin-top:5px;margin-bottom:5px;}
p.title{font-size:20px;padding-bottom:5px;border-bottom:solid 1px #ccc;}
.box{border:solid 1px #bbb;margin-top:10px;margin-left:10px;padding:5px;}
.box p{position:relative;}
.box p .v{padding-left:10px;font-weight:bold;}
.box p .c{position:absolute;left:20%;}
.box p .t{position:absolute;left:80%;}
</style>
</head>
<body style="background-color:#fafafa;">
	<div style="text-align:center;font-size:30px;">模板编写说明</div>
	<hr style="width:100%;"></hr>
	<div class="box">
		<p class="title">通用变量</p>
		<p><span class="v">cms</span><span class="c">cms变量，可用来获取数据</span></p>
		<p><span class="v">year</span><span class="c">当前年</span><span class="t">String</span></p>
		<p><span class="v">site</span><span class="c">站点信息</span><span class="t"><a href="#ViewSite">ViewSite</a></span></p>
		<p><span class="v">categorylist</span><span class="c">顶级栏目列表</span><span class="t">List&lt;<a href="#ViewCategory">ViewCategory</a>&gt;</span></p>
		<p><span class="v">ctx</span><span class="c">站点路径前缀</span><span class="t">String</span></p>
		<div class="box">
			<p class="title">文章页变量</p>
			<p><span class="v">category</span><span class="c">文章所属的栏目</span><span class="t"><a href="#ViewCategory">ViewCategory</a></span></p>
			<p><span class="v">vo</span><span class="c">文章的自定义字段</span><span class="t">String</span></p>
			<p><span class="v">id</span><span class="c">文章的编号</span><span class="t">Map</span></p>
			<p><span class="v">categoryid</span><span class="c">文章所属栏目的编号</span><span class="t">Long</span></p>
			<p><span class="v">title</span><span class="c">文章标题</span><span class="t">String</span></p>
			<p><span class="v">summary</span><span class="c">文章摘要</span><span class="t">String</span></p>
			<p><span class="v">metakeywords</span><span class="c">文章页的metakeywords</span><span class="t">String</span></p>
			<p><span class="v">metadescription</span><span class="c">文章页的metadescription</span><span class="t">String</span></p>
			<p><span class="v">releasetime</span><span class="c">文章页的发布时间</span><span class="t">String</span></p>
			<p><span class="v">releasesource</span><span class="c">文章来源</span><span class="t">String</span></p>
			<p><span class="v">releaseuser</span><span class="c">文章作者</span><span class="t">String</span></p>
			<p><span class="v">img</span><span class="c">文章图片封面</span><span class="t">String</span></p>
			<p><span class="v">url</span><span class="c">文章URL</span><span class="t">String</span></p>
			<p><span class="v">content</span><span class="c">文章内容</span><span class="t">String</span></p>
		</div>
		<div class="box">
			<p class="title">栏目页变量</p>
			<p><span class="v"><del>categoryparent</del></span><span class="c">栏目的父栏目（不推荐使用，可用category.parent代替）</span><span class="t"><a href="#ViewCategory">ViewCategory</a></span></p>
			<p><span class="v">categoryid</span><span class="c">栏目编号</span><span class="t">Long</span></p>
			<p><span class="v">category</span><span class="c">当前栏目</span><span class="t"><a href="#ViewCategory">ViewCategory</a></span></p>
			<p><span class="v">vo</span><span class="c">栏目的自定义字段</span><span class="t">Map</span></p>
			<p><span class="v">datalist</span><span class="c">栏目下的文章列表</span><span class="t">List&lt;<a href="#ViewArticle">ViewArticle</a>&gt;</span></p>
			<p><span class="v">datapageview</span><span class="c">栏目下文章列表的默认网页分页控件，直接输出即可</span><span class="t">String</span></p>
			<p><span class="v">datauri</span><span class="c">栏目下文章列表的URL地址前缀（即相同的部分），页数大于1时以“_页数”为中缀，后缀为“.html”</span><span class="t">String</span></p>
			<p><span class="v">datapage</span><span class="c">栏目下文章列表的分页信息</span><span class="t"><a href="#Datapage">Datapage</a></span></p>
		</div>
	</div>
	<div class="box">
		<p class="title">通用函数</p>
		<div class="box">
			<p><span class="v">put</span><span class="c">设置指定栏目下的文章或分页</span></p>
			<div class="box">
				<p class="title">参数</p>
				<p><span class="v">name</span><span class="c">设置到模板上的变量名称</span><span class="t">String</span></p>
				<p><span class="v">listOrPage</span><span class="c">列表或者分页</span><span class="t">boolean</span></p>
				<p><span class="v">currentPage</span><span class="c">当前页数</span><span class="t">int</span></p>
				<p><span class="v">pageSize</span><span class="c">每页文章数量</span><span class="t">int</span></p>
				<p><span class="v">desc</span><span class="c">是否倒序</span><span class="t">boolean</span></p>
				<p><span class="v">onlyImageTop</span><span class="c">是否只查有焦点图的</span><span class="t">boolean</span></p>
				<p><span class="v">onlyPageTop</span><span class="c">是否只查首页推荐的</span><span class="t">boolean</span></p>
				<p><span class="v">keyvalue</span><span class="c">查询关键字</span><span class="t">String</span></p>
				<p><span class="v">categoryids</span><span class="c">栏目数组，可以为变长参数</span><span class="t">Long...或String...</span></p>
			</div>
			<div class="box">
				<p class="title">返回值</p>
				<p><span class="v">listOrPage为true</span><span class="c">文章列表</span><span class="t">List&lt;<a href="#ViewArticle">ViewArticle</a>&gt;</span></p>
				<p><span class="v">listOrPage为false</span><span class="c">文章分页集合</span><span class="t"><a href="#ViewArticleSet">ViewArticleSet</a></span></p>
			</div>
		</div>
		<div class="box">
			<p><span class="v">putCategory</span><span class="c">设置指定栏目或栏目下的子栏目</span></p>
			<div class="box">
				<p class="title">参数</p>
				<p><span class="v">name</span><span class="c">设置到模板上的变量名称</span><span class="t">String</span></p>
				<p><span class="v">listOrOne</span><span class="c">查询指定栏目或其下的子栏目</span><span class="t">boolean</span></p>
				<p><span class="v">categoryid</span><span class="c">指定栏目的编号</span><span class="t">Long或String</span></p>
			</div>
			<div class="box">
				<p class="title">返回值</p>
				<p><span class="v">listOrOne为true</span><span class="c">栏目列表</span><span class="t">List&lt;<a href="#ViewCategory">ViewCategory</a>&gt;</span></p>
				<p><span class="v">listOrOne为false</span><span class="c">栏目</span><span class="t"><a href="#ViewCategory">ViewCategory</a></span></p>
			</div>
		</div>
	</div>
	<div class="box">
		<p class="title">通用类型</p>
		<div class="box" id="ViewSite">
			<p class="title">ViewSite<span class="c">站点</span></p>
			<p><span class="v">id</span><span class="c">编号</span><span class="t">Long</span></p>
			<p><span class="v">name</span><span class="c">站点名称</span><span class="t">String</span></p>
			<p><span class="v">url</span><span class="c">链接</span><span class="t">String</span></p>
			<p><span class="v">img</span><span class="c">图片</span><span class="t">String</span></p>
			<p><span class="v">metakeywords</span><span class="c">meta关键词</span><span class="t">String</span></p>
			<p><span class="v">metadescription</span><span class="c">meta描述</span><span class="t">String</span></p>
		</div>
		<div class="box" id="ViewCategory">
			<p class="title">ViewCategory<span class="c">栏目</span></p>
			<p><span class="v">id</span><span class="c">编号</span><span class="t">Long</span></p>
			<p><span class="v">pid</span><span class="c">父级栏目编号</span><span class="t">Long</span></p>
			<p><span class="v">siteid</span><span class="c">站点编号</span><span class="t">Long</span></p>
			<p><span class="v">name/title</span><span class="c">标题</span><span class="t">String</span></p>
			<p><span class="v">scope</span><span class="c">类型(0列表,1单页,2外链)</span><span class="t">int</span></p>
			<p><span class="v">url</span><span class="c">链接</span><span class="t">String</span></p>
			<p><span class="v">metakeywords</span><span class="c">meta关键词</span><span class="t">String</span></p>
			<p><span class="v">metadescription</span><span class="c">meta描述</span><span class="t">String</span></p>
			<p><span class="v">summary</span><span class="c">摘要</span><span class="t">String</span></p>
			<p><span class="v">releasetime</span><span class="c">创建时间</span><span class="t">String</span></p>
			<p><span class="v">releasesource</span><span class="c">来源</span><span class="t">String</span></p>
			<p><span class="v">releaseuser</span><span class="c">作者</span><span class="t">String</span></p>
			<p><span class="v">img</span><span class="c">图片</span><span class="t">String</span></p>
			<p><span class="v">content</span><span class="c">内容</span><span class="t">String</span></p>
			<p><span class="v">vo</span><span class="c">自定义字段</span><span class="t">Map</span></p>
			<p><span class="v">parent</span><span class="c">父栏目</span><span class="t"><a href="#ViewCategory">ViewCategory</a></span></p>
			<p><span class="v">list</span><span class="c">子栏目列表</span><span class="t">List&lt;<a href="#ViewCategory">ViewCategory</a>&gt;</span></p>
		</div>
		<div class="box" id="ViewArticle">
			<p class="title">ViewArticle<span class="c">文章</span></p>
			<p><span class="v">id</span><span class="c">编号</span><span class="t">Long</span></p>
			<p><span class="v">siteid</span><span class="c">站点编号</span><span class="t">Long</span></p>
			<p><span class="v">categoryid</span><span class="c">栏目编号</span><span class="t">Long</span></p>
			<p><span class="v">title</span><span class="c">标题</span><span class="t">String</span></p>
			<p><span class="v">scope</span><span class="c">类型(1单页,2外链)</span><span class="t">int</span></p>
			<p><span class="v">url</span><span class="c">链接</span><span class="t">String</span></p>
			<p><span class="v">metakeywords</span><span class="c">meta关键词</span><span class="t">String</span></p>
			<p><span class="v">metadescription</span><span class="c">meta描述</span><span class="t">String</span></p>
			<p><span class="v">summary</span><span class="c">摘要</span><span class="t">String</span></p>
			<p><span class="v">releasetime</span><span class="c">发布时间</span><span class="t">String</span></p>
			<p><span class="v">releasesource</span><span class="c">来源</span><span class="t">String</span></p>
			<p><span class="v">releaseuser</span><span class="c">作者</span><span class="t">String</span></p>
			<p><span class="v">img</span><span class="c">图片</span><span class="t">String</span></p>
			<p><span class="v">content</span><span class="c">内容</span><span class="t">String</span></p>
			<p><span class="v">vo</span><span class="c">自定义字段</span><span class="t">Map</span></p>
		</div>
		<div class="box" id="ViewArticleSet">
			<p class="title">ViewArticleSet<span class="c">文章分页</span></p>
			<p><span class="v">status</span><span class="c">状态码</span><span class="t">int</span></p>
			<p><span class="v">msg</span><span class="c">错误信息</span><span class="t">String</span></p>
			<p><span class="v">size</span><span class="c">查询到的文章总数</span><span class="t">int</span></p>
			<p><span class="v">page</span><span class="c">当前分页页码</span><span class="t">int</span></p>
			<p><span class="v">pagesize</span><span class="c">每页文章数量</span><span class="t">int</span></p>
			<p><span class="v">totalpage</span><span class="c">总页数</span><span class="t">int</span></p>
			<p><span class="v">rows</span><span class="c">分页的文章列表</span><span class="t">List&lt;<a href="#ViewArticle">ViewArticle</a>&gt;</span></p>
		</div>
		<div class="box" id="Datapage">
			<p class="title">Datapage<span class="c">翻页信息（用于第三方翻页组件）</span></p>
			<p><span class="v">page</span><span class="c">当前分页页码</span><span class="t">int</span></p>
			<p><span class="v">pagesize</span><span class="c">每页文章数量</span><span class="t">int</span></p>
			<p><span class="v">first</span><span class="c">第一页页码</span><span class="t">int</span></p>
			<p><span class="v">prev</span><span class="c">上一页页码</span><span class="t">int</span></p>
			<p><span class="v">next</span><span class="c">下一页页码</span><span class="t">int</span></p>
			<p><span class="v">last</span><span class="c">最后一页页码</span><span class="t">int</span></p>
			<p><span class="v">firsturl</span><span class="c">第一页链接</span><span class="t">String</span></p>
			<p><span class="v">prevurl</span><span class="c">上一页链接</span><span class="t">String</span></p>
			<p><span class="v">nexturl</span><span class="c">下一页链接</span><span class="t">String</span></p>
			<p><span class="v">lasturl</span><span class="c">最后一页链接</span><span class="t">String</span></p>
		</div>
	</div>
</body>
</html>
