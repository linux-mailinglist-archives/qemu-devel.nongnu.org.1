Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889078D502
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbI3A-0002Xq-1n; Wed, 30 Aug 2023 06:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qbI35-0002Vk-Of
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:03:44 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qbI32-0006MG-99
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693389820; x=1724925820;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q9Tv6m8UOshyBcdKABwThzngBohfWEaKqdUUkHHNbE0=;
 b=Uf3YtQMCehCT4s2SthlPD06pMVqW5l9Tle4ABez558ahKcoqKIsdewSj
 kl8Eni4cXKMU5eGt7dce3gDWOAXPbKll6wgHoPbyLuIj+DfUnhc5RHbJ9
 CBnKiqvSbCBncGm0hl2lgh/WtzSxp1U6YZkrFzns9OgetFlZRjJs0qZRd
 b2p7lMxDsu9gfqOaI9Xj3FGqxbZQjOMWOVqn5GyXFCPx/Lb4W/gZ+eL2a
 UpPQIT2OfqMoIknY3Y6h/ic0G37sY792EhEzHEStU/9eTJXk8pGSnSlRv
 pn2hIPOzVS5+k+QWPQ4l6T0x7efJcGMz2dQSMwb3zT6TVJ06xXIQl+hb8 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374510124"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="374510124"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="809077611"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="809077611"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2023 03:03:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 03:03:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 03:03:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 03:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToH/xBes9XmI8QWsdIv4WU9p1kLK3Qj0dN+3C9vbfEpHAcc0YUCxgbCLg6nPbcNVFmrcX2Z9xCmXhcB4LC+etzQHYeVeDB+g6gmAGNYKPewqk8Jlw1mPmQIJIzJ3SnzIaXk2aHaNhqcBxueRVDPwIWKHtIjYjV17vZZdijQGz2z5Uy30WCLpKUWRFX/UrCvzhMEDlU9epGOnWPt5oGW/cjNPLVGk85EvQz1eQu0kk17jUYaXEfMp8CYAiSrlHZYQx5c5TyWFQ1GZ5HBJICpZC4vx3AiVjK2PCidl5IqKYEOqta+jt4skryGpOctQmnW2evh9O5fM/A3/meBtpa2syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9Tv6m8UOshyBcdKABwThzngBohfWEaKqdUUkHHNbE0=;
 b=B3E8q0O8h27SoWc6o84XJhbd5rvDiN7tkkCRbA03gks193durRK0ZbiF7ZObMBFe/D24h8Gn5ro2i1AMyw0yQlYFa/726RluuCXNi0SU/O3FzJNFp3vhzV5Lm5fY6/kfatAXqW2Vn+J7pCKMlMR51M2fzIBoI6XFB3hf79XZgg1oMn4qOHtDHVPO+amciZjSsLEAG9z/CTaemLHjlugfOZ0dMKN/TAJsUf8UFkGsgRwjAk4J/AqbQfQHof6yt8TcXn7t/Kl2YqKvkxcm1l806f/qTXCoNWc5fJB9xGCs8dXz4k1cJmWiJJBw94T8oIoWTZAE6iX5iG5zl3ZcUchXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 10:03:33 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6678.023; Wed, 30 Aug 2023
 10:03:33 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
Subject: RE: [PATCH v1 3/4] vfio/pci: use an invalid fd to enable MSI-X
Thread-Topic: [PATCH v1 3/4] vfio/pci: use an invalid fd to enable MSI-X
Thread-Index: AQHZ1Mp6BsZEzkFue0GKpsn+IxUI8bABWeOAgAFHOuA=
Date: Wed, 30 Aug 2023 10:03:33 +0000
Message-ID: <DS0PR11MB8114DF931C88CD84C0E1BBEFA9E6A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <20230822072927.224803-4-jing2.liu@intel.com>
 <3716c573-fb2e-cc26-d77e-b930353f9b8d@redhat.com>
In-Reply-To: <3716c573-fb2e-cc26-d77e-b930353f9b8d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|LV8PR11MB8557:EE_
x-ms-office365-filtering-correlation-id: faabe95a-e610-4e5b-8054-08dba9405eba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qUZNE45g98soOGzWbhd/OmiKSCfAOTXGwzvssdaw0ytd9XdMSE/KeUP2TDpet5nAt/oWoTYZRuzhnnEYaXstvztho1CuAAJbqSOLVpwYa7HrG6zZi6TqO+OI1383vej7AzkQyiS/k8cSdzUn/foOpTcqd0pWYRhXi9P6hvup4W392ticGBbUZNc4HJf2lN7FnVuvRz59mbbpuER1DrNLXfHFD6zu9Q/l0UEpYgJ7LZy62sWPCUPQINLdsP4/7BerAJDD3J7iSZqJO5AffyaRQ6RiWlmoatvJ/slh015l1S8ZzFceJAy825BZ/deOVJzwtEvVxCQKTdMcneDrlgGrhWYoS6A7f/PKRkSWHdh8UWyGANIzbwFFk1XnF0u7H7SjYpsA896Q94XtmeRDb6uuXgEdtbQfM+Od18MPkBAyxHeFdPsc0h5Hov8BqXnRzZtoNO0KOJDeq5w5xnVYUCUolY3M85BBniW1o2w6V6w9bvzBbmjK2SMZtYww7BiZ0rh0dU89pX7O+j8eYaJkDfzlzq/2Lp/9+J6KjCmFS5YZF9DC+e++q5kaBrMNrl2ec7LYc2QJxn16JoicSH/GYvVkzQrPYAy9La7FRrecK8kLWFeJ3dfO0Z3pRVZ4YqFrkolv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199024)(1800799009)(186009)(9686003)(26005)(316002)(38100700002)(82960400001)(38070700005)(66899024)(41300700001)(4326008)(66574015)(33656002)(52536014)(2906002)(55016003)(86362001)(5660300002)(8676002)(83380400001)(8936002)(71200400001)(66446008)(7696005)(6506007)(64756008)(66476007)(66556008)(54906003)(53546011)(76116006)(110136005)(66946007)(478600001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnA2SzIyNC9TekVNcXVFSjBsQWhuNjVHQXhTRDU1b3JRUFRsb2VoK0NMSlBB?=
 =?utf-8?B?dUp5YUF5QUZLNlVmb3N5UTN0dndOSlIveXVRTllQeWQ4R2ZXQkJORHMxMFBl?=
 =?utf-8?B?bkIyMksrZkphZFJWY0taL2FzTlhGVENHWUpiZGFqZEJkeGJQczZlV3l6TU1n?=
 =?utf-8?B?ckp5ckhKUTlyM3dpYTdodmp0MUZBWFl2WFZUMFJCUTZ1K1hObi9HUzRnZEF0?=
 =?utf-8?B?c3lOZnEvYStoUHBURjJXSmpkTkxzNjdvaUVIQXFMQ1ZCYjZhL3lLcTdrcThu?=
 =?utf-8?B?Z1c4aWI2RklGbGJWdjdyVGVzRkFpT3l1S1M1dTJYS1ZwZHU2TGFMSVJpb0Uz?=
 =?utf-8?B?alcrUUVLdGxiMlNGMjIyZXV3eDVYZmhibVplQ1dMKytxaUhWaGN4c0ZJdjhJ?=
 =?utf-8?B?cmU4b1gzMFRqa1JQZVc4cEsyUTRUaHlHaml1Ulp5RVROd2xnRWhlRDZySkVK?=
 =?utf-8?B?a01TNHZTd2RoNzVwSGZBWDR1TFhzaUxlUW1kbVNDV0E0eFhzY21tUVIyOWZz?=
 =?utf-8?B?WllNUGMxOVcrYjdTeElSbFgzWi9INE03bDgrRFJnSCt0R2VTYzVpNFNpa1NR?=
 =?utf-8?B?cEhYRE9vT2ZXK3RtVksvS2dUZ1NhbGYrRmprTFZUUjJoTkowYnYvUFA3RVZB?=
 =?utf-8?B?VmIzNHI1NVhCQU9sRG8zRy9EbmJWL1hSdzYxR01sc1JHTUk3cVp2Zy83cU5Y?=
 =?utf-8?B?RzU1UEcrdHpmempwZUs0RCtpUGJrMytBd3FXczBkaXhyekpGNitKKyt4Q0Jj?=
 =?utf-8?B?ZVc3VEI1RjlUTTlRY0lsWG54YkhwcjR5em53SE5GQmFKSGNYNzFaNWFVOWcy?=
 =?utf-8?B?dDNVYWYvSEdzSXJ0c2FKZEo4YjJOaFljdXpMVlpYcXBCTVJzNzErcVA0eXZ2?=
 =?utf-8?B?TklNdnN3Q3FRdTBkYS9YMUxvVmtZYVdFSnFzU1c2YmdpbTVDeCtwWmpNTlgv?=
 =?utf-8?B?aDJPOTFRaThwQ2krT3czNk9OMThkTFNyS2NUYkh4R09CSVY0UE5JekFpNmla?=
 =?utf-8?B?dzEwWTlIQ0NNZTNrSFplR2tsVlAvemEyUFFIRElvd2dwa1FuSlZoeHhtZ2xQ?=
 =?utf-8?B?V3liMjJ4QjIvRnI2bFF3VmttQ2l3Y1VGU0RQUkRjK0xaQklBYzBFdkpha2x4?=
 =?utf-8?B?ZDBYM3hFOGdLYzJGMFFoZ2RmWFVZWW9WQUMyekVmU20zVExPVmhRMXNpamFZ?=
 =?utf-8?B?VlFZMUMzanNEOVZKaTBFTEpndk1nM1ZnTnE0c2kvc1puY0NuMUlITTM1OHM2?=
 =?utf-8?B?MHJaaGNYbDVqSmZTTC9jMjVMRW1zTnZjRzF3SCttaTY4dTN4a2VzZ2IrK2E3?=
 =?utf-8?B?VVVDcmNXeHdkRHdwQWRyT0NNcmdNZC81VXZRMGc0d1JVMjNNL2Q0M2htcDd1?=
 =?utf-8?B?V1FoQkJhM1JKejVxZk9vQkprOW5ua0ZJdUVhamJWcDVycjhPeS9LY3MzQ0hx?=
 =?utf-8?B?STF6cWZLOFlHbG5kKzFOLzNYSGhaRmZKejAyR2FSY1c2V3ZLVU42a1RSUSto?=
 =?utf-8?B?NW9rdDlGRlNjTUlzbWtQOS9FWHZuS1BZYnIwUlJkNlZrUFA5bDJnclpMcWYv?=
 =?utf-8?B?MmZsRWN0LzlHQ0hiQzZ1Y21VTGlFb0liL3ZoeXd5aCsyYmNCSGExdjFqMWMw?=
 =?utf-8?B?aW5CTURWVlFIZFQyWjBPUURCVlZ1T2Ruby9jMWRlWU4wZjU3S3NQL2krMnZ1?=
 =?utf-8?B?QTFHYk9ZMlZtUTJFWUdwVWRvdGxHejJNZTNvMzl3WThBY3FVV1NTTnpoM3VR?=
 =?utf-8?B?K21IQUF5YmtoeU0vNXpsMXNiT3pkZnN6RkcxUDhMYU1pKzFkRldGL1hLdE91?=
 =?utf-8?B?NG9OYmY5MFhwU0o0NXc1ajQ2WXE2WFZ1WG45dUtmeDd1ZGt2YnBjMzRCWGt2?=
 =?utf-8?B?NXV3NE9mVk05Zk9wQ1NCMW03OTduWDFTQ3ZOa05VVy9MOGtZV05aaWlUSHkr?=
 =?utf-8?B?emxyVFhNL1BrTFZUdGJ2ZWRVdjlwdTJ2SUQ2YStLT09jYXpkdjVCNnE0bk9t?=
 =?utf-8?B?c0JnYVhTdUtxSmppMkVjWDZMZkh4ajV0ajgyYzBqNUpBRzRKVVZsY1ZYcWJa?=
 =?utf-8?B?Y2FmRTRSNWJ1dm5pOEdKakJMM24rbkFNNHhVbThuR3BZOEVTbFhtQjVKYkFo?=
 =?utf-8?Q?AtDkA284vPI8dVjU0+TUQxVIY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faabe95a-e610-4e5b-8054-08dba9405eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 10:03:33.4953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMxiLsrdojsBYWaG7HtyGm1OqhJ4sRCCt06MWNoOU3L7sR3jlmCqdaN0sGNp13rkz3NLpsQGW2LKX1xq4efIdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpY++8jA0KDQpPbiA4LzI5LzIwMjMgMTA6MDQgUE0sIEPDqWRyaWMgTGUgR29hdGVy
IHdyb3RlOg0KPiBPbiA4LzIyLzIzIDA5OjI5LCBKaW5nIExpdSB3cm90ZToNCj4gPiBHdWVzdHMg
dHlwaWNhbGx5IGVuYWJsZSBNU0ktWCB3aXRoIGFsbCBvZiB0aGUgdmVjdG9ycyBtYXNrZWQgaW4g
dGhlDQo+ID4gTVNJLVggdmVjdG9yIHRhYmxlLiBUbyBtYXRjaCB0aGUgZ3Vlc3Qgc3RhdGUgb2Yg
ZGV2aWNlLCBRZW11IGVuYWJsZXMNCj4gPiBNU0ktWCBieQ0KPiANCj4gUUVNVSBpcyBwcmVmZXJy
ZWQgdG8gUWVtdS4NCkdvdCBpdC4gDQoNCj4gDQo+ID4gZW5hYmxpbmcgdmVjdG9yIDAgd2l0aCB1
c2Vyc3BhY2UgdHJpZ2dlcmluZyBhbmQgaW1tZWRpYXRlbHkgcmVsZWFzZS4NCj4gPiBIb3dldmVy
IHRoZSByZWxlYXNlIGZ1bmN0aW9uIGFjdHVhbGx5IGRvZXMgbm90IHJlbGVhc2UgaXQgZHVlIHRv
DQo+ID4gYWxyZWFkeSB1c2luZyB1c2Vyc3BhY2UgbW9kZS4NCj4gPg0KPiA+IEl0IGlzIG5vIG5l
ZWQgdG8gZW5hYmxlIHRyaWdnZXJpbmcgb24gaG9zdCBhbmQgcmVseSBvbiB0aGUgbWFzayBiaXQg
dG8NCj4gPiBhdm9pZCBzcHVyaW91cyBpbnRlcnJ1cHRzLiBVc2UgYW4gaW52YWxpZCBmZCAoaS5l
LiBmZCA9IC0xKSBpcyBlbm91Z2gNCj4gPiB0byBnZXQgTVNJLVggZW5hYmxlZC4NCj4gPg0KPiA+
IEFmdGVyIGR5bmFtaWMgTVNJLVggYWxsb2NhdGlvbiBpcyBzdXBwb3J0ZWQsIHRoZSBpbnRlcnJ1
cHQgcmVzdG9yaW5nDQo+ID4gYWxzbyBuZWVkIHVzZSBzdWNoIHdheSB0byBlbmFibGUgTVNJLVgs
IHRoZXJlZm9yZSwgY3JlYXRlIGEgZnVuY3Rpb24NCj4gPiBmb3IgdGhhdC4NCj4gPg0KPiA+IFN1
Z2dlc3RlZC1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKaW5nIExpdSA8amluZzIubGl1QGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFJGQyB2MToNCj4gPiAtIEEgbmV3IHBhdGNoLiBVc2UgYW4g
aW52YWxpZCBmZCB0byBnZXQgTVNJLVggZW5hYmxlZCBpbnN0ZWFkIG9mIHVzaW5nDQo+ID4gICAg
dXNlcnNwYWNlIHRyaWdnZXJpbmcuIChBbGV4KQ0KPiA+IC0tLQ0KPiA+ICAgaHcvdmZpby9wY2ku
YyB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYyBpbmRl
eA0KPiA+IDMxZjM2ZDY4YmIxOS4uZTI0YzIxMjQxYTBjIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3Zm
aW8vcGNpLmMNCj4gPiArKysgYi9ody92ZmlvL3BjaS5jDQo+ID4gQEAgLTM2OSw2ICszNjksMzkg
QEAgc3RhdGljIHZvaWQgdmZpb19tc2lfaW50ZXJydXB0KHZvaWQgKm9wYXF1ZSkNCj4gPiAgICAg
ICBub3RpZnkoJnZkZXYtPnBkZXYsIG5yKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICsvKg0KPiA+ICsg
KiBHZXQgTVNJLVggZW5hYmxlZCwgYnV0IG5vIHZlY3RvciBlbmFibGVkLCBieSBzZXR0aW5nIHZl
Y3RvciAwIHdpdGgNCj4gPiArYW4gaW52YWxpZA0KPiA+ICsgKiBmZCB0byBrZXJuZWwuDQo+ID4g
KyAqLw0KPiA+ICtzdGF0aWMgaW50IHZmaW9fZW5hYmxlX21zaXhfbm9fdmVjKFZGSU9QQ0lEZXZp
Y2UgKnZkZXYpPiArew0KPiA+ICsgICAgc3RydWN0IHZmaW9faXJxX3NldCAqaXJxX3NldDsNCj4g
DQo+IFRoaXMgY291bGQgYmUgYSAnZ19hdXRvZnJlZScgdmFyaWFibGUuDQoNClRoYW5rcyBmb3Ig
cG9pbnRpbmcgdGhpcyB0byBtZS4gSSBqdXN0IHJlYWxpemVkIFFFTVUgZG9jIHJlY29tbWVuZHMg
DQpnX2F1dG9mcmVlL2dfYXV0b3B0ciB0byBkbyBhdXRvbWF0aWMgbWVtb3J5IGRlYWxsb2NhdGlv
bi4NCg0KSSB3aWxsIHJlcGxhY2UgdG8gZ19hdXRvZnJlZSBzdHlsZSBpbiBuZXh0IHZlcnNpb24u
DQoNCkkgaGF2ZSBhIHF1ZXN0aW9uIGZvciBhIHNwZWNpZmljIGV4YW1wbGUgKG5vdCByZWxhdGVk
IHRvIHRoaXMgcGF0Y2gpLCBhbmQNCkkgZmFpbGVkIHRvIGZpbmQgYW4gZXhhbXBsZSBpbiBjdXJy
ZW50IFFFTVUgY29kZSB0byB1bmRlcnN0YW5kIGl0Lg0KSWYgb25lIGdfYXV0b2ZyZWUgc3RydWN0
dXJlIGluY2x1ZGVzIGEgcG9pbnRlciB0aGF0IHdlIGFsc28gYWxsb2NhdGUNCnNwYWNlIGZvciB0
aGUgaW5zaWRlIHBvaW50ZXIsIGNvdWxkIGdfYXV0b2ZyZWUgcmVsZWFzZSB0aGUgaW5zaWRlIHNw
YWNlPw0KDQpzdHJ1Y3QgZHVtbXkxIHsNCiAgICBpbnQgZGF0YTsNCiAgICBzdHJ1Y3QgKnA7DQp9
DQpzdHJ1Y3QgcCB7DQogICAgY2hhciBtZW1iZXJbXTsNCn0NCnZvaWQgZnVuYygpIHsNCiAgICBn
X2F1dG9mcmVlIHN0cnVjdCAqZHVtbXkxID0gTlVMTDsNCg0KICAgIGR1bW15MSA9IGdfbWFsbG9j
KCk7DQogICAgZHVtbXkxLT5wID0gZ19tYWxsb2MoKTsNCiAgICAuLi4NCiAgICByZXR1cm47CS8v
IGlzIHRoaXMgY29ycmVjdCBvciBuZWVkIGdfZnJlZShwKT8NCn0NCg0KPiANCj4gPiArICAgIGlu
dCByZXQgPSAwLCBhcmdzejsNCj4gPiArICAgIGludDMyX3QgKmZkOw0KPiA+ICsNCj4gPiArICAg
IGFyZ3N6ID0gc2l6ZW9mKCppcnFfc2V0KSArIHNpemVvZigqZmQpOw0KPiA+ICsNCj4gPiArICAg
IGlycV9zZXQgPSBnX21hbGxvYzAoYXJnc3opOw0KPiA+ICsgICAgaXJxX3NldC0+YXJnc3ogPSBh
cmdzejsNCj4gPiArICAgIGlycV9zZXQtPmZsYWdzID0gVkZJT19JUlFfU0VUX0RBVEFfRVZFTlRG
RCB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIFZGSU9fSVJRX1NFVF9BQ1RJT05fVFJJR0dF
UjsNCj4gPiArICAgIGlycV9zZXQtPmluZGV4ID0gVkZJT19QQ0lfTVNJWF9JUlFfSU5ERVg7DQo+
ID4gKyAgICBpcnFfc2V0LT5zdGFydCA9IDA7DQo+ID4gKyAgICBpcnFfc2V0LT5jb3VudCA9IDE7
DQo+ID4gKyAgICBmZCA9IChpbnQzMl90ICopJmlycV9zZXQtPmRhdGE7DQo+ID4gKyAgICAqZmQg
PSAtMTsNCj4gPiArDQo+ID4gKyAgICByZXQgPSBpb2N0bCh2ZGV2LT52YmFzZWRldi5mZCwgVkZJ
T19ERVZJQ0VfU0VUX0lSUVMsIGlycV9zZXQpOw0KPiA+ICsgICAgaWYgKHJldCkgew0KPiA+ICsg
ICAgICAgIGVycm9yX3JlcG9ydCgidmZpbzogZmFpbGVkIHRvIGVuYWJsZSBNU0ktWCB3aXRoIHZl
Y3RvciAwIHRyaWNrLCAlZCIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldCk7DQo+IA0K
PiBUaGUgYWJvdmUgbWVzc2FnZSBzZWVtcyByZWR1bmRhbnQuIEkgd291bGQgc2ltcGx5IHJldHVy
biAncmV0JyBhbmQgbGV0IHRoZQ0KPiBjYWxsZXIgcmVwb3J0IHRoZSBlcnJvci4gU2FtZSBhcyB2
ZmlvX2VuYWJsZV92ZWN0b3JzKCkuDQoNClVuZGVyc3Rvb2QuIFdpbGwgY2hhbmdlLg0KDQpUaGFu
a3MsDQpKaW5nDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+ICsgICAgfQ0KPiA+
ICsNCj4gPiArICAgIGdfZnJlZShpcnFfc2V0KTsNCj4gPiArDQo+ID4gKyAgICByZXR1cm4gcmV0
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGludCB2ZmlvX2VuYWJsZV92ZWN0b3JzKFZG
SU9QQ0lEZXZpY2UgKnZkZXYsIGJvb2wgbXNpeCkNCj4gPiAgIHsNCj4gPiAgICAgICBzdHJ1Y3Qg
dmZpb19pcnFfc2V0ICppcnFfc2V0Ow0KPiA+IEBAIC02MTgsNiArNjUxLDggQEAgc3RhdGljIHZv
aWQNCj4gPiB2ZmlvX2NvbW1pdF9rdm1fbXNpX3ZpcnFfYmF0Y2goVkZJT1BDSURldmljZSAqdmRl
dikNCj4gPg0KPiA+ICAgc3RhdGljIHZvaWQgdmZpb19tc2l4X2VuYWJsZShWRklPUENJRGV2aWNl
ICp2ZGV2KQ0KPiA+ICAgew0KPiA+ICsgICAgaW50IHJldDsNCj4gPiArDQo+ID4gICAgICAgdmZp
b19kaXNhYmxlX2ludGVycnVwdHModmRldik7DQo+ID4NCj4gPiAgICAgICB2ZGV2LT5tc2lfdmVj
dG9ycyA9IGdfbmV3MChWRklPTVNJVmVjdG9yLCB2ZGV2LT5tc2l4LT5lbnRyaWVzKTsNCj4gPiBA
QCAtNjQwLDggKzY3NSw2IEBAIHN0YXRpYyB2b2lkIHZmaW9fbXNpeF9lbmFibGUoVkZJT1BDSURl
dmljZSAqdmRldikNCj4gPiAgICAgICB2ZmlvX2NvbW1pdF9rdm1fbXNpX3ZpcnFfYmF0Y2godmRl
dik7DQo+ID4NCj4gPiAgICAgICBpZiAodmRldi0+bnJfdmVjdG9ycykgew0KPiA+IC0gICAgICAg
IGludCByZXQ7DQo+ID4gLQ0KPiA+ICAgICAgICAgICByZXQgPSB2ZmlvX2VuYWJsZV92ZWN0b3Jz
KHZkZXYsIHRydWUpOw0KPiA+ICAgICAgICAgICBpZiAocmV0KSB7DQo+ID4gICAgICAgICAgICAg
ICBlcnJvcl9yZXBvcnQoInZmaW86IGZhaWxlZCB0byBlbmFibGUgdmVjdG9ycywgJWQiLCByZXQp
Ow0KPiA+IEBAIC02NTUsMTMgKzY4OCwxNCBAQCBzdGF0aWMgdm9pZCB2ZmlvX21zaXhfZW5hYmxl
KFZGSU9QQ0lEZXZpY2UgKnZkZXYpDQo+ID4gICAgICAgICAgICAqIE1TSS1YIGNhcGFiaWxpdHks
IGJ1dCBsZWF2ZXMgdGhlIHZlY3RvciB0YWJsZSBtYXNrZWQuICBXZSB0aGVyZWZvcmUNCj4gPiAg
ICAgICAgICAgICogY2FuJ3QgcmVseSBvbiBhIHZlY3Rvcl91c2UgY2FsbGJhY2sgKGZyb20gcmVx
dWVzdF9pcnEoKSBpbiB0aGUgZ3Vlc3QpDQo+ID4gICAgICAgICAgICAqIHRvIHN3aXRjaCB0aGUg
cGh5c2ljYWwgZGV2aWNlIGludG8gTVNJLVggbW9kZSBiZWNhdXNlIHRoYXQgbWF5IGNvbWUNCj4g
YQ0KPiA+IC0gICAgICAgICAqIGxvbmcgdGltZSBhZnRlciBwY2lfZW5hYmxlX21zaXgoKS4gIFRo
aXMgY29kZSBlbmFibGVzIHZlY3RvciAwIHdpdGgNCj4gPiAtICAgICAgICAgKiB0cmlnZ2VyaW5n
IHRvIHVzZXJzcGFjZSwgdGhlbiBpbW1lZGlhdGVseSByZWxlYXNlIHRoZSB2ZWN0b3IsIGxlYXZp
bmcNCj4gPiAtICAgICAgICAgKiB0aGUgcGh5c2ljYWwgZGV2aWNlIHdpdGggbm8gdmVjdG9ycyBl
bmFibGVkLCBidXQgTVNJLVggZW5hYmxlZCwganVzdA0KPiA+IC0gICAgICAgICAqIGxpa2UgdGhl
IGd1ZXN0IHZpZXcuDQo+ID4gKyAgICAgICAgICogbG9uZyB0aW1lIGFmdGVyIHBjaV9lbmFibGVf
bXNpeCgpLiAgVGhpcyBjb2RlIHNldHMgdmVjdG9yIDAgd2l0aCBhbg0KPiA+ICsgICAgICAgICAq
IGludmFsaWQgZmQgdG8gbWFrZSB0aGUgcGh5c2ljYWwgZGV2aWNlIE1TSS1YIGVuYWJsZWQsIGJ1
dCB3aXRoIG5vDQo+ID4gKyAgICAgICAgICogdmVjdG9ycyBlbmFibGVkLCBqdXN0IGxpa2UgdGhl
IGd1ZXN0IHZpZXcuDQo+ID4gICAgICAgICAgICAqLw0KPiA+IC0gICAgICAgIHZmaW9fbXNpeF92
ZWN0b3JfZG9fdXNlKCZ2ZGV2LT5wZGV2LCAwLCBOVUxMLCBOVUxMKTsNCj4gPiAtICAgICAgICB2
ZmlvX21zaXhfdmVjdG9yX3JlbGVhc2UoJnZkZXYtPnBkZXYsIDApOw0KPiA+ICsgICAgICAgIHJl
dCA9IHZmaW9fZW5hYmxlX21zaXhfbm9fdmVjKHZkZXYpOw0KPiA+ICsgICAgICAgIGlmIChyZXQp
IHsNCj4gPiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJ2ZmlvOiBmYWlsZWQgdG8gZW5hYmxl
IE1TSS1YLCAlZCIsIHJldCk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgIHRyYWNlX3ZmaW9fbXNpeF9lbmFibGUodmRldi0+dmJhc2VkZXYubmFtZSk7DQoNCg==

