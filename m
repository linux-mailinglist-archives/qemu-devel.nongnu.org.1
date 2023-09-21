Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A18917A9464
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 14:47:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJ1b-0008HW-NH; Thu, 21 Sep 2023 08:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjJ00-00069b-Vk
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:41:44 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjIzY-0001ln-Gj
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695300072; x=1726836072;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wgY/lmtvxYK6esPhlDZwQQ3bZ+Cxely6/zmx66xLAw0=;
 b=iKYK0spTdhqas8ADkJ0UjkxBVuNNEsCCUkoWhdPCQrRVW+taNeCQN4J2
 VmnLoa6uehH5clwA3I5Awrvt71aecWPa7xPmxB4unxFwaezChpGh0B41T
 AzHsMmZTZuEabCPpINaZudxhsh9nhlXxw5jBiV9gQJHQF1amA6LGy87jv
 i1SBEmVtPSTDzdESfHw9pPk3jHM9NXBDTe7taLJwFNcctC6A4ETcCYauu
 IgdoYNPXtudeQm81+HOd2ekkPpAete1NJZGJ+P4KcipSNf/P9eCFHdXP/
 RzbCZxdHKc99OB1E4JBH5eZy7ywlhtMz4bC6zDotXye7gU5wdvtYFE25I A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="379366323"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; d="scan'208";a="379366323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 03:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696682733"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; d="scan'208";a="696682733"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Sep 2023 03:22:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 03:22:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 03:22:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 03:22:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 03:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VupTTZRw2uMZdSaDwdHKE1fno25uRUlZhUKiyfHpKCKfQfm7287cgpJtW9DwA8zO/Ckg1lUpdghpSMIn70cCJ+WZONR3/njWX6FJdzZmh1YQrPIUexMYr+OizJi5lTWo40YjVPQ7T2UNsol3N5pFhD1WH4HZSoHhsZHIPbc8jtCED+fn1IxW0ACnOQAuD17WleUtAysoEmHP2wiY8YqCesu6w1GmlTxDBifGzlUPVdz4PE5vhsFbRVODRJwFmq17K68z3rIVtEthKAMNQq+LhmBCJPSD7Zk6QYKBRxYy0ADaeOWHSpc6IHzCYUXKeC4m5qI1crJhia1pBpNicNn1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgY/lmtvxYK6esPhlDZwQQ3bZ+Cxely6/zmx66xLAw0=;
 b=dAvAc3WauX7T9Vhs1173uCfs7vnmhrQBseSp5ZSJ+r4w3sDcnIGJmc/YiYfLJyoEgwBiGV3uCY7OUBUn8h3ZCRorIuf3cn9aSmfSxxN9VZTr/7OPEAFKJaGGBIn5nbjZeoYcQnp7pghTYDJD/rAIXC8gBhNm3YV5KNMVrT4UT8ixKYQ4P86yOn1sVqFYg7WI+AMtPAx3S+PLaqNcUangC9qAEE93+1z5HxtcXhhnqs3u6lrgAMMSXn42PwB00NeK7/cyS/20H0mwCeSzzhn0ZacEOhlqbkVJFVg+/TDb1E44FUM77obVNB4wThB6E/9H/Vm9Mnzp7tXi4xZLk1xXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH0PR11MB8235.namprd11.prod.outlook.com (2603:10b6:610:187::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 10:22:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 10:22:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Thread-Topic: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Thread-Index: AQHZ2zAjqlgYZoGXuEGtL1+wwj7B+LAjupQAgAFeHYCAABp78A==
Date: Thu, 21 Sep 2023 10:22:38 +0000
Message-ID: <SJ0PR11MB674493761CD31BBE53753DC192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-6-zhenzhong.duan@intel.com>
 <127c3104-44e0-f19f-6339-43182fbf6db1@redhat.com>
 <95befe1b-efb4-82f9-3cf8-fe703378617f@redhat.com>
In-Reply-To: <95befe1b-efb4-82f9-3cf8-fe703378617f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH0PR11MB8235:EE_
x-ms-office365-filtering-correlation-id: ac81befc-9712-4355-14ef-08dbba8cae13
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gTTlwX9DOv9oqa7J5pLmwRCzwaNz5IlfpSPoUWkSXv7os/vVpT5BWlwtzHKN7ktaI+h49qvNa0K2ZFho6ggEq4K4f9aiIrKN1YqA5kbkvbPXYWqn5MV2lmqUE6q/+BlpMsNFvIoUV7Ubcif15bdLkgZMtCx7ZLDluMP9UChWcYIb7AWvzcNqFxUIr855IRloS+H2rU+O3MWuMjhZ5ZaSFPFRjLA8EtGkLypNfLteBtWwmSthHlUgR8GlToyG7ChxhyG+mn7hXaPqs0/hljpFUeivVRnEldurRgQv1x37js3eG/VvxIHE19Ntt+T/J5NBlImFh8hAWrq4XIM5Bo0fMmuTZeYwMFQbMEtfCJhjAJwyaQVSYWk6fkvf1P2cvkWRlra8qH/8e6cgrdcZsU3VzV1dEGxQlNI+y3EkBItqN4EYCqBeF60AcYjZjxbAYHamCyhK0++pwr+mNClqCWrpvUNCzXtVCoAIaX+XcUR3VXBV0WUDNXKrQ5OIa6LEz69zSt53rE1HgW/kuUtlxeWOXzRqFXR4irFLejl2uLp4en2yN3sqqW0lA9aXP70guVlCSrQbTuOUILiBVMQwGho8JsYkeQFypmCN2iG9EwY+vJF8Mfzb1nXVQAh39ErbdKOI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(186009)(451199024)(1800799009)(86362001)(9686003)(53546011)(7696005)(6506007)(107886003)(55016003)(82960400001)(2906002)(38100700002)(38070700005)(316002)(54906003)(122000001)(64756008)(66556008)(66446008)(66476007)(66946007)(478600001)(71200400001)(66574015)(83380400001)(110136005)(33656002)(26005)(76116006)(52536014)(8676002)(4326008)(5660300002)(8936002)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVNKQUp6TmNMUmlYWlRMZmpDcHlCdTBydjEwditPdlUwUXNxWnhpemp1SWln?=
 =?utf-8?B?VmtmSWdnNjVhNDhLQ25GREQ3SDgxVWR6cDRSNVJPWW1lTXk5NFVhVVRjNkZn?=
 =?utf-8?B?NnNUUlZVTVF0NExWdU0wdDRsQndiSUZWY2NYTjc2QzdiKzJHWjllYkkzMm9M?=
 =?utf-8?B?eUtNSFZ6RzBJOWUrSUUwQjgzV1NVNzdaWG4yZ20xMWd6dUZhYXgycHh6UThS?=
 =?utf-8?B?WDRYV0lVZWkwQzJycGI1WDhnVDd1UFBTTHJlMXFQLzQ3Y3B4V0JIUGFWL3Rw?=
 =?utf-8?B?Tk9CdHlvMjVMZnV2SjBNOFBHOC85dU45OHROVHlhOEtyZVB6THNaTFl3bkl1?=
 =?utf-8?B?YnNkM0s3akJtT1FCTXhhb2xKU2NBOFNOd0RzTWpvZlU4QzlJeEllNEw0V2ll?=
 =?utf-8?B?aU03cjhNRHBzNklKZEMySVBTSnZXZWl1c2o2MGpSeDc5TmhuZlZXUzlSNGJW?=
 =?utf-8?B?OFlLYjBBSENLcmxrMVlBMXVvYlVBVllEeXdjeDNHZUl2YUNFTUk0Q2M5VTZQ?=
 =?utf-8?B?Z3l5U2xkelhRRWZlOTZ1bmsvYWF1WHJZVjFra205c1ZVMlRXY2F3d0FSeEJD?=
 =?utf-8?B?N0paLzRsTE1rUTZBeWk2bGZ0VXI4ckZwZ0RqZHIvamFOVEdXMjZDSW1udmFv?=
 =?utf-8?B?bytDOTdpWTZaL21wTTg1b25wR3lZbGxYd0VsZjZ1cmFjTXRqMUdDY1pseUtm?=
 =?utf-8?B?Yys2UzNKVkJGMGp4SEgra0NDM1FWY08yMTdxcGpLcU1nZHFCWjhCVjR6OEpE?=
 =?utf-8?B?Q24zSUNJdFFKSytsTVRsSVNXR0gxVzdSNWEvalQrL1A2NExldVg3dUJib3lX?=
 =?utf-8?B?QlM3MjB1S2ZxY2FTRkpuaWI5Q29idDNwU21TQXQ5ZE5RTmVJMytGa0txZkds?=
 =?utf-8?B?YlpiYmJlUFZtVTV3OGdNUmtkWjFSZkZQRnhCa0xsY0ZKb1pwQjg5eFlGZGtU?=
 =?utf-8?B?MzVzcUNYQ1U3R3ZiWUZudnYySFMzeTgrMTk4VXd4a2V1OE9yTmUxOVg3UjBm?=
 =?utf-8?B?WHlTb3FjSTFHbHNQdlVkV3ZxcDV2UWhPNURUaVNIQ25mNG9VVDRUUkNpaStt?=
 =?utf-8?B?UTlZY2g0bVc0dmJTUHRxZE9vSGsrMGpGbEpIUjhxcHNISHJEVnNlQXZqcGpH?=
 =?utf-8?B?bDJBY1JNR1MxTkd3bS9SVFZXS2lUWVpBMmRVNEIvQmFmYTF6eGJ4UmJjYUdJ?=
 =?utf-8?B?RnozNWVnakdQWHdmNjVUbVlmWW9NSitVazhUSFhuYmE0YkxYRHl3TUEzT0I1?=
 =?utf-8?B?V3YzeUl5NmhCaEVybnFjMEZvR0hpUUxYYVZmeFRBVzE4TzIxTGJWY25jeGI4?=
 =?utf-8?B?Q05yQ0pZd1pTRmxETTN5eWswMGYwRklaclhFNC9IQTRpL2xFSHJ6NmZwQ2lJ?=
 =?utf-8?B?M1Y1OWlHdm9QVHJjNzdrRysycm1NOWV6Y1l2cEoweWZ0bmRGckl4Y1lENXFz?=
 =?utf-8?B?SE5uMzB1SHU3N0pVVElBSEV2VFpJZ2syRFdTWm1jaW90UTVaRkxha0MwRlpu?=
 =?utf-8?B?UjR5R3ZHMGhJeVVWNWxQd3U4TzA2N1VHZEM1SGFPN0k4Njdla0pIcEFucVhZ?=
 =?utf-8?B?Vk9mdTdWaytKSUpuZHBFa1NvaHdaZjArNk5SU0JwTnNySUh5WEhQNjgvNEdG?=
 =?utf-8?B?SDFCN1FZRFlma1dwUDhqa2pYWlVpVlQ3WlFaZk5oVDNNVmhieEdhWlgxOGtR?=
 =?utf-8?B?UzAwaHB0cHEyN01GV244Nzh4K2xkVW5Vc3BETEhUZEVWTURVUm1tRlZQV1Rw?=
 =?utf-8?B?bFJFam44bHJYWTBEWkJCVERCMjNwbDExbFNjOE10RlB4aW5GcFVuMkNVdlVp?=
 =?utf-8?B?T3RkVWhQcmhKTWtMWUQraFRaL0p3Ujd2U1hkQnJFbWFyUGdzRk1nQUN1Tkw1?=
 =?utf-8?B?T2JzcGJ3Zm1QcWVEUXZwdEIwSm1rUGwxTWhWcTdVVjBVNDAvTHJYaUZ3emNr?=
 =?utf-8?B?ekpiRkpaY2UxcHJBMVZaZkFpLzJuVEF3MDRPdVZDdEtXQnR4NUJEd245Q1BH?=
 =?utf-8?B?WElVWTZSNjM5T21YaFk3Vm9PTW5JSU94bGhvVVdpalF2NU90alJ4ZUl5b0hI?=
 =?utf-8?B?aXBTM2puMENkNndLYXo4TXUzdkR5aG4rZkpIc3BodmN0Y2R3WnZGVG0zUXp0?=
 =?utf-8?B?aG9VZHQ0L2MyUnJTc2YzVUxiNnkwQWI1MktnQ2lweFFNNFQzakJOVndXT0JU?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac81befc-9712-4355-14ef-08dbba8cae13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 10:22:38.1712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rttQPS/q1eAkGka5/MjkMzWLzLhYeacJiSV+30S8ww4B143k2VvvCkLL3m3Cin8UvtV1Qm8OS0imBpexra2Hm5cfKj+kKZM1Qo72e9xxuoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8235
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIxLCAyMDIzIDQ6
NDIgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDA1LzIyXSB2ZmlvL2NvbW1vbjogRXh0cmFj
dCBvdXQNCj52ZmlvX2t2bV9kZXZpY2VfW2FkZC9kZWxdX2ZkDQo+DQo+T24gOS8yMC8yMyAxMzo0
OSwgRXJpYyBBdWdlciB3cm90ZToNCj4+IEhpIFpoZW56aG9uZywNCj4+DQo+PiBPbiA4LzMwLzIz
IDEyOjM3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiAuLi53aGljaCB3aWxsIGJlIHVzZWQg
YnkgYm90aCBsZWdhY3kgYW5kIGlvbW11ZmQgYmFja2VuZC4NCj4+IEkgcHJlZmVyIGdlbnVpbmUg
c2VudGVuY2VzIGluIHRoZSBjb21taXQgbXNnLiBBbHNvIHlvdSBleHBsYWluIHdoYXQgeW91DQo+
PiBkbyBidXQgbm90IHdoeS4NCj4+DQo+PiBzdWdnZXN0aW9uOiBJbnRyb2R1Y2UgdHdvIG5ldyBo
ZWxwZXJzLCB2ZmlvX2t2bV9kZXZpY2VfW2FkZC9kZWxdX2ZkDQo+PiB3aGljaCB0YWtlIGFzIGlu
cHV0IGEgZmlsZSBkZXNjcmlwdG9yIHdoaWNoIGNhbiBiZSBlaXRoZXIgYSBncm91cCBmZCBvcg0K
Pj4gYSBjZGV2IGZkLiBUaGlzIHVzZXMgdGhlIG5ldyBLVk1fREVWX1ZGSU9fRklMRSBWRklPIEtW
TSBkZXZpY2UgZ3JvdXAsDQo+PiB3aGljaCBhbGlhc2VzIHRvIHRoZSBsZWdhY3kgS1ZNX0RFVl9W
RklPX0dST1VQLg0KPg0KPkFoIHllcy4gSSBkaWRuJ3QgdW5kZXJzdGFuZCB3aHkgdGhlICdzL0dS
T1VQL0ZJTEUvJyBjaGFuZ2UgaW4gdGhlDQo+VkZJTyBLVk0gZGV2aWNlIGlvY3Rscy4gVGhhbmtz
IGZvciBjbGFyaWZ5aW5nLg0KPg0KPldoYXQgYWJvdXQgcHJlLTYuNiBrZXJuZWxzIHdpdGhvdXQg
S1ZNX0RFVl9WRklPX0ZJTEUgc3VwcG9ydCA/DQpUaGV5IGFyZSBwdXJlbHkgYWxpYXMuIFNlZSBi
ZWxvdyBjb21taXQ6DQoNCmNvbW1pdCBkYTNjMjJjNzRhM2M2Y2JkMjZkZjQwYjJmNjc5OGEyZDQx
YmU4MGFjDQpBdXRob3I6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KRGF0ZTogICBU
dWUgU2VwIDEyIDExOjI0OjQwIDIwMjMgKzAyMDANCg0KICAgIGxpbnV4LWhlYWRlcnM6IFVwZGF0
ZSB0byBMaW51eCB2Ni42LXJjMQ0KDQogICAgVGhpcyB1cGRhdGUgY29udGFpbnMgdGhlIHJlcXVp
cmVkIGhlYWRlciBjaGFuZ2VzIGZvciB0aGUNCiAgICAidGFyZ2V0L3MzOTB4OiBBUC1wYXNzdGhy
b3VnaCBmb3IgUFYgZ3Vlc3RzIiBwYXRjaCBmcm9tDQogICAgU3RlZmZlbiBFaWRlbi4NCg0KICAg
IE1lc3NhZ2UtSUQ6IDwyMDIzMDkxMjA5MzQzMi4xODAwNDEtMS10aHV0aEByZWRoYXQuY29tPg0K
ICAgIFNpZ25lZC1vZmYtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KDQpkaWZm
IC0tZ2l0IGEvbGludXgtaGVhZGVycy9saW51eC9rdm0uaCBiL2xpbnV4LWhlYWRlcnMvbGludXgv
a3ZtLmgNCmluZGV4IDFmM2YzMzMzYTQuLjBkNzRlZTk5OWEgMTAwNjQ0DQotLS0gYS9saW51eC1o
ZWFkZXJzL2xpbnV4L2t2bS5oDQorKysgYi9saW51eC1oZWFkZXJzL2xpbnV4L2t2bS5oDQpAQCAt
MTQxNCw5ICsxNDE0LDE2IEBAIHN0cnVjdCBrdm1fZGV2aWNlX2F0dHIgew0KICAgICAgICBfX3U2
NCAgIGFkZHI7ICAgICAgICAgICAvKiB1c2Vyc3BhY2UgYWRkcmVzcyBvZiBhdHRyIGRhdGEgKi8N
CiB9Ow0KDQotI2RlZmluZSAgS1ZNX0RFVl9WRklPX0dST1VQICAgICAgICAgICAgICAgICAgICAx
DQotI2RlZmluZSAgIEtWTV9ERVZfVkZJT19HUk9VUF9BREQgICAgICAgICAgICAgICAgICAgICAg
IDENCi0jZGVmaW5lICAgS1ZNX0RFVl9WRklPX0dST1VQX0RFTCAgICAgICAgICAgICAgICAgICAg
ICAgMg0KKyNkZWZpbmUgIEtWTV9ERVZfVkZJT19GSUxFICAgICAgICAgICAgICAgICAgICAgMQ0K
Kw0KKyNkZWZpbmUgICBLVk1fREVWX1ZGSU9fRklMRV9BREQgICAgICAgICAgICAgICAgICAgICAg
ICAxDQorI2RlZmluZSAgIEtWTV9ERVZfVkZJT19GSUxFX0RFTCAgICAgICAgICAgICAgICAgICAg
ICAgIDINCisNCisvKiBLVk1fREVWX1ZGSU9fR1JPVVAgYWxpYXNlcyBhcmUgZm9yIGNvbXBpbGUg
dGltZSB1YXBpIGNvbXBhdGliaWxpdHkgKi8NCisjZGVmaW5lICBLVk1fREVWX1ZGSU9fR1JPVVAg
ICAgS1ZNX0RFVl9WRklPX0ZJTEUNCisNCisjZGVmaW5lICAgS1ZNX0RFVl9WRklPX0dST1VQX0FE
RCAgICAgICBLVk1fREVWX1ZGSU9fRklMRV9BREQNCisjZGVmaW5lICAgS1ZNX0RFVl9WRklPX0dS
T1VQX0RFTCAgICAgICBLVk1fREVWX1ZGSU9fRklMRV9ERUwNCiAjZGVmaW5lICAgS1ZNX0RFVl9W
RklPX0dST1VQX1NFVF9TUEFQUl9UQ0UgICAgICAgICAgICAgMw0KDQpQcmUtNi42IGtlcm5lbCBu
b3Qgc3VwcG9ydGluZyBLVk1fREVWX1ZGSU9fRklMRSBhbHNvIG5vdCBzdXBwb3J0IElPTU1VRkQu
DQpTbyBJIHRoaW5rIHRoYXQncyBmaW5lLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

