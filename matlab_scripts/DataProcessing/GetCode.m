function Code = GetCode(Name)
%Takes the name string and spits out the corresponding code
Key=["zhanghaoyu","tysc100028";"wangxupeng","tysc100027";"nichengbo","tysc100026";"futianyu","tysc100025";"chentongfeng","tysc100024";"zhuhaifeng","tysc100023";"wutianyao","tysc100022";"wangxingtao","tysc100021";"susirui","tysc100020";"lixin","tysc100019";"helecheng","tysc100018";"geyongwei","tysc100017";"yinyicheng","tysc100016";"zhongnaidun","tysc100015";"yangfan","tysc100014";"wangqiuran","tysc100013";"maoqilong","tysc100012";"gaoyuguang","tysc100011";"chenmeng","tysc100010";"zhangjianqiang","tysc100009";"xiahan","tysc100008";"wuyanjun","tysc100007";"huzhongzhong","tysc100006";"guoyunzhe","tysc100005";"guoshengbo","tysc100004";"panlongyu","tysc100003";"lizhexi","tysc100002";"lixiang","tysc100001"];
a=lower(Name);
X=contains(Key(1:end,1),a);
Code=Key(X,2);
end
