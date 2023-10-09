Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F05FF7BD530
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplag-0004CG-Op; Mon, 09 Oct 2023 04:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qplae-0004Bx-HF
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:26:12 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qplaa-0007zb-Jm
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696839968; x=1728375968;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=DTCnyLFnTm6ibAjME6BzDjx8epXe8gBu3G5qC2wpYhI=;
 b=Za8LPjjlSbk5UK7eujuDjlZhQJZbIfxeZSfRGRpFyNG0ZR0Ly2knmgsF
 DbLZnsWKLkZkMHduqrRK8LLzZDcoQB8U12NV7INjDAhZYney6C9yoZo2L
 OxFgkHHPxrIGIB66AyB+iELiw5Io+l0U0vOnufJ3LeA+GtEHrWtEQuXfI
 PIiPnlhHut2EcRsaV0cn1DB7sdR1ovf1+4MzvlL6HyT+vs5e3Ewypzbzz
 xG4sm6UggZh1SnQbr/79XlMcSS205tFaz3F3QfpeYV7iA4Ais7LS2vCyZ
 UWz3t5ntbhvf3F5pKrr4+6Vblp8NTOA20BmfXXdeMp+59F2faJWdFk8uE w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="382971780"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="382971780"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2023 01:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="729593699"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="729593699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Oct 2023 01:26:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 01:26:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 01:26:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 01:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyKr6zkZfL9rzmboVNMVB36JXMqZ1xRWrnaVqSf05ocOyOQgM09R/XDs/7w3uGTY/+bB6SbLYh1xE3TQMBg7fm0GHY4MWhejoUMn3Uj/gK/yhaNzpWSiyA8UUcIpNyPstZKQX7K+zxpEpuB9IImKmhOd1f2nXFG8ehYxOFbyCh8Vln1qmLvbWEUVWrUc3ajQeWaK5LLoxleW24rdUXMPyGcCdTCDYZhuOmQGOeOIjrETpu7NDsh63hBe2SsLHbnU8De4M3+PR1ReqghGBZDHW7sR5XnsUO32o/jjeXGzfYX9Ng9b1/WV/KXBZfI8tPoNPECRsm8/P2U4mA3eQCdM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTCnyLFnTm6ibAjME6BzDjx8epXe8gBu3G5qC2wpYhI=;
 b=Uqqa1QmQfHqagbEzR5i8XJt1XoD58dYDBOMrFYRh8dQfdBYwL2g7siBOgZn/QqMB46COj8mFFnenndJzziBCsJ7dC5fvLLkqvcSG5O9Sv98LUlL7jxTBpfyPlFEzOM4u46yAnoYEVij74YzqQE+NJ15B+6Nh3j7K1gBIQDlHjMDm8vZgZTwwUyjF/V5ZjI06ncxQAZs/5fuS+AzOF2wqI22VkhfsbOs+bMWWQlqKSjpiM0B4vfORqOQmbu4RF/dkgUbpkQiVB2OmFkSkshCMBDVVPKCa6ZlrwdQqO2V8RNlDx8a0K92kUY6Z0A9//u+OWe622ho5FwnB+Gp9+rm/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by DM4PR11MB7327.namprd11.prod.outlook.com (2603:10b6:8:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 9 Oct
 2023 08:25:59 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 08:25:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>
Subject: RE: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Index: AQHZ9tnw8//L3Tx/I0evXiAMnZMSkrA/ryVQgACBngCAAH3+IIAAdNMAgAACAJA=
Date: Mon, 9 Oct 2023 08:25:59 +0000
Message-ID: <PH7PR11MB6722EE017A05685E2408A8D692CEA@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231004154518.334760-1-eric.auger@redhat.com>
 <20231004154518.334760-11-eric.auger@redhat.com>
 <PH7PR11MB67220561760B1AE2DB9277AA92CFA@PH7PR11MB6722.namprd11.prod.outlook.com>
 <4ac0b36c-bf7e-4f00-52f2-1499e75413e7@redhat.com>
 <PH7PR11MB67224BDF9E0837B921827C9892CEA@PH7PR11MB6722.namprd11.prod.outlook.com>
 <74d56985-3573-e01f-b6b4-5fc7829ddfc8@redhat.com>
In-Reply-To: <74d56985-3573-e01f-b6b4-5fc7829ddfc8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|DM4PR11MB7327:EE_
x-ms-office365-filtering-correlation-id: 97cf267b-2a0b-4c79-a99b-08dbc8a15e13
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3nzWuqxDM7dyOSEYo0XPn2o9AXEi8Ti+lNe73YK19dX0ixgngDERroTZ7o0F1rpjg8rPNyFIAvq7mL810hzOYBUI/YZ70Z8nocSkuu4ANigeFvH6vlJBrWa5EFv9UDm0sxkpQkjwTHMAsLWNhCl3eLQpPemN+uY/BLXzVxqzMoooQ7ecCUKSCT6tDW9NZTOP3maC0vFwNWmEhEkCDw1LzkOojDIswa0pamAd0uWerOxt2Ac29aPbNcYNIu/3ZgmponIe78r409BzEouaJtNgBJ+Pjso0m8wTKp7I2J6rPvDgQ1EoV4xz701UOa39Mb3N6QlMH0FpwILE+lGY7Em7ZQwDPlWVVb4uZnG8y6LfLMBdMyyX1OfEovnO9OaU4tGG2eByhzJtJBtnRfyECb3R4cvYBzUOEop875zU1N30MgwmhimUbe2/2rNTeSu+a1OtOiOCdQ58s92Buem2z6OYsh//YQYPlG8elh3AQpQrmeRUJP283VRjeVsPnbkydiiQmyB0NcsfLaiiGAn5jHOLopLIeiGdKV9Mpib72LolmNm73UBh00WrqfPuMLdKvRuQ/Mu/DHZ6ObWhaHF6nsvUMfeGqPfN5yYqtEc5bWG0RVUaDJ9oUOmeO7x3ymuRZTd97q3M4d7ukYoeuK1cUuxbJhgRpSn6zd0Sf9jAHsiqnj29kkRWDAe1mM8h5kglhzn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(41300700001)(33656002)(122000001)(52536014)(55016003)(7416002)(2906002)(38100700002)(86362001)(38070700005)(5660300002)(8676002)(8936002)(316002)(83380400001)(82960400001)(45080400002)(110136005)(66946007)(478600001)(9686003)(26005)(71200400001)(7696005)(6506007)(76116006)(64756008)(53546011)(966005)(921005)(66476007)(66446008)(66556008)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUx4VGN0anJOeUVjZTlCdi9KaHRhOVpwVi9JOVNMS0c4YXlYZlA4UjZadGI5?=
 =?utf-8?B?M3pHNlRuL0R2VVZCeDVnR3BVTjVQQmVzUWF6RGhTeUwvT3JTRnErYWdjTzRh?=
 =?utf-8?B?ZldlaFB6VWNsUEVvVmlya3FqRlQ0LytEWVVKN2o2WHhFNUsyb2FFbGNwRVdJ?=
 =?utf-8?B?NGxzLzBZVW1KbkZsZVF4d1d4K3Arc3RBS0RDcmpCaDV5RWd0ZGZ5OHhkTytH?=
 =?utf-8?B?ell1NW1XSHNSQys0RlVMRzZrZGJLc0J3blNOK1VlLzZDMVp0NXV3UDVZSVBF?=
 =?utf-8?B?bkx4Z2FxREwvMVJ6NW1nSEpYYlBGcGxuYkQ4MDFyVktPRkJPMnU3TXJrUDNa?=
 =?utf-8?B?Z1hQS3VCTit4blRNS2RDa0Q1aEQ2a1dMMWE2bkp4SGxCTDA5NEtnZUtheFRL?=
 =?utf-8?B?eG5PQlh2ZUFEZHZpcWZpcyt4MnBDYi9IZ0ZiUGdLQTNPYWhGQ3RTZ0ZtNFJL?=
 =?utf-8?B?NERVNitrOFAxMDdUdXk5MWkycDJBZzBvdU5JZlZUSWVKRUVHYW1nUkE3dVRD?=
 =?utf-8?B?OEVjdFFwSk5JZ0tIclVGdElRMVI5ek5RU1ZBMFFnNU8wY1lWK2ZCU08rZlk3?=
 =?utf-8?B?cmpWSzRXK2o0YWRNd2NORVFCSkVkcVdFRUE5YUdUVkpWRXhObDMyRlBJWDBw?=
 =?utf-8?B?MVhNN2NZd0JpSXNUcXZ3VXI2azl4VW0yRkVLc3pKc3dQRkgwWVh1UVJ1SHcx?=
 =?utf-8?B?anYwaG1pb3dOaHhUcjVEK3BYblRFYkFPbUFGc3kvNVlCSzU2aytnM2FLNFJC?=
 =?utf-8?B?bTRoczZIQ3dOZEN6QURHVjZUYlVKMDBTMHVLY0plNGJKelN1VTlXOXF0dGhW?=
 =?utf-8?B?UHMyQThqeUdlSmt5dEdMMU5FdGUxaURLaGxPUFpYakJWcHYxQW5YcThPL0Ex?=
 =?utf-8?B?Uyt0VlYzQS9VZ2wzUm9IWGVReUlxMHpGcGJ3OTE1aU1SZG9qYTRDSUxIMTZn?=
 =?utf-8?B?U21PTnE1dVc2VURhSHNUeU5PU0JvNlh0aEVDY2xtMWZGN0VldkM2aDVyd2hF?=
 =?utf-8?B?ckFWZTdhTXJVN2ZEVEo2d2IzVGNGUGNBSzRHT3p0bTBRUmZseENlaUNqODlx?=
 =?utf-8?B?cnlSMmw1elFlMnJEK2VTcU91UHVkOC9IY0NscDhZTDBoOEJEVEVtZTZjRUtM?=
 =?utf-8?B?NHBRYlJYWWRMSXRNY0U4NktobTEwUS8xbTdLNm5YbjRpSGp4OWd0TTBlZlpO?=
 =?utf-8?B?b0Y5RkxKOW9WUHphRkpBY1pqUkJiby8yYW9VQkhHeURHSDNCWW8xUTBFRERE?=
 =?utf-8?B?bzRTUnVRMEJCTklkZjVFRk5wdVlDNHFqK0ZBTDgzNnMzMFAvY3ZqMVRJS09w?=
 =?utf-8?B?ZmhDak5DNmJrU3NJSEpzZjFFWHpxRlYxWE5mSC9iSmI4L2xBdk5UTDAvekhp?=
 =?utf-8?B?Ry9oQ2VFWGN0WnZGSmwyMjdmNHcyUGY0U2NnZ0poSDRwcml4Y3FXb2Z3cExi?=
 =?utf-8?B?MW9naTdqbkYyWGJtMkNuRDErSzhnMjVvMCswRG1BOU93Rk1Ta3NsRTd0SkpS?=
 =?utf-8?B?SFVtaTdKZ1VZemVsTjlCV0VrWi95TzI2RTlGTnl2ZDNpWjFZMnQ3VGtBaVlN?=
 =?utf-8?B?UkRXOWU4RVVDVWwvRmFwU3ZiYVI0YXFXMFVva0x3S0ltcG9hYjdkYS85aUlu?=
 =?utf-8?B?YkozTkovdG9XUWw3b0xvd0ZMb1ZFUEVKN1hvQmcvdnFrVVlFZmdDT3pwYVo2?=
 =?utf-8?B?QTZqbmtqQTBNVU9jT2p1c0w4d1ZWdlRacTUxaUFJQTc2Vzdka3JmNHVTT3pL?=
 =?utf-8?B?UnR2T3o5b1BXdVJZQjVuUXZMMWRxZlFUeG8xejh2SkVEcDIrTVZndHZ1eXk3?=
 =?utf-8?B?bmRqNmhEWEs2WjV3RGpEWitVSW5jTnlDK1hidURmemlTTGpyY0YxVzIvbjRx?=
 =?utf-8?B?OStOWjZQc0MzaXdBWUdEWFpLcnJKVFVvcVlwYWJpaGRPT0hKM0xUR1J5czZ3?=
 =?utf-8?B?VHdJSGo1Wjc2SDBmcWtyVkdHTXdLYXVMUFgwM1dlYThYdVdjTk9DWXp0aDY2?=
 =?utf-8?B?RkxkanpLcDhQMkRiUlRaVXRraC91bUdvelRjaXB0V2sxSUVlMVRISk5VeEEx?=
 =?utf-8?B?TS9HRFpiZUJKQ1ZGNGNWb2pjVjhLK3ZtTWdHc2wxSFVJc3pZeWJaM2ZYdEZQ?=
 =?utf-8?Q?Ut5lWoIFZ4C7Ps1LHYlUWTmEL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cf267b-2a0b-4c79-a99b-08dbc8a15e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 08:25:59.6589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkBQnvjisUfhBmHnMG5dOd1C0qP2GAzIiNWpbORkbx9MRvO9iNkln31m22kDeN4fehLOjt4ZfGXOMfDdfCvkQtPXAIzJAPUF3gEUSFyjSbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7327
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogcWVtdS1kZXZl
bC1ib3VuY2VzK3poZW56aG9uZy5kdWFuPWludGVsLmNvbUBub25nbnUub3JnIDxxZW11LQ0KPmRl
dmVsLWJvdW5jZXMremhlbnpob25nLmR1YW49aW50ZWwuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFs
ZiBPZiBFcmljDQo+QXVnZXINCj5TZW50OiBNb25kYXksIE9jdG9iZXIgOSwgMjAyMyA0OjE1IFBN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCAxMC8xNV0gdmZpby9jY3c6IFVzZSB2ZmlvX1thdHRh
Y2gvZGV0YWNoXV9kZXZpY2UNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gMTAvOS8yMyAwMzoy
NSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+PiBT
ZW50OiBNb25kYXksIE9jdG9iZXIgOSwgMjAyMyAxOjQ2IEFNDQo+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NCAxMC8xNV0gdmZpby9jY3c6IFVzZSB2ZmlvX1thdHRhY2gvZGV0YWNoXV9kZXZpY2UN
Cj4+Pg0KPj4+IEhpIFpoZW56aG9uZywNCj4+PiBPbiAxMC84LzIzIDEyOjIxLCBEdWFuLCBaaGVu
emhvbmcgd3JvdGU6DQo+Pj4+IEhpIEVyaWMsDQo+Pj4+DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29t
Pg0KPj4+Pj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDQsIDIwMjMgMTE6NDQgUE0NCj4+Pj4+
IFN1YmplY3Q6IFtQQVRDSCB2NCAxMC8xNV0gdmZpby9jY3c6IFVzZSB2ZmlvX1thdHRhY2gvZGV0
YWNoXV9kZXZpY2UNCj4+Pj4+DQo+Pj4+PiBMZXQgdGhlIHZmaW8tY2N3IGRldmljZSB1c2UgdmZp
b19hdHRhY2hfZGV2aWNlKCkgYW5kDQo+Pj4+PiB2ZmlvX2RldGFjaF9kZXZpY2UoKSwgaGVuY2Ug
aGlkaW5nIHRoZSBkZXRhaWxzIG9mIHRoZSB1c2VkDQo+Pj4+PiBJT01NVSBiYWNrZW5kLg0KPj4+
Pj4NCj4+Pj4+IE5vdGUgdGhhdCB0aGUgbWlncmF0aW9uIHJlZHVjZXMgdGhlIGZvbGxvd2luZyB0
cmFjZQ0KPj4+Pj4gInZmaW86IHN1YmNoYW5uZWwgJXMgaGFzIGFscmVhZHkgYmVlbiBhdHRhY2hl
ZCIgKGZlYXR1cmluZw0KPj4+Pj4gY3NzaWQuc3NpZC5kZXZpZCkgaW50byAiZGV2aWNlIGlzIGFs
cmVhZHkgYXR0YWNoZWQiDQo+Pj4+Pg0KPj4+Pj4gQWxzbyBub3cgYWxsIHRoZSBkZXZpY2VzIGhh
dmUgYmVlbiBtaWdyYXRlZCB0byB1c2UgdGhlIG5ldw0KPj4+Pj4gdmZpb19hdHRhY2hfZGV2aWNl
L3ZmaW9fZGV0YWNoX2RldmljZSBBUEksIGxldCdzIHR1cm4gdGhlDQo+Pj4+PiBsZWdhY3kgZnVu
Y3Rpb25zIGludG8gc3RhdGljIGZ1bmN0aW9ucywgbG9jYWwgdG8gY29udGFpbmVyLmMuDQo+Pj4+
Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29t
Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4+Pj4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgUm9zYXRvIDxtanJvc2F0b0BsaW51eC5pYm0u
Y29tPg0KPj4+Pj4NCj4+Pj4+IC0tLQ0KPj4+Pj4NCj4+Pj4+IHYzOg0KPj4+Pj4gLSBzaW1wbGlm
aWVkIHZiYXNlZGV2LT5kZXYgc2V0dGluZw0KPj4+Pj4NCj4+Pj4+IHYyIC0+IHYzOg0KPj4+Pj4g
LSBIb3BlZnVsbHkgZml4IGNvbmZ1c2lvbiBiZXRlZW4gdmJhc2VkZXYtPm5hbWUsIG1kZXZpZCBh
bmQgc3lzZnNkZXYNCj4+Pj4+ICB3aGlsZSBrZWVwaW5nIGludG8gYWNjb3VudCBNYXR0aGV3J3Mg
Y29tbWVudA0KPj4+Pj4gIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvNmUwNGFi
OGYtZGM4NC1lOWMyLWRlZWEtDQo+Pj4+PiAyYjZiMzE2NzhiNTNAbGludXguaWJtLmNvbS8NCj4+
Pj4+IC0tLQ0KPj4+Pj4gaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAgIDUgLS0NCj4+
Pj4+IGh3L3ZmaW8vY2N3LmMgICAgICAgICAgICAgICAgIHwgMTIyICsrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+IGh3L3ZmaW8vY29tbW9uLmMgICAgICAgICAgICAgIHwg
IDEwICstLQ0KPj4+Pj4gMyBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAxMDAgZGVs
ZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92Zmlv
LWNvbW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29tbW9uLmgNCj4+Pj4+IGluZGV4
IDEyZmJmYmMzN2QuLmM0ODZiZGVmMmEgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9pbmNsdWRlL2h3L3Zm
aW8vdmZpby1jb21tb24uaA0KPj4+Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9u
LmgNCj4+Pj4+IEBAIC0yMDIsNyArMjAyLDYgQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPj4+Pj4gICAg
IGh3YWRkciBwYWdlczsNCj4+Pj4+IH0gVkZJT0JpdG1hcDsNCj4+Pj4+DQo+Pj4+PiAtdm9pZCB2
ZmlvX3B1dF9iYXNlX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldik7DQo+Pj4+PiB2b2lkIHZm
aW9fZGlzYWJsZV9pcnFpbmRleChWRklPRGV2aWNlICp2YmFzZWRldiwgaW50IGluZGV4KTsNCj4+
Pj4+IHZvaWQgdmZpb191bm1hc2tfc2luZ2xlX2lycWluZGV4KFZGSU9EZXZpY2UgKnZiYXNlZGV2
LCBpbnQgaW5kZXgpOw0KPj4+Pj4gdm9pZCB2ZmlvX21hc2tfc2luZ2xlX2lycWluZGV4KFZGSU9E
ZXZpY2UgKnZiYXNlZGV2LCBpbnQgaW5kZXgpOw0KPj4+Pj4gQEAgLTIyMCwxMSArMjE5LDcgQEAg
dm9pZCB2ZmlvX3JlZ2lvbl91bm1hcChWRklPUmVnaW9uICpyZWdpb24pOw0KPj4+Pj4gdm9pZCB2
ZmlvX3JlZ2lvbl9leGl0KFZGSU9SZWdpb24gKnJlZ2lvbik7DQo+Pj4+PiB2b2lkIHZmaW9fcmVn
aW9uX2ZpbmFsaXplKFZGSU9SZWdpb24gKnJlZ2lvbik7DQo+Pj4+PiB2b2lkIHZmaW9fcmVzZXRf
aGFuZGxlcih2b2lkICpvcGFxdWUpOw0KPj4+Pj4gLVZGSU9Hcm91cCAqdmZpb19nZXRfZ3JvdXAo
aW50IGdyb3VwaWQsIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCk7DQo+Pj4+PiAtdm9p
ZCB2ZmlvX3B1dF9ncm91cChWRklPR3JvdXAgKmdyb3VwKTsNCj4+Pj4+IHN0cnVjdCB2ZmlvX2Rl
dmljZV9pbmZvICp2ZmlvX2dldF9kZXZpY2VfaW5mbyhpbnQgZmQpOw0KPj4+Pj4gLWludCB2Zmlv
X2dldF9kZXZpY2UoVkZJT0dyb3VwICpncm91cCwgY29uc3QgY2hhciAqbmFtZSwNCj4+Pj4+IC0g
ICAgICAgICAgICAgICAgICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApOw0K
Pj4+Pj4gaW50IHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFz
ZWRldiwNCj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJy
b3IgKiplcnJwKTsNCj4+Pj4+IHZvaWQgdmZpb19kZXRhY2hfZGV2aWNlKFZGSU9EZXZpY2UgKnZi
YXNlZGV2KTsNCj4+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2Njdy5jIGIvaHcvdmZpby9jY3cu
Yw0KPj4+Pj4gaW5kZXggMWUyZmNlODNiMC4uNmVjMzVmZWRjOSAxMDA2NDQNCj4+Pj4+IC0tLSBh
L2h3L3ZmaW8vY2N3LmMNCj4+Pj4+ICsrKyBiL2h3L3ZmaW8vY2N3LmMNCj4+Pj4+IEBAIC01NzIs
ODggKzU3MiwxNSBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Njd19wdXRfcmVnaW9uKFZGSU9DQ1dEZXZp
Y2UNCj4+Pj4+ICp2Y2RldikNCj4+Pj4+ICAgICBnX2ZyZWUodmNkZXYtPmlvX3JlZ2lvbik7DQo+
Pj4+PiB9DQo+Pj4+Pg0KPj4+Pj4gLXN0YXRpYyB2b2lkIHZmaW9fY2N3X3B1dF9kZXZpY2UoVkZJ
T0NDV0RldmljZSAqdmNkZXYpDQo+Pj4+PiAtew0KPj4+Pj4gLSAgICBnX2ZyZWUodmNkZXYtPnZk
ZXYubmFtZSk7DQo+Pj4+PiAtICAgIHZmaW9fcHV0X2Jhc2VfZGV2aWNlKCZ2Y2Rldi0+dmRldik7
DQo+Pj4+PiAtfQ0KPj4+Pj4gLQ0KPj4+Pj4gLXN0YXRpYyB2b2lkIHZmaW9fY2N3X2dldF9kZXZp
Y2UoVkZJT0dyb3VwICpncm91cCwgVkZJT0NDV0RldmljZQ0KPip2Y2RldiwNCj4+Pj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+Pj4+IC17DQo+Pj4+
PiAtICAgIFMzOTBDQ1dEZXZpY2UgKmNkZXYgPSBTMzkwX0NDV19ERVZJQ0UodmNkZXYpOw0KPj4+
Pj4gLSAgICBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIleC4leC4lMDR4IiwgY2Rldi0+
aG9zdGlkLmNzc2lkLA0KPj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNk
ZXYtPmhvc3RpZC5zc2lkLA0KPj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNkZXYtPmhvc3RpZC5kZXZpZCk7DQo+Pj4+PiAtICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2Ow0K
Pj4+Pj4gLQ0KPj4+Pj4gLSAgICBRTElTVF9GT1JFQUNIKHZiYXNlZGV2LCAmZ3JvdXAtPmRldmlj
ZV9saXN0LCBuZXh0KSB7DQo+Pj4+PiAtICAgICAgICBpZiAoc3RyY21wKHZiYXNlZGV2LT5uYW1l
LCBuYW1lKSA9PSAwKSB7DQo+Pj4+PiAtICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmZp
bzogc3ViY2hhbm5lbCAlcyBoYXMgYWxyZWFkeSBiZWVuIGF0dGFjaGVkIiwNCj4+Pj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgIG5hbWUpOw0KPj4+Pj4gLSAgICAgICAgICAgIGdvdG8gb3V0X2Vy
cjsNCj4+Pj4+IC0gICAgICAgIH0NCj4+Pj4+IC0gICAgfQ0KPj4+Pj4gLQ0KPj4+Pj4gLSAgICAv
Kg0KPj4+Pj4gLSAgICAgKiBBbGwgdmZpby1jY3cgZGV2aWNlcyBhcmUgYmVsaWV2ZWQgdG8gb3Bl
cmF0ZSBpbiBhIHdheSBjb21wYXRpYmxlIHdpdGgNCj4+Pj4+IC0gICAgICogZGlzY2FyZGluZyBv
ZiBtZW1vcnkgaW4gUkFNIGJsb2NrcywgaWUuIHBhZ2VzIHBpbm5lZCBpbiB0aGUgaG9zdCBhcmUN
Cj4+Pj4+IC0gICAgICogaW4gdGhlIGN1cnJlbnQgd29ya2luZyBzZXQgb2YgdGhlIGd1ZXN0IGRy
aXZlciBhbmQgdGhlcmVmb3JlIG5ldmVyDQo+Pj4+PiAtICAgICAqIG92ZXJsYXAgZS5nLiwgd2l0
aCBwYWdlcyBhdmFpbGFibGUgdG8gdGhlIGd1ZXN0IGJhbGxvb24gZHJpdmVyLiAgVGhpcw0KPj4+
Pj4gLSAgICAgKiBuZWVkcyB0byBiZSBzZXQgYmVmb3JlIHZmaW9fZ2V0X2RldmljZSgpIGZvciB2
ZmlvIGNvbW1vbiB0byBoYW5kbGUNCj4+Pj4+IC0gICAgICogcmFtX2Jsb2NrX2Rpc2NhcmRfZGlz
YWJsZSgpLg0KPj4+Pj4gLSAgICAgKi8NCj4+Pj4+IC0gICAgdmNkZXYtPnZkZXYucmFtX2Jsb2Nr
X2Rpc2NhcmRfYWxsb3dlZCA9IHRydWU7DQo+Pj4+PiAtDQo+Pj4+PiAtICAgIGlmICh2ZmlvX2dl
dF9kZXZpY2UoZ3JvdXAsIGNkZXYtPm1kZXZpZCwgJnZjZGV2LT52ZGV2LCBlcnJwKSkgew0KPj4+
Pj4gLSAgICAgICAgZ290byBvdXRfZXJyOw0KPj4+Pj4gLSAgICB9DQo+Pj4+PiAtDQo+Pj4+PiAt
ICAgIHZjZGV2LT52ZGV2Lm9wcyA9ICZ2ZmlvX2Njd19vcHM7DQo+Pj4+PiAtICAgIHZjZGV2LT52
ZGV2LnR5cGUgPSBWRklPX0RFVklDRV9UWVBFX0NDVzsNCj4+Pj4+IC0gICAgdmNkZXYtPnZkZXYu
bmFtZSA9IG5hbWU7DQo+Pj4+PiAtICAgIHZjZGV2LT52ZGV2LmRldiA9IERFVklDRSh2Y2Rldik7
DQo+Pj4+PiAtDQo+Pj4+PiAtICAgIHJldHVybjsNCj4+Pj4+IC0NCj4+Pj4+IC1vdXRfZXJyOg0K
Pj4+Pj4gLSAgICBnX2ZyZWUobmFtZSk7DQo+Pj4+PiAtfQ0KPj4+Pj4gLQ0KPj4+Pj4gLXN0YXRp
YyBWRklPR3JvdXAgKnZmaW9fY2N3X2dldF9ncm91cChTMzkwQ0NXRGV2aWNlICpjZGV2LCBFcnJv
cg0KPioqZXJycCkNCj4+Pj4+IC17DQo+Pj4+PiAtICAgIGNoYXIgKnRtcCwgZ3JvdXBfcGF0aFtQ
QVRIX01BWF07DQo+Pj4+PiAtICAgIHNzaXplX3QgbGVuOw0KPj4+Pj4gLSAgICBpbnQgZ3JvdXBp
ZDsNCj4+Pj4+IC0NCj4+Pj4+IC0gICAgdG1wID0NCj4+PiBnX3N0cmR1cF9wcmludGYoIi9zeXMv
YnVzL2Nzcy9kZXZpY2VzLyV4LiV4LiUwNHgvJXMvaW9tbXVfZ3JvdXAiLA0KPj4+Pj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgY2Rldi0+aG9zdGlkLmNzc2lkLCBjZGV2LT5ob3N0aWQuc3Np
ZCwNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIGNkZXYtPmhvc3RpZC5kZXZpZCwg
Y2Rldi0+bWRldmlkKTsNCj4+Pj4+IC0gICAgbGVuID0gcmVhZGxpbmsodG1wLCBncm91cF9wYXRo
LCBzaXplb2YoZ3JvdXBfcGF0aCkpOw0KPj4+Pj4gLSAgICBnX2ZyZWUodG1wKTsNCj4+Pj4+IC0N
Cj4+Pj4+IC0gICAgaWYgKGxlbiA8PSAwIHx8IGxlbiA+PSBzaXplb2YoZ3JvdXBfcGF0aCkpIHsN
Cj4+Pj4+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwgInZmaW86IG5vIGlvbW11X2dyb3VwIGZv
dW5kIik7DQo+Pj4+PiAtICAgICAgICByZXR1cm4gTlVMTDsNCj4+Pj4+IC0gICAgfQ0KPj4+Pj4g
LQ0KPj4+Pj4gLSAgICBncm91cF9wYXRoW2xlbl0gPSAwOw0KPj4+Pj4gLQ0KPj4+Pj4gLSAgICBp
ZiAoc3NjYW5mKGJhc2VuYW1lKGdyb3VwX3BhdGgpLCAiJWQiLCAmZ3JvdXBpZCkgIT0gMSkgew0K
Pj4+Pj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAidmZpbzogZmFpbGVkIHRvIHJlYWQgJXMi
LCBncm91cF9wYXRoKTsNCj4+Pj4+IC0gICAgICAgIHJldHVybiBOVUxMOw0KPj4+Pj4gLSAgICB9
DQo+Pj4+PiAtDQo+Pj4+PiAtICAgIHJldHVybiB2ZmlvX2dldF9ncm91cChncm91cGlkLCAmYWRk
cmVzc19zcGFjZV9tZW1vcnksIGVycnApOw0KPj4+Pj4gLX0NCj4+Pj4+IC0NCj4+Pj4+IHN0YXRp
YyB2b2lkIHZmaW9fY2N3X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0K
Pj4+Pj4gew0KPj4+Pj4gLSAgICBWRklPR3JvdXAgKmdyb3VwOw0KPj4+Pj4gICAgIFMzOTBDQ1dE
ZXZpY2UgKmNkZXYgPSBTMzkwX0NDV19ERVZJQ0UoZGV2KTsNCj4+Pj4+ICAgICBWRklPQ0NXRGV2
aWNlICp2Y2RldiA9IFZGSU9fQ0NXKGNkZXYpOw0KPj4+Pj4gICAgIFMzOTBDQ1dEZXZpY2VDbGFz
cyAqY2RjID0gUzM5MF9DQ1dfREVWSUNFX0dFVF9DTEFTUyhjZGV2KTsNCj4+Pj4+ICsgICAgVkZJ
T0RldmljZSAqdmJhc2VkZXYgPSAmdmNkZXYtPnZkZXY7DQo+Pj4+PiAgICAgRXJyb3IgKmVyciA9
IE5VTEw7DQo+Pj4+PiArICAgIGNoYXIgKm5hbWU7DQo+Pj4+PiArICAgIGludCByZXQ7DQo+Pj4+
Pg0KPj4+Pj4gICAgIC8qIENhbGwgdGhlIGNsYXNzIGluaXQgZnVuY3Rpb24gZm9yIHN1YmNoYW5u
ZWwuICovDQo+Pj4+PiAgICAgaWYgKGNkYy0+cmVhbGl6ZSkgew0KPj4+Pj4gQEAgLTY2MywxNCAr
NTkwLDMxIEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwN
Cj5FcnJvcg0KPj4+Pj4gKiplcnJwKQ0KPj4+Pj4gICAgICAgICB9DQo+Pj4+PiAgICAgfQ0KPj4+
Pj4NCj4+Pj4+IC0gICAgZ3JvdXAgPSB2ZmlvX2Njd19nZXRfZ3JvdXAoY2RldiwgJmVycik7DQo+
Pj4+PiAtICAgIGlmICghZ3JvdXApIHsNCj4+Pj4+IC0gICAgICAgIGdvdG8gb3V0X2dyb3VwX2Vy
cjsNCj4+Pj4+IC0gICAgfQ0KPj4+Pj4gKyAgICBuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIleC4l
eC4lMDR4IiwgdmNkZXYtPmNkZXYuaG9zdGlkLmNzc2lkLA0KPj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZjZGV2LT5jZGV2Lmhvc3RpZC5zc2lkLA0KPj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHZjZGV2LT5jZGV2Lmhvc3RpZC5kZXZpZCk7DQo+Pj4+PiArICAgIHZi
YXNlZGV2LT5zeXNmc2RldiA9IGdfc3RyZHVwX3ByaW50ZigiL3N5cy9idXMvY3NzL2RldmljZXMv
JXMvJXMiLA0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bmFtZSwNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNk
ZXYtPm1kZXZpZCk7DQo+Pj4+IEhvcGluZyBub3QgbGF0ZSBmb3IgeW91IHRvIGluY2x1ZGUgdGhp
cyBpbiB2NS4NCj4+Pj4gSSB0aGluayBubyBuZWVkIHRvIHJlLWFzc2lnbiBzeXNmc2RldiBhcyBp
dCdzIGEgdXNlciBwcm9wZXJ0eSwgd2UnZCBiZXR0ZXIgdG8NCj4+Pj4ga2VlcCB0aGUgb3JpZ2lu
YWwgdXNlciB2YWx1ZS4gQWxzbyBsb29rcyBhIG1lbW9yeSBsZWFrIGhlcmUuDQo+Pj4gT0sgSSBy
ZW1vdmVkIGl0Lg0KPj4+Pj4gKyAgICB2YmFzZWRldi0+b3BzID0gJnZmaW9fY2N3X29wczsNCj4+
Pj4+ICsgICAgdmJhc2VkZXYtPnR5cGUgPSBWRklPX0RFVklDRV9UWVBFX0NDVzsNCj4+Pj4+ICsg
ICAgdmJhc2VkZXYtPm5hbWUgPSBuYW1lOw0KPj4+PiBUaGVyZSB3aWxsIGJlIGEgcG90ZW50aWFs
IGZhaWx1cmUgd2hlbiBhIHNlY29uZCBtZGV2IGRldmljZSB1bmRlcg0KPj4+PiBzYW1lIGNzc2lk
LnNzaWQuZGV2aWQgYXR0YWNoZWQuIFdlIGNhbiB1c2UgY2Rldi0+bWRldmlkIGFzIG5hbWUuDQo+
Pj4gQnV0IHRoaXMgbWF0aGVzIHZmaW9fY2N3X2dldF9kZXZpY2UoKSBleGlzdGluZyBjb2RlIHdo
ZXJlDQo+Pj4gdmNkZXYtPnZkZXYubmFtZSA9IG5hbWU7IGFuZA0KPj4+IG5hbWUgPSBnX3N0cmR1
cF9wcmludGYoIiV4LiV4LiUwNHgiLCBjZGV2LT5ob3N0aWQuY3NzaWQsDQo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
ZGV2LT5ob3N0aWQuc3NpZCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNkZXYtPmhvc3RpZC5kZXZpZCk7DQo+PiBJ
IHN1c3BlY3QgdGhpcyBpcyBhIGJ1ZyBvZiB0aGUgZXhpc3RpbmcgY29kZS4NCj5UaGVuIEkgd291
bGQgcHJlZmVyIHdlIGZpeCBpdCBzZXBhcmF0ZWx5LiBUaGlzIHBhdGNoIG1pZ3JhdGVzIHRoZQ0K
PmV4aXN0aW5nIGNvZGUgd2l0aG91dCBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCg0KT0ss
IG1ha2Ugc2Vuc2UuIEknbGwgZG8gdGhhdCBhZnRlciB5b3VyIHY1IGdldCBpbi4NCg0KPg0KPj4N
Cj4+PiBjZGV2LT5tZGV2aWQgaXMgcGFzc2VkIGFzIGZpcnN0IGFyZyBvZiB2ZmlvX2F0dGFjaF9k
ZXZpY2UoKSBpbnN0ZWFkIC4NCj4+IHZmaW9fYXR0YWNoX2RldmljZSgpIHVzZXMgY2Rldi0+bWRl
dmlkIHRvIGdldCBkZXZpY2UgRkQsIG5vdGhpbmcgbW9yZS4NCj4+DQo+PiBJZiB3ZSB1c2UgY3Nz
aWQuc3NpZC5kZXZpZCBhcyBuYW1lLCB0aGVuIGRpZmZlcmVudCBtZGV2IHVuZGVyIHNhbWUNCj5j
c3NpZC5zc2lkLmRldmlkIHdpbGwgaGF2ZSBzYW1lIG5hbWUsIGFuZCB0aGUgc2Vjb25kIG1kZXYg
YXR0YWNobWVudCB3aWxsIGZhaWwgdG8NCj5hdHRhY2ggaW4gdmZpb19hdHRhY2hfZGV2aWNlKCk6
DQo+Pg0KPj4gICAgIFFMSVNUX0ZPUkVBQ0godmJhc2VkZXZfaXRlciwgJmdyb3VwLT5kZXZpY2Vf
bGlzdCwgbmV4dCkgew0KPj4gICAgICAgICBpZiAoc3RyY21wKHZiYXNlZGV2X2l0ZXItPm5hbWUs
IHZiYXNlZGV2LT5uYW1lKSA9PSAwKSB7DQo+PiAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJkZXZpY2UgaXMgYWxyZWFkeSBhdHRhY2hlZCIpOw0KPj4gICAgICAgICAgICAgdmZpb19wdXRf
Z3JvdXAoZ3JvdXApOw0KPj4gICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4+ICAgICAgICAg
fQ0KPj4gICAgIH0NCj5JIGdldCB5b3VyIHBvaW50IGJ1dCB0aGlzIGNvbnZlcnNpb24gbWF0Y2hl
cyB0aGUgZXhpc3RpbmcNCj52ZmlvX2Njd19nZXRfZGV2aWNlKCkgY29kZToNCj7CoMKgwqAgY2hh
ciAqbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiJXguJXguJTA0eCIsIGNkZXYtPmhvc3RpZC5jc3Np
ZCwNCj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNkZXYtPmhvc3RpZC5zc2lkLA0KPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2Rldi0+aG9zdGlkLmRl
dmlkKTsNCj7CoMKgwqAgVkZJT0RldmljZSAqdmJhc2VkZXY7DQo+DQo+wqDCoMKgIFFMSVNUX0ZP
UkVBQ0godmJhc2VkZXYsICZncm91cC0+ZGV2aWNlX2xpc3QsIG5leHQpIHsNCj7CoMKgwqDCoMKg
wqDCoCBpZiAoc3RyY21wKHZiYXNlZGV2LT5uYW1lLCBuYW1lKSA9PSAwKSB7DQo+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJ2ZmlvOiBzdWJjaGFubmVsICVzIGhhcyBh
bHJlYWR5IGJlZW4NCj5hdHRhY2hlZCIsDQo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbmFtZSk7DQo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9l
cnI7DQo+wqDCoMKgwqDCoMKgwqAgfQ0KPsKgwqDCoCB9DQo+DQo+Pg0KPj4+IGkgdGhpbmsgdGhp
cyBhbHNvIG1hdGNoZXMNCj4+Pg0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9QSDdQUjEx
TUI2NzIyMkREMjgyRjk4RTAzMDk1RkJBOEE5MkMxQUBQSA0KPj4+IDdQUjExTUI2NzIyLm5hbXBy
ZDExLnByb2Qub3V0bG9vay5jb20vDQo+Pj4gbm8/DQo+PiBJdCBkb2Vzbid0IG1hdGNoIHdoYXQg
TWF0dGV3IHN1Z2dlc3RlZDogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS0NCj5kZXZlbC82
ZTA0YWI4Zi1kYzg0LWU5YzItZGVlYS0yYjZiMzE2NzhiNTNAbGludXguaWJtLmNvbS8NCj50aGlz
IHdhcyBSRkMgdjMuIEF0IHRoYXQgdGltZSB3ZSBkaWQgbm90IHBhc3MgYW55ICJuYW1lIiBhcmcg
dG8NCj4NCj52ZmlvX2F0dGFjaF9kZXZpY2UoVkZJT0RldmljZSAqdmJhc2VkZXYsIEFkZHJlc3NT
cGFjZSAqYXMsIEVycm9yICoqZXJycCkNCj5hbmQgdmJhc2VkZXYtPm5hbWUgd2FzIHVzZWQgd2hl
biBjYWxsaW5nIHZmaW9fZ2V0X2RldmljZSgpIHdoaWxlIHdlIG5vdw0KPnVzZSBjZGV2LT5tZGV2
aWQuIEJlc2lkZXMgTWF0dGV3IHJhbiBzb21lIGJhc2ljIHRlc3RzIG9uIFBBVENIIHYzOg0KPmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8zM2I3ODAzYy1mMjMxLWQ0ZmItZDlkOS0NCj4yNmEw
OTdhODllOTNAcmVkaGF0LmNvbS8NCj5TbyBJIHdvdWxkIGJlIHRlbXB0ZWQgdG8gbGVhdmUgaXQg
YXMgaXMgKHdpdGhvdXQgdGhlIHN5c2ZzZGV2IG92ZXJ3cml0ZQ0KPndoaWNoIGNhbWUgZnJvbSBN
YXR0ZXcncyBzdWdnZXN0aW9uIGluDQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC82ZTA0YWI4Zi1kYzg0LWU5YzItZGVlYS0NCj4yYjZiMzE2NzhiNTNAbGludXguaWJtLmNvbS8N
Cj4pLiBUaGFua3MgRXJpYw0KDQpPSywgdGhlbiBnbyBhaGVhZC4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg==

