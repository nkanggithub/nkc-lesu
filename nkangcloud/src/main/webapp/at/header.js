﻿define("project/zt/2016/0530kyldywap/js/common/header/header",["./js/nav","./tpl/nav.tpl"],function(require){var a=require("./js/nav"),b={init:function(a){this.args=a,this.getLoginInfoRemote()},_handlerLoginInfo:function(b){var c={isLogin:!1,userName:""};1==b.status?c.isLogin=!1:(c.isLogin=!0,c.userName=b.data.userName),this.args.login.loginOriginUrl=this.args.login.loginUrl,this.args.login.loginUrl=this.plusNextPage(this.args.login.loginUrl),1==$.cookie("SEM")&&(this.args.login.loginUrl=this.plusNextPage(this.args.login.mobileloginUrl)),this.args.login.quitUrl=this.plusNextPage(this.args.login.quitUrl),$.extend(this.args.login,c),a.init(this.args)},plusNextPage:function(a){return-1==a.indexOf("?")?a+"?next_page="+location.href:a+"&next_page="+location.href},getLoginInfoRemote:function(){return $.ajax({url:this.args.loginInfoUrl,type:"get",dataType:"jsonp"}).done(function(a){b._handlerLoginInfo(a)})}};return function(a){$(function(){b.init(a)})}}),define("project/zt/2016/0530kyldywap/js/common/header/js/nav",[],function(require,exports,module){var a,b,c,d,e=require("project/zt/2016/0530kyldywap/js/common/header/tpl/nav.tpl"),f={init:function(e){f.opts=e,window.KOO_login=window.KOO_login||f.opts.login,$(function(){a=$("#ji-header"),b=$(document),c=$("body"),d=$(window),f.leftNav()})},leftNav:function(){function a(){var a=d.height();h.css("height",a+"px"),i.css("height",a+"px"),j.css({height:a+"px",overflow:"hidden"})}var b=_.template(e),c=b({login:f.opts.login}),g=$(".i-base-wrap");g.append(c);var h=$(".i-page-mask"),i=$(".i-left-nav"),j=$(".i-content-wrap"),k=i.find("form");k.on("submit",f.searchSubmit),g.on("click.leftNav",function(b){var c=$(b.target);c.hasClass("i-head-login")&&(a(),g.addClass("i-nav-open"),h.show(),d.on("touchmove.lock scroll.lock",function(){a()})),c.hasClass("i-page-mask")&&(g.removeClass("i-nav-open"),h.hide(),j.css({height:"auto",overflow:"visible"}),d.off("touchmove.lock scroll.lock"))}),d.on("orientationchange",function(){g.hasClass("i-nav-open")&&a()})},goBack:function(){a.on("click",".i-head-back",function(){return window.history.go(-1),!1})}};module.exports={init:f.init}}),define("project/zt/2016/0530kyldywap/js/common/header/tpl/nav.tpl",[],'<div class="i-page-mask"></div>\n<div class="i-left-nav">\n    <div class="inner">\n        <div class="top">\n            <div class="top-right">\n                <a href="<%- login.isLogin ? login.userCenter : login.loginUrl %>"><%- login.isLogin ? login.userName : \'鐠囧嘲鍘涢惂璇茬秿\' %></a>\n            </div>\n        </div>\n        <ul class="link-list">\n            <%\n            var loginUrl = login.loginOriginUrl;\n            var getLoginJumpUrl = function( jumpUrl ) {\n                var hasProtocol = /http/.test( jumpUrl );\n                if( !hasProtocol ) {\n                    jumpUrl = location.protocol + jumpUrl;\n                }\n                return loginUrl.indexOf( \'?\' ) == -1 ? (loginUrl + \'?next_page=\' + jumpUrl) : (loginUrl + \'&next_page=\' + jumpUrl);\n            }\n            var myCourseUrl = login.isLogin ? login.myCourse : getLoginJumpUrl( login.myCourse ),\n                    myOrderUrl = login.isLogin ? login.myOrder : getLoginJumpUrl( login.myOrder ),\n                    myCouponUrl = login.isLogin ? login.myDiscount : getLoginJumpUrl( login.myDiscount ),\n                    myCashUrl = login.isLogin ? login.myCash : getLoginJumpUrl( login.myCash ),\n                    myCardUrl = login.isLogin ? login.myLearnCard : getLoginJumpUrl( login.myLearnCard );\n            %>\n            <li>\n                <a href="<%- myCourseUrl %>">閹存垹娈戠拠鍓р柤</a>\n            </li>\n            <li>\n                <a href="<%- myOrderUrl %>">閹存垹娈戠拋銏犲礋</a>\n            </li>\n            <li>\n                <a href="<%- myCouponUrl %>">閹存垹娈戞导妯诲劕閸掞拷</a>\n            </li>\n            <li>\n                <a href="<%- myCashUrl %>">閹存垹娈戦悳浼村櫨鐠愶附鍩?/a>\n            </li>\n            <li>\n                <a href="<%- myCardUrl %>">閹存垹娈戠€涳缚绡勯崡陇澶勯幋锟?/a>\n            </li>\n            <% if(login.isLogin){ %>\n            <li>\n                <a href="<%- login.quitUrl %>">闁偓閸戯拷</a>\n            </li>\n            <% } %>\n        </ul>\n    </div>\n</div>');