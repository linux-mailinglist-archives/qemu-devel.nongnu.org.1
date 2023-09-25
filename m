Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E37ACFE0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkeoK-0004Wd-6F; Mon, 25 Sep 2023 02:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkeoF-0004WO-5P
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:11:07 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkeoB-0002FP-VH
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 02:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695622263; x=1727158263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CN/Mqj/YUcNBFLbaTbHx+vB/iwIZ7wFlkJ08VnHXArA=;
 b=EWoTrYERHNGIkN1PjKh8bNP+7UNi3df57IzPj0YSEJ1mNegm/TAnv9hI
 TQcXOboyv9OWeN5iKeaird5tzKwwOrtkESOLN9AYpPvjc7/ESAqjGJiht
 HsH690xepvBpkZpqqZGgkyGZDkusN27iJigPsa1NQLoF9E3W5R2kgayQU
 zDZP0JqlGbTO621kfjneqIJuTeCxzohzJdYAgYSnJ3OLJJ+UyyYCqqt9A
 LMcT57oGwvD/fJvJzlJEGbFc5zEwbUxg9FHU2YguzzvSGAtZMN6CrNpx3
 l9V/lxVb4ajRsvUPTMs8LvW+jif9zvhqc9QK8tjugNeFJx4lorf0ZfZiL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447660987"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="447660987"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2023 23:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838473975"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; d="scan'208";a="838473975"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2023 23:11:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:11:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:11:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:10:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu0m8fvYV/8U+jkhiTlK2daG77S33iPb7sg/01KNhJJIDJ7l3SB+iAYvhcSHjmxZXrjsLGZeKB54wN+tjPL3oeiPw1bKGJks2tSiyeyrXScjKbPvTb8ExF6NTn6OcV+FmYs3Q9usVKNSdmvFBa0ibZ2l2X+TmIbTsmik475HRWz7ohz7R5yWvf8YhQ4XWboYAN36jnFTLDRgTLR6aal8dq5dJ8DrZKotHlAI6awTZJ3olcc9RQVsEXfcSeTu8EtGiC+89H5kBAmPkj6OCMJhhRLg5It34nsdtWg5U307FefiIqcc8u1e6sEgJdMmzLrghKAeZChBK7UWWU8NKD3caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN/Mqj/YUcNBFLbaTbHx+vB/iwIZ7wFlkJ08VnHXArA=;
 b=DuGV4GHzZ/ABuj9gSKIiNuafPZ+uVzcpJ17hGGGA4wla+94zjc4jQPLeXXsYFSbjx+O3DHDFx4T7JN2qs+4dL1mzxjkdAmh7jp0EnbCpfvuv8E3yeRi+k0lEsb8WiaO6lYFI7oxzbjSRxBMSHM1LpE1nqq25D7trCvkwDusGkkaadfM6BqnbgHarek5wx/uFuByY4fByb2y+N+2xd/ykPHyKFri0ohVBQ4ztWIVnzuJDkfqzXWnZk3V/HAofV/qkeDYc8qy3bfDPNTqCcGetVpBNDtyCfMsi4gtk/PNPRQmpc8A/fIkjTL8uwr23ajD88WfHYvloPqJM4cUo85xQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Mon, 25 Sep 2023 06:10:52 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d%4]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 06:10:52 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
Subject: RE: [PATCH v2 0/4] Support dynamic MSI-X allocation
Thread-Topic: [PATCH v2 0/4] Support dynamic MSI-X allocation
Thread-Index: AQHZ6hTZuVItv3TqgEOPSDFb1gVcdrAnWl2AgAO+joA=
Date: Mon, 25 Sep 2023 06:10:52 +0000
Message-ID: <DS0PR11MB81148755C18973C9CF85BF08A9FCA@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
 <20230922145631.2bdc67dd.alex.williamson@redhat.com>
In-Reply-To: <20230922145631.2bdc67dd.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|PH7PR11MB5765:EE_
x-ms-office365-filtering-correlation-id: ee616be9-5cd0-46a7-6b00-08dbbd8e2c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kgpT/3I1iPRv2k2K0xDLM0tEYZOu+wOt91gFgH+kj9v2YevxQN6VmSBISfqq3bHkovRQJY2Ql1mSExh7ThtKrWAjoVCmI6+STQpF/kvhHo2ovLEDEnxX4oAca7YCUr8w3kRZV6PQ+PAeKlTMhnev09NeqcQb71YK/DHd2shktYTo/LOTpRo7KZfc8lR/b8cU2QhO5KSDMTVmWwQlUSFbq7oaPWSs6F7mfMGsVhAnxI5WpEdgbDovfgWkhqEUpIoHaUbp/8eHvqWqyt44LNA4HHsXflMgBCobLTjxDh4B8QZhdkclwhzKIp7VP/Bm6Ak8lFt4bxWzXjURPwgVNndZsx3Upwe9H0/FB7to2VU5T2kQnXOp56nc7PGd2rkzzkPpaR61EsEc/0cdqh5uaCw6S+yW5POlI1twuSzCI/1hIqfmYLtQVu5Y6nFltBQZJFKNQZk+z/WzcT3sFbpnIXfUcmPeua/QwEhg7nX9BCnFNpLUFHx5OhQG6KYTwlz5eSVOn8hirVtei8T6YUFQfVUlKG7oOH4JEprnTXbdBMRIJjrjGs0JPAX66G6ZZ88oQmS2pxYXw1NVVHaVV7BQxygshcoJ9kVbnyeCaxbMZlC1bG7sng+Ci/EwbzBEH0HkkcFfZX/C0PFqa5nSwnA580SkLCMDnafpvhbICKRdSzrZp2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(55016003)(86362001)(82960400001)(8676002)(122000001)(54906003)(6916009)(316002)(64756008)(66446008)(38070700005)(66556008)(76116006)(966005)(6506007)(2906002)(66476007)(478600001)(66946007)(83380400001)(66574015)(38100700002)(52536014)(8936002)(26005)(41300700001)(71200400001)(9686003)(7696005)(5660300002)(33656002)(4326008)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFdTbkswbWtCbWZyN3NQSXgyMHE4UDNtV2IzMlZFYzNYcFV1cmRrR2V5dTds?=
 =?utf-8?B?NzFmM2FJQ2hQZEU1dWV2NHJiSG8ySUkxUElva2dRQ3FRdG5jdk9TaTd3bGM3?=
 =?utf-8?B?ZjcwZGZ1Z0hURG9wQ2JORmFlejdXa1o0SmJyN2k4YzVReXhjb0ZhSWl2eWdr?=
 =?utf-8?B?U2llcWwxeTdrQzJCT2xwVjk0dXNoeTA2NUp1VDZWNGV5dHp3cng3ckZleFNv?=
 =?utf-8?B?SytWSU9HajlQbHVoRWVLb2t2RVNOVHJhVW9Qa255T1lYSGQwS1N3djljWVIz?=
 =?utf-8?B?NXk5KzcvYzJSY05nZ1h2N1pocjkrbWdWa0JtaGtsOTduRit0djlCZmRPVDA5?=
 =?utf-8?B?bVRTeFpYWWtQejcxdHpndU0yTGRNSitrU3NJcGtzdWt3ZmM0NW9UQ0poNWp0?=
 =?utf-8?B?T1BvOXplQ0VvUHJTOXhyM1lBN2w4a1FtNWFDZGZ4UERqcXhzVHovcUdBWG9v?=
 =?utf-8?B?MnE1NDFNUFg5M09XaW01WlV2SnNuUG5tUDRaelBPRnhzMytpbFJnTWJDWGg3?=
 =?utf-8?B?MDgzMHlSa3FyVk0vT0I3bmttV3VTakRSNnhFbkxES2p0SlVpMEk5SE9UU0Z3?=
 =?utf-8?B?YUFVRCt1dW1raUdjaXVSRUtLREtCUXdnNTNvRHZkOXZKTFBFdmFITnppb3JK?=
 =?utf-8?B?aW9pa3p1SzR4a052ejNUelV5N1lqdDl5dEF2c3Fjc1I3S0NQaFlCNU02dWZT?=
 =?utf-8?B?L3VKSWtuOWYzaUJIaE81dGptNFd0Y1JFbzJVenBwNHRaUW42UWozSGZZWnov?=
 =?utf-8?B?ZXloaXBCY3RKMWhyOXoxWnRRZDlBZUxBaFRQbEIvYm44bjRyOEFFcDVuKzBl?=
 =?utf-8?B?UzBLekdhN2hsRm02M2Y3NkFMMHFSQUl6OVF2K0gwL29sY0Iwb2FKNExiUVJE?=
 =?utf-8?B?amc4Tm5jRUZsQWR6V3pNMGNTYnpsNnh6U3R4L3hWTFBxMks5SnhHN2ZPZUl1?=
 =?utf-8?B?Q2k1OUJCTFhUUWVZVFJTekRGSjRvZlh3OTFsc0Zpenhjd3B6dGpJL0JEWENK?=
 =?utf-8?B?M2tETHZwRUxrVHljVTRwUHZGcG9OQVhBVkxHUzh5NTBEM0Zlb2ViN2Z5UDZV?=
 =?utf-8?B?c1l0N2VYTEs4MkVENUdKeFIyUFFZcUxFa3JEMVpqSTRHS2VGM3hsS25ibm52?=
 =?utf-8?B?YXNsbnJWNzUzVHFpTG8xQWQ2ZEY5VHdraGwwQ3dOeTczUkdGZTlvWUMvbGlE?=
 =?utf-8?B?M2ZkNUZ3YnRtZjlYMmM3ZXJzcDB0Y2tHZkZLeTJoN2svMWphZGZRZnplZ3dt?=
 =?utf-8?B?ZHZXR0Q3RWFHVm9reDJJZEhhbGNTd0c4b2xHTEU2MS94NnVOY3pWSzhpaGti?=
 =?utf-8?B?SC9nYldQaWRaQ1lxK0xiSmhleGZGMEs0bnhLZDRpWC9nUlROMVNpd21zMFRY?=
 =?utf-8?B?a29kNVpmVTJhZTJjRmdXVFFVM3BqaS8raHNBV05hc1crdWVXeTlEall2cGZn?=
 =?utf-8?B?NmhuekVGbmVMOUxZb3NQMTZmVUVqeC9ZMStlSkVnRHdvZ2plQ3pROU5KY1dI?=
 =?utf-8?B?MWlFWUZQTkphdmNCTGNWZHp5Z2JTRmNYQk80c0VaTEJzMm1QOUoxOFpOMDQy?=
 =?utf-8?B?dzNFeC9ta3lZOVNDcG1nSTFaNmhzTWJ0WDAxdVRsdEdiZzdaMVNVL3l0TVE3?=
 =?utf-8?B?cmVHK2MxVTl5S0dtN3hqVFQ4NjhzUng2Kzd2TnVLNFFvUnkvb3ZpVE1Jb1Jj?=
 =?utf-8?B?R0w0blhrK0tUenJxR3ArMm5USzJpOVZnMEc3TTlsYmQrWnAwdlZWWG9KL2du?=
 =?utf-8?B?d0tQRGV3MGI4NmZWVXkrcndOcTJCV1lHUVFFQi94UWhkaldydXV4cUhnb2tk?=
 =?utf-8?B?T0xDbGtQVE5NcjNqVTBld3EzSy9DQlpGQjJWaWNtM3JBeXFuK3pIK2l2OGMy?=
 =?utf-8?B?aTdYNnE1aTI3dlA2bU96ZzJUR20vb2FvMjU0UkVjQ1ZJZ1JiY2l0eU1tMEVt?=
 =?utf-8?B?SlpFTlBQcEF2TmlKZFF3bnZUU0VQcUpwY281N3RHTG4xWHpzbnNMT2orWnBl?=
 =?utf-8?B?M2NsMVIyYjhDNi9TUTRGNFhJSjNaWkVCNHBzbkc3c1lOa08rMzF4ekczcTc2?=
 =?utf-8?B?c3BaVDJHRjhYakJRQkVjM3MzQitwSko2SEJIdWJYb0gxR1dGMDJsNnpucGxr?=
 =?utf-8?Q?afrn24fsTnjRGBpZX0IdQtkMV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee616be9-5cd0-46a7-6b00-08dbbd8e2c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:10:52.4999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NH9EQYjgGJDRAdFbTmXAKDhPorXfl7Y8mmVShVA9UP7XUSllY5kp/te79T14blbM9mI8hd4KIPZS/lR2zHEoZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQWxleCwNCg0KPiBPbiBTYXQsIDkvMjMvMjAyMyA0OjU3QU0sIEFsZXggV2lsbGlhbXNvbiA8
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAxOCBTZXAg
MjAyMyAwNTo0NTowMyAtMDQwMA0KPiBKaW5nIExpdSA8amluZzIubGl1QGludGVsLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+ID4gLSB2MToNCj4gPiBodHRwczovL3d3
dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9tc2c5ODI4NDIuaHRtbA0K
PiA+IC0gUmV2aXNlIFFlbXUgdG8gUUVNVS4gKEPDqWRyaWMpDQo+ID4gLSBBZGQgZ19mcmVlIHdo
ZW4gZmFpbHVyZSBvZiBnZXR0aW5nIE1TSS1YIGlycSBpbmZvLiAoQ8OpZHJpYykNCj4gPiAtIEFw
cGx5IEPDqWRyaWMncyBSZXZpZXdlZC1ieS4gKEPDqWRyaWMpDQo+ID4gLSBVc2UgZ19hdXRvZnJl
ZSB0byBhdXRvbWF0aWNhbGx5IHJlbGVhc2UuIChDw6lkcmljKQ0KPiA+IC0gUmVtb3ZlIHRoZSBm
YWlsdXJlIG1lc3NhZ2UgaW4gdmZpb19lbmFibGVfbXNpeF9ub192ZWMoKS4gKEPDqWRyaWMpDQo+
ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIFJGQyB2MToNCj4gPiAtIFJGQyB2MToNCj4gPiBodHRwczov
L3d3dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251Lm9yZy9tc2c5Nzg2MzcuaHRt
bA0KPiA+IC0gUmV2aXNlIHRoZSBjb21tZW50cy4gKEFsZXgpDQo+ID4gLSBSZXBvcnQgZXJyb3Ig
b2YgZ2V0dGluZyBpcnEgaW5mbyBhbmQgcmVtb3ZlIHRoZSB0cmFjZSBvZiBmYWlsdXJlDQo+ID4g
ICBjYXNlLiAoQWxleCwgQ8OpZHJpYykNCj4gPiAtIE9ubHkgc3RvcmUgZHluYW1pYyBhbGxvY2F0
aW9uIGZsYWcgYXMgYSBib29sIHR5cGUgYW5kIHRlc3QNCj4gPiAgIGFjY29yZGluZ2x5LiAoQWxl
eCkNCj4gPiAtIE1vdmUgZHluYW1pYyBhbGxvY2F0aW9uIGRldGVjdGlvbiB0byB2ZmlvX21zaXhf
ZWFybHlfc2V0dXAoKS4gKEFsZXgpDQo+ID4gLSBDaGFuZ2UgdGhlIGNvbmRpdGlvbiBsb2dpYyBp
biB2ZmlvX21zaXhfdmVjdG9yX2RvX3VzZSgpIHRoYXQgbW92aW5nDQo+ID4gICB0aGUgZGVmZXJf
a3ZtX2lycV9yb3V0aW5nIHRlc3Qgb3V0IGFuZCBjcmVhdGUgYSBjb21tb24gcGxhY2UgdG8gdXBk
YXRlDQo+ID4gICBucl92ZWN0b3JzLiAoQWxleCkNCj4gPiAtIENvbnNvbGlkYXRlIHRoZSB3YXkg
b2YgTVNJLVggZW5hYmxpbmcgZHVyaW5nIGRldmljZSBpbml0aWFsaXphdGlvbiBhbmQNCj4gPiAg
IGludGVycnVwdCByZXN0b3JpbmcgdGhhdCB1c2VzIGZkID0gLTEgdHJpY2suIENyZWF0ZSBhIGZ1
bmN0aW9uIGRvaW5nDQo+ID4gICB0aGF0LiAoQWxleCkNCj4gPg0KPiA+IEJlZm9yZSBrZXJuZWwg
djYuNSwgZHluYW1pYyBhbGxvY2F0aW9uIG9mIE1TSS1YIGludGVycnVwdHMgd2FzIG5vdA0KPiA+
IHN1cHBvcnRlZC4gUUVNVSB0aGVyZWZvcmUgd2hlbiBhbGxvY2F0aW5nIGEgbmV3IGludGVycnVw
dCwgc2hvdWxkDQo+ID4gZmlyc3QgcmVsZWFzZSBhbGwgcHJldmlvdXNseSBhbGxvY2F0ZWQgaW50
ZXJydXB0cyAoaW5jbHVkaW5nIGRpc2FibGUNCj4gPiBvZiBNU0ktWCkgYW5kIHJlLWFsbG9jYXRl
IGFsbCBpbnRlcnJ1cHRzIHRoYXQgaW5jbHVkZXMgdGhlIG5ldyBvbmUuDQo+ID4NCj4gPiBUaGUg
a2VybmVsIHNlcmllcyBbMV0gYWRkcyB0aGUgc3VwcG9ydCBvZiBkeW5hbWljIE1TSS1YIGFsbG9j
YXRpb24gdG8NCj4gPiB2ZmlvLXBjaSBhbmQgdXNlcyB0aGUgZXhpc3RpbmcgZmxhZyBWRklPX0lS
UV9JTkZPX05PUkVTSVpFIHRvIGd1aWRlDQo+ID4gdXNlciBzcGFjZSwgdGhhdCB3aGVuIGR5bmFt
aWMgTVNJLVggaXMgc3VwcG9ydGVkIHRoZSBmbGFnIGlzIGNsZWFyZWQuDQo+ID4NCj4gPiBUaGlz
IHNlcmllcyBtYWtlcyB0aGUgYmVoYXZpb3IgZm9yIFZGSU8gUENJIGRldmljZXMgd2hlbiBkeW5h
bWljIE1TSS1YDQo+ID4gYWxsb2NhdGlvbiBpcyBzdXBwb3J0ZWQuIFdoZW4gZ3Vlc3QgdW5tYXNr
cyBhbiBpbnRlcnJ1cHQsIFFFTVUgY2FuDQo+ID4gZGlyZWN0bHkgYWxsb2NhdGUgYW4gaW50ZXJy
dXB0IG9uIGhvc3QgZm9yIHRoaXMgYW5kIGhhcyBub3RoaW5nIHRvIGRvDQo+ID4gd2l0aCB0aGUg
cHJldmlvdXNseSBhbGxvY2F0ZWQgb25lcy4gVGhlcmVmb3JlLCBob3N0IG9ubHkgYWxsb2NhdGVz
DQo+ID4gaW50ZXJydXB0cyBmb3IgdGhvc2UgdW5tYXNrZWQgKGVuYWJsZWQpIGludGVycnVwdHMg
aW5zaWRlIGd1ZXN0IHdoZW4NCj4gPiBkeW5hbWljIE1TSS1YIGFsbG9jYXRpb24gaXMgc3VwcG9y
dGVkIGJ5IGRldmljZS4NCj4gPg0KPiA+IFdoZW4gZ3Vlc3RzIGVuYWJsZSBNU0ktWCB3aXRoIGFs
bCBvZiB0aGUgdmVjdG9ycyBtYXNrZWQsIFFFTVUgbmVlZA0KPiA+IG1hdGNoIHRoZSBzdGF0ZSB0
byBlbmFibGUgTVNJLVggd2l0aCBubyB2ZWN0b3IgZW5hYmxlZC4gRHVyaW5nDQo+ID4gbWlncmF0
aW9uIHJlc3RvcmUsIFFFTVUgYWxzbyBuZWVkIGVuYWJsZSBNU0ktWCBmaXJzdCBpbiBkeW5hbWlj
DQo+ID4gYWxsb2NhdGlvbiBtb2RlLCB0byBhdm9pZCB0aGUgZ3Vlc3QgdW51c2VkIHZlY3RvcnMg
YmVpbmcgYWxsb2NhdGVkIG9uDQo+ID4gaG9zdC4gVG8gY29uc29saWRhdGUgdGhlbSwgd2UgdXNl
IHZlY3RvciAwIHdpdGggYW4gaW52YWxpZCBmZCB0byBnZXQNCj4gPiBNU0ktWCBlbmFibGVkIGFu
ZCBjcmVhdGUgYSBjb21tb24gZnVuY3Rpb24gZm9yIHRoaXMuIFRoaXMgaXMgY2xlYW5lcg0KPiA+
IHRoYW4gc2V0dGluZyB1c2Vyc3BhY2UgdHJpZ2dlcmluZyBhbmQgaW1tZWRpYXRlbHkgcmVsZWFz
ZS4NCj4gPg0KPiA+IEFueSBmZWVkYmFjayBpcyBhcHByZWNpYXRlZC4NCj4gPg0KPiA+IEppbmcN
Cj4gPg0KPiA+IFsxXSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvOTMxNjc5Lw0KPiA+DQo+ID4g
SmluZyBMaXUgKDQpOg0KPiA+ICAgdmZpby9wY2k6IGRldGVjdCB0aGUgc3VwcG9ydCBvZiBkeW5h
bWljIE1TSS1YIGFsbG9jYXRpb24NCj4gPiAgIHZmaW8vcGNpOiBlbmFibGUgdmVjdG9yIG9uIGR5
bmFtaWMgTVNJLVggYWxsb2NhdGlvbg0KPiA+ICAgdmZpby9wY2k6IHVzZSBhbiBpbnZhbGlkIGZk
IHRvIGVuYWJsZSBNU0ktWA0KPiA+ICAgdmZpby9wY2k6IGVuYWJsZSBNU0ktWCBpbiBpbnRlcnJ1
cHQgcmVzdG9yaW5nIG9uIGR5bmFtaWMgYWxsb2NhdGlvbg0KPiA+DQo+ID4gIGh3L3ZmaW8vcGNp
LmMgICAgICAgIHwgMTIxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0NCj4gPiAgaHcvdmZpby9wY2kuaCAgICAgICAgfCAgIDEgKw0KPiA+ICBody92ZmlvL3RyYWNl
LWV2ZW50cyB8ICAgMiArLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKyks
IDI4IGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBTb21lIG1pbm9yIGNvbW1lbnRzIG9uIDIvIGJ1
dCBvdGhlcndpc2U6DQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4Lndp
bGxpYW1zb25AcmVkaGF0LmNvbT4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIGZlZWRi
YWNrLiBXaWxsIGFwcGx5IG9uIHYzIHdpdGggZml4IGZvciAyLzQuIA0KDQpKaW5nDQoNCg==

