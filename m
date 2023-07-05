Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D15187481CD
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:14:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzVq-0005Ie-8k; Wed, 05 Jul 2023 06:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGzVk-0005ID-E9; Wed, 05 Jul 2023 06:13:24 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGzVh-0006vY-Iq; Wed, 05 Jul 2023 06:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688552001; x=1720088001;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0xeJOFLG4z5G1N3g8jqxe6XYJL//Xohvac2HCfporpc=;
 b=QqSZtQ/ftTCl0W9IYM+Md9ae5Wm3/+20WjIFjBklaxO7A59br9MfRGw/
 xBu9fDI0wySxaw0aRP7R2ebZ60RFc0pNnXdUZfRAbyLiADSsXE3SS9HCN
 e945KutBJWFHeVQRu3u4lAUVt9JwjtSvtG2t1ZM6HfWi0bkRu2o7gOQSF
 CfE/iyg+7ADaXKxYEiwjn9OmCBHMhfSOgO8MK9DdkOYyBJSthpmX8iFNR
 E/s5DKxRKKSld9Rer4h1Xgo9dMtKgZh4u+p8qbV2ulzb74HEQ6Gseq93R
 uGXJQdAFEfH1T3pQ+R/3kSEE039SXJa3JKS/8f+4z03g8LzHSjmJAcd+s g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="429336885"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="429336885"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 03:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="696403142"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="696403142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga006.jf.intel.com with ESMTP; 05 Jul 2023 03:13:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 03:13:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 03:13:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 03:13:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 03:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU1GSBnM84i228v+HHPFfswcY7IytC7BktaztEC3ZYaxPwvGricirUq3rT2/bNndowAFTbOvzHsckwU0CsPtZlJ9I7GxVU8+kbcMPV/8kKuazXWjzSXmmDr9XyKJOvZX7+y70sXGWnEkcG7+yN3zwoaol/JphJMgPryZ4CVnHwiLTvSm8/DUjj2aXpQ8FoRZs0XXP0blnJjGlzy2ji8Ce9uCQ5e6At8NAPOhZz4VAwqEZI8smpyDaCXxyOVYVEzLQNweSl0YSz4ROO49QEqUq91JeGuiGMCiMQcYs1RlgZZ8VvmmGWBlBko/EyEVRo/YLqVe1hpI4tLZP1A6a1XvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MST4AztR3Dw7p3lBwBlN9HEYaK3nVHjeiXsT0COJLZU=;
 b=ERmYBZnHLTxaz0LMzJDTIA8+lLSkgINPFZLlCwXq1OjGWVBJ6LmlVDa/Rq6Q0w0CGuNoLQmnK8yK/M5gaYi4G5xaaTRAvrgM7P/kM+cZNY9ZWMjspNWasy5auVEX0mMKj+sV31ES7Zus8h61ZLtSHrtgZvwxSQYqV/jaIUrpjzfWI/hRr410tayRt1jcrlsKUbJolqtGeBLOIHBUlmqkaK4B/4K/7EigfXBkOzl9ySWkgB35iQuwuy+klBi3xEsUSgVQaioffKjoCwcgyPI0z721Ax5j6v9cLQvYXmYhCe5Vb0m1ewVCiz4ACQIfqtq0JSqkfJuzPmIO2XHMRKD/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 10:13:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 10:13:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>, "bharat.bhushan@nxp.com"
 <bharat.bhushan@nxp.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Topic: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Index: AQHZrmjiQzWi8iDMQE285Hu7NzFLv6+qlagQgABDBwCAABlkcA==
Date: Wed, 5 Jul 2023 10:13:11 +0000
Message-ID: <SJ0PR11MB674426C1F9AB893C82E371A4922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-2-eric.auger@redhat.com>
 <SJ0PR11MB674435F2BA42A8925ABA336F922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230705082902.GA2234638@myrica>
In-Reply-To: <20230705082902.GA2234638@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB7740:EE_
x-ms-office365-filtering-correlation-id: 61281176-e8d7-42fb-42a7-08db7d406fea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LTDZJkpE2xY0PJRF/LyaIetz2ZObZ1e+N8kj0b1aONWU8uJk9g8TY0a2svPMVIx3D9pL3VjEBPeEQvY4OOs+mlzHXTRbeVVMSaOV5+FtKFo+8O+Bej9jRQRi90AOF+E4HRkRl65t9rljOlQXyJDyJ4vaggMS6WchOHnu3ak34NN803KjAp9E+xt8qNuuoFrpt/qeaW3aR3BJRuO3fNiaAUPHuzYXCJolAnPStgzHiLbw5/+dVTUjDFwIw3oTvP8A9Vm5XagiWIOzePz1s/wJ5i9CnTdd4FSBowFZOl+O4fGeTD1LNsrCHvmRUbKdIChgH6MY6njL+kMc+ntDjU6mMmp8UwOD/Jbzc6Jc1XX3upcLmu3g/r5oO8aObaUiYKq9AiAgYzreet86jA27e4UwxCNRAdCFQ2nQb0jubtqrEVhu2CghZbzDDTR8Rg/ThVdcsIPS8IAQAabastU8+jmdd53ffErDHUzcZYDo01hT2G376ictamK3aqkKW9q/K+rpGlp/ajG+iD1jFst0npZYbbXz3SCnanDcDvl53Vl7DnuB6oKBZdWAYAEexksh4OfnINKHiva8Eir/o6DyQLYXe+JDrfCT6joY+5OVPpPurTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(83380400001)(54906003)(86362001)(41300700001)(8676002)(7416002)(2906002)(5660300002)(52536014)(33656002)(8936002)(66946007)(6916009)(64756008)(66556008)(66476007)(76116006)(38070700005)(66446008)(478600001)(316002)(71200400001)(7696005)(55016003)(38100700002)(122000001)(4326008)(82960400001)(6506007)(26005)(9686003)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aw0ROs+E46GCXzPA8YsGLzBcAJWtCR9cewhXPHM1SeFXYe1SyQF7eo2kNwMX?=
 =?us-ascii?Q?bjcxxpCtcNmugWUrETB6NuHLfl+Y5Jeqctym+GwCaGR457w1DNQSfx81od5p?=
 =?us-ascii?Q?E6c533WzqRCzaOCCZDu9+Jq+shqIdlU8oFdE8fn6BuNUHSxQpD+rpwqBsvWf?=
 =?us-ascii?Q?aQIJzcTPIecRGBoERufRBjs5SzrN62Hfee85/syYoVxqY8f8bGRqTXiKfGE2?=
 =?us-ascii?Q?lq9AnvS7ZpuoeUjpo7+GnRQ8uQFrsZ9BsQPJsk0/zttSRQF1xj2hEacm8k0q?=
 =?us-ascii?Q?6kBhknAM+p5tNMUJ+WxhAtp73zAza0FBPwMni11hi6kzhJjt5GoMQjlj09AW?=
 =?us-ascii?Q?z+N+cb/IAI0qe0mIC0DgbnjeQVoEmjo+9gj077St3WTsB2jULv9FLEXMLh5B?=
 =?us-ascii?Q?+W9NUIXDn0VPpD+Pu227wDa9umv+x5IZ5mBDLn/friCgJRdyozjYvIxf7VX4?=
 =?us-ascii?Q?IHUQE5LbOGWPkLvYzBayoCoLmwzZ9urh6VK1fagX7TLIo6Hsfqg66nOM/o5X?=
 =?us-ascii?Q?BULGUKZVh0m0OY4C3iYhItfC1Aux+ah8wDQOYZe4g9Y4nua9mT1fAHePOYAc?=
 =?us-ascii?Q?Td6sX33z0rM1EbglzaH7gJkmm1jwD0cWFxViBBhkOyyoaoK6vbb1B/7dIC7v?=
 =?us-ascii?Q?pwgD4WNgyJ8RCiDMnXPqv19mirbCLpyTJspEeGSIs/1ZU6BT+b7B5CnPoZWA?=
 =?us-ascii?Q?O+X3760yESoCEV+xf4OOXlqozJ++zADOIL/1EhWIgvwMR+K6f2V87AFuG2o/?=
 =?us-ascii?Q?W2KPsRyI8fhGU7BBldF3STvHU35pdziCgpHmvespfcWN0PS0PILgYoFmLqaK?=
 =?us-ascii?Q?bKvkQVdcV0Z54KjkVuDWUClMGwzNmGZ8VX2ZWXAhJg1QF5u65MBX2cS+y9S2?=
 =?us-ascii?Q?kFTdGghG8DFeIc76felIJp+B5f799vK5H99475+35YgHaFOS1czE3rHFZfLq?=
 =?us-ascii?Q?Chvh9TSlGNPc3vwKgaR/NJtZmgLIducbIgPVT9TxR78ulXCSrR14GBNi5cgK?=
 =?us-ascii?Q?/K5UrHgff2i6fIlJJ5e5QXpIhXljPHJ0fbRf9rZwGTsZJhYU95D8yPrpN+gZ?=
 =?us-ascii?Q?2kLexeC5ZH0zV6RPeVvI1WU14oYXzSq9kT6ZMqcqOYTx/371s+l22ABdlQNV?=
 =?us-ascii?Q?Nr0RGcEI2lB5unVtoCqnP9xj+tehr9wE1k01gMjxuxFg1F5fvi5OEQJJpT20?=
 =?us-ascii?Q?b4apZq+3bp82iFSwLaQmLv1sItHHjLMDL8OfVdQxnwRNzg3iGo5Pi8m/UMaR?=
 =?us-ascii?Q?JFA6VSVWs+kHTAwKVJ80IeIQLSCJ8N12SXuJ5y2f/MatNG0Ysf0PheLWSXVK?=
 =?us-ascii?Q?/vtuVKD7zBWzmpXrKfYvN5VNohGVq3g7c8HfP+91zHmJyHhrQIDBETnFxLiN?=
 =?us-ascii?Q?8G3Urc/iU2J+lWVBFnU2KxMD4qVx1XuSvy+hVcOthTc76iP3ey/1wxyf2D5j?=
 =?us-ascii?Q?la8h39e823AALwkqG0zLerAV9uxHitct6I0eAa/PAv1HRAIaCQYIhMeRFY2R?=
 =?us-ascii?Q?9ryNna2D5ySOp5f33SMddcaq/9QBhsi9xBbBwjlGL48kBYGSmG5gz9ZC4/ny?=
 =?us-ascii?Q?WqRPJ70NiG+RxnCxqq2xnnxOiubba+/pQJ+r2mSe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61281176-e8d7-42fb-42a7-08db7d406fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 10:13:11.1816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLOOwOStQRez9R9jFK1Qj2XVBcY93nNpPxU2m03HvS12eRpBB7434UWBYQ8DAtYaNxhJ51ucEhqGUsldkICX+G/CgJhJqgMEQdff3kfcnZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
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

>-----Original Message-----
>From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>Sent: Wednesday, July 5, 2023 4:29 PM
>Subject: Re: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
>assignment
>
>On Wed, Jul 05, 2023 at 04:52:09AM +0000, Duan, Zhenzhong wrote:
>> Hi Eric,
>>
>> >-----Original Message-----
>> >From: Eric Auger <eric.auger@redhat.com>
>> >Sent: Tuesday, July 4, 2023 7:15 PM
>> >Subject: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO
>> >device assignment
>> >
>> >When running on a 64kB page size host and protecting a VFIO device
>> >with the virtio-iommu, qemu crashes with this kind of message:
>> >
>> >qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
>> >with mask 0x20010000
>>
>> Does 0x20010000 mean only  512MB and 64KB super page mapping is
>> supported for host iommu hw? 4KB mapping not supported?
>
>It's not a restriction by the HW IOMMU, but the host kernel. An Arm SMMU
>can implement 4KB, 16KB and/or 64KB granules, but the host kernel only
>advertises through VFIO the granule corresponding to host PAGE_SIZE. This
>restriction is done by arm_lpae_restrict_pgsizes() in order to choose a pa=
ge
>size when a device is driven by the host.

Just curious why not advertises the Arm SMMU implemented granules to VFIO
Eg:4KB, 16KB or 64KB granules? But arm_lpae_restrict_pgsizes() restricted o=
nes,
Eg: for SZ_4K, (SZ_4K | SZ_2M | SZ_1G).
(SZ_4K | SZ_2M | SZ_1G) looks not real hardware granules of Arm SMMU.

>
>>
>> There is a check in guest kernel side hint only 4KB is supported, with
>> this patch we force viommu->pgsize_bitmap to 0x20010000 and fail below
>> check? Does this device work in guest?
>> Please correct me if I understand wrong.
>
>Right, a guest using 4KB pages under a host that uses 64KB is not supporte=
d,
>because if the guest attempts to dma_map a 4K page, the IOMMU cannot
>create a mapping small enough, the mapping would have to spill over
>neighbouring guest memory.
>
>One possible solution would be supporting multiple page granules. If we
>added a page granule negotiation through VFIO and virtio-iommu then the
>guest could pick the page size it wants. But this requires changes to Linu=
x UAPI
>so isn't a priority at the moment, because we're trying to enable nesting =
which
>would support 64K-host/4K-guest as well.
>
>See also the discussion on the patch that introduced the guest check
>https://lore.kernel.org/linux-iommu/20200318114047.1518048-1-jean-
>philippe@linaro.org/

Clear, thanks for sharing the history.

Regards
Zhenzhong

