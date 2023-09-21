Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 688C37A91AA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjCwW-0003c1-OP; Thu, 21 Sep 2023 02:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjCwU-0003b7-7m
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:13:38 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjCwS-0007a8-Bm
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695276816; x=1726812816;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JcWazQ/UBX59MtWoMfTpl90tt21Pd0tKIbdNT7Gyfko=;
 b=WWlh62EHDtEU/yrebPyth41MoKqYahJ5Dt64lTmWTmOA9n1KDmLb4NiZ
 jqELPf8vWSaqFJJLfaCRzUnymwsO7Ld73mOtWL2ZrMy/A8Exr//rz3Sfe
 Fv5w7wgQo3ezklNjA0z1Q2omwFIKavQJraf8PRVbIbIyg+qflemfduF8I
 KwRhtcqFYDeJSACqqarsIEOxuuxJVBzOMRU173BspwAYJx8Mrc73izYMQ
 GoobYN2/ivt+GLhAtCNSfWSJd1N5bOdsk9EZZAZKE7b94cMFcSxaNQyJD
 NMN+RXsl60KSElnpLUfSeJ5rDwz9Xkitn5OyPP9bXifeK7qY03Kja6ArW w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="380339856"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="380339856"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 23:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740497280"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="740497280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 23:13:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 23:13:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 23:13:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 23:13:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 23:13:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCLbLpoUoR358key0vPqmChNE5UmBlHRrMxZc+NlbxrTh1ngEWlzTU8B/Erovd975SnP+sGMg22RNxsGO3rluZh4ygap5NE+8mWtwgUthqwSlah9UraNjh9zTMarEO9v/ZhVmSGImGRZfdgR+QoDVYAFUc4XYimyNHzAnoJbKsmqjzUSG48yzLWy2BKZ9Uu7cMHg8uNX3AVFdD6AwmoORkS2Yhl7nOGMWzlRxHR1LXKqxjCcJolgfslRRK5RUPncVsrvq4OXiT6cmgs3L+nNx6BOq8MP/NrC1oN/6kGmmFhgteqOkCrhoqmKCEYZq38kpRBJKSkyfUGwXpYmX97eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JgsjfOeedEwp/FSDeM/7GWFF3z8Vh7E4NNDO4u03fw=;
 b=kknPeTUbx3ewXjndmTbLmHt7cXmCuCROSLVpPOVLZWxG4gzWIo79C1AX4JFKevluuC/4q9zOnT2EKciFSQT43xUdYwGtHNkbvbLgsbwA9Rt8Gt3AdL7AhJP5LsxTN7gE3Xhxw+32BF/mB6cAKjO+nkqC/vDKyu6rJ9JGafAw9+avGvycxuA7foQ0gT4PhUdJ7vUQwo56CRdHAtl3hzUX+/lMkZVmxsuxq75iKdSctKFvF5Zc0eBf38x6BpCy/viiCRZoqMNBU29cUd+TKKmvw++e1OqpD7EpW5ukYbRyDJZSuyV7LsWl7xu6juqmCFuz89QKJSToATiZSWd3aV7whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM8PR11MB5704.namprd11.prod.outlook.com (2603:10b6:8:23::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Thu, 21 Sep 2023 06:13:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 06:13:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 07/22] vfio/common: Refactor vfio_viommu_preset() to be
 group agnostic
Thread-Topic: [PATCH v1 07/22] vfio/common: Refactor vfio_viommu_preset() to
 be group agnostic
Thread-Index: AQHZ2zAo3NsMmQdR20Og0Ie/MXHDX7Akc5mAgAB5sKA=
Date: Thu, 21 Sep 2023 06:13:27 +0000
Message-ID: <SJ0PR11MB6744CC9C9FE0B2648572DF4192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-8-zhenzhong.duan@intel.com>
 <20230920165127.0a4ea315.alex.williamson@redhat.com>
In-Reply-To: <20230920165127.0a4ea315.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM8PR11MB5704:EE_
x-ms-office365-filtering-correlation-id: 0fbf387a-3abd-40b8-ed89-08dbba69dea6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZk3dLpqpXCDR1Ld7q1IwcNEgbAI4QiXEGcfabUj4H8RdG/yEu2M8Xq+jw1nPVqF/DuBgtQsEnsjjxRMEW8tw6Y9iIkEwgAHQ0VzC8t3SCagawGNv1VXsTdCuBrU2hjrFQNZcV80xHXIvEym8b8OzJ0VNzwZaQ12pQdyZVizq8RNfWCdBQDn50+vjgWwn61r5xl0bYDQe049cKRD/d+gmuQGLlB9CTO+Ropivbl2VM5PpRYKvH1WeD1sSb9mhQ6ptZGMT1AZHLf92xMJwjjS1kB2WCf/+2hrJyaq9ExB2nhUDVha7escre0cMWKAnZmXJtaLMSeJWSYaX0mu232FhFUMPFoFIbEtpHeoLikza9r5VsPwvju5KNxx76VOkpyRfKULS78OpgYIXmRHKQlerNqXHnFh+FyMGi2E3vaCZN4B1MEOsIk1P3EIoGAiF+gCL80yevuGBUbhxkloNRIY985ifGM6G4yCSkIfBOsSD8atFp0Spw9bvwm2Nkhqbj5O2oxZ00G3AHAmzyajvSvKB7w6pXF9JKgFvQBJkYjKvA7jgWK1+cH/Nc5i46tQXR+bF6KppPn5ybIU+jmPieIUXDdudeoGzLdIf2y2mnvIoq/9KvzbL+EEsguV/VK0GYoT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(1800799009)(186009)(451199024)(55016003)(83380400001)(2906002)(54906003)(7696005)(64756008)(82960400001)(71200400001)(122000001)(6506007)(6916009)(41300700001)(4326008)(66446008)(5660300002)(66946007)(76116006)(66476007)(66556008)(8936002)(8676002)(52536014)(38070700005)(316002)(33656002)(478600001)(86362001)(9686003)(38100700002)(26005)(107886003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zNrbOSu8My327Qbcjcr6UGMKkqk1wJydbsuL531AAUdsigiHKvwCWAuEdejx?=
 =?us-ascii?Q?xhIKzVtWo/FxYQq0WesV42B6fiKPyvBbb/aR8Io58Gi8G+NO6+2FIzIlFAtE?=
 =?us-ascii?Q?0wXue7E0QSO5wv+wBD2bAksUzKXIIA6yHy9ehNa/xcjE343xubnu5sQvOskm?=
 =?us-ascii?Q?Y84eFqOjYs8mJbESI7uQDbGsRN++FgAR28cdUiS2KN0EdimZrKleapFVtRNN?=
 =?us-ascii?Q?uMDs9IxkmIuYFLHBkcsqXHiRFnlfIZt1LeXGK2KzMrBxhZPVIW0sXewkoyuI?=
 =?us-ascii?Q?exx2lx9O8HTLEHkwMPDuj6ddd9fo2HlmNflb5RoUYe0VY+BgSc1+HyFbjtaF?=
 =?us-ascii?Q?2mSGfsi6dTRISEqzlVuLEnntJSYirEwZT/XF1IDa+T5Ba/rAYv1SPPxx27lO?=
 =?us-ascii?Q?RNIH3FTXo4LQ7h7zdjh5eIXT290grdz39uqi4rkBRfMjNWq4Rv5OlScmKkDQ?=
 =?us-ascii?Q?Xdv1rPO3JU6S5XLsAPcTLoi5se57+pPFEVjBOroUSb+cCgJh4IlTFqb/L7Sx?=
 =?us-ascii?Q?T9GS9exNBxIhPMj5k1K1T98twd4O6unDxb5adJuokKuhuuGJsvIU6eZxz4MA?=
 =?us-ascii?Q?ZzzxQVuinUYY59Ss+EFvfmYYGDqMVX5Chvk0F8L1MW1dTxRt28jcvE9u/jUN?=
 =?us-ascii?Q?KH1LGGh2w9ECcrPXL8P7xdX/EvgMR/us2+BXZ8L2To5gqvIoGT4qHnQyn8x/?=
 =?us-ascii?Q?F6f8eciOXLtApp1QjLN6RLUTFjHWkz5pobm+oRFLkZhpZR4U68vwIVI7PMzy?=
 =?us-ascii?Q?da+N5MknqwDsvzI3yKBnADGfybGJ1LNqSfYaBTvnFp+rQwA7OW5IB1XOkPMK?=
 =?us-ascii?Q?cUkjY5f6HGB5llE+oinGBED679ZCq0Mn/G3jJQXXg0uwQwJcLeuKxd4ZO/X8?=
 =?us-ascii?Q?YojIO8DLgLAzixrNompFROOy+RbcT1Rrnq8wpUFOR3yMp5EfsZ6ZW7JtsYIS?=
 =?us-ascii?Q?0ZlL5FVTHwGoKTJEqMYILxOf93oQpEzcU2y40gD8diCLJxyi7iCe4CwQSD+2?=
 =?us-ascii?Q?jqUppvtIq8kJVQ66r6Hp33RwY8AUspCcis/WT+I4Cc18ykastK2SVUetWicp?=
 =?us-ascii?Q?zihu6bnjjPmUPtOSYEJ2gTwzEVUW5afSHGthXrzxM5daSaT5DTsHVLaMDrLU?=
 =?us-ascii?Q?8Dc18YtION7sW2NlQ7kW9szX0/Qv9GLNYC8EeUW6jy1H62XxgM5BMF1LI3/V?=
 =?us-ascii?Q?OSTXuVlZUAg1FxPGcPu/95B9NpSfKhr5Adx8pELCBY+YTlQNA8jFUOo3te2u?=
 =?us-ascii?Q?YJT0HXw6nZvvgT1nNeU/5qQ1gZERzKnRKor67UX3B3A00A0/VjizMO9QMnb4?=
 =?us-ascii?Q?EbBQugLukndlUdJN8FiVUEjNUtXFkJrgQswrvHAjrkfBY05qipmVWvLFyGCi?=
 =?us-ascii?Q?1/xiC7LuLZsuiPShuxyDkqygBDmHN1kzhsOroB7fkDlveyEzO1StQbgeBjnY?=
 =?us-ascii?Q?HXcCoP+ovv/qNVz2h8uSJXaqNPjCDX7DBq74JcQ89XW1anKAqJM9K40HK2u1?=
 =?us-ascii?Q?m4dq6Gy7KfTNtcSeHF5+RiuNEqT47zy65Xab2SlqdntQcAgeQhtRCF+SbTXZ?=
 =?us-ascii?Q?xj5oWtDX7HHyT0JR9tFHthsHK8bckmjccmdqXiFQrXokOrca8jJ73cc2sphm?=
 =?us-ascii?Q?wQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbf387a-3abd-40b8-ed89-08dbba69dea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 06:13:27.2778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrinfLJlZrUTcgv1Iu9HSST2sMlMam8o5vRDc6sUyxm3F1rxC1ufwLRx3wIyCNb0a2wRXxMXl6ekU7faCE5Y1zRgslohBI2HtzBF4x3tXYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5704
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
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
>From: Alex Williamson <alex.williamson@redhat.com>
>Sent: Thursday, September 21, 2023 6:51 AM
>Subject: Re: [PATCH v1 07/22] vfio/common: Refactor vfio_viommu_preset() t=
o
>be group agnostic
>
>On Wed, 30 Aug 2023 18:37:39 +0800
>Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
>
>> So that it doesn't need to be moved into container.c as done
>> in following patch.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/vfio/common.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 51c6e7598e..fda5fc87b9 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -219,7 +219,22 @@ void vfio_unblock_multiple_devices_migration(void)
>>
>>  bool vfio_viommu_preset(VFIODevice *vbasedev)
>>  {
>> -    return vbasedev->group->container->space->as !=3D &address_space_me=
mory;
>> +    VFIOAddressSpace *space;
>> +    VFIOContainer *container;
>> +    VFIODevice *tmp_dev;
>> +
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        QLIST_FOREACH(container, &space->containers, next) {
>> +            tmp_dev =3D NULL;
>> +            while ((tmp_dev =3D vfio_container_dev_iter_next(container,
>> +                                                           tmp_dev))) {
>> +                if (vbasedev =3D=3D tmp_dev) {
>> +                    return space->as !=3D &address_space_memory;
>> +                }
>> +            }
>> +        }
>> +    }
>> +    g_assert_not_reached();
>
>Should the VFIODevice just have a pointer to the VFIOAddressSpace?

After "[PATCH v1 13/22] vfio: Add base container", VFIODevice has pointer
to base container which has pointer further to VFIOAddressSpace.
Is that meet your expectation?

Thanks
Zhenzhong


