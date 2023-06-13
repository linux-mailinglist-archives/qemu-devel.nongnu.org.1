Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25A72E2DE
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 14:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q936Y-0007Lz-E2; Tue, 13 Jun 2023 08:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.laight@aculab.com>)
 id 1q936W-0007Lq-Go
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:26:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.laight@aculab.com>)
 id 1q936U-0004g2-Nc
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:26:32 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-Ufe39FLKM9uv02YWJ1c2EA-1; Tue, 13 Jun 2023 13:25:11 +0100
X-MC-Unique: Ufe39FLKM9uv02YWJ1c2EA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 13 Jun
 2023 13:25:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 13 Jun 2023 13:25:03 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Kasireddy, Vivek'" <vivek.kasireddy@intel.com>, David Hildenbrand
 <david@redhat.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Hugh Dickins <hughd@google.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, "Kim, Dongwon" <dongwon.kim@intel.com>, 
 "Chang, Junxiao" <junxiao.chang@intel.com>,
 "kirill.shutemov@linux.intel.com"
 <kirill.shutemov@linux.intel.com>, "Hocko, Michal" <mhocko@suse.com>,
 "jmarchan@redhat.com" <jmarchan@redhat.com>, "muchun.song@linux.dev"
 <muchun.song@linux.dev>, James Houghton <jthoughton@google.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: RE: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
Thread-Topic: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
Thread-Index: AQHZmkrTMFwnMH2R1EGnnRur83Hw9a+FyCfggAEHOQCAAT7FoIAAoNDA
Date: Tue, 13 Jun 2023 12:25:03 +0000
Message-ID: <89652021ecea4aa2ada763c97deeb543@AcuMS.aculab.com>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
 <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
 <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=185.58.86.151;
 envelope-from=david.laight@aculab.com; helo=eu-smtp-delivery-151.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

RnJvbTogS2FzaXJlZGR5LCBWaXZlayA8dml2ZWsua2FzaXJlZGR5QGludGVsLmNvbT4NCj4gU2Vu
dDogMTMgSnVuZSAyMDIzIDA5OjI2DQouLi4NCj4gPiBJcyBteSB1bmRlcnN0YW5kaW5nIGNvcnJl
Y3QsIHRoYXQgd2UgY2FuIGVmZmVjdGl2ZWx5IGxvbmctdGVybSBwaW4NCj4gPiAod29yc2UgdGhh
biBtbG9jaykgNjQgTWlCIHBlciBVRE1BQlVGX0NSRUFURSwgYWxsb3dpbmcgZXZlbnR1YWxseSAh
cm9vdA0KPiA+IHVzZXJzDQo+DQo+IFRoZSA2NCBNaUIgbGltaXQgaXMgdGhlIHRoZW9yZXRpY2Fs
IHVwcGVyIGJvdW5kIHRoYXQgd2UgaGF2ZSBub3Qgc2VlbiBoaXQgaW4NCj4gcHJhY3RpY2UuIFR5
cGljYWxseSwgZm9yIGEgMTkyMHgxMDgwIHJlc29sdXRpb24gKGNvbW1vbmx5IHVzZWQgaW4gR3Vl
c3RzKSwNCj4gdGhlIHNpemUgb2YgdGhlIEZCIGlzIH44IE1CICgxOTIweDEwODB4NCkuIEFuZCwg
bW9zdCBtb2Rlcm4gR3JhcGhpY3MNCj4gY29tcG9zaXRvcnMgZmxpcCBiZXR3ZWVuIHR3byBGQnMu
DQoNCldoYXQgY29kZSBkb2VzIGFuZCB3aGF0IHBvdGVudGlhbGx5IG1hbGljaW91cyBjb2RlIG1p
Z2h0IGRvDQphcmUgZW50aXJlbHkgZGlmZmVyZW50IHRoaW5ncy4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


