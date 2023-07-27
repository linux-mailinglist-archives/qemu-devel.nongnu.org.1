Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D2765718
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2SS-00048y-9i; Thu, 27 Jul 2023 10:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qP2SP-00048P-I5
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:59:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qP2SN-0006zq-9a
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:59:13 -0400
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBYmG6VyfzrS0g;
 Thu, 27 Jul 2023 22:58:06 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 22:59:00 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.027; 
 Thu, 27 Jul 2023 15:58:59 +0100
To: Gavin Shan <gshan@redhat.com>, xianglai li <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, zhukeqian
 <zhukeqian1@huawei.com>
CC: Salil Mehta <salil.mehta@opnsrc.net>
Subject: RE: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
Thread-Topic: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
Thread-Index: AQHZut1S/3Pg6wJUHEOwtjZl057Sma/MxBCAgAD5+6A=
Date: Thu, 27 Jul 2023 14:58:58 +0000
Message-ID: <f0be74b6104f49be943f5266be40cdd6@huawei.com>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
In-Reply-To: <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.64]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=salil.mehta@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgR2F2aW4sDQoNCj4gRnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIEp1bHkgMjcsIDIwMjMgMTo1NyBBTQ0KPiANCj4gSGkgWGlhbmdsYWksDQo+
IA0KPiBPbiA3LzIwLzIzIDE3OjE1LCB4aWFuZ2xhaSBsaSB3cm90ZToNCj4gPiBIZWxsbyBldmVy
eW9uZSwgV2UgcmVmZXIgdG8gdGhlIGltcGxlbWVudGF0aW9uIG9mIEFSTSBDUFUNCj4gPiBIb3Qt
UGx1ZyB0byBhZGQgR0VELWJhc2VkIENQVSBIb3QtUGx1ZyBzdXBwb3J0IHRvIExvb25nYXJjaC4N
Cj4gPg0KPiA+IFRoZSBmaXJzdCA0IHBhdGNoZXMgYXJlIGNoYW5nZXMgdG8gdGhlIFFFTVUgY29t
bW9uIGNvZGUsDQo+ID4gaW5jbHVkaW5nIGFkZGluZyBHRUQgc3VwcG9ydCBmb3IgQ1BVIEhvdC1Q
bHVnLCB1cGRhdGluZw0KPiA+IHRoZSBBQ1BJIHRhYmxlIGNyZWF0aW9uIHByb2Nlc3MsIGFuZCBh
ZGRpbmcgcWRldl9kaXNjb25uZWN0X2dwaW9fb3V0X25hbWVkDQo+ID4gYW5kIGNwdV9hZGRyZXNz
X3NwYWNlX2Rlc3Ryb3kgaW50ZXJmYWNlcyB0byByZWxlYXNlIHJlc291cmNlcw0KPiA+IHdoZW4g
Q1BVIHVuLXBsdWcuDQo+ID4NCj4gPiBUaGUgbGFzdCBmb3VyIHBhdGNoZXMgYXJlIExvb25nYXJj
aCBhcmNoaXRlY3R1cmUtcmVsYXRlZCwNCj4gPiBhbmQgdGhlIG1vZGlmaWNhdGlvbnMgaW5jbHVk
ZSB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgaG9vaw0KPiA+IGZ1bmN0aW9uIHJlbGF0ZWQgdG8gdGhl
IENQVSBIb3QtKFVOKVBsdWcsIHRoZSBhbGxvY2F0aW9uDQo+ID4gYW5kIHJlbGVhc2Ugb2YgQ1BV
IHJlc291cmNlcyB3aGVuIENQVSBIb3QtKFVOKVBsdWcsDQo+ID4gdGhlIGNyZWF0aW9uIHByb2Nl
c3Mgb2YgdXBkYXRpbmcgdGhlIEFDUEkgdGFibGUsDQo+ID4gYW5kIGZpbmFsbHkgdGhlIGN1c3Rv
bSBzd2l0Y2ggZm9yIHRoZSBDUFUgSG90LVBsdWcuDQoNClsuLi5dDQoNCj4gSXQgc2VlbXMgdGhl
IGRlc2lnbiBmb3IgQVJNNjQgaG90cGx1ZyBoYXMgYmVlbiBncmVhdGx5IHJlZmVycmVkLCBidXQg
dGhlIGF1dGhvcnMNCj4gYXJlIG1pc3NlZCB0byBiZSBjb3BpZWQgaWYgeW91IHdlcmUgcmVmZXJy
aW5nIHRvIHRoZSBmb2xsb3dpbmcgcmVwb3NpdG9yeS4NCj4gVGhlcmUgd2lsbCBiZSBjb25mbGlj
dHMgYmV0d2VlbiB0aG9zZSB0d28gcGF0Y2hzZXRzIGFzIEkgY2FuIHNlZSBhbmQgSSdtIG5vdCBz
dXJlDQo+IGhvdyBpdCBjYW4gYmUgcmVzb2x2ZWQuIEluIHRoZW9yeSwgb25lIHBhdGNoc2V0IG5l
ZWRzIHRvIGJlIHJlYmFzZWQgb24gYW5vdGhlcg0KPiBvbmUgc2luY2UgdGhleSdyZSBzaGFyaW5n
IGxhcmdlIGFtb3VudCBvZiBjb2Rlcy4NCj4gDQo+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9zYWxp
bC1tZWh0YS9xZW11LmdpdA0KPiAgICAoYnJhbmNoOiB2aXJ0LWNwdWhwLWFybXY4L3JmYy12MS1w
b3J0MTEwNTIwMjMuZGV2LTEpDQo+IA0KPiBJIHRvb2sgYSBxdWljayBzY2FuIG9uIHRoaXMgc2Vy
aWVzLiBMb29uZ2FyY2ggZG9lc24ndCBoYXZlIEFSTTY0J3MgY29uc3RyYWludCBkdWUNCj4gdG8g
dkdJQzMgd2hlcmUgYWxsIHZDUFVzJ3MgZmlsZSBkZXNjcmlwdG9yIG5lZWRzIHRvIGJlIGluIHBs
YWNlLiBJdCBtZWFucyB0aGUgcG9zc2libGUNCj4gYW5kIG5vdCB5ZXQgcHJlc2VudCB2Q1BVIG5l
ZWRzIHRvIGJlIHZpc2libGUgdG8gS1ZNLiBXaXRob3V0IHRoaXMgY29uc3RyYWludCwgdGhlDQo+
IGltcGxlbWVudGF0aW9uIGlzIHNpbXBsaWZpZWQgYSBsb3QuDQo+IA0KPiBCZXNpZGVzLCB3ZSBm
b3VuZCB0aGUgdkNQVSBob3RwbHVnIGlzbid0IHdvcmtpbmcgZm9yIFRDRyB3aGVuIFNhbGlsJ3Mg
c2VyaWVzIHdhcw0KPiB0ZXN0ZWQuIEknbSBub3Qgc3VyZSBpZiB3ZSBoYXZlIHNhbWUgaXNzdWUg
d2l0aCB0aGlzIHNlcmllcywgb3IgVENHIGlzbid0IGEgY29uY2Vybg0KPiB0byB1cyBhdCBhbGw/
DQoNCg0KU29ycnksIEkgc2hvdWxkIGhhdmUgcmVwbGllZCB0aGlzIGluIHRoZSBvdGhlciBtYWls
IGJ1dCBoYXZlIGJlZW4gb24vb2ZmIGluIGxhc3QNCmZldyBkYXlzIGR1ZSB0byBzb21lIG1lZGlj
YWwgcmVhc29ucy4gQnV0IGpvdHRpbmcgaXQgaGVyZToNCg0KWWVzLCB5b3UgYXJlIGNvcnJlY3Qu
IEFuZCB0aGVyZSBhcmUgc29tZSB0cml2aWFsIGZpeGVzIHdlIGFscmVhZHkgaGF2ZSB0byBtYWtl
DQppdCB3b3JrLiBJbiBjYXNlIGl0IGlzIHVzZWZ1bCB0byB5b3UsIHdlIGFyZSBwbGFubmluZyB0
byBhZGQgdGhlbSBmb3IgdGhlIHNha2UNCm9mIGNvbXBsZXRpb24uIE1heWJlIHlvdSBjYW4gdHJ5
IHRoYXQgaW4gdGhlIFJGQyBWMiBvciBJJ2xsIHNoYXJlIHdpdGggeW91IHRoZQ0KcmVwb3NpdG9y
eSBvbmNlIEkgcHVzaCB0aGUgZml4ZXMuDQoNCk1hbnkgdGhhbmtzIQ0KDQpCZXN0IHdpc2hlcywN
ClNhbGlsLg0K

