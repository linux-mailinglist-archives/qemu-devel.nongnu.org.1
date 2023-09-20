Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B17327A7116
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 05:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qio6n-0002jY-8R; Tue, 19 Sep 2023 23:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qio6k-0002jB-Hm
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 23:42:34 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qio6e-0007i8-BE
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 23:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695181348; x=1726717348;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uBWbaPjaqrjdMVUujj/LE/PW6jYbqfq+6nIh7c1EZDg=;
 b=MVXjloFHHTXdq69ZPEO1joSHBDheN9AouFuhUEXOQWtvz0fU0QcdMAAe
 pDg4TwT/sirAtWiM5cPxNa7ElR1PiP8PwhnZgtlfwobp3cwZgbnTmO8Vx
 OK83IIuGd0i5WQqNOb5+ZcS6zxdFy7QwAGVQLCsFcb8y8MeFLRf39dwWg
 z1dop7zOaCmOadhc/nfuwP6NmAdAOTq3fu7VNaGT8f1uozkBrbRAiHIxg
 pCqLvmKgbCWytRK2kDOwrVtFJhzvp8iQVNKejmedblAcNRjYhqja5TClm
 ERKjPS7VKC1wXLshSuJpzggljXlDM5+79df3mGXNJyFxyuNVVLL59aq2S Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="382862400"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; d="scan'208";a="382862400"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 20:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749732128"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; d="scan'208";a="749732128"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Sep 2023 20:42:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 20:42:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 20:42:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 20:42:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 20:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0isj01TPPQOPkfK9rl4qr5nhlzQX26b1Qt2JOUdbBlnTA1t1twFOZJEsfIOJ9nOFpoQKFGs1dXWNLMj/KU6k7G2NNLjhtEvMGn9hVZoYjP1tXeViLTvMgu7cJGTQCxUWZkPATG6vsAMBoOy2IBBj/HxHraVVW9f7a1L3rm1iuKjm/fooce7k6VcoYdyrPxvhi5Z6OoDGO9n2MtnxqlRGFGLCPHBkY4cHkC9TNnhqDyUJkF33FCg6cUYRJEIxqn2+an1GUe2Df5w4m5qBmRCGGOF0WIrv0mnzS9OTMZnXN/WfXr6wqBChB9QHsl4XwMARQfwXY+xCMt8L++QYc5VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBWbaPjaqrjdMVUujj/LE/PW6jYbqfq+6nIh7c1EZDg=;
 b=ZEOVfIczvbLA4+aDd0v9OUtU+x8Dk+Fphx8NuGzI2PeWZHgCxAen6lx6Mm3OI/+fW3AUx+u/t47+qe4A9wJ1NEhFk37I9Z8MEDC5duThBNOVbjNCA1GUHf9SEOyr7qDcq++1+FIDPfBZvECj+DZi73dazP4S2eYVj34nqzCeRboZulqpouD6hNiFyYlazyWtbMZWaEM4IVnYTTtoYlri9D11sMm1Dj2rp884XIghIh/GnlqDxaTQIARoaC/zWCuWkmnQR8RIt+EFYPoIUX3kUheccz1ymqQGXlueUEd+HJCL+Ey3Tq7bYcarZromWB64BFBCb+EcHtWmJwb/Rdz+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7214.namprd11.prod.outlook.com (2603:10b6:8:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 03:42:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 03:42:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [PATCH v1 15/22] Add iommufd configure option
Thread-Topic: [PATCH v1 15/22] Add iommufd configure option
Thread-Index: AQHZ2zBBz9BBn8bZBkKAV/2bA/8zjLAigTGAgACtoLA=
Date: Wed, 20 Sep 2023 03:42:20 +0000
Message-ID: <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
In-Reply-To: <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7214:EE_
x-ms-office365-filtering-correlation-id: ccb05b7b-8f8f-4e72-7c4a-08dbb98b9831
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dde99m6Fq09DuagYCMRP9pvakoIJZnvbY2jzCEN9U8l6c5k271CBOltTjhhZWCaaA3nZdKua43ecxgGQ6rwIvPApAZAHtUrYvwwgxsxnzu7tQIDf844nzD2k0qbNrDSGPTPQ28awZkcIUNcTWPc8iVTZSQJJJTtrAyJ6dThOXp9ZwuAOIh+i6boeL4l0o/MGQolXMIpjgqCPSOBmjloJFPIfZuEe+55r9AkUWJFXmc6x0EJIxrLmVJ+q4Krc1jX++7Uj4PCixxCzm8cRj7MhPFXKJAKOed5sSeFFCua6bOMxYc+7nZJT1opJg76KGPJdFBvT0K2ncFFTP+tFJVNXU3mk20Yi5j4BZazuS3cuxFQKeY8wUWcoxq6hMMAyK3MlmS8f7yOXgA6N/lS7UR/0tNuF38WU+HbydAW3fv8Lh8nyTnXImnU675o9zA5AxFA16fCmK53cWeT6VehKxKr1ATRWtjOin266uFzagema2SC4oisDG2dDEazdptuVWeAvDnPBTZvGWzHpFM0VVNFbVHo9BVx0JyDda4y8SwA7B7LDcMAxrBuOxrYd33brkvwt0xmPYYF5qg5gPLKMQCqXcW3at7jTR5695nn52ratAG6cU9BKDQGFQO0SrrWgzy/j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(1800799009)(186009)(451199024)(7416002)(2906002)(4744005)(33656002)(86362001)(55016003)(38070700005)(82960400001)(38100700002)(122000001)(54906003)(316002)(9686003)(64756008)(110136005)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(8676002)(8936002)(4326008)(71200400001)(7696005)(6506007)(83380400001)(478600001)(5660300002)(52536014)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0ZZcittZFVDZ2wzWFRybUdkTGkzU24xMzhXY2VrNlN5b3o3OEF0MGRlR1FM?=
 =?utf-8?B?T3lUOU50Z2cra2tGNnYxTms4bERYU24xMkhpR2IxUG1wWUNNbE9zeGxrYkht?=
 =?utf-8?B?dGRVendvTUlsU2RZazFVdEd2TnZWbUpaN1h1UStwa0x5QTlpcXFYc2xkYnRO?=
 =?utf-8?B?YXZMVDErdCtzUkdYdldOOWxTdE1DSTdHMkJucWtoSTJIQXlRVG5nV3JYVkpX?=
 =?utf-8?B?c3dVYWFnQlpMQkFFMnBhY3VERC9NZmFlNVprZmV5OTVFVzVFNmE3eGEyY3Fo?=
 =?utf-8?B?YTJZZFlFTHpjSmE4di81RldhdGFMSk9FWEtKMkwxTmdrRWNkYXdndStkRmJI?=
 =?utf-8?B?bVlEWlF2Y3Z1NjBDYjBtZkJuT1o2bjFlamdzdnIwZ3l4VE9sdDFXNkFaZnpH?=
 =?utf-8?B?akw2YXIxVFRFWHkyWVJHbDYyc21jNExHZlRHMjBZSEZMM01EcmV0VjAyeWVZ?=
 =?utf-8?B?SE1pTEU0R0VaZ0ZiSW5JcmJTZERVdktwZnYrUkRyVjk5Y3FRY3hGYkx5cVB3?=
 =?utf-8?B?em5aRXVnK0hxdDVLMnc2d0ZPTWw4SUMyTUZKQXBLblQ4MmJXWlpzcFRtc0w5?=
 =?utf-8?B?Z1RSMFFDTzl0QSsyS2d0MnNYNStLd2tNcmRyZ25CYU5zYTRGdnJvdXVaQksw?=
 =?utf-8?B?ZFJPNWh5UlMyMENHbXljSnRVRC9LTTJlZDFEYUFWbGI3UDFFQjA0dUF3aUxv?=
 =?utf-8?B?M01yQzN4N1IyY3BXZGY0TkFSY0dNOFdISHdRZlVOc1lUMS9KZ0tlZlZWWkho?=
 =?utf-8?B?ekhVLzd0ejNlSE9NOTFqcmhyV0tDSzNsOTIxRE5OR2pVYldZaTlleS9UOEdp?=
 =?utf-8?B?ekltNExLSzJVZmQ4SUFtWUFycEJRTDdoc2lIK0k4RGFEb1ppMlpnNnAwYW1t?=
 =?utf-8?B?azQxVGJHUnllMFFiSldQNjY2L3kwTk52eThydTg5aU9UdkY0dXFrV2dxWTFh?=
 =?utf-8?B?KzAycit5alRCa201ZVY1eG9QTFlCZjBQZHZqWHR2Zm15TUphNG9TQ2UxbVc5?=
 =?utf-8?B?aUx2dVRKMmthUmhZMTIzZGhwZGtxL1NOSlFWbzVmRldJNnRBL2gxbE1QUjF6?=
 =?utf-8?B?L2Y4bEp0MTZmU01rL3VwVjcrN1VmQktmSlA5UDBiV0FiUGh2eVllZGRLeUln?=
 =?utf-8?B?Qm5QMWRLY1Nlcy83SXB4TzJWVWxJcFRBVjZkNlpoOHQ1NGEzVjZCZ3hTa0hR?=
 =?utf-8?B?N0ZQTFNTVWZqWXA0R1AzdDZCM3dxWk53RkU1Sk55aUMwczcvL1AyZmJMQTJs?=
 =?utf-8?B?em1BV1NKZ1FUUHNWRlU1YytBTHc1akdET2ZqUVVqTWk4Nm82Mll0QUVGWUJp?=
 =?utf-8?B?Q2MxUWs3TW44OFN6d0FLMlJ1a1pSMGlUdzgwbzRRWFNkYkpuQ2tvU0k2bmhZ?=
 =?utf-8?B?ZTcraFh3dkt3Sk03LzJ2TjJwS2dmY0NnZEMxMjFVdkQ1SnloTFROaWo1a3RD?=
 =?utf-8?B?Z0VzUEllNnBObzBqWENka0I4RkZkdkRLZm10eUdqbGQraXVLT1J3TEl3QUdO?=
 =?utf-8?B?WXZvZ2xDdHRlbXJJdUpFQ3lWcHBHNit4UXNzVmFBcExkL0dVQlVjRjZzblhn?=
 =?utf-8?B?Z0VNV3VCdEc5b2ZROEx4NFFlZmhtckRvRnh6NzNYRkJMRjRYbTh4VmxUa2o0?=
 =?utf-8?B?VktkSHRtL01KZWZtRHpYZE5icFVyUFJwb3pvWERIdHhLVFJlRlFYZ2pwQWdB?=
 =?utf-8?B?NnFsNFRyczIvVWF3SmNaQll3M2RyUlFkckdwbVZhcEJtOGlCWFBJM1ZiYzVk?=
 =?utf-8?B?bDhkSk82eEZGM0F5YkVTa0RvTHhTdk5Uc29mTlRCaVlIZ2lzbERjeTRVTzVL?=
 =?utf-8?B?bnVlaW91MFdEMS9sWkJuYkdzREI4cDIvbWl4aHBOSTVoUVEzaVQ3cUJOaWdF?=
 =?utf-8?B?UzRSKzY2RXN0dDZuRFRCNlVNcEJIZGdMd0xYYjBOUkFiVDFnemhicVdnSWhW?=
 =?utf-8?B?cjFFUm9iVkp0RkFQeHVENHMwbm5JSU96RUJEcG52UkoxRG85a0llQWlmWkZn?=
 =?utf-8?B?c1k5RVkrRCtJek5pSXlmZlY5YzVMU09EMVJZdXU0Smo0bVBGYzlKQm1BWUcw?=
 =?utf-8?B?TlpmRmdLdTB6cCtMSnEwRG0wZTlUQUhVOEUybjM5VUxlZFRodFRLTHovenFp?=
 =?utf-8?Q?8r1SVR0ArAJ6n54MTUJcLqchz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb05b7b-8f8f-4e72-7c4a-08dbb98b9831
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 03:42:20.7743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P329F4A5Ob+9z62VEUNCtRr2wznS4k1q/D4QRIdfsfhNNwMekdbFR2OwtaR7YapYJcXm3ykiBL/ll+SV0lQZoSv6+VIcftofmT650yzwkfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7214
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyAx
OjA4IEFNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxNS8yMl0gQWRkIGlvbW11ZmQgY29uZmln
dXJlIG9wdGlvbg0KPg0KPk9uIDgvMzAvMjMgMTI6MzcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4gVGhpcyBhZGRzICItLWVuYWJsZS1pb21tdWZkLy0tZGlzYWJsZS1pb21tdWZkIiB0byBlbmFi
bGUgb3IgZGlzYWJsZQ0KPj4gaW9tbXVmZCBzdXBwb3J0LCBlbmFibGVkIGJ5IGRlZmF1bHQuDQo+
DQo+V2h5IHdvdWxkIHNvbWVvbmUgd2FudCB0byBkaXNhYmxlIHN1cHBvcnQgYXQgY29tcGlsZSB0
aW1lID8gSXQgbWlnaHQNCg0KRm9yIHRob3NlIHVzZXJzIHdobyBvbmx5IHdhbnQgdG8gc3VwcG9y
dCBsZWdhY3kgY29udGFpbmVyIGZlYXR1cmU/DQpMZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgcHJl
ZmVyIHRvIGRyb3AgdGhpcyBwYXRjaCwgSSdtIGZpbmUgd2l0aCB0aGF0Lg0KDQo+aGF2ZSBiZWVu
IHVzZWZ1bCBmb3IgZGV2IGJ1dCBub3cgUUVNVSBzaG91bGQgc2VsZi1hZGp1c3QgYXQgcnVudGlt
ZQ0KPmRlcGVuZGluZyBvbmx5IG9uIHRoZSBob3N0IGNhcGFiaWxpdGllcyBBRkFJVUkuIEFtIEkg
bWlzc2luZyBzb21ldGhpbmcgPw0KDQpJT01NVUZEIGRvZXNuJ3Qgc3VwcG9ydCBhbGwgZmVhdHVy
ZXMgb2YgbGVnYWN5IGNvbnRhaW5lciwgc28gUUVNVQ0KZG9lc24ndCBzZWxmLWFkanVzdCBhdCBy
dW50aW1lIGJ5IGNoZWNraW5nIGlmIGhvc3Qgc3VwcG9ydHMgSU9NTVVGRC4NCldlIG5lZWQgdG8g
c3BlY2lmeSBpdCBleHBsaWNpdGx5IHRvIHVzZSBJT01NVUZEIGFzIGJlbG93Og0KDQogICAgLW9i
amVjdCBpb21tdWZkLGlkPWlvbW11ZmQwDQogICAgLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwMDA6
MDI6MDAuMCxpb21tdWZkPWlvbW11ZmQwDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

