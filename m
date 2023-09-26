Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E507AED23
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7R3-0008EK-TC; Tue, 26 Sep 2023 08:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7Qv-0008D3-Fn
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:44:57 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql7Qq-0000pH-Vj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:44:57 -0400
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rvzsg3Jxdz15NT5;
 Tue, 26 Sep 2023 20:42:31 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 20:44:44 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031; 
 Tue, 26 Sep 2023 13:44:42 +0100
To: David Hildenbrand <david@redhat.com>, lixianglai <lixianglai@loongson.cn>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@opnsrc.net>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "wangyanan
 (Y)" <wangyanan55@huawei.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Bibo Mao
 <maobibo@loongson.cn>
Subject: RE: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Topic: [PATCH v2 04/10] Introduce the CPU address space destruction
 function
Thread-Index: AQHZ5R7Fmo7gjrU/1EmDlFadlO4IebAWsogAgAOJWgCAAAdJgIAA3/CAgAABaoCAAFe/AIARji0QgAALU5D///fCgIAAErCw///xKgCAABFDsA==
Date: Tue, 26 Sep 2023 12:44:42 +0000
Message-ID: <f44b49d55fe5491c9dd0733ba11aca6a@huawei.com>
References: <cover.1694433326.git.lixianglai@loongson.cn>
 <3a4fc2a3df4b767c3c296a7da3bc15ca9c251316.1694433326.git.lixianglai@loongson.cn>
 <43f04ba4-3e16-ea5c-a212-66dda73a76c4@redhat.com>
 <20eb8316-22a2-c812-7172-6bd9016877cc@loongson.cn>
 <dd2b9190-c748-0ae2-b9de-8842e6e758e2@redhat.com>
 <7e0e1639-d821-fecb-b647-4a18afa600cc@loongson.cn>
 <e4e88068-4754-f7d4-e080-b7b8d5bcf006@loongson.cn>
 <5f610a1d-da1b-0094-41e7-f69164c4d0e0@redhat.com>
 <7906109a36c5467fa9b529520671fa77@huawei.com>
 <b8f256b3549e41a09119dee5ab5439d9@huawei.com>
 <40647bc5-6a2e-0b59-3605-0de8d4639f66@redhat.com>
 <e4b1bd2abbbe4763953c611e0308a530@huawei.com>
 <6c271cbe-22bb-417f-9873-31ad6f75f28c@redhat.com>
In-Reply-To: <6c271cbe-22bb-417f-9873-31ad6f75f28c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=salil.mehta@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVl
c2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDE6MzcgUE0NCj4gVG86IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPjsgbGl4aWFuZ2xhaQ0KPiA8bGl4aWFuZ2xhaUBsb29uZ3Nvbi5j
bj47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRh
QG9wbnNyYy5uZXQ+OyBYaWFvanVhbiBZYW5nDQo+IDx5YW5neGlhb2p1YW5AbG9vbmdzb24uY24+
OyBTb25nIEdhbyA8Z2Fvc29uZ0Bsb29uZ3Nvbi5jbj47IE1pY2hhZWwgUy4NCj4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+OyBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsgQW5p
IFNpbmhhDQo+IDxhbmlzaW5oYUByZWRoYXQuY29tPjsgUGFvbG8gQm9uemluaSA8cGJvbnppbmlA
cmVkaGF0LmNvbT47IFJpY2hhcmQNCj4gSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnPjsgRWR1YXJkbyBIYWJrb3N0DQo+IDxlZHVhcmRvQGhhYmtvc3QubmV0PjsgTWFyY2Vs
IEFwZmVsYmF1bSA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+Ow0KPiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OyB3YW5neWFuYW4gKFkpDQo+IDx3YW5neWFu
YW41NUBodWF3ZWkuY29tPjsgRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNv
bT47IFBldGVyDQo+IFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47IEJpYm8gTWFvIDxtYW9iaWJvQGxv
b25nc29uLmNuPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA0LzEwXSBJbnRyb2R1Y2UgdGhl
IENQVSBhZGRyZXNzIHNwYWNlIGRlc3RydWN0aW9uDQo+IGZ1bmN0aW9uDQo+IA0KPiBPbiAyNi4w
OS4yMyAxNDozMiwgU2FsaWwgTWVodGEgd3JvdGU6DQo+ID4+IEZyb206IERhdmlkIEhpbGRlbmJy
YW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjYs
IDIwMjMgMToyNCBQTQ0KPiA+Pg0KPiA+PiBPbiAyNi4wOS4yMyAxMzo1NSwgU2FsaWwgTWVodGEg
d3JvdGU6DQo+ID4+Pj4gRnJvbTogU2FsaWwgTWVodGENCj4gPj4+PiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgMjYsIDIwMjMgMTI6MjEgUE0NCj4gPj4+PiBUbzogJ0RhdmlkIEhpbGRlbmJyYW5k
JyA8ZGF2aWRAcmVkaGF0LmNvbT47IGxpeGlhbmdsYWkNCj4gPj4+PiA8bGl4aWFuZ2xhaUBsb29u
Z3Nvbi5jbj47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+Pj4+IENjOiBTYWxpbCBNZWh0YSA8
c2FsaWwubWVodGFAb3Buc3JjLm5ldD47IFhpYW9qdWFuIFlhbmcNCj4gPj4+PiA8eWFuZ3hpYW9q
dWFuQGxvb25nc29uLmNuPjsgU29uZyBHYW8gPGdhb3NvbmdAbG9vbmdzb24uY24+OyBNaWNoYWVs
IFMuDQo+ID4+Pj4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBJZ29yIE1hbW1lZG92IDxpbWFt
bWVkb0ByZWRoYXQuY29tPjsgQW5pDQo+IFNpbmhhDQo+ID4+Pj4gPGFuaXNpbmhhQHJlZGhhdC5j
b20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiA+Pj4+
IEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8gSGFia29z
dA0KPiA+Pj4+IDxlZHVhcmRvQGhhYmtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2Vs
LmFwZmVsYmF1bUBnbWFpbC5jb20+Ow0KPiA+Pj4+IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz47IHdhbmd5YW5hbiAoWSkNCj4gPj4+PiA8d2FuZ3lhbmFuNTVAaHVh
d2VpLmNvbT47IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+Ow0KPiA+
PiBQZXRlcg0KPiA+Pj4+IFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47IEJpYm8gTWFvIDxtYW9iaWJv
QGxvb25nc29uLmNuPg0KPiA+Pj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMDQvMTBdIEludHJv
ZHVjZSB0aGUgQ1BVIGFkZHJlc3Mgc3BhY2UNCj4gPj4gZGVzdHJ1Y3Rpb24NCj4gPj4+PiBmdW5j
dGlvbg0KPiA+Pj4+DQo+ID4+Pj4gSGkgRGF2aWQsDQo+ID4+Pj4NCj4gPj4+Pj4gRnJvbTogRGF2
aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+ID4+Pj4+IFNlbnQ6IEZyaWRheSwg
U2VwdGVtYmVyIDE1LCAyMDIzIDk6MDcgQU0NCj4gPj4+Pj4gVG86IGxpeGlhbmdsYWkgPGxpeGlh
bmdsYWlAbG9vbmdzb24uY24+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFNhbGlsDQo+ID4+Pj4g
TWVodGENCj4gPj4+Pj4gPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ID4+Pj4+IENjOiBTYWxp
bCBNZWh0YSA8c2FsaWwubWVodGFAb3Buc3JjLm5ldD47IFhpYW9qdWFuIFlhbmcNCj4gPj4+Pj4g
PHlhbmd4aWFvanVhbkBsb29uZ3Nvbi5jbj47IFNvbmcgR2FvIDxnYW9zb25nQGxvb25nc29uLmNu
PjsgTWljaGFlbA0KPiBTLg0KPiA+Pj4+PiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IElnb3Ig
TWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+OyBBbmkNCj4gPj4gU2luaGENCj4gPj4+Pj4g
PGFuaXNpbmhhQHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29t
PjsgUmljaGFyZA0KPiA+Pj4+PiBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5v
cmc+OyBFZHVhcmRvIEhhYmtvc3QNCj4gPj4+Pj4gPGVkdWFyZG9AaGFia29zdC5uZXQ+OyBNYXJj
ZWwgQXBmZWxiYXVtIDxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT47DQo+ID4+Pj4+IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz47IHdhbmd5YW5hbiAoWSkNCj4g
Pj4+Pj4gPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+OyBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJy
YW5nZUByZWRoYXQuY29tPjsNCj4gPj4gUGV0ZXINCj4gPj4+Pj4gWHUgPHBldGVyeEByZWRoYXQu
Y29tPjsgQmlibyBNYW8gPG1hb2JpYm9AbG9vbmdzb24uY24+DQo+ID4+Pj4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjIgMDQvMTBdIEludHJvZHVjZSB0aGUgQ1BVIGFkZHJlc3Mgc3BhY2UNCj4gPj4g
ZGVzdHJ1Y3Rpb24NCj4gPj4+Pj4gZnVuY3Rpb24NCj4gPj4+Pj4NCj4gPj4+Pj4gT24gMTUuMDku
MjMgMDQ6NTMsIGxpeGlhbmdsYWkgd3JvdGU6DQo+ID4+Pj4+PiBIaSBEYXZpZCBIaWxkZW5icmFu
ZDoNCj4gPj4+Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBIaSBEYXZpZCBIaWxkZW5icmFuZDoN
Cj4gPj4+Pj4+Pj4gT24gMTQuMDkuMjMgMTU6MDAsIGxpeGlhbmdsYWkgd3JvdGU6DQo+ID4+Pj4+
Pj4+PiBIaSBEYXZpZDoNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gSGkhDQo+ID4+Pj4+Pj4+DQo+
ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+IE9uIDEyLjA5LjIzIDA0OjExLCB4aWFuZ2xhaSBsaSB3
cm90ZToNCj4gPj4+Pj4+Pj4+Pj4gSW50cm9kdWNlIG5ldyBmdW5jdGlvbiB0byBkZXN0cm95IENQ
VSBhZGRyZXNzIHNwYWNlIHJlc291cmNlcw0KPiA+Pj4+Pj4+Pj4+PiBmb3IgY3B1IGhvdC0odW4p
cGx1Zy4NCj4gPj4+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+PiBIb3cgZG8gb3RoZXIgYXJjaHMgaGFu
ZGxlIHRoYXQ/IE9yIGhvdyBhcmUgdGhleSBhYmxlIHRvIGdldCBhd2F5DQo+ID4+Pj4+Pj4+Pj4g
d2l0aG91dCBkZXN0cm95aW5nPw0KPiA+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBUaGV5IGRvIG5v
dCByZW1vdmUgdGhlIGNwdSBhZGRyZXNzIHNwYWNlLCB0YWtpbmcgdGhlIFg4Ng0KPiA+Pj4+Pj4+
Pj4gYXJjaGl0ZWN0dXJlIGFzDQo+ID4+Pj4+Pj4+PiBhbiBleGFtcGxlOg0KPiA+Pj4+Pj4+Pj4N
Cj4gPj4+Pj4+Pj4+IDEuU3RhcnQgdGhlIHg4NiBWTToNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+
PiAuL3FlbXUtc3lzdGVtLXg4Nl82NCBcDQo+ID4+Pj4+Pj4+PiAtbWFjaGluZSBxMzXCoCBcDQo+
ID4+Pj4+Pj4+PiAtY3B1IEJyb2Fkd2VsbC1JQlJTIFwNCj4gPj4+Pj4+Pj4+IC1zbXAgMSxtYXhj
cHVzPTEwMCxzb2NrZXRzPTEwMCxjb3Jlcz0xLHRocmVhZHM9MSBcDQo+ID4+Pj4+Pj4+PiAtbSA0
RyBcDQo+ID4+Pj4+Pj4+PiAtZHJpdmUgZmlsZT1+L2Fub2xpcy04LjgucWNvdzLCoCBcDQo+ID4+
Pj4+Pj4+PiAtc2VyaWFsIHN0ZGlvwqDCoCBcDQo+ID4+Pj4+Pj4+PiAtbW9uaXRvciB0ZWxuZXQ6
bG9jYWxob3N0OjQ0OTgsc2VydmVyLG5vd2FpdMKgwqAgXA0KPiA+Pj4+Pj4+Pj4gLW5vZ3JhcGhp
Yw0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IDIuQ29ubmVjdCB0aGUgcWVtdSBtb25pdG9yDQo+
ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gdGVsbmV0IDEyNy4wLjAuMSA0NDk4DQo+ID4+Pj4+Pj4+
Pg0KPiA+Pj4+Pj4+Pj4gaW5mbyBtdHJlZQ0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+IGFkZHJl
c3Mtc3BhY2U6IGNwdS1tZW1vcnktMA0KPiA+Pj4+Pj4+Pj4gYWRkcmVzcy1zcGFjZTogbWVtb3J5
DQo+ID4+Pj4+Pj4+PiAgICDCoCDCoCAwMDAwMDAwMDAwMDAwMDAwLWZmZmZmZmZmZmZmZmZmZmYg
KHByaW8gMCwgaS9vKTogc3lzdGVtDQo+ID4+Pj4+Pj4+PiAgICDCoCDCoMKgwqAgMDAwMDAwMDAw
MDAwMDAwMC0wMDAwMDAwMDdmZmZmZmZmIChwcmlvIDAsIHJhbSk6IGFsaWFzDQo+ID4+Pj4+Pj4+
PiByYW0tYmVsb3ctNGcNCj4gPj4+Pj4+Pj4+IEBwYy5yYW0gMDAwMDAwMDAwMDAwMDAwMC0wMDAw
MDAwMDdmZmZmZmZmDQo+ID4+Pj4+Pj4+PiAgICDCoCDCoMKgwqAgMDAwMDAwMDAwMDAwMDAwMC1m
ZmZmZmZmZmZmZmZmZmZmIChwcmlvIC0xLCBpL28pOiBwY2kNCj4gPj4+Pj4+Pj4+ICAgIMKgIMKg
wqDCoMKgwqAgMDAwMDAwMDAwMDBhMDAwMC0wMDAwMDAwMDAwMGJmZmZmIChwcmlvIDEsIGkvbyk6
IHZnYS0NCj4gPj4gbG93bWVtDQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gMy5QZXJmb3JtIGNw
dSBob3Qgc3dhcCBpbnQgcWVtdSBtb25pdG9yDQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gZGV2
aWNlX2FkZA0KPiA+Pj4+Pj4+Pj4gQnJvYWR3ZWxsLUlCUlMteDg2XzY0LWNwdSxzb2NrZXQtaWQ9
MSxjb3JlLWlkPTAsdGhyZWFkLQ0KPiBpZD0wLGlkPWNwdTENCj4gPj4+Pj4+Pj4+IGRldmljZV9k
ZWwgY3B1MQ0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gSG0sIGRvZXNuJ3Qg
c2VlbSB0byB3b3JrIGZvciBtZSBvbiB1cHN0cmVhbSBRRU1VIGZvciBzb21lIHJlYXNvbjoNCj4g
Pj4+Pj4+Pj4gIkVycm9yOiBhY3BpOiBkZXZpY2UgdW5wbHVnIHJlcXVlc3QgZm9yIG5vdCBzdXBw
b3J0ZWQgZGV2aWNlIHR5cGU6DQo+ID4+Pj4+Pj4+IEJyb2Fkd2VsbC1JQlJTLXg4Nl82NC1jcHUi
DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+IEZpcnN0IEkgdXNlIHFlbXUgdGNnLCBhbmQgdGhlbiB0aGUg
Y3B1IG5lZWRzIHRvIGJlIHJlbW92ZWQgYWZ0ZXIgdGhlDQo+ID4+Pj4+PiBvcGVyYXRpbmcgc3lz
dGVtIGlzIGJvb3RlZC4NCj4gPj4+Pj4NCj4gPj4+Pj4gQWgsIHRoZSBsYXN0IHRoaW5nIGlzIHRo
ZSBpbXBvcnRhbnQgYml0LiBJIGNhbiByZXByb2R1Y2UgdGhpcyB3aXRoDQo+IEtWTQ0KPiA+Pj4+
PiBlYXNpbHkuDQo+ID4+Pj4+DQo+ID4+Pj4+IERvaW5nIGl0IGEgY291cGxlIG9mIHRpbWVzDQo+
ID4+Pj4+DQo+ID4+Pj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMA0KPiA+Pj4+PiBhZGRy
ZXNzLXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9y
eS0xDQo+ID4+Pj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4+PiBhZGRyZXNz
LXNwYWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0x
DQo+ID4+Pj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4+PiBhZGRyZXNzLXNw
YWNlOiBjcHUtbWVtb3J5LTENCj4gPj4+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+
ID4+Pj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4+PiBhZGRyZXNzLXNwYWNl
OiBjcHUtbWVtb3J5LTENCj4gPj4+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+ID4+
Pj4+IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4+PiBhZGRyZXNzLXNwYWNlOiBj
cHUtbWVtb3J5LTENCj4gPj4+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+ID4+Pj4+
IGFkZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4+PiBhZGRyZXNzLXNwYWNlOiBjcHUt
bWVtb3J5LTENCj4gPj4+Pj4gYWRkcmVzcy1zcGFjZTogY3B1LW1lbW9yeS0xDQo+ID4+Pj4+IGFk
ZHJlc3Mtc3BhY2U6IGNwdS1tZW1vcnktMQ0KPiA+Pj4+PiBhZGRyZXNzLXNwYWNlOiBjcHUtbWVt
b3J5LTENCj4gPj4+Pj4NCj4gPj4+Pj4gTG9va3MgbGlrZSBhIHJlc291cmNlL21lbW9yeSBsZWFr
Lg0KPiA+Pj4+DQo+ID4+Pj4gWWVzLCB0aGVyZSB3YXMuIFRoYW5rcyBmb3IgaWRlbnRpZnlpbmcg
aXQuIEkgaGF2ZSBmaXhlZCBpbiB0aGUNCj4gPj4+PiBsYXRlc3QgUkZDIFYyLiBQbGVhc2UgY2hl
Y2sgaGVyZToNCj4gPj4+Pg0KPiA+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyMzA5MjYxMDA0MzYuMjgyODQtMS0NCj4gPj4+PiBzYWxpbC5tZWh0YUBodWF3ZWkuY29t
L1QvI201ZjVhZTQwYjA5MWQ2OWQwMTAxMjg4MGQ3NTAwZDk2ODc0YTlkMzljDQo+ID4+Pj4NCj4g
Pj4+PiBJIGhhdmUgdGVzdGVkIGFuZCBBZGRyZXNzU3BhY2UgY29tZXMgYW5kIGdvZXMgYXdheSBj
bGVhbmx5DQo+ID4+Pj4gb24gQ1BVIGhvdCh1bilwbHVnIGFjdGlvbi4NCj4gPj4+DQo+ID4+PiBI
aSBEYXZpZC9YaWFuZ2xhaSwNCj4gPj4+IEFyZSB5b3Ugb2theSBpZiBJIHB1dCBSZXBvcnRlZC1i
eSBhbmQgZ2l2ZSByZWZlcmVuY2UgdG8gdGhpcw0KPiA+Pj4gY29udmVyc2F0aW9uPw0KPiA+Pg0K
PiA+PiBZZXMuIEFuZCBpZGVhbGx5LCBzZW5kIHRoZSBmaXhlcyBzZXBhcmF0ZWx5IGZyb20gdGhl
IG90aGVyIGFybSBwYXRjaGVzLg0KPiA+DQo+ID4gQVJNIFZpcnR1YWwgQ1BVIEhvdHBsdWcgc3Vw
cG9ydCBwYXRjaGVzIGFyZSBzdGlsbCB1bmRlciByZXZpZXcuDQo+IA0KPiBUaGUgb3RoZXIgYXJj
aGl0ZWN0dXJlcyAoYXMgc2hvd24sIHg4NiBpcyBhZmZlY3RlZCkgY2FuIGJlIGZpeGVkDQo+IGlu
ZGVwZW5kZW50IG9mIHRoYXQgc3VwcG9ydC4NCg0KWWVzLCB0aGV5IGNhbiBiZSBhbmQgdGhlIFRD
RyBhcyB3ZWxsLiBVbnJlYWxpemUgcGFydCBvZiBUQ0cgaXMNCmJyb2tlbiBldmVuIG9uIEFSTS4g
TmVlZCBzb21lIHdheSB0byBjbGVhbmx5IHVuYXNzaWduIFRyYW5zbGF0aW9uDQpibG9ja3MgZnJv
bSB0aGUgUmVnaW9uIHRyZWVzLiBUaGF04oCZcyBhIHBlbmRpbmcgd29yayBhdCBvdXIgZW5kLg0K
QnV0IHlvdSBhcmUgbW9yZSB0aGFuIHdlbGNvbWUgdG8gaGVscCBhbmQgY29udHJpYnV0ZSBpbiB0
aGF0DQphcyB3ZWxsLg0KDQpBbHNvLCBJIGNhbiBoZWxwIHRvIGNvbnRyaWJ1dGUsIGlmIHJlcXVp
cmVkLg0KDQpNYW55IHRoYW5rcw0KU2FsaWwuDQoNCg0KDQo=

