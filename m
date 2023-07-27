Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C457656DA
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2LR-0000ZV-9N; Thu, 27 Jul 2023 10:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qP2LJ-0000XQ-P5
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:51:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qP2LD-0005Fr-Jw
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:51:53 -0400
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBYbm4vMJz1GDGV;
 Thu, 27 Jul 2023 22:50:44 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 22:51:38 +0800
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.027; 
 Thu, 27 Jul 2023 15:51:36 +0100
To: lixianglai <lixianglai@loongson.cn>, Gavin Shan <gshan@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, zhukeqian
 <zhukeqian1@huawei.com>, Bibo Mao <maobibo@loongson.cn>
CC: Salil Mehta <salil.mehta@opnsrc.net>
Subject: RE: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
Thread-Topic: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
Thread-Index: AQHZut1S/3Pg6wJUHEOwtjZl057Sma/MxBCAgAAVewCAAN8c4A==
Date: Thu, 27 Jul 2023 14:51:36 +0000
Message-ID: <0e2212c9533f49d9ba9dc7e728b8b586@huawei.com>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
 <e1c36ce7-6799-b003-9a47-b8094f869168@loongson.cn>
In-Reply-To: <e1c36ce7-6799-b003-9a47-b8094f869168@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.64]
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGVsbG8sDQoNCj4gRnJvbTogbGl4aWFuZ2xhaSA8bGl4aWFuZ2xhaUBsb29uZ3Nvbi5jbj4NCj4g
U2VudDogVGh1cnNkYXksIEp1bHkgMjcsIDIwMjMgMzoxNCBBTQ0KPiBUbzogR2F2aW4gU2hhbiA8
Z3NoYW5AcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgU2FsaWwgTWVodGENCj4g
PHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyB6aHVrZXFpYW4gPHpodWtlcWlhbjFAaHVhd2VpLmNv
bT47IEJpYm8gTWFvDQo+IDxtYW9iaWJvQGxvb25nc29uLmNuPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDAvOF0gQWRkcyBDUFUgaG90LXBsdWcgc3VwcG9ydCB0byBMb29uZ2FyY2gNCj4gDQo+IEhp
IEdhdmluIGFuZCBTYWxpbCwNCj4gDQo+IE9uIDcvMjcvMjMgODo1NyBBTSwgR2F2aW4gU2hhbiB3
cm90ZToNCj4gPiBIaSBYaWFuZ2xhaSwNCj4gPg0KPiA+IE9uIDcvMjAvMjMgMTc6MTUsIHhpYW5n
bGFpIGxpIHdyb3RlOg0KPiA+PiBIZWxsbyBldmVyeW9uZSwgV2UgcmVmZXIgdG8gdGhlIGltcGxl
bWVudGF0aW9uIG9mIEFSTSBDUFUNCj4gPj4gSG90LVBsdWcgdG8gYWRkIEdFRC1iYXNlZCBDUFUg
SG90LVBsdWcgc3VwcG9ydCB0byBMb29uZ2FyY2guDQo+ID4+DQo+ID4+IFRoZSBmaXJzdCA0IHBh
dGNoZXMgYXJlIGNoYW5nZXMgdG8gdGhlIFFFTVUgY29tbW9uIGNvZGUsDQo+ID4+IGluY2x1ZGlu
ZyBhZGRpbmcgR0VEIHN1cHBvcnQgZm9yIENQVSBIb3QtUGx1ZywgdXBkYXRpbmcNCj4gPj4gdGhl
IEFDUEkgdGFibGUgY3JlYXRpb24gcHJvY2VzcywgYW5kIGFkZGluZw0KPiA+PiBxZGV2X2Rpc2Nv
bm5lY3RfZ3Bpb19vdXRfbmFtZWQNCj4gPj4gYW5kIGNwdV9hZGRyZXNzX3NwYWNlX2Rlc3Ryb3kg
aW50ZXJmYWNlcyB0byByZWxlYXNlIHJlc291cmNlcw0KPiA+PiB3aGVuIENQVSB1bi1wbHVnLg0K
PiA+Pg0KPiA+PiBUaGUgbGFzdCBmb3VyIHBhdGNoZXMgYXJlIExvb25nYXJjaCBhcmNoaXRlY3R1
cmUtcmVsYXRlZCwNCj4gPj4gYW5kIHRoZSBtb2RpZmljYXRpb25zIGluY2x1ZGUgdGhlIGRlZmlu
aXRpb24gb2YgdGhlIGhvb2sNCj4gPj4gZnVuY3Rpb24gcmVsYXRlZCB0byB0aGUgQ1BVIEhvdC0o
VU4pUGx1ZywgdGhlIGFsbG9jYXRpb24NCj4gPj4gYW5kIHJlbGVhc2Ugb2YgQ1BVIHJlc291cmNl
cyB3aGVuIENQVSBIb3QtKFVOKVBsdWcsDQo+ID4+IHRoZSBjcmVhdGlvbiBwcm9jZXNzIG9mIHVw
ZGF0aW5nIHRoZSBBQ1BJIHRhYmxlLA0KPiA+PiBhbmQgZmluYWxseSB0aGUgY3VzdG9tIHN3aXRj
aCBmb3IgdGhlIENQVSBIb3QtUGx1Zy4NCj4gPj4NCj4gPg0KPiA+IFsuLi5dDQo+ID4NCj4gPiBJ
dCBzZWVtcyB0aGUgZGVzaWduIGZvciBBUk02NCBob3RwbHVnIGhhcyBiZWVuIGdyZWF0bHkgcmVm
ZXJyZWQsIGJ1dCB0aGUgYXV0aG9ycw0KPiA+IGFyZSBtaXNzZWQgdG8gYmUgY29waWVkIGlmIHlv
dSB3ZXJlIHJlZmVycmluZyB0byB0aGUgZm9sbG93aW5nIHJlcG9zaXRvcnkuIFRoZXJlDQo+ID4g
d2lsbCBiZSBjb25mbGljdHMgYmV0d2VlbiB0aG9zZSB0d28gcGF0Y2hzZXRzIGFzIEkgY2FuIHNl
ZSBhbmQgSSdtIG5vdCBzdXJlIGhvdw0KPiA+IGl0IGNhbiBiZSByZXNvbHZlZC4gSW4gdGhlb3J5
LCBvbmUgcGF0Y2hzZXQgbmVlZHMgdG8gYmUgcmViYXNlZCBvbiBhbm90aGVyIG9uZQ0KPiA+IHNp
bmNlIHRoZXkncmUgc2hhcmluZyBsYXJnZSBhbW91bnQgb2YgY29kZXMuDQo+ID4NCj4gPiDCoCBo
dHRwczovL2dpdGh1Yi5jb20vc2FsaWwtbWVodGEvcWVtdS5naXQNCj4gPiDCoCAoYnJhbmNoOiB2
aXJ0LWNwdWhwLWFybXY4L3JmYy12MS1wb3J0MTEwNTIwMjMuZGV2LTEpDQo+ID4NCj4gPiBJIHRv
b2sgYSBxdWljayBzY2FuIG9uIHRoaXMgc2VyaWVzLiBMb29uZ2FyY2ggZG9lc24ndCBoYXZlIEFS
TTY0J3MgY29uc3RyYWludCBkdWUNCj4gPiB0byB2R0lDMyB3aGVyZSBhbGwgdkNQVXMncyBmaWxl
IGRlc2NyaXB0b3IgbmVlZHMgdG8gYmUgaW4gcGxhY2UuIEl0IG1lYW5zIHRoZSBwb3NzaWJsZQ0K
PiA+IGFuZCBub3QgeWV0IHByZXNlbnQgdkNQVSBuZWVkcyB0byBiZSB2aXNpYmxlIHRvIEtWTS4g
V2l0aG91dCB0aGlzIGNvbnN0cmFpbnQsIHRoZQ0KPiA+IGltcGxlbWVudGF0aW9uIGlzIHNpbXBs
aWZpZWQgYSBsb3QuDQo+IA0KPiBXZSBoYXZlIGdyZWF0IHJlc3BlY3QgYW5kIGdyYXRpdHVkZSB0
byBTYWxpbCBhbmQgaGlzIHRlYW0gZm9yIHRoZWlyIHdvcmsNCj4gYW5kIGNvbnRyaWJ1dGlvbnMg
dG8gQ1BVIEhvdFBsdWcsDQoNCg0KTWFueSB0aGFua3MhIFJlYWxseSBhcHByZWNpYXRlIHRoaXMu
DQoNCg0KPiB3aGljaCBncmVhdGx5IHJlZHVjZWQgdGhlIGRpZmZpY3VsdHkgb2YgZGV2ZWxvcGlu
ZyBDUFUgSG90UGx1ZyBpbg0KPiBMb29uZ2FyY2guDQoNCg0KV2UgYXJlIGdsYWQgdGhhdCB0aGlz
IHdvcmsgaXMgdXNlZnVsIHRvIG90aGVyIGNvbXBhbmllcyBhcyB3ZWxsIHRoaXMNCndhcyBvbmUg
b2Ygb3VyIGdvYWwuDQoNCg0KPiBTbywgV2UgcGxhbiB0byByZWJhc2UgdGhlIG5leHQgdmVyc2lv
biBvZiBwYXRjaCBiYXNlZCBvbiB0aGVpciBjb2RlLg0KDQoNCkdyZWF0LiBUaGFua3MgZm9yIGNs
YXJpZnlpbmcgdGhpcyBhcyBhY2NvdW50YWJpbGl0eSBpcyBpbXBvcnRhbnQNCmV2ZW4gdGhvdWdo
IHdlIGFyZSB3b3JraW5nIGluIGEgY29sbGFib3JhdGl2ZSBlbnZpcm9ubWVudC4NCg0KQXMgc3Vj
aCwgSSBhbSBwbGFubmluZyB0byBzZW5kIHRoZSBSRkMgVjIgaW4gMiB3ZWVrcyBvZiB0aW1lIGFu
ZA0Kd2lsbCBtYWtlIHN1cmUgdGhhdCB0aGUgcGF0Y2hlcyB3aGljaCBhcmUgcmVxdWlyZWQgYnkg
eW91ciBwYXRjaC1zZXQNCmFyZSBmb3JtZWQgaW4gc3VjaCBhIHdheSB0aGF0IHRoZXkgY2FuIGJl
IGluZGVwZW5kZW50bHkgYWNjZXB0ZWQNCncuci50IHJlc3Qgb2YgdGhlIEFSTTY0IGFyY2hpdGVj
dHVyZSBzcGVjaWZpYyBwYXRjaC1zZXQuDQoNCg0KPiBIaSBTYWxpbCwNCj4gDQo+IEkgZXN0aW1h
dGUgdGhhdCBpdCB3aWxsIHRha2UgcXVpdGUgc29tZSB0aW1lIGZvciB5b3VyIHBhdGNoIHNlcmll
cyB0bw0KPiBtZXJnZSBpbiwNCj4gDQo+IGlmIGFsbG93ZWQsIGNhbiB5b3UgbWVyZ2UgeW91ciBw
YXRjaCBzZXJpZXMgY2hhbmdlcyB0byB0aGUgY29tbW9uIGNvZGUNCj4gc2VjdGlvbiBpbnRvIHRo
ZSBjb21tdW5pdHkgZmlyc3QsDQo+IA0KPiBzbyB0aGF0IG91ciBjb2RlIGNhbiBiZSByZWJhc2Ug
YW5kIG1lcmdlZC4NCg0KDQpTdXJlLCBhcyBjbGFyaWZpZWQgYWJvdmUsIHNvbWV0aGluZyBzaW1p
bGFyLCB3aWxsIGNyZWF0ZSBhIHBhdGNoLXNldA0Kd2hpY2ggd2lsbCBoYXZlIHBhdGNoZXMgd2hp
Y2ggY2FuIGJlIGluZGVwZW5kZW50bHkgYWNjZXB0ZWQvQWNrJ2VkDQphbmQgY29uc3VtZWQgZXZl
biBiZWZvcmUgdGhlIGNvbXBsZXRlIHBhdGNoLXNldC4NCg0KQWx0aG91Z2ggSSB0aGluaywgZXZl
biBpbiBjdXJyZW50IGZvcm0gbW9zdCBwYXRjaGVzIGhhdmUgYmVlbiBhcnJhbmdlZA0KaW4gc3Vj
aCBhIHdheS4gQnV0IEkgd2lsbCBkb3VibHkgY2hlY2sgYWdhaW4gYmVmb3JlIEkgZmxvYXQgUkZD
IFYyLg0KDQoNCj4gPiBCZXNpZGVzLCB3ZSBmb3VuZCB0aGUgdkNQVSBob3RwbHVnIGlzbid0IHdv
cmtpbmcgZm9yIFRDRyB3aGVuIFNhbGlsJ3MNCj4gPiBzZXJpZXMgd2FzDQo+ID4gdGVzdGVkLiBJ
J20gbm90IHN1cmUgaWYgd2UgaGF2ZSBzYW1lIGlzc3VlIHdpdGggdGhpcyBzZXJpZXMsIG9yIFRD
Rw0KPiA+IGlzbid0IGEgY29uY2Vybg0KPiA+IHRvIHVzIGF0IGFsbD8NCj4gDQo+IEF0IHByZXNl
bnQsIFFFTVUgb25seSBzdXBwb3J0cyBUQ0cgdW5kZXIgTG9vbmdhcmNoLA0KPiANCj4gYW5kIHdl
IHRlc3QgQ1BVIEhvdFBsdWcgaXMgYWxzbyBjYXJyaWVkIG91dCB1bmRlciBRRU1VIFRDRywNCj4g
DQo+IGFuZCBDUFUgSG90UGx1ZyBjYW4gd29yayBub3JtYWxseSB3aGVuIHRlc3RpbmcuDQo+IA0K
PiBPZiBjb3Vyc2UsIHdlIGFyZSBhbHNvIHZlcnkgaGFwcHkgdG8gc2VlIHlvdSB0ZXN0aW5nIENQ
VSBob3RwbHVnIHVuZGVyDQo+IExvb25nYXJjaCwNCj4gDQo+IHdoaWNoIGNhbiBmaW5kIG1vcmUg
cHJvYmxlbXMgYW5kIGhlbHAgdXMgaW1wcm92ZSBvdXIgcGF0Y2guDQoNCg0KV2Uga25vdyB0aGF0
LiBUaGVyZSBhcmUgc29tZSB0cml2aWFsIGZpeGVzIHdlIGFscmVhZHkgaGF2ZSwgSSB3aWxsIHB1
c2gNCnRoZW0gYXMgd2VsbCBmb3IgdGhlIGNvbXBsZXRpb24uIFdlIHdlcmUgbm90IHN1cmUgaWYg
YW55Ym9keSBuZWVkcyB0aGVtDQphcyB1c2FnZSBvZiB2Q1BVIEhvdHBsdWcgdW5kZXIgJ2FjY2Vs
PXRjZycgaXMgaGlnaGx5IHVubGlrZWx5IGV4Y2VwdCBmb3INCnRlc3RpbmcgY2FzZXMuIFBsZWFz
ZSBsZXQgdXMga25vdyBpZiB5b3UgaGF2ZSBhbnk/DQoNCg0KTWFueSB0aGFua3MhDQpTYWxpbC4N
Cg0K

