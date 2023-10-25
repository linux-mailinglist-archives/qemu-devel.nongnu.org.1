Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A37D63AC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYWn-00009u-1u; Wed, 25 Oct 2023 03:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qvYWk-00009W-0o
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:42:06 -0400
Received: from exchange.fintech.ru ([195.54.195.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mironov@fintech.ru>)
 id 1qvYWh-00072Q-8N
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:42:05 -0400
Received: from Ex16-02.fintech.ru (10.0.10.19) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 25 Oct
 2023 10:35:24 +0300
Received: from Ex16-02.fintech.ru (10.0.10.19) by Ex16-02.fintech.ru
 (10.0.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 25 Oct
 2023 10:35:24 +0300
Received: from Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c]) by
 Ex16-02.fintech.ru ([fe80::18b6:cd4a:a259:613c%3]) with mapi id
 15.01.2242.004; Wed, 25 Oct 2023 10:35:24 +0300
From: =?utf-8?B?0JzQuNGA0L7QvdC+0LIg0KHQtdGA0LPQtdC5INCS0LvQsNC00LjQvNC40YA=?=
 =?utf-8?B?0L7QstC40Yc=?= <mironov@fintech.ru>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Linux Verification Center
 <sdl.qemu@linuxtesting.org>
Subject: Re: [PATCH 1/1] ui: Replacing pointer in function
Thread-Topic: [PATCH 1/1] ui: Replacing pointer in function
Thread-Index: AQHZ/PklAx7SbqPmqEiegoIdEqlkSrBMKvYAgA4FfeQ=
Date: Wed, 25 Oct 2023 07:35:24 +0000
Message-ID: <8963b4b9de39416db776fcf9c96f348a@fintech.ru>
References: <20231012104448.1251039-1-mironov@fintech.ru>,
 <CAMxuvazb=kfGHoSxs7J95t9i_OGNdd_oTOmGgHe3hMYk2EwoOA@mail.gmail.com>
In-Reply-To: <CAMxuvazb=kfGHoSxs7J95t9i_OGNdd_oTOmGgHe3hMYk2EwoOA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.1.141]
Content-Type: multipart/alternative;
 boundary="_000_8963b4b9de39416db776fcf9c96f348afintechru_"
MIME-Version: 1.0
Received-SPF: pass client-ip=195.54.195.159; envelope-from=mironov@fintech.ru;
 helo=exchange.fintech.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

--_000_8963b4b9de39416db776fcf9c96f348afintechru_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8hIElzIHRoZXJlIGFueSBwcm9ncmVzcyBvbiB0aGlzIHBhdGNoPw0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0K0J7RgjogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+DQrQntGC0L/RgNCw0LLQu9C10L3QvjogMTYg0L7QutGC0Y/Q
sdGA0Y8gMjAyMyDQsy4gMTU6MjM6NDINCtCa0L7QvNGDOiDQnNC40YDQvtC90L7QsiDQodC10YDQ
s9C10Lkg0JLQu9Cw0LTQuNC80LjRgNC+0LLQuNGHDQrQmtC+0L/QuNGPOiBrcmF4ZWxAcmVkaGF0
LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyDQrQ
otC10LzQsDogUmU6IFtQQVRDSCAxLzFdIHVpOiBSZXBsYWNpbmcgcG9pbnRlciBpbiBmdW5jdGlv
bg0KDQpPbiBUaHUsIE9jdCAxMiwgMjAyMyBhdCAyOjQ24oCvUE0gU2VyZ2V5IE1pcm9ub3YgPG1p
cm9ub3ZAZmludGVjaC5ydT4gd3JvdGU6DQo+DQo+IEF0IHRoZSBlbmQgb2YgdGhlIGZpcnN0IGlm
IHdlIHNlZSAndmMtPmdmeC5zdXJmYWNlID0gTlVMTDsnLA0KPiBmdXJ0aGVyIGNoZWNraW5nIG9m
IGl0IGlzIHBvaW50bGVzcy4gSW4gdGhlIHNlY29uZCBpZiwgZWN0eCBpcyB0YWtlbi4NCj4NCj4g
Rm91bmQgYnkgTGludXggVmVyaWZpY2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0
aCBTVkFDRS4NCj4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVy
IDxzZGwucWVtdUBsaW51eHRlc3Rpbmcub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBTZXJnZXkgTWly
b25vdiA8bWlyb25vdkBmaW50ZWNoLnJ1Pg0KDQpSZXZpZXdlZC1ieTogTWFyYy1BbmRyw6kgTHVy
ZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQoNCj4gLS0tDQo+ICB1aS9ndGsuYyB8
IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiBpbmRleCA5MzVkZTEyMDli
Li41ZGEzZjliMDIyIDEwMDY0NA0KPiAtLS0gYS91aS9ndGsuYw0KPiArKysgYi91aS9ndGsuYw0K
PiBAQCAtMTQwMCw3ICsxNDAwLDcgQEAgc3RhdGljIHZvaWQgZ2RfbWVudV91bnRhYmlmeShHdGtN
ZW51SXRlbSAqaXRlbSwgdm9pZCAqb3BhcXVlKQ0KPiAgICAgICAgICAgICAgZWdsRGVzdHJveVN1
cmZhY2UocWVtdV9lZ2xfZGlzcGxheSwgdmMtPmdmeC5lc3VyZmFjZSk7DQo+ICAgICAgICAgICAg
ICB2Yy0+Z2Z4LmVzdXJmYWNlID0gTlVMTDsNCj4gICAgICAgICAgfQ0KPiAtICAgICAgICBpZiAo
dmMtPmdmeC5lc3VyZmFjZSkgew0KPiArICAgICAgICBpZiAodmMtPmdmeC5lY3R4KSB7DQo+ICAg
ICAgICAgICAgICBlZ2xEZXN0cm95Q29udGV4dChxZW11X2VnbF9kaXNwbGF5LCB2Yy0+Z2Z4LmVj
dHgpOw0KPiAgICAgICAgICAgICAgdmMtPmdmeC5lY3R4ID0gTlVMTDsNCj4gICAgICAgICAgfQ0K
PiAtLQ0KPiAyLjMxLjENCj4NCg0K

--_000_8963b4b9de39416db776fcf9c96f348afintechru_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRvciIgY29udGVu
dD0iTWljcm9zb2Z0IEV4Y2hhbmdlIFNlcnZlciI+DQo8IS0tIGNvbnZlcnRlZCBmcm9tIHRleHQg
LS0+PHN0eWxlPjwhLS0gLkVtYWlsUXVvdGUgeyBtYXJnaW4tbGVmdDogMXB0OyBwYWRkaW5nLWxl
ZnQ6IDRwdDsgYm9yZGVyLWxlZnQ6ICM4MDAwMDAgMnB4IHNvbGlkOyB9IC0tPjwvc3R5bGU+DQo8
L2hlYWQ+DQo8Ym9keT4NCjxtZXRhIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD1VVEYtOCI+
DQo8c3R5bGUgdHlwZT0idGV4dC9jc3MiIHN0eWxlPSIiPg0KPCEtLQ0KcA0KCXttYXJnaW4tdG9w
OjA7DQoJbWFyZ2luLWJvdHRvbTowfQ0KLS0+DQo8L3N0eWxlPg0KPGRpdiBkaXI9Imx0ciI+DQo8
ZGl2IGlkPSJ4X2RpdnRhZ2RlZmF1bHR3cmFwcGVyIiBkaXI9Imx0ciIgc3R5bGU9ImZvbnQtc2l6
ZToxMnB0OyBjb2xvcjojMDAwMDAwOyBmb250LWZhbWlseTpDYWxpYnJpLEhlbHZldGljYSxzYW5z
LXNlcmlmIj4NCjxwPjxzcGFuPkhlbGxvISBJcyB0aGVyZSBhbnkgcHJvZ3Jlc3Mgb24gdGhpcyBw
YXRjaD88L3NwYW4+PGJyPg0KPC9wPg0KPC9kaXY+DQo8aHIgdGFiaW5kZXg9Ii0xIiBzdHlsZT0i
ZGlzcGxheTppbmxpbmUtYmxvY2s7IHdpZHRoOjk4JSI+DQo8ZGl2IGlkPSJ4X2RpdlJwbHlGd2RN
c2ciIGRpcj0ibHRyIj48Zm9udCBmYWNlPSJDYWxpYnJpLCBzYW5zLXNlcmlmIiBjb2xvcj0iIzAw
MDAwMCIgc3R5bGU9ImZvbnQtc2l6ZToxMXB0Ij48Yj7QntGCOjwvYj4gTWFyYy1BbmRyw6kgTHVy
ZWF1ICZsdDttYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20mZ3Q7PGJyPg0KPGI+0J7RgtC/0YDQ
sNCy0LvQtdC90L46PC9iPiAxNiDQvtC60YLRj9Cx0YDRjyAyMDIzINCzLiAxNToyMzo0Mjxicj4N
CjxiPtCa0L7QvNGDOjwvYj4g0JzQuNGA0L7QvdC+0LIg0KHQtdGA0LPQtdC5INCS0LvQsNC00LjQ
vNC40YDQvtCy0LjRhzxicj4NCjxiPtCa0L7Qv9C40Y86PC9iPiBrcmF4ZWxAcmVkaGF0LmNvbTsg
cWVtdS1kZXZlbEBub25nbnUub3JnOyBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyPGJyPg0KPGI+
0KLQtdC80LA6PC9iPiBSZTogW1BBVENIIDEvMV0gdWk6IFJlcGxhY2luZyBwb2ludGVyIGluIGZ1
bmN0aW9uPC9mb250Pg0KPGRpdj4mbmJzcDs8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8Zm9udCBz
aXplPSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwcHQ7Ij4NCjxkaXYgY2xhc3M9IlBsYWlu
VGV4dCI+T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMjo0NuKAr1BNIFNlcmdleSBNaXJvbm92ICZs
dDttaXJvbm92QGZpbnRlY2gucnUmZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7IEF0IHRo
ZSBlbmQgb2YgdGhlIGZpcnN0IGlmIHdlIHNlZSAndmMtJmd0O2dmeC5zdXJmYWNlID0gTlVMTDsn
LDxicj4NCiZndDsgZnVydGhlciBjaGVja2luZyBvZiBpdCBpcyBwb2ludGxlc3MuIEluIHRoZSBz
ZWNvbmQgaWYsIGVjdHggaXMgdGFrZW4uPGJyPg0KJmd0Ozxicj4NCiZndDsgRm91bmQgYnkgTGlu
dXggVmVyaWZpY2F0aW9uIENlbnRlciAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTVkFDRS48YnI+
DQomZ3Q7PGJyPg0KJmd0OyBDby1kZXZlbG9wZWQtYnk6IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50
ZXIgJmx0O3NkbC5xZW11QGxpbnV4dGVzdGluZy5vcmcmZ3Q7PGJyPg0KJmd0OyBTaWduZWQtb2Zm
LWJ5OiBTZXJnZXkgTWlyb25vdiAmbHQ7bWlyb25vdkBmaW50ZWNoLnJ1Jmd0Ozxicj4NCjxicj4N
ClJldmlld2VkLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgJmx0O21hcmNhbmRyZS5sdXJlYXVAcmVk
aGF0LmNvbSZndDs8YnI+DQo8YnI+DQomZ3Q7IC0tLTxicj4NCiZndDsmbmJzcDsgdWkvZ3RrLmMg
fCAyICYjNDM7LTxicj4NCiZndDsmbmJzcDsgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCYj
NDM7KSwgMSBkZWxldGlvbigtKTxicj4NCiZndDs8YnI+DQomZ3Q7IGRpZmYgLS1naXQgYS91aS9n
dGsuYyBiL3VpL2d0ay5jPGJyPg0KJmd0OyBpbmRleCA5MzVkZTEyMDliLi41ZGEzZjliMDIyIDEw
MDY0NDxicj4NCiZndDsgLS0tIGEvdWkvZ3RrLmM8YnI+DQomZ3Q7ICYjNDM7JiM0MzsmIzQzOyBi
L3VpL2d0ay5jPGJyPg0KJmd0OyBAQCAtMTQwMCw3ICYjNDM7MTQwMCw3IEBAIHN0YXRpYyB2b2lk
IGdkX21lbnVfdW50YWJpZnkoR3RrTWVudUl0ZW0gKml0ZW0sIHZvaWQgKm9wYXF1ZSk8YnI+DQom
Z3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGVnbERlc3Ryb3lTdXJmYWNlKHFlbXVfZWdsX2Rpc3Bs
YXksIHZjLSZndDtnZnguZXN1cmZhY2UpOzxicj4NCiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsg
dmMtJmd0O2dmeC5lc3VyZmFjZSA9IE5VTEw7PGJyPg0KJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPg0KJmd0OyAtJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGlmICh2Yy0mZ3Q7Z2Z4LmVzdXJmYWNl
KSB7PGJyPg0KJmd0OyAmIzQzOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBpZiAodmMtJmd0O2dmeC5lY3R4KSB7PGJyPg0KJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBlZ2xEZXN0cm95Q29udGV4dChxZW11X2VnbF9kaXNwbGF5LCB2Yy0mZ3Q7Z2Z4LmVjdHgpOzxi
cj4NCiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgdmMtJmd0O2dmeC5lY3R4ID0gTlVMTDs8YnI+
DQomZ3Q7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7IH08YnI+DQomZ3Q7IC0tPGJyPg0KJmd0OyAyLjMxLjE8YnI+DQomZ3Q7PGJyPg0KPGJyPg0K
PC9kaXY+DQo8L3NwYW4+PC9mb250Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_8963b4b9de39416db776fcf9c96f348afintechru_--

