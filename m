Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8909872F96B
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 11:40:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Mxz-0003e5-Tr; Wed, 14 Jun 2023 05:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9Mxw-0003dg-Vi
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 05:39:00 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9Mxu-0007nw-L5
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 05:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686735538; x=1718271538;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Axd64haXdAoCKC7kSQhQU6+0uPL7Kgm3ZJ0wVol8OdE=;
 b=mEa3Zu6XBodyg6pRzoAzTljFi6He3sV9wABrQD4JCFsvCl1iA4ba5ciE
 mctm/TCl2wp90HUwDEuc1z3xbyHBHEwtkYpRqDhKDpzPVZTxO457KcQPY
 tHlnBdNmh+em3K1mRhfT6S4kJPUNH8zh8PuBIs1tTDjvRa7UpsLJqcPu9
 k+WGkJEKPN8QLJ+R7G3FAOOTHyZE8Fvs0rhcgxcXyGDhE7DPCg5o5WqpN
 KKEZ12sKQma8R1eYywQ66rxFeJczf2ARr43/L7fxtOL1gBcyqUBmkgF3b
 lYQLjIYUoyIi6bodWAMvG+tS2vWT2rQElZcTeyPskrnaFkzjSOHayfp+a g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="338920942"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; d="scan'208";a="338920942"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 02:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="1042126360"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; d="scan'208";a="1042126360"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2023 02:38:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 02:38:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 02:38:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 02:38:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp9+WSwCPg2CodbmKeD9fQR//Gg7immmw2UzKqO/nByYvQHIWhA+by5iV9cEaN6I/M6O03kDXszpxOqB4XUZoLMt6KhvWviT4Wv88rOIRvQKT7f2+bd45dyC62/hM1o5Btu924xxdlEXmf1ez/Bql5gfL2OW56T256j4Ns16rKRCwJQ6pt0hGNEP4V66GFTLVIdf2fhnVA6eIGD+6+Hig4Pi2R/pvtEC2p/+7JlEj7GsLQn1+kbOCziDMZ+R2ega7cbDZJbB+6vcVan7X5hHitx7CFrTUCfMDsa376WJCNtFrhVa5bIshwqaBzROPNKDRn5pJaGUX7ldF7xEjw9Z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axd64haXdAoCKC7kSQhQU6+0uPL7Kgm3ZJ0wVol8OdE=;
 b=abc9/QkzWiKa+OZf+wImhhy240tf1KHx95pfhmuOff26IljVDyep6VrWWIqX/Jy019iPUrmSd+G8WD1pNH5DB9e/z2ZLfr9g7artKR7ZlX0QyWthcoc93Pwu/VDv1IuaihP4Z+8VLWFv2dh5KnHz0rkAzNSbKQB/FWpWmdCxlxf2Gn2OrGiXWfvyShhm33ZR346XRRVAA384ZZcSKajZt9FT2tF/z9fFWzR1rwykIoeXHnEDjrZ0G6SNwguyPJSmGbmBwx+MRRsxM+P9JcUoOd9HE0SDZ+vvRZuagGgilDWlDRiUNJcCZn6eDcHmk2kVlvhd6wT9SYdt0o0Vk8AfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 09:38:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 09:38:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Topic: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Index: AQHZmfDNwmLmlvy/GkmXR1XRJDGDhq+BXVuAgAB4mHCAAGFdYA==
Date: Wed, 14 Jun 2023 09:38:41 +0000
Message-ID: <SJ0PR11MB674410E7D30E10736AB90BA8925AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com> <ZII7UyaKrArIM5Qg@x1n>
 <SJ0PR11MB6744CBC59B0BE971EE24D3799251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744CBC59B0BE971EE24D3799251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8443:EE_
x-ms-office365-filtering-correlation-id: 9f8f78fe-3d0f-447c-5062-08db6cbb237d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oW7loIn0eBYcm8+zvrLZaDMbwGa83UI+pUcGLqOTB6SMn6uK6kbWpP0uoqnvsW9i9qRg9J7Xs8BhXqoERdYT8gDxlUogOLxKu2LpKlDJwb/Ib0KbhVH8oN86SwROsUdpT8gEwaZq45yXu0ceniCAeIO64vzKq7HvO5giYo1lj2uGMI8V2coFgA/HGOC7xDmQiB2gTuV3e4989i2cqxlM7e5s0k08aXAUwb6DzEfTfKqYsgpuSG6/Lm3L97HWIvDdTP0iRjhvJPK319r6Z+4TfQpxW0SYPRWxHDJKuf5xZ/FH1yKGx+ay4vp6JTx3bJxMVO4NlcY7Omv5Jad4AiXRd4DiwU3VblGjNFfFbCf+bBhfMCmKfGGVzP/YS/kTpEDsRRbiSwsHnGcNZm7fsgizdvi+dS9BTj5W/6jLbTWTN25FgYjdNF4WDVkPPNRJs8/9NgKzKJREI5UAEVUUzylTbj5fgbhUJWRIX9jKXoKHWi1PwpY/bKPaOodchPf/hGvbHw0oKDkWrTp+gYQP3LTvxsvgtPoD9jlySFfGEkgS/QU2yK/wI49XTKGKemQbwfa7Vhwjf5XTCvxrD1b+yX03vyrOsPqLE3flSO1XUpdWWCnQ6T0P2W7pDFNXZmoqhiQa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(6916009)(66946007)(4326008)(76116006)(66446008)(66556008)(64756008)(186003)(54906003)(478600001)(2906002)(66476007)(8676002)(316002)(41300700001)(107886003)(86362001)(7696005)(7416002)(6506007)(52536014)(33656002)(8936002)(38070700005)(71200400001)(122000001)(9686003)(83380400001)(82960400001)(26005)(5660300002)(38100700002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWZoOTY1VkV3Sm40UVdkMGs2SVlrekt1VERuZTlVLzdZV1dNU0piTTVkSXQ2?=
 =?utf-8?B?TFFnQWVBTkxRaFQ0YkY3R1dab1hFWTcvck5hUThORHZIa2VQY1dqQlUrWmdN?=
 =?utf-8?B?T2VpQmJQZktaYTBvS1JDUDNpVlFLdjQ1QVpETWNJZ3BFYVRWTlJSSmg2WXl3?=
 =?utf-8?B?VnRhZllJN20wTWNkbkljR0RDcGtBZHJxbm42Y3U5VTFxRVI1RXJkcEJMNytv?=
 =?utf-8?B?UWRlTmcvUFpwMVVGWHVQUDZmRkhBZUJnR1VZVDZRZ0JsdnlOdWQ2Z1J0WlZm?=
 =?utf-8?B?YTUyQ2Rwb3padWVYMkpTMDdFcnk4Y29QTjltMU1za1ZnUTNZZlcvc3d2eXhJ?=
 =?utf-8?B?VVo0RHJxV2RIT1BIT0o5c0xacU1mNHJLQWMrS1NBZFUzdVJFaE9OY1AwaElL?=
 =?utf-8?B?ZEZmL1hRM1RkTVo2eDdtazJsd1pheU1BMUlFQ3pQMkZmZUF6YUk1MFhtUVpa?=
 =?utf-8?B?Y2RrUXdNdGd1cFpQL3drN1VOakpYa2pqbHJjdXV6b1FWblFPTXVrVUNjdFN2?=
 =?utf-8?B?c2dXa1gzRUZRbjcyTlNIN3VFczNDeTR6bW1aKzNrYnVxRmhBWDIvZEYwOVJR?=
 =?utf-8?B?RlZQa2FZRE1nUHl1TFdZb3BLVTRmTGdoM1A2OVZnUTdXMXlwaVFEUUI5R3ZP?=
 =?utf-8?B?Nkw5UXA0SmZNTmFOamRrZ0hpZHR2aVRiSktPV2VqcG9reUxaeUNjQk12aWtj?=
 =?utf-8?B?bHhCdTdmeEhGbmdSSGZ4U3FHZDhFWlNFcVFxMEIwbnhGM2RoQmxNZ1R4MFJH?=
 =?utf-8?B?djBtS0Fqc3ViOFRyZDNTS3YzVGlQVUw0clhLUlNIR1VkMHhaNTJaTHRJNzhM?=
 =?utf-8?B?UEJ1MjF0eUYzeFJpTTRlanNBb01MempRbHhVcE9NSGc4MlZ1amhsbm1SOEpq?=
 =?utf-8?B?dUJZdTdFbG15UHJNRlNydllZYUpqbHpJS29wNXhWaCtScFEvcmRvRmJlN0ZL?=
 =?utf-8?B?MUhDTnZKRUVOVnNBRGlMR253c3NtRG51SEhIYTM4MmRVcTJVUVBpMlVsSmJC?=
 =?utf-8?B?WFdrTm9qT2FEZGNvY05idHFKRFJsL3hhNW5paXFtUktleVJCK2drb0dobjE1?=
 =?utf-8?B?cWtrc003c2RHem5TRTZZaldPSm9jdkd2N3RNVEV5ai8yRUVNSTdxb2s0bDdN?=
 =?utf-8?B?bnVNOUxKdzFJNGlOdk92UGIzeU1YVWVmRzcxVy9xRm0yTUVPZmxIK1RQZjdy?=
 =?utf-8?B?RkVZd3FkYnFvLzgybWtjMmZNTWNWWVFqUVNPYkRvRnd5U1NKeFlNa283MTN4?=
 =?utf-8?B?TS9PZ2JuSWZlL2tDZWIvekdKTHVJdFJFc1UrZk9yeTU3Y0VBWEFEQy9ZcHZE?=
 =?utf-8?B?NGVaRS8rMnE2NE1PL2Z2WTZzdTJ4ck9mQStWTGI5c3FuTWZUYXkxeDBzV05R?=
 =?utf-8?B?ZUxYUU9rc1RPbG9RUnlrVXpHT2hkQVJOT09VTlFlazhkakV3YWFmcHNwczNk?=
 =?utf-8?B?bmtVdjFwWU9mS3BJOWVNaTVlcDhTeG9KRWRDTDhHaW45YVlnZ09TNmNyaS90?=
 =?utf-8?B?ZGoxSW51ME5EMjNieVRkb3VMaEMrSnpGWGFnUTBpOENieGtQM2Y5enk2bmY4?=
 =?utf-8?B?UXZqWjFwajRobjBSZGw5MUgwVDRiMExpU3FaWTIwc1JyRXIzelVlSUtmMncr?=
 =?utf-8?B?V2dwUlQrcGRCSXNqeGMrTnMzY2wyTnEvVUU2YmhrNzNjU1Vybk8vMTdUSFFJ?=
 =?utf-8?B?RXVLMDA2NlZaU2FnbG9rRFd1Z0t0MU91VitGSzZBbEpkTk9uVkxRbkc2WTRY?=
 =?utf-8?B?L28waWt1bDZST2wrU3VPZ3l6cEN2eEF4Wmt3RGt3aVdMZzNnNm5OSDA1WW80?=
 =?utf-8?B?cGZodTRsOE9oV0FJYmF3VkxXM2w3anlVbk93Y1drUE5OcXZvM1VGYnhvNEp6?=
 =?utf-8?B?ZmltZ05VV1lRRHBzM2FDWjVrcThxazZDZSttSWdtTnpwQlhzZW5mMnpvRVRo?=
 =?utf-8?B?Z2pQOHBWWUcyRXEwTUpORy9hT3dLK2doMkhzeEpYclowellCWGFUYlJRSTZC?=
 =?utf-8?B?SHVZOUJWN3VEMHZBY2J2SUNid1RocGpOODIyYWVXRU9vUnp1Tm5oQndZM09v?=
 =?utf-8?B?Z24yOGJGUFdlK0pScmxvbDJEYkRzRS9lRVhqaTdPdUlTWG9hT052UGpJUWht?=
 =?utf-8?Q?6aulp6wertVdxQMaVyVi2CsPR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8f78fe-3d0f-447c-5062-08db6cbb237d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 09:38:41.3032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Azkvb6cCCa1+9XJAOLtipezCaesi52k+nt1AY1FJyq68C2H4jt2eR7zTH5OcOROspE8FDGjgh4Jgr6T8AvFEQG+fukMNJGM4mZ+QOxonAts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mga17.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHVhbiwgWmhlbnpob25nDQo+U2Vu
dDogRnJpZGF5LCBKdW5lIDksIDIwMjMgMTI6MDIgUE0NCj5UbzogUGV0ZXIgWHUgPHBldGVyeEBy
ZWRoYXQuY29tPg0KPkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBq
YXNvd2FuZ0ByZWRoYXQuY29tOw0KPnBib256aW5pQHJlZGhhdC5jb207IHJpY2hhcmQuaGVuZGVy
c29uQGxpbmFyby5vcmc7IGVkdWFyZG9AaGFia29zdC5uZXQ7DQo+bWFyY2VsLmFwZmVsYmF1bUBn
bWFpbC5jb207IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOw0KPmNsZ0ByZWRoYXQuY29tOyBk
YXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGluYXJvLm9yZzsNCj5rd2Fua2hlZGVAbnZpZGlhLmNv
bTsgY2ppYUBudmlkaWEuY29tOyBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcs
DQo+Q2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+U3ViamVjdDogUkU6IFtQQVRDSCB2
MyA1LzVdIGludGVsX2lvbW11OiBPcHRpbWl6ZSBvdXQgc29tZSB1bm5lY2Vzc2FyeQ0KPlVOTUFQ
IGNhbGxzDQo+DQo+DQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IFBl
dGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4+U2VudDogRnJpZGF5LCBKdW5lIDksIDIwMjMg
NDozNCBBTQ0KPj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+PkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0By
ZWRoYXQuY29tOw0KPj5wYm9uemluaUByZWRoYXQuY29tOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnOw0KPmVkdWFyZG9AaGFia29zdC5uZXQ7DQo+Pm1hcmNlbC5hcGZlbGJhdW1AZ21haWwu
Y29tOyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsNCj5jbGdAcmVkaGF0LmNvbTsNCj4+ZGF2
aWRAcmVkaGF0LmNvbTsgcGhpbG1kQGxpbmFyby5vcmc7IGt3YW5raGVkZUBudmlkaWEuY29tOw0K
Pj5jamlhQG52aWRpYS5jb207IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPjsgUGVuZywg
Q2hhbyBQDQo+PjxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgNS81XSBpbnRlbF9pb21tdTogT3B0aW1pemUgb3V0IHNvbWUgdW5uZWNlc3NhcnkNCj4+VU5N
QVAgY2FsbHMNCj4+DQo+Pk9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDA1OjUyOjMxUE0gKzA4MDAs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+ICAgICAgd2hpbGUgKHJlbWFpbiA+PSBWVERfUEFH
RV9TSVpFKSB7DQo+Pj4gLSAgICAgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCj4+PiAgICAgICAg
ICB1aW50NjRfdCBtYXNrID0gZG1hX2FsaWduZWRfcG93Ml9tYXNrKHN0YXJ0LCBlbmQsIHMtPmF3
X2JpdHMpOw0KPj4+ICAgICAgICAgIHVpbnQ2NF90IHNpemUgPSBtYXNrICsgMTsNCj4+Pg0KPj4+
ICAgICAgICAgIGFzc2VydChzaXplKTsNCj4+Pg0KPj4+IC0gICAgICAgIGV2ZW50LnR5cGUgPSBJ
T01NVV9OT1RJRklFUl9VTk1BUDsNCj4+PiAtICAgICAgICBldmVudC5lbnRyeS5pb3ZhID0gc3Rh
cnQ7DQo+Pj4gLSAgICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gbWFzazsNCj4+PiAtICAg
ICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+Pj4g
LSAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+Pj4gLSAgICAgICAgLyog
VGhpcyBmaWVsZCBpcyBtZWFuaW5nbGVzcyBmb3IgdW5tYXAgKi8NCj4+PiAtICAgICAgICBldmVu
dC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPj4+IC0NCj4+PiAtICAgICAgICBtZW1vcnlf
cmVnaW9uX25vdGlmeV9pb21tdV9vbmUobiwgJmV2ZW50KTsNCj4+PiArICAgICAgICBtYXAuaW92
YSA9IHN0YXJ0Ow0KPj4+ICsgICAgICAgIG1hcC5zaXplID0gbWFzazsNCj4+PiArICAgICAgICBp
ZiAoaW92YV90cmVlX2ZpbmQoYXMtPmlvdmFfdHJlZSwgJm1hcCkpIHsNCj4+PiArICAgICAgICAg
ICAgZXZlbnQuZW50cnkuaW92YSA9IHN0YXJ0Ow0KPj4+ICsgICAgICAgICAgICBldmVudC5lbnRy
eS5hZGRyX21hc2sgPSBtYXNrOw0KPj4+ICsgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlm
eV9pb21tdV9vbmUobiwgJmV2ZW50KTsNCj4+PiArICAgICAgICB9DQo+Pg0KPj5BaCBvbmUgbW9y
ZSB0aGluZzogSSB0aGluayB0aGlzIHBhdGggY2FuIGFsc28gYmUgdHJpZ2dlcmVkIGJ5IG5vdGlm
aWVycw0KPj53aXRob3V0IE1BUCBldmVudCByZWdpc3RlcmVkLCB3aG9zZSBpb3ZhIHRyZWUgd2ls
bCBhbHdheXMgYmUgZW1wdHkuICBTbw0KPj53ZSBtYXkgb25seSBkbyB0aGlzIGZvciBNQVAsIHRo
ZW4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgaXQnbGwgYmUgd29ydGh3aGlsZS4uDQo+DQo+SG1tLCB5
ZXMsIG15IGNoYW5nZSB3aWxsIGxlYWQgdG8gdmhvc3QgbWlzc2VkIHRvIHJlY2VpdmUgc29tZSBp
bnZhbGlkYXRpb24NCj5yZXF1ZXN0IGluIGRldmljZS10bGIgZGlzYWJsZWQgY2FzZSBhcyBpb3Zh
IHRyZWUgaXMgZW1wdHkuIFRoYW5rcyBmb3IgcG9pbnQgb3V0Lg0KPg0KPkxldCBtZSBjb2xsZWN0
IHRpbWUgZGlmZiBzcGVudCBpbiB1bm1hcCBBUyBmb3IgeW91IHRvIGRlY2lkZSBpZiBpdCBzdGls
bCB3b3J0aCBvcg0KPm5vdC4NCkkgdXNlZCBiZWxvdyBjaGFuZ2VzIHRvIGNvbGxlY3QgdGltZSBz
cGVudDoNCg0KQEAgLTM3MzksMTIgKzM3MzksMTQgQEAgVlREQWRkcmVzc1NwYWNlICp2dGRfZmlu
ZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCiAvKiBVbm1hcCB0aGUg
d2hvbGUgcmFuZ2UgaW4gdGhlIG5vdGlmaWVyJ3Mgc2NvcGUuICovDQogc3RhdGljIHZvaWQgdnRk
X2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywgSU9NTVVOb3RpZmllciAq
bikNCiB7DQorICAgIGludDY0X3Qgc3RhcnRfdHYsIGRlbHRhX3R2Ow0KICAgICBod2FkZHIgc2l6
ZSwgcmVtYWluOw0KICAgICBod2FkZHIgc3RhcnQgPSBuLT5zdGFydDsNCiAgICAgaHdhZGRyIGVu
ZCA9IG4tPmVuZDsNCiAgICAgSW50ZWxJT01NVVN0YXRlICpzID0gYXMtPmlvbW11X3N0YXRlOw0K
ICAgICBETUFNYXAgbWFwOw0KDQorICAgIHN0YXJ0X3R2ID0gcWVtdV9jbG9ja19nZXRfdXMoUUVN
VV9DTE9DS19SRUFMVElNRSk7DQogICAgIC8qDQogICAgICAqIE5vdGU6IGFsbCB0aGUgY29kZXMg
aW4gdGhpcyBmdW5jdGlvbiBoYXMgYSBhc3N1bXB0aW9uIHRoYXQgSU9WQQ0KICAgICAgKiBiaXRz
IGFyZSBubyBtb3JlIHRoYW4gVlREX01HQVcgYml0cyAod2hpY2ggaXMgcmVzdHJpY3RlZCBieQ0K
QEAgLTM3OTMsNiArMzc5NSw5IEBAIHN0YXRpYyB2b2lkIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFw
KFZUREFkZHJlc3NTcGFjZSAqYXMsIElPTU1VTm90aWZpZXIgKm4pDQogICAgIG1hcC5pb3ZhID0g
bi0+c3RhcnQ7DQogICAgIG1hcC5zaXplID0gc2l6ZTsNCiAgICAgaW92YV90cmVlX3JlbW92ZShh
cy0+aW92YV90cmVlLCBtYXApOw0KKw0KKyAgICBkZWx0YV90diA9IHFlbXVfY2xvY2tfZ2V0X3Vz
KFFFTVVfQ0xPQ0tfUkVBTFRJTUUpIC0gc3RhcnRfdHY7DQorICAgIHByaW50ZigiKioqKioqKioq
KioqIGRlbHRhX3R2ICVsdSB1cyAqKioqKioqKioqKioqKlxuIiwgZGVsdGFfdHYpOw0KIH0NCg0K
V2l0aCBsZWdhY3kgY29udGFpbmVyKHZmaW8tcGNpLGhvc3Q9ODE6MTEuMSxpZD12ZmlvMSxidXM9
cm9vdDEpDQpIb3RwbHVnOg0KKioqKioqKioqKioqIGRlbHRhX3R2IDEyIHVzICoqKioqKioqKioq
KioqDQoqKioqKioqKioqKiogZGVsdGFfdHYgOCB1cyAqKioqKioqKioqKioqKg0KVW5wbHVnOg0K
KioqKioqKioqKioqIGRlbHRhX3R2IDEyIHVzICoqKioqKioqKioqKioqDQoqKioqKioqKioqKiog
ZGVsdGFfdHYgMyB1cyAqKioqKioqKioqKioqKg0KDQpBZnRlciBmaXg6DQpIb3RwbHVnOiBlbXB0
eQ0KVW5wbHVnOg0KKioqKioqKioqKioqIGRlbHRhX3R2IDIgdXMgKioqKioqKioqKioqKioNCioq
KioqKioqKioqKiBkZWx0YV90diAxIHVzICoqKioqKioqKioqKioqDQoNCldpdGggaW9tbXVmZCBj
b250YWluZXIodmZpby1wY2ksaG9zdD04MToxMS4xLGlkPXZmaW8xLGJ1cz1yb290MSxpb21tdWZk
PWlvbW11ZmQwKQ0KSG90cGx1ZzoNCioqKioqKioqKioqKiBkZWx0YV90diAyNSB1cyAqKioqKioq
KioqKioqKg0KKioqKioqKioqKioqIGRlbHRhX3R2IDIzIHVzICoqKioqKioqKioqKioqIA0KVW5w
bHVnOg0KKioqKioqKioqKioqIGRlbHRhX3R2IDE1IHVzICoqKioqKioqKioqKioqDQoqKioqKioq
KioqKiogZGVsdGFfdHYgNSB1cyAqKioqKioqKioqKioqKg0KDQpBZnRlciBmaXg6DQpIb3RwbHVn
OiBlbXB0eQ0KVW5wbHVnOg0KKioqKioqKioqKioqIGRlbHRhX3R2IDIgdXMgKioqKioqKioqKioq
KioNCioqKioqKioqKioqKiBkZWx0YV90diAxIHVzICoqKioqKioqKioqKioqDQoNCkl0IGxvb2tz
IHRoZSBiZW5lZml0IG9mIHRoaXMgcGF0Y2ggaXMgbmVnbGlnaWJsZSBmb3IgbGVnYWN5IGNvbnRh
aW5lciBhbmQgaW9tbXVmZC4NCkknZCBsaWtlIHRvIGRyb3AgdGhpcyBwYXRjaCBhcyBpdCBtYWtl
cyBubyBkaWZmZXJlbmNlLCB5b3VyIG9waW5pb24/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

