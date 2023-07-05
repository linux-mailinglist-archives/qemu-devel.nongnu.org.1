Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6DB747C32
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 06:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGuVH-0008Bn-8M; Wed, 05 Jul 2023 00:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGuVF-0008Bb-Rn; Wed, 05 Jul 2023 00:52:33 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGuVC-0003B1-2r; Wed, 05 Jul 2023 00:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688532750; x=1720068750;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=smACpwgrig896YapvOyFzIxcxeyIB9QHRigO7FHN1gI=;
 b=cZ7YcokUajynHLCBaXVkpd7nIMoFpdfiHQxWjSkxyjAeExAEltdFACHt
 yzpUfDTlWJrcojhEXjJnGxEV2JzVgMQCGZE3+3Ktrc4SHDn3/QNG5jV+D
 PZ20P6mS57n79UbyWhMuckY/23TZXDuAPOdk0Z4+pfnAmDzgIoMV9KJ/s
 au2RmeNK0C9ram6jwMTK3/0q9gAWxTZsznR/uvzIcCs3NCESnrpfmX+XZ
 XsXOlgRQuNyEk2iLu1UqJyGPbcG3YItDEHMVrBFibeTOo9nVjP19L9hVD
 iXtjRFrANfUoId/kP+UjTKrdWd9Dk7HHeTQzZVeSW4+H9JBdJ1fIoTVrw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="393999217"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="393999217"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2023 21:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="754234129"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="754234129"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga001.jf.intel.com with ESMTP; 04 Jul 2023 21:52:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 21:52:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 21:52:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 21:52:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 21:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4mIqWmk7oh0R30EUMTXzK3CoFufY/h2yvOCguh1ht17PW2tuQd177/7++FuFAYvZGXuLdxzARdBDQjBnJJThIAF+koBMXnlMiU391LveVNUYZSmIbnFbSFgI8CG8deJ3JkvjuTqSEBd3IWE3Q6BKOSBIfhLuCN0/1Yf8k3YQ37Iqurr2/0tEm6R7nM3Emw/49/amc6xczwmATcFIvhR5L830eR/C56A2U1lZspsgvY7nhrTmReuHLPU6MuKr4+J8Ra3u7pMM+EAhQNIXTe0ViuVYGNk+XvD54DXDxUXHyDVsDM1X+7ZsHq0D5JWf3hz7xxwkrVxvfYTqKJ8gnLf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MzmYJM2vk3nbic+nJuaQWjwLVHFNUxhSfK8aAasmzU=;
 b=V3T/nt4pE5KG4rEHxk331Uz6C0XgDJ6d1lW/Go+g6EiHJy6cHwtrIi9EBPiLl7vgdB1R3RDt/7PAHkifvG6B+95Hqa70C80KCbju0RuouhxSjjnMkxj5uozR4StqgypNJmMMa8tet1HlRipcr1pkQuKmBSP7YD670j5BrGzR0cCcTBawxngj0KpagMqPVscuFsMUH/EqBuOt1JHo1I3pLSzBrsgU5xPA6oGqGEEmpfL9BqwuZ8oJmnEeOa7MO6k5pEI26TVRq6T0Dc5eToJ8O4AcOIvCbaHQhNJ/+tZ5w9aI2CkDXFrc/TfYfj1fDYIgO/wzIpgHQ3xNwy1UNL/sHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 04:52:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 04:52:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>, "bharat.bhushan@nxp.com"
 <bharat.bhushan@nxp.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Topic: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Index: AQHZrmjiQzWi8iDMQE285Hu7NzFLv6+qlagQ
Date: Wed, 5 Jul 2023 04:52:09 +0000
Message-ID: <SJ0PR11MB674435F2BA42A8925ABA336F922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-2-eric.auger@redhat.com>
In-Reply-To: <20230704111527.3424992-2-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: 9a175f00-fc0a-4b11-4c09-08db7d1396f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6uAugFShRFa5WkkZiuE1kQTjApJ1CqKisNhyJYJ4HdGi7XX6YsQ8NoQSm/kmQt2Nz8Bu646K7Bxwa7cbsbBUae0CdZr5YjuO8YbeiUnOPU0qvJuhsJYTjrg+eH58Fzp2sG6fHZOICDc4CxZ6Ub0NreifYUJg2tW4qmrT56urB8aE2ooHVKng0i22BBCzKeCYl4wy3Z3ukUXw4U3yFjrpKyZejvePK50HY502a2dOsX2HTxQ9ltiV3pDbWcL/9SRGcxDVwO9wL3mJjkHfkB+WApuSXrSmtQKm9PfQJO3qh2FCsu9oHxRAhhuQTd67b/uFIPBQfPPTHEYTZMX7P2c36409e/ZAKJETJdAIZdCs+4Ks5pg2lUOgoqNbvh8rOsG3Bxzj7vrxBlLjyb3BUZqKsxSQemJWOMBx2t/4lR2NlaZbtvZUeQa01yhmqyItgH8CJfzKzAw8NaRoGjESMF2a+ieyPR0uP/zLjD3a3ueBT2YPh8j+bTjzmyu5AB/8HI+wP1t02zJaYSZyuKwpawiCRtWeTa+CmylhQSKgGL0KlVVIy0mRjyzDqjkzyy7nIrQc7gXnqQeOSTXQA6/gREpfPMRxZBPUempJOtMs0OMVLLBNkWmaw1USmjDJ/MeRhvIw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(8676002)(8936002)(6506007)(186003)(26005)(2906002)(66946007)(76116006)(55016003)(5660300002)(52536014)(7416002)(66446008)(41300700001)(122000001)(7696005)(82960400001)(71200400001)(316002)(4326008)(66556008)(33656002)(66476007)(64756008)(83380400001)(110136005)(54906003)(38070700005)(478600001)(9686003)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uxbls6XzQOR0OwY8cR8JeKg/2SLiaIeobje8JjMiQzd1Luwv1KSa6WNaUCL2?=
 =?us-ascii?Q?pNQDvi/1Ulig1mZqx30S3l9iT314JpQ8zXSI8nEOMrFgRPyT5lxH+cJVWNUv?=
 =?us-ascii?Q?3Q4kEMb0DyCb0b2OYpONazF6MIUJGjTELyh/3IiwuphEAOENlr280rZ01iBQ?=
 =?us-ascii?Q?jUC71igyIW54ZMOHdYeZAScMoG9b2Ca8khd8UIbR7UM++nfK4ir/XUqKE6n4?=
 =?us-ascii?Q?fIyMzndjkTYjeZRWuNUzNy1YDzd3QKNXWmh/JSuTjB03QZxzAL+kgpj9brj9?=
 =?us-ascii?Q?M18ppWHoTOWstxg2Mbs74mOmahwYfXKoN9oWZq9xaxap5rM3kNsA157qPuOL?=
 =?us-ascii?Q?ohk3MIAWBJSUS3Wbf9hb+kgmNZqZe99flKNNZb2pzKCYmeWa7HhJoftvqm3g?=
 =?us-ascii?Q?AqGwUV4/WJ00pbs5CbTodnlsaIZQKgYjdTtKLjyKf7nzd8SD3+HM4mfoctoA?=
 =?us-ascii?Q?P3s7+/uDrBeRimP8U4Vk47YYFkwUg4m3jzoSbZW/OtYlBwUbZR2l2cR5IK7j?=
 =?us-ascii?Q?P/pUZNvTrc8/khlbIJhg9RQAepJ+XjKOuYuF2PwlCkrfVjW303eeaKBK4ZVu?=
 =?us-ascii?Q?uk9sco6Kl6wVXjAtMN/GLEkDlwGu9vk0E0aRnFafMt8CuzeRWWd+P3kBFNHj?=
 =?us-ascii?Q?9mpr24CMchWpTIhg94sSmsmQ/ISXdR75JpK90iBKgPAvKexarUIBFVCd3YQ7?=
 =?us-ascii?Q?vOaTwjZx7VslgbZOB9U6Xr5G+6w0hz7kd6SF/JocLcqgIB1FMzx2LNOSh2CA?=
 =?us-ascii?Q?cQcH8LD1ej1qLmOB2inrjDdMiYVZO/+p62da0U3JC1fkmX3rB048QkBw8d/T?=
 =?us-ascii?Q?qvxUjcET18dZa69Pwy9niKMRFOJEuali0nlM+svju7jVitwPxlculyX+ywp1?=
 =?us-ascii?Q?ftlPPO21oOCREsWJFGv4JjI1ES95SPwQDh3MfMnTKPM3XpItarh4uf98rAq0?=
 =?us-ascii?Q?mW9SnWgextBKudSBH/o6kKE6sPOy1/rkSupEyGAFWm92CvefftGfJI/al44s?=
 =?us-ascii?Q?622wdnTTt68whvTmMvbVtuVt0zeo/uVcC+qtw+94rBn7/6kiLKCEsBKPiGug?=
 =?us-ascii?Q?JoZsojSddVdLibuR6ylOxteiM0D5XWGrt5AxoNNNhUdqBGZ+CBoBlqZxO4qF?=
 =?us-ascii?Q?db44XcYWFzGmb9GQli6FDY1TV1vtFjOVN8jgD+k4XLbtUeW3AUoTNr8+iinm?=
 =?us-ascii?Q?npCw5fPrKz3ihjnA7IYeas/MO7iwoFQgPR+msFUzlnf9itaG72WI/KmTnDso?=
 =?us-ascii?Q?pcqXh+8amrnbOKePEiI7ac+btGEJvu/JqtzdYEjnh0tgEF7fb49hdby5dH6l?=
 =?us-ascii?Q?nLCSPj140VhHUQGb+5Ge648Ih4aM22WJb9qMkWkJs10h2SdBsuFxid1Zsj3M?=
 =?us-ascii?Q?TfOqpV4iHv6Ni8BhygoNQHDDfBy9f/sVlXxCYlXBIIqnEOrPjwfr+UpgKdNz?=
 =?us-ascii?Q?HyJnvgFqgOuSMk5q+Vd/2vpQSATOoLZnN9c4a14M4dv9fTXJtQTXgSZK1Png?=
 =?us-ascii?Q?Knt8insx4varwKDioODh5SBYD5EneTpTCrri5cST+5eya8X3tz66+AMh+eHk?=
 =?us-ascii?Q?M1D4sAjmSqyDBIZ7iIgXIdAW5a/PfcLKLBd6Qzqo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a175f00-fc0a-4b11-4c09-08db7d1396f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 04:52:09.3229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSiMhn+i306+qsDcyDruLAGdIlsjk225Dcs/BYQtBDZVO+uXGeedcrl9F4Dnw0vKZ4zlnibnYtxZOXsG54LgRvty6jwx5ZNN3/sqmm0+r8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Sent: Tuesday, July 4, 2023 7:15 PM
>Subject: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
>assignment
>
>When running on a 64kB page size host and protecting a VFIO device
>with the virtio-iommu, qemu crashes with this kind of message:
>
>qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
>with mask 0x20010000

Does 0x20010000 mean only  512MB and 64KB super page mapping is
supported for host iommu hw? 4KB mapping not supported?

There is a check in guest kernel side hint only 4KB is supported, with
this patch we force viommu->pgsize_bitmap to 0x20010000
and fail below check? Does this device work in guest?
Please correct me if I understand wrong.

static int viommu_domain_finalise(struct viommu_endpoint *vdev,
                                  struct iommu_domain *domain)
{
...
        viommu_page_size =3D 1UL << __ffs(viommu->pgsize_bitmap);
        if (viommu_page_size > PAGE_SIZE) {
                dev_err(vdev->dev,
                        "granule 0x%lx larger than system page size 0x%lx\n=
",
                        viommu_page_size, PAGE_SIZE);
                return -ENODEV;
        }

Another question is: Presume 0x20010000 does mean only 512MB and 64KB
is supported. Is host hva->hpa mapping ensured to be compatible with at lea=
st
64KB mapping? If host mmu only support 4KB mapping or other non-compatible
with 0x20010000, will vfio_dma_map() fail?

>qemu: hardware error: vfio: DMA mapping failed, unable to continue
>
>This is due to the fact the IOMMU MR corresponding to the VFIO device
>is enabled very late on domain attach, after the machine init.
>The device reports a minimal 64kB page size but it is too late to be
>applied. virtio_iommu_set_page_size_mask() fails and this causes
>vfio_listener_region_add() to end up with hw_error();
>
>To work around this issue, we transiently enable the IOMMU MR on
>machine init to collect the page size requirements and then restore
>the bypass state.
>
>Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned
>device")
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> include/hw/virtio/virtio-iommu.h |  2 ++
> hw/virtio/virtio-iommu.c         | 30 ++++++++++++++++++++++++++++--
> hw/virtio/trace-events           |  1 +
> 3 files changed, 31 insertions(+), 2 deletions(-)
>
>diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>iommu.h
>index 2ad5ee320b..a93fc5383e 100644
>--- a/include/hw/virtio/virtio-iommu.h
>+++ b/include/hw/virtio/virtio-iommu.h
>@@ -61,6 +61,8 @@ struct VirtIOIOMMU {
>     QemuRecMutex mutex;
>     GTree *endpoints;
>     bool boot_bypass;
>+    Notifier machine_done;
>+    bool granule_frozen;
> };
>
> #endif
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 1cd258135d..1eaf81bab5 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -24,6 +24,7 @@
> #include "hw/virtio/virtio.h"
> #include "sysemu/kvm.h"
> #include "sysemu/reset.h"
>+#include "sysemu/sysemu.h"
> #include "qapi/error.h"
> #include "qemu/error-report.h"
> #include "trace.h"
>@@ -1106,12 +1107,12 @@ static int
>virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>     }
>
>     /*
>-     * After the machine is finalized, we can't change the mask anymore. =
If by
>+     * Once the granule is frozen we can't change the mask anymore. If by
>      * chance the hotplugged device supports the same granule, we can sti=
ll
>      * accept it. Having a different masks is possible but the guest will=
 use
>      * sub-optimal block sizes, so warn about it.
>      */
>-    if (phase_check(PHASE_MACHINE_READY)) {
>+    if (s->granule_frozen) {
>         int new_granule =3D ctz64(new_mask);
>         int cur_granule =3D ctz64(cur_mask);
>
>@@ -1146,6 +1147,27 @@ static void virtio_iommu_system_reset(void
>*opaque)
>
> }
>
>+static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
>+{
>+    VirtIOIOMMU *s =3D container_of(notifier, VirtIOIOMMU, machine_done);
>+    bool boot_bypass =3D s->config.bypass;
>+    int granule;
>+
>+    /*
>+     * Transient IOMMU MR enable to collect page_size_mask requirement
>+     * through memory_region_iommu_set_page_size_mask() called by
>+     * VFIO region_add() callback
>+     */
>+    s->config.bypass =3D 0;
>+    virtio_iommu_switch_address_space_all(s);
>+    /* restore default */
>+    s->config.bypass =3D boot_bypass;
>+    virtio_iommu_switch_address_space_all(s);
>+    s->granule_frozen =3D true;
>+    granule =3D ctz64(s->config.page_size_mask);
>+    trace_virtio_iommu_freeze_granule(BIT(granule));
>+}

It looks a bit heavy here just in order to get page_size_mask from host sid=
e.
But maybe this is the only way with current interface.

Thanks
Zhenzhong

>+
> static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> {
>     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>@@ -1189,6 +1211,9 @@ static void virtio_iommu_device_realize(DeviceState
>*dev, Error **errp)
>         error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
>     }
>
>+    s->machine_done.notify =3D virtio_iommu_freeze_granule;
>+    qemu_add_machine_init_done_notifier(&s->machine_done);
>+
>     qemu_register_reset(virtio_iommu_system_reset, s);
> }
>
>@@ -1198,6 +1223,7 @@ static void
>virtio_iommu_device_unrealize(DeviceState *dev)
>     VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
>
>     qemu_unregister_reset(virtio_iommu_system_reset, s);
>+    qemu_remove_machine_init_done_notifier(&s->machine_done);
>
>     g_hash_table_destroy(s->as_by_busptr);
>     if (s->domains) {
>diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>index 8f8d05cf9b..68b752e304 100644
>--- a/hw/virtio/trace-events
>+++ b/hw/virtio/trace-events
>@@ -131,6 +131,7 @@ virtio_iommu_set_page_size_mask(const char *name,
>uint64_t old, uint64_t new) "m
> virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
> virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
> virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn,
>bool on) "Device %02x:%02x.%x switching address space (iommu
>enabled=3D%d)"
>+virtio_iommu_freeze_granule(uint64_t page_size_mask) "granule set to
>0x%"PRIx64
>
> # virtio-mem.c
> virtio_mem_send_response(uint16_t type) "type=3D%" PRIu16
>--
>2.38.1


