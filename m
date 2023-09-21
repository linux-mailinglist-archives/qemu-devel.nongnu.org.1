Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 492567A9155
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 05:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjAbc-0006NX-M4; Wed, 20 Sep 2023 23:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjAbZ-0006NK-9v
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:43:53 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjAbX-0007Sh-Ao
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695267831; x=1726803831;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ntn6DmvMa3SbgJ9CWaVdw75eIaZ/NOOqp2uFojowroA=;
 b=Aeu1lnO9vZ0EnsnX043r8oOaL7sWrS/MniCwwdZX6W5PI9PAEwTEzWqW
 xiZW1TXQLt1NbjvIJOVGn+8zW4MgoJ4rNMHi8otkbHLxfoNfAg1ks4idI
 JAOvaqQihSaegZ+wMSm6jVpRfSJP1w3HGdyBuPs3fQx/fmASwwgaDskis
 YpYyuVvp8k/sxCbLl5ijTFS1gpCviETvYiROzPE99I7jGmGVL0xj2jdYd
 wq7ZkaCqQn1txoHhliUuAAv1Fn+PX07UbQJ4/4bU/eT59gJs3HYLY8wAJ
 KMuvacY9qAhNHkOOkGvVnFFGJdMT0A1HCzAD2Mf1CvFtqCLf+Z8aWFsPq Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466718059"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="466718059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 20:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920566581"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="920566581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 20:43:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 20:43:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 20:43:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 20:43:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkRJk7anQDqmFuqmflV5t3K9lUHyUeH9WSugP7CfIQ9MZHYy5PgeibxMUTwOP7TGOto2Qiz+dTatYlBSb5GqR8emR9l3Ssnd5dBxhZs5vdZ4SjyQGfSzDO3F/JGykKAQKHQnBMzkbSXErfcxyD6+YSngWS333vVSTEGE1ZQIFmhihEBNxNj9g8IssklUZFQTvWp1sotzSGwpVsF9Un6IXWxWEuJJzRAgsuSOwr42D39ODm2KOHuZji1WJOPfoiNdW2da+k+fvmoO+LB0UVdybITnP1gXn9r2rxKZqru0vd3iFaiDs0iZgZDz9XqLmaQh+Ui2cPR3WE5ap6nS79q0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n6gbK09GzPkImNELqdtiq1EHiO3INM0x34jUL6IUdA=;
 b=MpUUdg2QLDctMhiX629hRwlMlEmmFhMVf9XtTHve/doR939V65pJ/mSa4+C86R2ZTOKC9d31b7pb/P7pf87R8z8/5iT9j2CRyvsAnhh0TpLboyoJ2Rm4UxQtKz2fuK2Edw7ga1nvlEWrZwcGSdD+QfsLA4PKVqXnO03wYTjnAtD5n+K7SJfNfuKR5LmBXeuCjJ7WbFaAYGJO+pjkWvVm6PS1f4Sh2w54pF6hMMynQZluk1IeqriFLkPXtIKjLITVv0ZXQv+N1Sv3dam2HRNZcuZvriHz6HdcDtvBYxJo3qwV+wWjaGjl5IBp57zJ5uUEMHMcqC1BlXkYAdQSYj5g2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 03:43:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 03:43:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Eric Auger <eric.auger@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: RE: [PATCH v1 15/22] Add iommufd configure option
Thread-Topic: [PATCH v1 15/22] Add iommufd configure option
Thread-Index: AQHZ2zBBz9BBn8bZBkKAV/2bA/8zjLAigTGAgACtoLCAAJRFAIAACMOAgAADKICAAEz8gIAAAzGAgAAH2QCAAAC5gIAAm7tw
Date: Thu, 21 Sep 2023 03:43:44 +0000
Message-ID: <SJ0PR11MB6744556F557B48305EA094E392F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
 <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
 <a0f3fab2-069e-f286-aae8-25d5269e6e0c@redhat.com>
 <20230920174919.GF13733@nvidia.com>
 <20230920121724.381716d4.alex.williamson@redhat.com>
 <20230920181959.GI13733@nvidia.com>
In-Reply-To: <20230920181959.GI13733@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6701:EE_
x-ms-office365-filtering-correlation-id: 5a8b8598-d218-4f62-b1c0-08dbba54f448
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IErdXNMzGMGCInw6+nchQvT9uL1JOPf7k3e2VWPIsuHpN5XMLi4P/j6GbRC1P9lRz0eYzzMHJaXuNqqBdUVNpVo5UbfSyG4zQS4Ngpg4UHZrq3pARVgk7ExwSalUefM3az0Ds1weCw7jhoxzMYXkjr47wHcc31cZmXJMK4amzunbCa+3ORfKp8w70PlUqSySwQOmjWXjeKy4b5F5Eh+J+0pWPlb7IDutuDRLT3aPJ9ZiZ6I0GuS1HWodsyW3VttIjJNo3i3sJ3h19mOvRNd+A81v90hhfgSwZYKlseVR6cm/CTGG70HSzDsZox68scelSCFZ4NmDLH2FfvnjyADcVbt8d18/K9nG5uYfFkmBYy/kKcdMfCyYdY76dw6+8XgR1tn88bomdhWOrk1wsvk8dyyQLZuOvmpN9etK+MfajKYaeCmSY7XFrzNuHvLJcgF38umAL9KJH0umNljIIMT7lhT/BzpEdAN3J4ASuoljPrPkHrCNaljyNhCvF9Ye1U91gveHclnNyqX19a92KUvKhvaoefRaeEVeLrk1k5pJjcbY6sY7ETGWcGIbiQeJw5j/WWiK3Hp4MV/5BAGdizf9sdNEDEgZx3q9BwkwMzhR6nkgaxkZXjKhtEo4/8WKpy3n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(6506007)(7696005)(71200400001)(9686003)(83380400001)(478600001)(2906002)(26005)(4744005)(8936002)(8676002)(7416002)(76116006)(64756008)(316002)(66476007)(66946007)(66446008)(5660300002)(41300700001)(52536014)(110136005)(66556008)(4326008)(54906003)(82960400001)(55016003)(33656002)(86362001)(38100700002)(38070700005)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8HjV1ZUazcOhphT3N0kpMdn0JSQ629xPqtK6aGB5drJQVLgzJbuoUuwppM?=
 =?iso-8859-1?Q?w0iNOm54bHizYNuHAo5XdxXnP3cZjeGpQvJrO0VMr4EZHovj5K45Pfc3gQ?=
 =?iso-8859-1?Q?aqrdH5wccpkiNkYFjda5YN6LdeFpeI7hDtn1e+fUx/HEs9DmV2VYEDW/CF?=
 =?iso-8859-1?Q?Ynt6kFqPGgOLhJQomfreybDnNTD2D+Ut7ZrvfErJWAGhhzHxIZRAatj4fy?=
 =?iso-8859-1?Q?j1f6qViE1rmD9tHCPeqeXFgJ9DOxcnlKhwl6/0dffpIg26mG+HGrWVA8AQ?=
 =?iso-8859-1?Q?iw3CvaYTyaPD1zAmpm85CcNN2DmpVRPQYB5Y727ce2AfyNYDeHgabCjhNO?=
 =?iso-8859-1?Q?jIXRa/x5HzEHwQ1M3Og6nkfuigN46hPepXXh9AEBY6F+6DeHZk88MDLVJm?=
 =?iso-8859-1?Q?6PfxbvnNlSwWVWmeO3J20145sJ5CAzlvijVi2fQot0jLQ6cY0S+b70lbgP?=
 =?iso-8859-1?Q?Sq8zwfv3Wne1yfYaUZd9XFqlUK4H2pwmrI+F9w/MHHQW5YsGOPcZbIrhps?=
 =?iso-8859-1?Q?Dvjt7xzLpHsbqZ794NPivarLFrJOJZ21bedgHRNsFCID48k6N3LHyML+p7?=
 =?iso-8859-1?Q?0KSuAQIe2/NuVKZXNM+eTn+FWwcla5mXjGI3BYeql92APDnZqYANFCs2ML?=
 =?iso-8859-1?Q?u62agGMCWxebWQol6VAoy0cnhC/AE3llCOPAHuTjQWo1iZbhC+e0mU/ML4?=
 =?iso-8859-1?Q?GvFjt4OOG+8qvm7WoH6ct29GRwbissEd9RE/lJbnOjqLyJov8+yW+FzV6P?=
 =?iso-8859-1?Q?QyR2ppZ/w0UIhDfTWkxwZUz6DE5pDLZM7uU0IQ1zhO+0Olq0gvpdSazWyk?=
 =?iso-8859-1?Q?IeOWJ2PbvfCWOSF1b7s3IieXr0FiPR9hmasUvwCDGla1vtVvqPhCSdVEGq?=
 =?iso-8859-1?Q?u+ET9F5/Hs3yArrXUSHXFIhM5N93CEi5Cax11r/rGINEMUrzYAQ80AKa9x?=
 =?iso-8859-1?Q?im0Zx4sWLQvaix21M9bB5AESoNQ+GWuva/FqA0+A8ONx46oOVehCjJBjj6?=
 =?iso-8859-1?Q?DNpMLNQ9qcWWxBLi7mlBVcFEj9Z3greftrcKOTWAVHFYLKoY0A5d3fbLLg?=
 =?iso-8859-1?Q?TzkPoTeSqTpNFWm3bvwxomnYbUOrerVFgkB6trH+S4R/GzAvg9CUsh0mjo?=
 =?iso-8859-1?Q?XHvjwCwkproyZuOgOIAwTEf+TTUVaW3f6UpeoUfteIK+q3pyiDEh2Q9HcN?=
 =?iso-8859-1?Q?ka0zMod68dWfl8TZCKRQd+9/Q08Sza0DYHh/tMW9DxQ5dop5z76JqzqMHe?=
 =?iso-8859-1?Q?32orJggfF2W7flz0TU2usywYmbQmzu4gMF5yAlkw9RmO6uUEQTAzsujvCG?=
 =?iso-8859-1?Q?NlVEy24z5yk9U2GFRdBtAXy6qzFiDCAd5K6PqCc0h6EoX/8EYB4Iq194W+?=
 =?iso-8859-1?Q?uAJbxlHAv+PH/pa9fAhUnMDbsckFxkon3WI/WH7D9fN0I4gfiWjkErd/C5?=
 =?iso-8859-1?Q?RDQonzDFMl2sgNwJwiW0y825pBSiWE+41ip54Z9XR79jvIS+DJ/PfuhhMh?=
 =?iso-8859-1?Q?4bOR8vu7b0buNw8o7zlBoc6HeW65oe6RnjeiqQnvzYMF84azGdS8BC3VVC?=
 =?iso-8859-1?Q?G9yGdFtgHq1mm//chyJ4WZzT7JaFhc8u6JriMGZ4Dnq2+krJBVQWtuiSj1?=
 =?iso-8859-1?Q?1ddzxtNZRDoQ0GVmrCBMWsePWE9Cox0phfVcg8r0xRPly2ArjCbVRk3Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8b8598-d218-4f62-b1c0-08dbba54f448
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 03:43:44.1470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 599ag3/vUz4cULeoSyIT8vYzqgH0Fgxp33v8uieDFpQ0HLE7/nAPW33efU6Hl3+XHK9NxhJjjY82DlAccCUae+raBQWJp+mBPQiwRmHrZ6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
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



>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Sent: Thursday, September 21, 2023 2:20 AM
>Subject: Re: [PATCH v1 15/22] Add iommufd configure option
>
>On Wed, Sep 20, 2023 at 12:17:24PM -0600, Alex Williamson wrote:
>
>> > The iommufd design requires one open of the /dev/iommu to be shared
>> > across all the vfios.
>>
>> "requires"?  It's certainly of limited value to have multiple iommufd
>> instances rather than create multiple address spaces within a single
>> iommufd, but what exactly precludes an iommufd per device if QEMU, or
>> any other userspace so desired?  Thanks,
>
>From the kernel side requires is too strong I suppose
>
>Not sure about these qemu patches though?

I had ever tested with multiple IOMMUFDs and mix of IOMMUFD/legacy BE linki=
ng to different VFIO devices with this series,  all works fine.

Thanks
Zhenzhong

