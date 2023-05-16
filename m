Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229F7050F2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:37:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvmF-00018d-K3; Tue, 16 May 2023 10:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1pyvlz-00016E-QY
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:35:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1pyvlu-0004MG-WF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:35:30 -0400
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLJf60RxDz67Lff;
 Tue, 16 May 2023 22:34:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 15:35:21 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.023; 
 Tue, 16 May 2023 15:35:21 +0100
To: Alex Williamson <alex.williamson@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela
 <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH v11 05/11] vfio/migration: Block multiple devices migration
Thread-Topic: [PATCH v11 05/11] vfio/migration: Block multiple devices
 migration
Thread-Index: AQHZQhQ7Fuj3Zst8rUyBXFad0ORVja9dM+pwgAAS8oCAAC6S0P//+r8AgAARNmA=
Date: Tue, 16 May 2023 14:35:21 +0000
Message-ID: <a48c5d11dbcd470f93633aae721b2d18@huawei.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-6-avihaih@nvidia.com>
 <e333783cc59647ed93d944b05f12fe68@huawei.com>	<ZGNwK+6HmM8lPjAU@nvidia.com>
 <c61606fdcb074dc88b29ae459dbdc0df@huawei.com>
 <20230516082732.702e8788.alex.williamson@redhat.com>
In-Reply-To: <20230516082732.702e8788.alex.williamson@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleCBXaWxsaWFtc29u
IFttYWlsdG86YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb21dDQo+IFNlbnQ6IDE2IE1heSAyMDIz
IDE1OjI4DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IENjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEu
Y29tPjsgQXZpaGFpIEhvcm9uIDxhdmloYWloQG52aWRpYS5jb20+Ow0KPiBxZW11LWRldmVsQG5v
bmdudS5vcmc7IEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+OyBEci4gRGF2aWQN
Cj4gQWxhbiBHaWxiZXJ0IDxkZ2lsYmVydEByZWRoYXQuY29tPjsgTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT47DQo+IENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPjsg
UGFvbG8gQm9uemluaQ0KPiA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkNCj4gPHZzZW1lbnRzb3ZAeWFuZGV4LXRlYW0ucnU+OyBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+OyBZaXNoYWkNCj4gSGFkYXMgPHlpc2hhaWhAbnZpZGlhLmNv
bT47IE1hb3IgR290dGxpZWIgPG1hb3JnQG52aWRpYS5jb20+OyBLaXJ0aQ0KPiBXYW5raGVkZSA8
a3dhbmtoZWRlQG52aWRpYS5jb20+OyBUYXJ1biBHdXB0YSA8dGFyZ3VwdGFAbnZpZGlhLmNvbT47
DQo+IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MTEgMDUvMTFdIHZmaW8vbWlncmF0aW9uOiBCbG9jayBtdWx0aXBsZSBkZXZp
Y2VzDQo+IG1pZ3JhdGlvbg0KPiANCj4gT24gVHVlLCAxNiBNYXkgMjAyMyAxMzo1NzoyMiArMDAw
MA0KPiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgW21haWx0bzpqZ2dAbnZpZGlhLmNvbV0N
Cj4gPiA+IFNlbnQ6IDE2IE1heSAyMDIzIDEzOjAwDQo+ID4gPiBUbzogU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+
ID4gQ2M6IEF2aWhhaSBIb3JvbiA8YXZpaGFpaEBudmlkaWEuY29tPjsgcWVtdS1kZXZlbEBub25n
bnUub3JnOyBBbGV4DQo+ID4gPiBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNv
bT47IEp1YW4gUXVpbnRlbGENCj4gPiA+IDxxdWludGVsYUByZWRoYXQuY29tPjsgRHIuIERhdmlk
IEFsYW4gR2lsYmVydCA8ZGdpbGJlcnRAcmVkaGF0LmNvbT47DQo+ID4gPiBNaWNoYWVsIFMuIFRz
aXJraW4gPG1zdEByZWRoYXQuY29tPjsgQ29ybmVsaWEgSHVjaw0KPiA8Y29odWNrQHJlZGhhdC5j
b20+Ow0KPiA+ID4gUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkNCj4gPiA+IDx2c2VtZW50c292QHlhbmRleC10ZWFtLnJ1Pjsg
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPjsNCj4gWWlzaGFpDQo+ID4gPiBIYWRh
cyA8eWlzaGFpaEBudmlkaWEuY29tPjsgTWFvciBHb3R0bGllYiA8bWFvcmdAbnZpZGlhLmNvbT47
IEtpcnRpDQo+ID4gPiBXYW5raGVkZSA8a3dhbmtoZWRlQG52aWRpYS5jb20+OyBUYXJ1biBHdXB0
YQ0KPiA8dGFyZ3VwdGFAbnZpZGlhLmNvbT47DQo+ID4gPiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5t
YXJ0aW5zQG9yYWNsZS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAwNS8xMV0g
dmZpby9taWdyYXRpb246IEJsb2NrIG11bHRpcGxlIGRldmljZXMNCj4gPiA+IG1pZ3JhdGlvbg0K
PiA+ID4NCj4gPiA+IE9uIFR1ZSwgTWF5IDE2LCAyMDIzIGF0IDEwOjAzOjU0QU0gKzAwMDAsIFNo
YW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gPiBD
dXJyZW50bHkgVkZJTyBtaWdyYXRpb24gZG9lc24ndCBpbXBsZW1lbnQgc29tZSBraW5kIG9mDQo+
IGludGVybWVkaWF0ZQ0KPiA+ID4gPiA+IHF1aWVzY2VudCBzdGF0ZSBpbiB3aGljaCBQMlAgRE1B
cyBhcmUgcXVpZXNjZWQgYmVmb3JlIHN0b3BwaW5nIG9yDQo+ID4gPiA+ID4gcnVubmluZyB0aGUg
ZGV2aWNlLiBUaGlzIGNhbiBjYXVzZSBwcm9ibGVtcyBpbiBtdWx0aS1kZXZpY2UgbWlncmF0aW9u
DQo+ID4gPiA+ID4gd2hlcmUgdGhlIGRldmljZXMgYXJlIGRvaW5nIFAyUCBETUFzLCBzaW5jZSB0
aGUgZGV2aWNlcyBhcmUgbm90DQo+IHN0b3BwZWQNCj4gPiA+ID4gPiB0b2dldGhlciBhdCB0aGUg
c2FtZSB0aW1lLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVW50aWwgc3VjaCBzdXBwb3J0IGlzIGFk
ZGVkLCBibG9jayBtaWdyYXRpb24gb2YgbXVsdGlwbGUgZGV2aWNlcy4NCj4gPiA+ID4NCj4gPiA+
ID4gTWlzc2VkIHRoaXMgb25lLiBDdXJyZW50bHkgdGhpcyBibG9ja3MgZXZlbiBpZiB0aGUgYXR0
YWNoZWQgZGV2aWNlcyBhcmUNCj4gbm90DQo+ID4gPiA+IGNhcGFibGUgb2YgUDJQIERNQXMuIGVn
OyBIaVNpbGljb24gQUNDIGRldmljZXMuIFRoZXNlIGFyZSBpbnRlZ3JhdGVkDQo+IGVuZA0KPiA+
ID4gcG9pbnQNCj4gPiA+ID4gZGV2aWNlcyB3aXRob3V0IGFueSBQMlAgY2FwYWJpbGl0eSBiZXR3
ZWVuIHRoZW0uIElzIGl0IE9rIHRvIGNoZWNrIGZvcg0KPiA+ID4gPiBWRklPX01JR1JBVElPTl9Q
MlAgZmxhZyBhbmQgYWxsb3cgaWYgdGhlIGRldmljZXMgYXJlIG5vdCBzdXBwb3J0aW5nDQo+ID4g
PiB0aGF0Pw0KPiA+ID4NCj4gPiA+IExhY2tpbmcgVkZJT19NSUdSQVRJT05fUDJQIGRvZXNuJ3Qg
bWVhbiB0aGUgZGV2aWNlIGlzIGluY2FwYWJsZSBvZg0KPiA+ID4gUDJQLCBpdCBtZWFucyB0aGUg
bWlncmF0aW9uIGNhbid0IHN1cHBvcnQgUDJQLg0KPiA+ID4NCj4gPiA+IFdlJ2QgbmVlZCBzb21l
IGtpbmQgb2YgbmV3IGZsYWcgdG8gY2hlY2sgYW5kIHN1Y2ggZGV2aWNlcyBzaG91bGQgYmUNCj4g
PiA+IGJsb2NrZWQgZnJvbSBjcmVhdGluZyBQMlAgbWFwcGluZ3MuIEJhc2ljYWxseSB3ZSBkb24n
dCBjdXJyZW50bHkNCj4gPiA+IGZ1bGx5IHN1cHBvcnQgZGV2aWNlcyB0aGF0IGFyZSBpbmNhcGFi
bGUgb2YgUDJQIG9wZXJhdGlvbnMuDQo+ID4NCj4gPiBPay4gSSB3aWxsIHRha2UgYSBsb29rLg0K
PiA+DQo+ID4gPiBXaGF0IGhhcHBlbnMgb24geW91ciBwbGF0Zm9ybSBpZiBhIGd1ZXN0IHRyaWVz
IHRvIGRvIFAyUD8gRG9lcyB0aGUNCj4gPiA+IHBsYXRmb3JtIGNyYXNoPw0KPiA+DQo+ID4gSSBh
bSBub3Qgc3VyZS4gU2luY2UgdGhlIGRldmljZXMgYXJlIGJlaGluZCBTTU1VLCBJIHdhcyB1bmRl
ciB0aGUNCj4gYXNzdW1wdGlvbg0KPiA+IHRoYXQgd2UgZG8gaGF2ZSB0aGUgZ3VhcmFudGVlIG9m
IGlzb2xhdGlvbiBoZXJlKGdyb3VwaW5nKS4gT3IgdGhpcyBpcw0KPiBzb21ldGhpbmcNCj4gPiB3
ZSBhcmUgd29ycmllZCBvbmx5IGR1cmluZyBtaWdyYXRpb24/DQo+IA0KPiBHcm91cGluZyBkb2Vz
bid0IGd1YXJhbnRlZSB0aGF0IG1hcHBpbmdzIGNhbm5vdCBiZSBjcmVhdGVkIHRocm91Z2ggdGhl
DQo+IFNNTVUgYmV0d2VlbiBkZXZpY2VzLiAgV2hlbiB3ZSByZWZlciB0byBkZXZpY2VzIGJlaW5n
IGlzb2xhdGVkIGJldHdlZW4NCj4gZ3JvdXBzLCB0aGF0IG9ubHkgZXhjbHVkZXMgaW50ZXJuYWwg
UDJQIGJldHdlZW4gZGV2aWNlcywgZm9yIGV4YW1wbGUNCj4gYWNyb3NzIHRoZSBpbnRlcm5hbCBs
aW5rIGJldHdlZW4gZnVuY3Rpb25zIHdpdGggaW1wbGVtZW50YXRpb24gc3BlY2lmaWMNCj4gcm91
dGluZy4gIEZvciBncm91cCBpc29sYXRpb24sIHRoZSBndWFyYW50ZWUgaXMgdGhhdCBETUEgaXMg
YWx3YXlzDQo+IHJvdXRlZCB1cHN0cmVhbSwgbm90IHRoYXQgdGhlIHVsdGltYXRlIHRhcmdldCBj
YW5ub3QgYmUgYW5vdGhlciBkZXZpY2UuDQo+IFRvIGd1YXJhbnRlZSBsYWNrIG9mIFAyUCB0aGUg
U01NVSB3b3VsZCBuZWVkIHRvIHJlamVjdCBub24tbWVtb3J5DQo+IHRyYW5zbGF0aW9uIHRhcmdl
dHMuICBUaGFua3MsDQoNCk9rLiBHb3QgaXQuIFNvIGl0IGRlcGVuZHMgb24gd2hhdCBTTU1VIGRv
ZXMgZm9yIHRoYXQgbWFwcGluZyBhbmQgaXMgbm90DQpyZWxhdGVkIHRvIG1pZ3JhdGlvbiBwZXIg
c2UgYW5kIGhhcyB0aGUgcG90ZW50aWFsIHRvIGNyYXNoIHRoZSBzeXN0ZW0gaWYgDQpTTU1VIGdv
IGFoZWFkIHdpdGggdGhhdCBtZW1vcnkgYWNjZXNzLiBJc24ndCBpdCBhIG1vcmUgZ2VuZXJpYyBw
cm9ibGVtDQp0aGVuIHdoZW4gd2UgaGF2ZSBtdWx0aXBsZSBkZXZpY2VzIGF0dGFjaGVkIHRvIHRo
ZSBWTT8gSSBuZWVkIHRvIGNoZWNrIGlmIA0KdGhlcmUgaXMgYW55dGhpbmcgaW4gU01NVSBzcGVj
IHRoYXQgZm9yYmlkcyB0aGlzIGFjY2Vzcy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg==

