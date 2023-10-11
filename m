Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A007C5589
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZKT-0006gc-4D; Wed, 11 Oct 2023 09:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lv.mengzhao@zte.com.cn>)
 id 1qqTU8-0000Ew-HO; Wed, 11 Oct 2023 03:18:24 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lv.mengzhao@zte.com.cn>)
 id 1qqTU3-0000Wq-HY; Wed, 11 Oct 2023 03:18:24 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4S53yJ11YBz4xVbv;
 Wed, 11 Oct 2023 15:18:00 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl2.zte.com.cn with SMTP id 39B7HqQo085845;
 Wed, 11 Oct 2023 15:17:53 +0800 (+08)
 (envelope-from lv.mengzhao@zte.com.cn)
Received: from mapi (xaxapp03[null]) by mapi (Zmail) with MAPI id mid31;
 Wed, 11 Oct 2023 15:17:54 +0800 (CST)
Date: Wed, 11 Oct 2023 15:17:54 +0800 (CST)
X-Zmail-TransId: 2afb65264c226da-73b8f
X-Mailer: Zmail v1.0
Message-ID: <202310111517549668181@zte.com.cn>
Mime-Version: 1.0
From: <lv.mengzhao@zte.com.cn>
To: <mst@redhat.com>, <stefanha@redhat.com>, <kwolf@redhat.com>,
 <hreitz@redhat.com>
Cc: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <hu.jian@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB2aXJ0aW8tYmxrOiBkb24ndCBzdGFydCBkYXRhcGxhbmUgZHVyaW5nIHRoZSBzdG9wIG9mIGRhdGFwbGFuZQ==?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl2.zte.com.cn 39B7HqQo085845
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65264C28.000/4S53yJ11YBz4xVbv
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=lv.mengzhao@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Oct 2023 09:32:07 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogaHVqaWFuIDxodS5qaWFuQHp0ZS5jb20uY24+DQoNCkR1cmluZyB0aGUgc3RvcCBvZiBk
YXRhcGxhbmUgZm9yIHZpcnRpby1ibGssIHZpcnRpb19idXNfY2xlYW51cF9ob3N0X25vdGlmaWVy
KCkgaXMgYmUNCmNhbGxlZCB0byBjbGVhbiB1cCBub3RpZmllciBhdCB0aGUgZW5kLCBpZiBwb2xs
ZWQgaW9ldmVudGZkLCB2aXJ0aW9fYmxrX2hhbmRsZV9vdXRwdXQoKQ0KaXMgdXNlZCB0byBoYW5k
bGUgaW8gcmVxdWVzdC4gQnV0IGR1ZSB0byBzLT5kYXRhcGxhbmVfZGlzYWJsZWQgaXMgZmFsc2Us
IGl0IHdpbGwgYmUNCnJldHVybmVkIGRpcmVjdGx5LCB3aGljaCBkcm9wcyBpbyByZXF1ZXN0Lg0K
QmFja3RyYWNlOg0KLT52aXJ0aW9fYmxrX2RhdGFfcGxhbmVfc3RvcA0KICAtPnZpcnRpb19idXNf
Y2xlYW51cF9ob3N0X25vdGlmaWVyDQogICAgLT52aXJ0aW9fcXVldWVfaG9zdF9ub3RpZmllcl9y
ZWFkDQogICAgICAtPnZpcnRpb19xdWV1ZV9ub3RpZnlfdnENCiAgICAgICAgLT52cS0+aGFuZGxl
X291dHB1dA0KICAgICAgICAgIC0+dmlydGlvX2Jsa19oYW5kbGVfb3V0cHV0DQogICAgICAgICAg
ICAtPmlmIChzLT5kYXRhcGxhbmUgICYmICFzLT5kYXRhcGxhbmVfc3RvcGVkKQ0KICAgICAgICAg
ICAgICAtPmlmICghcy0+ZGF0YXBsYW5lX2Rpc2FibGVkKQ0KICAgICAgICAgICAgICAgIC0+cmV0
dXJuICoNCiAgICAgICAgICAgIC0+dmlydGlvX2Jsa19oYW5kbGVfb3V0cHV0X2RvDQpUaGUgYWJv
dmUgcHJvYmxlbSBjYW4gb2NjdXIgd2hlbiB1c2luZyAidmlyc2ggcmVzZXQiIGNtZGxpbmUgdG8g
cmVzZXQgZ3Vlc3QsIHdoaWxlDQpndWVzdCBkb2VzIGlvLg0KVG8gZml4IHRoaXMgcHJvYmxlbSwg
ZG9uJ3QgdHJ5IHRvIHN0YXJ0IGRhdGFwbGFuZSBpZiBzLT5zdG9wcGluZyBpcyB0cnVlLCBhbmQg
aW8gd2lsbA0KYmUgaGFuZGxlZCBieSB2aXJ0aW9fYmxrX2hhbmRsZV92cSgpLg0KDQpTaWduZWQt
b2ZmLWJ5OiBodWppYW4gPGh1LmppYW5AenRlLmNvbS5jbj4NCi0tLQ0KIGh3L2Jsb2NrL3ZpcnRp
by1ibGsuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYyBiL2h3L2Jsb2NrL3Zp
cnRpby1ibGsuYw0KaW5kZXggMzllN2YyMy4uYzJkNTkzOCAxMDA2NDQNCi0tLSBhL2h3L2Jsb2Nr
L3ZpcnRpby1ibGsuYw0KKysrIGIvaHcvYmxvY2svdmlydGlvLWJsay5jDQpAQCAtMTE2Niw3ICsx
MTY2LDcgQEAgc3RhdGljIHZvaWQgdmlydGlvX2Jsa19oYW5kbGVfb3V0cHV0KFZpcnRJT0Rldmlj
ZSAqdmRldiwgVmlydFF1ZXVlICp2cSkNCiB7DQogICAgIFZpcnRJT0Jsb2NrICpzID0gKFZpcnRJ
T0Jsb2NrICopdmRldjsNCg0KLSAgICBpZiAocy0+ZGF0YXBsYW5lICYmICFzLT5kYXRhcGxhbmVf
c3RhcnRlZCkgew0KKyAgICBpZiAocy0+ZGF0YXBsYW5lICYmICFzLT5kYXRhcGxhbmVfc3RhcnRl
ZCAmJiAhcy0+c3RvcHBpbmcpIHsNCiAgICAgICAgIC8qIFNvbWUgZ3Vlc3RzIGtpY2sgYmVmb3Jl
IHNldHRpbmcgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSyBzbyBzdGFydA0KICAgICAgICAgICog
ZGF0YXBsYW5lIGhlcmUgaW5zdGVhZCBvZiB3YWl0aW5nIGZvciAuc2V0X3N0YXR1cygpLg0KICAg
ICAgICAgICovDQotLQ0KMS44LjMuMQ==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IGh1amlhbiAmbHQ7aHUuamlhbkB6dGUu
Y29tLmNuJmd0OzwvcD48cD48YnI+PC9wPjxwPkR1cmluZyB0aGUgc3RvcCBvZiBkYXRhcGxhbmUg
Zm9yIHZpcnRpby1ibGssIHZpcnRpb19idXNfY2xlYW51cF9ob3N0X25vdGlmaWVyKCkgaXMgYmU8
L3A+PHA+Y2FsbGVkIHRvIGNsZWFuIHVwIG5vdGlmaWVyIGF0IHRoZSBlbmQsIGlmIHBvbGxlZCBp
b2V2ZW50ZmQsIHZpcnRpb19ibGtfaGFuZGxlX291dHB1dCgpPC9wPjxwPmlzIHVzZWQgdG8gaGFu
ZGxlIGlvIHJlcXVlc3QuIEJ1dCBkdWUgdG8gcy0mZ3Q7ZGF0YXBsYW5lX2Rpc2FibGVkIGlzIGZh
bHNlLCBpdCB3aWxsIGJlPC9wPjxwPnJldHVybmVkIGRpcmVjdGx5LCB3aGljaCBkcm9wcyBpbyBy
ZXF1ZXN0LjwvcD48cD5CYWNrdHJhY2U6PC9wPjxwPi0mZ3Q7dmlydGlvX2Jsa19kYXRhX3BsYW5l
X3N0b3A8L3A+PHA+Jm5ic3A7IC0mZ3Q7dmlydGlvX2J1c19jbGVhbnVwX2hvc3Rfbm90aWZpZXI8
L3A+PHA+Jm5ic3A7ICZuYnNwOyAtJmd0O3ZpcnRpb19xdWV1ZV9ob3N0X25vdGlmaWVyX3JlYWQ8
L3A+PHA+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgLSZndDt2aXJ0aW9fcXVldWVfbm90aWZ5X3ZxPC9w
PjxwPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAtJmd0O3ZxLSZndDtoYW5kbGVfb3V0cHV0
PC9wPjxwPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgLSZndDt2aXJ0aW9fYmxr
X2hhbmRsZV9vdXRwdXQ8L3A+PHA+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgLSZndDtpZiAocy0mZ3Q7ZGF0YXBsYW5lICZuYnNwOyZhbXA7JmFtcDsgIXMtJmd0O2Rh
dGFwbGFuZV9zdG9wZWQpPC9wPjxwPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAtJmd0O2lmICghcy0mZ3Q7ZGF0YXBsYW5lX2Rpc2FibGVkKTwvcD48cD4m
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IC0m
Z3Q7cmV0dXJuICo8L3A+PHA+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgLSZndDt2aXJ0aW9fYmxrX2hhbmRsZV9vdXRwdXRfZG88L3A+PHA+VGhlIGFib3ZlIHByb2Js
ZW0gY2FuIG9jY3VyIHdoZW4gdXNpbmcgInZpcnNoIHJlc2V0IiBjbWRsaW5lIHRvIHJlc2V0IGd1
ZXN0LCB3aGlsZTwvcD48cD5ndWVzdCBkb2VzIGlvLjwvcD48cD5UbyBmaXggdGhpcyBwcm9ibGVt
LCBkb24ndCB0cnkgdG8gc3RhcnQgZGF0YXBsYW5lIGlmIHMtJmd0O3N0b3BwaW5nIGlzIHRydWUs
IGFuZCBpbyB3aWxsPC9wPjxwPmJlIGhhbmRsZWQgYnkgdmlydGlvX2Jsa19oYW5kbGVfdnEoKS48
L3A+PHA+PGJyPjwvcD48cD5TaWduZWQtb2ZmLWJ5OiBodWppYW4gJmx0O2h1LmppYW5AenRlLmNv
bS5jbiZndDs8L3A+PHA+LS0tPC9wPjxwPiZuYnNwO2h3L2Jsb2NrL3ZpcnRpby1ibGsuYyB8IDIg
Ky08L3A+PHA+Jm5ic3A7MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pPC9wPjxwPjxicj48L3A+PHA+ZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3ZpcnRpby1ibGsuYyBi
L2h3L2Jsb2NrL3ZpcnRpby1ibGsuYzwvcD48cD5pbmRleCAzOWU3ZjIzLi5jMmQ1OTM4IDEwMDY0
NDwvcD48cD4tLS0gYS9ody9ibG9jay92aXJ0aW8tYmxrLmM8L3A+PHA+KysrIGIvaHcvYmxvY2sv
dmlydGlvLWJsay5jPC9wPjxwPkBAIC0xMTY2LDcgKzExNjYsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0
aW9fYmxrX2hhbmRsZV9vdXRwdXQoVmlydElPRGV2aWNlICp2ZGV2LCBWaXJ0UXVldWUgKnZxKTwv
cD48cD4mbmJzcDt7PC9wPjxwPiZuYnNwOyAmbmJzcDsgJm5ic3A7VmlydElPQmxvY2sgKnMgPSAo
VmlydElPQmxvY2sgKil2ZGV2OzwvcD48cD48YnI+PC9wPjxwPi0gJm5ic3A7ICZuYnNwO2lmIChz
LSZndDtkYXRhcGxhbmUgJmFtcDsmYW1wOyAhcy0mZ3Q7ZGF0YXBsYW5lX3N0YXJ0ZWQpIHs8L3A+
PHA+KyAmbmJzcDsgJm5ic3A7aWYgKHMtJmd0O2RhdGFwbGFuZSAmYW1wOyZhbXA7ICFzLSZndDtk
YXRhcGxhbmVfc3RhcnRlZCAmYW1wOyZhbXA7ICFzLSZndDtzdG9wcGluZykgezwvcD48cD4mbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7LyogU29tZSBndWVzdHMga2ljayBiZWZvcmUg
c2V0dGluZyBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LIHNvIHN0YXJ0PC9wPjxwPiZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgKiBkYXRhcGxhbmUgaGVyZSBpbnN0ZWFkIG9mIHdh
aXRpbmcgZm9yIC5zZXRfc3RhdHVzKCkuPC9wPjxwPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgKi88L3A+PHA+LS08L3A+PHA+MS44LjMuMTwvcD48cCBzdHlsZT0iZm9udC1zaXpl
OjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+
PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxNaWNyb3Nv
ZnQgWWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZhbWlseTrl
vq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9udC1zaXpl
OjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxicj48L3A+
PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


