Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DCB7408D4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 05:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qELYc-0003so-UF; Tue, 27 Jun 2023 23:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1qELYa-0003sa-C1
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 23:09:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1qELYX-0005cf-I3
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 23:09:24 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QrRLM2bq8z67JVD;
 Wed, 28 Jun 2023 11:06:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 04:09:06 +0100
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.027; 
 Wed, 28 Jun 2023 04:09:06 +0100
To: Jason Gunthorpe <jgg@nvidia.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, "Juan
 Quintela" <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Yishai Hadas
 <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Thread-Topic: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Thread-Index: AQHZqAe9xWqtnkKCnUuk+QMqdzcMFK+dAQSAgAAFtACAAB2sAIAAIb+AgADz/gCAAEj3gIAAAl0AgAECezA=
Date: Wed, 28 Jun 2023 03:09:06 +0000
Message-ID: <79ac5615a818493488f806d51d63b7ef@huawei.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
 <20230626112729.06dc48d8.alex.williamson@redhat.com>
 <976b7037-ee62-f86d-5772-6a2deca0816d@nvidia.com>
 <0a6e8496-f3c8-567a-c886-b8ea604c799a@redhat.com>
 <ZJrWXkM3FmEPtLMC@nvidia.com>
In-Reply-To: <ZJrWXkM3FmEPtLMC@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.175.9]
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IFttYWlsdG86amdnQG52aWRpYS5jb21dDQo+IFNlbnQ6IDI3IEp1bmUgMjAyMyAxMzozMA0KPiBU
bzogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBDYzogQXZpaGFpIEhvcm9u
IDxhdmloYWloQG52aWRpYS5jb20+OyBBbGV4IFdpbGxpYW1zb24NCj4gPGFsZXgud2lsbGlhbXNv
bkByZWRoYXQuY29tPjsgSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPjsN
Cj4gSnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT47IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT47DQo+IExlb25hcmRvIEJyYXMgPGxlb2JyYXNAcmVkaGF0LmNvbT47IFpoZW56
aG9uZyBEdWFuDQo+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBZaXNoYWkgSGFkYXMgPHlp
c2hhaWhAbnZpZGlhLmNvbT47IE1hb3INCj4gR290dGxpZWIgPG1hb3JnQG52aWRpYS5jb20+OyBL
aXJ0aSBXYW5raGVkZSA8a3dhbmtoZWRlQG52aWRpYS5jb20+Ow0KPiBUYXJ1biBHdXB0YSA8dGFy
Z3VwdGFAbnZpZGlhLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgU2hhbWVlcmFsaQ0KPiBL
b2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDMvM10gdmZpby9taWdyYXRpb246IE1ha2UgVkZJTyBtaWdyYXRp
b24NCj4gbm9uLWV4cGVyaW1lbnRhbA0KPiANCj4gT24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgMDI6
MjE6NTVQTSArMDIwMCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+IA0KPiA+IFdlIGhhdmUg
YSB3YXkgdG8gcnVuIGFuZCBtaWdyYXRlIGEgbWFjaGluZSB3aXRoIGEgZGV2aWNlIG5vdCBzdXBw
b3J0aW5nDQo+ID4gZGlydHkgdHJhY2tpbmcuIE9ubHkgSGlzaWxpY29uIGlzIGluIHRoYXQgY2Fz
ZSB0b2RheS4gTWF5IGJlIHRoZXJlIGFyZQ0KPiA+IHBsYW5zIHRvIGFkZCBkaXJ0eSB0cmFja2lu
ZyBzdXBwb3J0ID8NCj4gDQo+IEhpc2lsaWNvbiB3aWxsIGV2ZW50dWFsbHkgdXNlIEpvYW8ncyB3
b3JrIGZvciBJT01NVSBiYXNlZCB0cmFja2luZywNCj4gdGhpcyBpcyB3aGF0IHRoZWlyIEhXIHdh
cyBkZXNpZ25lZCB0byBkby4NCg0KWWVzLiBUaGUgcGxhbiBpcyB0byBtYWtlIHVzZSBvZiBTTU1V
djMgSFRUVSBmZWF0dXJlIGZvciBkaXJ0eSB0cmFja2luZyBiYXNlZA0Kb24gSm9hbydzIHdvcmsg
aGVyZSwNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8yMDIzMDUxODIwNDY1MC4xNDU0MS0x
LWpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20vDQoNClRoYW5rcywNClNoYW1lZXINCg0K

