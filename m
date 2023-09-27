Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778AB7AF800
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 04:10:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlJzC-0006m9-8K; Tue, 26 Sep 2023 22:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlJzA-0006lw-Jg
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 22:09:08 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlJz7-0001ck-LW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 22:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695780545; x=1727316545;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KgHYX7umCqkuy7nxUmEcY4oQcHw+v+zpLEJy9wANxn4=;
 b=LaINVjFHNoCP7p2FRxWzit428lhn75OERHwLltcUT3ccitCT9bdY7OR9
 kkNVaY/CPxZETPJ41S0rxfz3nrRHcVyglv+LqbtIeETFcY3xOIgy+ciCl
 L4ql0O4SH9ZiJwfobPK6cuep0XvXPP+IsdQ5fvDLQEfyABuYb6KiVsTJV
 0fz/YDlKvgasnTLOTxk2SCGNTPefb+/0gHq68oIEKryZ0NzLjuHBqiHtc
 4TinS/cefxfRGBDKiwL3HsRRBg7Otzcfay8o2bm/PvbZDiq34vhs39ccX
 Pbn34Af9Tp0HJjwzV7nfHlWhDo3MHwFueQHhRprhx/X/H1yk6RqjWkUO7 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385566138"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="385566138"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 19:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742544973"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="742544973"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2023 19:09:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 19:09:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 19:09:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 19:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qze9IhU7lcc0W67IKVmXt+IOEDRUeEeb/WpE3knC3MgnHWt983s6+JWvYEVD8sL7SmOMvXwgCg5cYKy4WFe6SPVnnuKXu8u1QkIWpyqAodtu7CLzoAAOuFeol2WaYVxADraEjoT3MToGyUnJKSpDAvnM/YEAQOXB0LNrUzSL6tGupa+TQQPavglfbo55yw4O7XNilurNL2eud3DNqqr/Bcmb26iVkUSO1Qjd0No42QYu2UcRdwPFrIwLmpFqBL7mc+SZRUe9/ryaunvIRnWpmf8nlImWIF94QCci1roJAeGw6IV/JGtvke9L7tRELKccS9uEaUhJb6qG/T4wBuT5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgHYX7umCqkuy7nxUmEcY4oQcHw+v+zpLEJy9wANxn4=;
 b=j9jqAhBwYohSQPyt3GV0P4hNa4NFE4Y+t7NPSzGsbfckkaVBOyVT0hCN2HOXFcjh3EHXKBdU21riewvxopKAA6vflS3tyPNGLU/8ugYUylxaPuU3d0toSkAS+5X6Z+n9EJErY3KPAzpjlghsvEuaHFWZZgd48leGLiz+JCSG+Yk/Qqo3ymJ3N9pjFBqqK+dWi2tbxYsE8SicN25vXiKj8jaswZiaTCRf/hqnM1tYAcR8TzZe4ztfxpinyrcGbfQnGGBsYfCX3ux42KYqjutOOf8lCdhjP1kPDSpZV3EQ+RY5VvUm0ROqV9zDwTTKtmjgGApyB+CJrwfgS6Nijoj8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 02:08:59 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 02:08:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Thread-Topic: [PATCH v1 04/22] vfio/common: Introduce
 vfio_container_add|del_section_window()
Thread-Index: AQHZ2zAehlbwdht3pk2TTCWy8hx+WrAlFOCAgAAWtICACOnxMA==
Date: Wed, 27 Sep 2023 02:08:59 +0000
Message-ID: <PH7PR11MB6722E273E32EE622608E863692C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-5-zhenzhong.duan@intel.com>
 <facf584a-e8bf-5386-8660-ac7dd3e6dde8@redhat.com>
 <SJ0PR11MB6744CFE4E7D6AB400FD8BE6D92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744CFE4E7D6AB400FD8BE6D92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|PH8PR11MB6732:EE_
x-ms-office365-filtering-correlation-id: 0d949d63-4847-444d-9dbc-08dbbefeb645
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y+LBTE7FbVcp5MHBbackh9+tqCss5pne+n/uePIXUww4eoAvwVYlY25ouKhmQ5x3S2rYrSHShzG64mEW+fslW7D1qUHo0EMi03lTdJwMD3UQNUbPcTDz5A5/Nk/WljBuUnf4I9SVItr4azs4IS6HWsJv+fCesxX9TEgL7PQ5hUdQd1o7Vy8tFk4kTyPhd6tzf0FqkLzPrgJ/qjhXyqrx8305/IlX4CH0D/X/k3XHg03S2IxFzFrL8qYlArdtRBoS7P8lRlpqIY1A797rBHpjaZJKkskPWbVWEZAiZEA+LaZM5IHErleglmtcUPiMjn093sNIi8ut6WNnEjkvBv7Vj3h8RuSqsaQgZmkpfP7QN1i92y12IIndN4jW0dEe58HfGYX5pUnlipiMp0GGDF7cgHenEO7AsvZqDIhKzJcHkPr0BtqgzvRyxQzx9xuvJb9QJBvJWPdQyVLbsyuUfDVqXIA8Lfkoul8r2Q5lGBPZdoHdmoNbsHxI1iJKQNPGf3SL7cG3UJe+rBEpCHQ2LKg6hQ/bcTCF5wJMOkUt1TqLxfYwWosTlVi/BTV+BXFcqYnlw6+YOzH5KUzfhD6+A0bGcahSshduySFQi8jkDPifdow6PUXbztbjEMvShUCyEKiI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(66556008)(8676002)(83380400001)(316002)(55016003)(107886003)(71200400001)(33656002)(9686003)(82960400001)(7696005)(6506007)(26005)(76116006)(41300700001)(38100700002)(66446008)(54906003)(64756008)(4326008)(8936002)(66476007)(66946007)(52536014)(2906002)(110136005)(86362001)(38070700005)(122000001)(478600001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0dpcjc0ZVUzd0hZUTVvbjR3ckVWcmt6ZXJlWU1XUjNrUmdaVTl4L1hPQTI0?=
 =?utf-8?B?MjVMcFZtYlBnTkt3QkludFg0TWZ2dU5LQkRNaXB0NWFYeUhLMEZWOTJPY0Ur?=
 =?utf-8?B?S2VPd3p3VVd3Vy9NRmM2QzFZOFpMY05SQWtQTldqRTBnWGV3S3ZPS3BkeVJp?=
 =?utf-8?B?Wnc3bXIxR2RLRDJTa2hHbU54T0NLd1NLL3pob0NlbW1tcWxOR1c4bWdHN3pW?=
 =?utf-8?B?QkVJMVZqYnc5cjJvajdTRWhxS0NGN1Q4d0trdnFJV1dFbmpVdWFSbGJoczcv?=
 =?utf-8?B?dHZSa0hRMkhWVER3N2QrdTV2aVA5WTloMUVTbEhXNVk1V040UjJBZkVxU0pk?=
 =?utf-8?B?QWlYUzJsalBwaU5hbzFmS29GTzVybWkyRklza1dkSEcxZTN4ZWE3ZFozMEhy?=
 =?utf-8?B?UHhid2E5Y05oTmhsdEFhSEpQSXA5c1V1TmZzMUYyQm41L25pQVVLcnA4RE4v?=
 =?utf-8?B?cTllOXBYbTBsZklscVFjRVB0b0pyVGtmc3dJODlEdkJRVWp5UC9TZm81Y2lD?=
 =?utf-8?B?dnRvL3FVb1JaYzhIa1Y1MklFa2srMm1mT0d1QkRodWUvZE5raHU0YXo3NStR?=
 =?utf-8?B?ZWZVNjlZbGlFZlNqdWVQQ1RUVHA1S1lHZnR6SU10eWNyUkZNTkxIVjd4RWVk?=
 =?utf-8?B?T2h6VllDVVB5ZVRtcDNwWFQvQUgyc2VJSFREOGxGK01pN1VtN2xjKzIwcE55?=
 =?utf-8?B?MlhlNE5NbE5xdnFtTlZaekI0OFJmWGVvSURBUy8yVVl5TEFmVDJnTHdwRGll?=
 =?utf-8?B?WnYvQW0xLzV5Zk1aSllzL1VoVllpeHB3QWY3VFlqWnQ0cVZXcm5wUjY5Tm9M?=
 =?utf-8?B?NVp2ZGF4LzNNeGlEV3hHSWxrZVZ2Y2VJcmZvRnd5VkFMMWFhRjJzUlZyQnFm?=
 =?utf-8?B?aHAwZEtNb2VoVWE1U1Zvc0NGK3hrSTNDblduTk85YlpHQ1A1dUZGUVlXS0Zu?=
 =?utf-8?B?dlpvbHkrR2lNQTR4VVN1WWthT204MjFrdHBtaEFhT0I2UTdOZklnRGdhQ3Q4?=
 =?utf-8?B?NFlLNjV0MmRpVmdJa0Zjb0FBNnZDNW92QXo5cW92c3pXZ1dDRW9lNmp0NEpR?=
 =?utf-8?B?RnBicWhheTMzeUhDSnRmUldQM096VkliZTVoSmluVTNJZUVEV25KaWJWZ3o0?=
 =?utf-8?B?ZHVhS21VcGg0Ni9mQjBVekczYnJySmhLZVU2K3VHRWN3Mk5Vbjk5czJYcjBS?=
 =?utf-8?B?bFpzMC96TnpTaEo2dkp1SEJjYlNGMzgrL0ZVKzBRSU1BWDFvY29kRW1kbmhs?=
 =?utf-8?B?ZlpEcjdRbFBwRE1wSGJEb203b3o5ZXhKWStSQXB1ejdwenhHaThNaEd0b3ZC?=
 =?utf-8?B?ZGsraE90NVNXdGhWeVE2NTZFTmVIcGYzN0dVOFplaGladDI4YytWZVBDNzNI?=
 =?utf-8?B?NzEwWWZWb1RNRjM2QXNqdG1aNS9mb1FFZGJOQmloQlF0WGtKWngvSmJXT0Fx?=
 =?utf-8?B?SVZtSzF5RWFoYUI0TkRlcjRmTHVmRUV6K3pZV3ZQMnZUVXFHcWpKeTZFUkoy?=
 =?utf-8?B?ZmR1YXo5SW1XNVh6bXJiTFRiU0wyZmNiTHQ3azc5MG42RVpNeUNKM3pCWG1E?=
 =?utf-8?B?Uk80Mnk2M0ZVUXJLMHU1S2tLT2tVbndNbkI1RDQrMkJ4dTJhQlFZS2V0ckZZ?=
 =?utf-8?B?U1paSXZqaUJ3SlZWQWh2R1NmckJCWm1HT0lzNWNWeEhJL2ZEQ2pzYlNJdnBU?=
 =?utf-8?B?b2pzOFo5bHFqSHVPOFdycVZMbFJnQ2ZFcjRFUEZLWTBmejNkcVcvaE93UVZ3?=
 =?utf-8?B?cTR4ZDRpR3I1enVhdmtYRlhzY3ZqUUZwS1hTRkJ3QWVFQUdBQ3NHT3dXWWlZ?=
 =?utf-8?B?OHdkdk1XV2VCWVo2WExKdXJyRE9qeERQQ0c5Mm1PaWtkait4L0lnUldTZVhy?=
 =?utf-8?B?cDZodW5GMlVsZ0g4cVRMcENtVW5mWmtLM1FIcHJrbjhiNFJRUzdhNGtuQ2lz?=
 =?utf-8?B?VWZxVFQ0MUY5RG8yWERRRFJ0RnlSMDNhelhodHFUbUgvamJNaVk3MklDY2JG?=
 =?utf-8?B?alRPbVg3bDBuOTdtbGpWR2ZScFh6MTdXaHlWeUhJS3Vva2dYNVo4RFc4SnpN?=
 =?utf-8?B?QWhYQnRVK0RnQW1USVFWZVJiUWdFZHVUa0VUc1kzOG5tN3I1d0Q2Y1VxNi92?=
 =?utf-8?Q?X7s+vnPlb0c8Mp5bQcNgq6X1w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d949d63-4847-444d-9dbc-08dbbefeb645
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 02:08:59.1651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxQUBfuZd1jCa9YUXwv7jsQjA6lFPAoAsyxMetXz8HbLJaoxqjWT0x2IspiSkHstsFbJvJIV8cgqhpCjxS1KJYj/E//lo+iCV29o029GuzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHVhbiwg
Wmhlbnpob25nDQo+U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA2OjE0IFBNDQo+
U3ViamVjdDogUkU6IFtQQVRDSCB2MSAwNC8yMl0gdmZpby9jb21tb246IEludHJvZHVjZQ0KPnZm
aW9fY29udGFpbmVyX2FkZHxkZWxfc2VjdGlvbl93aW5kb3coKQ0KPg0KPkhpIEPDqWRyaWMsDQo+
DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj4+U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA0
OjI5IFBNDQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMjJdIHZmaW8vY29tbW9uOiBJbnRy
b2R1Y2UNCj4+dmZpb19jb250YWluZXJfYWRkfGRlbF9zZWN0aW9uX3dpbmRvdygpDQo+Pg0KPj5I
ZWxsbyBaaGVuemhvbmcsDQo+Pg0KPj5PbiA4LzMwLzIzIDEyOjM3LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4N
Cj4+PiBJbnRyb2R1Y2UgaGVscGVyIGZ1bmN0aW9ucyB0aGF0IGlzb2xhdGUgdGhlIGNvZGUgdXNl
ZCBmb3INCj4+PiBWRklPX1NQQVBSX1RDRV92Ml9JT01NVS4gVGhpcyBjb2RlIHJlbGlhbmNlIGlz
IElPTU1VIGJhY2tlbmQNCj4+PiBzcGVjaWZpYyB3aGVyZWFzIHRoZSByZXN0IG9mIHRoZSBjb2Rl
IGluIHRoZSBjYWxsZXJzLCBpZS4NCj4+PiB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9hZGR8ZGVsIGlz
IG5vdC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4+IC0tLQ0KPj4+ICAgaHcvdmZpby9jb21tb24uYyB8IDE1NiArKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDg5IGluc2VydGlvbnMoKyksIDY3IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vY29tbW9uLmMgYi9ody92ZmlvL2NvbW1vbi5jDQo+Pj4gaW5kZXggOWNhNjk1ODM3
Zi4uNjcxNTBlNDU3NSAxMDA2NDQNCj4+PiAtLS0gYS9ody92ZmlvL2NvbW1vbi5jDQo+Pj4gKysr
IGIvaHcvdmZpby9jb21tb24uYw0KPj4+IEBAIC03OTYsNiArNzk2LDkyIEBAIHN0YXRpYyBib29s
DQo+PnZmaW9fZ2V0X3NlY3Rpb25faW92YV9yYW5nZShWRklPQ29udGFpbmVyICpjb250YWluZXIs
DQo+Pj4gICAgICAgcmV0dXJuIHRydWU7DQo+Pj4gICB9DQo+Pj4NCj4+PiArc3RhdGljIGludCB2
ZmlvX2NvbnRhaW5lcl9hZGRfc2VjdGlvbl93aW5kb3coVkZJT0NvbnRhaW5lciAqY29udGFpbmVy
LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNZW1v
cnlSZWdpb25TZWN0aW9uICpzZWN0aW9uLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+Pj4gK3sNCj4+PiArICAgIFZGSU9I
b3N0RE1BV2luZG93ICpob3N0d2luOw0KPj4+ICsgICAgaHdhZGRyIHBnc2l6ZSA9IDA7DQo+Pj4g
KyAgICBpbnQgcmV0Ow0KPj4+ICsNCj4+PiArICAgIGlmIChjb250YWluZXItPmlvbW11X3R5cGUg
IT0gVkZJT19TUEFQUl9UQ0VfdjJfSU9NTVUpIHsNCj4+PiArICAgICAgICByZXR1cm4gMDsNCj4+
PiArICAgIH0NCj4+DQo+PlRoaXMgdGVzdCBtYWtlcyBtZSB0aGluayB0aGF0IHdlIHNob3VsZCBy
ZWdpc3RlciBhIHNwZWNpZmljIGJhY2tlbmQNCj4+Zm9yIHRoZSBwc2VyaWVzIG1hY2hpbmVzLCBp
bXBsZW1lbnRpbmcgdGhlIGFkZC9kZWxfd2luZG93IGhhbmRsZXIsDQo+PnNpbmNlIG90aGVycyBk
byBub3QgbmVlZCBpdC4gQ29ycmVjdCA/DQo+DQo+WWVzLCBpbnRyb2R1Y2luZyBhIHNwZWNpZmlj
IGJhY2tlbmQgY291bGQgaGVscCByZW1vdmluZyBhYm92ZSBjaGVjay4NCj5CdXQgZWFjaCBiYWNr
ZW5kIGhhcyBhIFZGSU9JT01NVUJhY2tlbmRPcHMsIHdlIG5lZWQgc2FtZSBjaGVjaw0KPmFzIGFi
b3ZlIHRvIHNlbGVjdCBPcHMuDQo+DQo+Pg0KPj5JdCB3b3VsZCBhdm9pZCB0aGlzIHVnbHkgdGVz
dC4gTGV0J3Mga2VlcCB0aGF0IGluIG1pbmQgd2hlbiB0aGUNCj4+YmFja2VuZHMgYXJlIGludHJv
ZHVjZWQuDQo+Pg0KPj4+ICsNCj4+PiArICAgIC8qIEZvciBub3cgaW50ZXJzZWN0aW9ucyBhcmUg
bm90IGFsbG93ZWQsIHdlIG1heSByZWxheCB0aGlzIGxhdGVyICovDQo+Pj4gKyAgICBRTElTVF9G
T1JFQUNIKGhvc3R3aW4sICZjb250YWluZXItPmhvc3R3aW5fbGlzdCwgaG9zdHdpbl9uZXh0KSB7
DQo+Pj4gKyAgICAgICAgaWYgKHJhbmdlc19vdmVybGFwKGhvc3R3aW4tPm1pbl9pb3ZhLA0KPj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBob3N0d2luLT5tYXhfaW92YSAtIGhvc3R3aW4t
Pm1pbl9pb3ZhICsgMSwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VjdGlvbi0+
b2Zmc2V0X3dpdGhpbl9hZGRyZXNzX3NwYWNlLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQxMjhfZ2V0NjQoc2VjdGlvbi0+c2l6ZSkpKSB7DQo+Pj4gKyAgICAgICAgICAgIGVy
cm9yX3NldGcoZXJycCwNCj4+PiArICAgICAgICAgICAgICAgICJyZWdpb24gWzB4JSJQUkl4NjQi
LDB4JSJQUkl4NjQiXSBvdmVybGFwcyB3aXRoIGV4aXN0aW5nIg0KPj4+ICsgICAgICAgICAgICAg
ICAgImhvc3QgRE1BIHdpbmRvdyBbMHglIlBSSXg2NCIsMHglIlBSSXg2NCJdIiwNCj4+PiArICAg
ICAgICAgICAgICAgIHNlY3Rpb24tPm9mZnNldF93aXRoaW5fYWRkcmVzc19zcGFjZSwNCj4+PiAr
ICAgICAgICAgICAgICAgIHNlY3Rpb24tPm9mZnNldF93aXRoaW5fYWRkcmVzc19zcGFjZSArDQo+
Pj4gKyAgICAgICAgICAgICAgICAgICAgaW50MTI4X2dldDY0KHNlY3Rpb24tPnNpemUpIC0gMSwN
Cj4+PiArICAgICAgICAgICAgICAgIGhvc3R3aW4tPm1pbl9pb3ZhLCBob3N0d2luLT5tYXhfaW92
YSk7DQo+Pj4gKyAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4+ICsgICAgICAgIH0NCj4+
PiArICAgIH0NCj4+PiArDQo+Pj4gKyAgICByZXQgPSB2ZmlvX3NwYXByX2NyZWF0ZV93aW5kb3co
Y29udGFpbmVyLCBzZWN0aW9uLCAmcGdzaXplKTsNCj4+PiArICAgIGlmIChyZXQpIHsNCj4+PiAr
ICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsICJGYWlsZWQgdG8gY3JlYXRlIFNQ
QVBSIHdpbmRvdyIpOw0KPj4+ICsgICAgICAgIHJldHVybiByZXQ7DQo+Pj4gKyAgICB9DQo+Pj4g
Kw0KPj4+ICsgICAgdmZpb19ob3N0X3dpbl9hZGQoY29udGFpbmVyLCBzZWN0aW9uLT5vZmZzZXRf
d2l0aGluX2FkZHJlc3Nfc3BhY2UsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICBzZWN0aW9u
LT5vZmZzZXRfd2l0aGluX2FkZHJlc3Nfc3BhY2UgKw0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgaW50MTI4X2dldDY0KHNlY3Rpb24tPnNpemUpIC0gMSwgcGdzaXplKTsNCj4+PiArI2lmZGVm
IENPTkZJR19LVk0NCj4+DQo+PnRoZSBpZmRlZiB0ZXN0IGRvZXNuJ3Qgc2VlbSB1c2VmdWwgYmVj
YXVzZSB0aGUgY29tcGlsZXIgc2hvdWxkIGNvbXBpbGUNCj4+b3V0IHRoZSBzZWN0aW9uIGJlbG93
IHNpbmNlLCBpbiB0aGF0IGNhc2UsIGt2bV9lbmFibGVkKCkgaXMgZGVmaW5lZCBhcyA6DQo+Pg0K
Pj4gICAjZGVmaW5lIGt2bV9lbmFibGVkKCkgICAgICAgICAgICgwKQ0KPg0KPkxvb2tzIHNvLCBJ
J2xsIHJlbW92ZSBpdCBpbiB2Mi4NCg0KRm9yZ290IHRvIGxldCB5b3Uga25vdywgZmluYWxseSBJ
IGZhaWxlZCB0byByZW1vdmUgdGhlIGlmZGVmIHRlc3QgaW4gdjIgZHVlIHRvDQptYW55ICJ1bmRl
Y2xhcmVkIiBjb21waWxlIGVycm9ycy4gSSBndWVzcyB0aGUgcmVhc29uIGlzIGdyYW1tYXRpY2Fs
IGNoZWNrDQpJcyB0cmlnZ2VyZWQgYmVmb3JlIG9wdGltaXphdGlvbiBpbiBjb21waWxlci4NCg0K
Rm9yIGV4YW1wbGU6DQplcnJvcjog4oCYS1ZNX0RFVl9WRklPX0dST1VQ4oCZIHVuZGVjbGFyZWQN
CmVycm9yOiDigJh2ZmlvX2t2bV9kZXZpY2VfZmTigJkgdW5kZWNsYXJlZA0KLi4uDQoNClRoYW5r
cw0KWmhlbnpob25nDQo=

