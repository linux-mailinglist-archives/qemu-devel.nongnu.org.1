Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C46747C37
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 06:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGuYi-0001ck-Vt; Wed, 05 Jul 2023 00:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGuYh-0001a0-1n; Wed, 05 Jul 2023 00:56:07 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGuYf-0004RD-1S; Wed, 05 Jul 2023 00:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688532965; x=1720068965;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=geaDXtg7XBOlieEOd2GqUhRfWgMgdk1WPuXNikT2yeo=;
 b=FY5LFk4P0puxNZkZc4yZspVFy1tlfT27Lm5fjtdLwkj6wxOlXSBpZ17W
 zXSBxpyedxd6z7cZsmq813VmNyAencyOWDe+AHPQoCeMuY2K2X5oCD99Y
 sxbcnIpN1VlZiEM2faILFm+I7O3bBLoK7gGS8VqOT+TH6AwweDrRUa6EY
 4l3tP3heL/RlEh58B09wn2LM5Y6I2iivq4wy150XDZJu0IORs8c437j+X
 Dk6nuKbVBkz8jA/TR1BdtjerdUV9AA9Sx1dlU2ZWiyu4KuxsMxX2qawiJ
 6qH7JlUwA9gIGlmGQkqQ6eiFhoFxoWemZsaCJ+/UP6fzLPSWadn3fl7b3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="362112617"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="362112617"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2023 21:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="832377111"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="832377111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2023 21:56:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 21:56:01 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 21:56:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 21:56:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 21:56:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inJ5fRcrJDc0ste9VlT7oJptQkIzEyGLaHYcealel/ictoRhgMrf1AfqhApR0XLvMJXsUiDiEcQeVJo/vIQeBFkDlWyUy/Ud3iEYq5PtNmLniDSREBvlDXLBWHtQtrJiDFAzH2kYusOuntleutiT5m5XevdVS0y/Nb8xE0sKN9TSM/fB3mhlAxaV6nMzS4xAgMvYtXC6oTAsXo81U0Qeuahcb418NS/cJzEqiPKOxiID7y7kzpTA+3XV7ve2VmQm70C6lp4w2Jnx5KaZ/WB3eu7wnmxLNo2UOQMXq4preaxVxPsE8f5nGPd5EnOQ/WXRSnsw+ddJalPeJGyaCiGP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zfl0CACu3dKtEUH4DaLzAYT+H83DNWvXs6KKiiuGiM=;
 b=ZwlCbNGUjlXAHqwBV093URwLmu36a3tfMg4fLiNTbuxP4McEReVQZEBcWx3t0xwG8f0WRMOV38iVNzvHj8cHEmmPkxQKxgPvVlo7AcFxs7uG4CpwqMmF2OsQXBJ4mE/fxJaZPbGc2bHzoslCOikELybjiqL4gUtBJI1OmAZOOpI21H18+3KJpUeUg7Gac0LdS1/y7fdJk2mFifJiPPfmgUBdePcSEqTl3+SLbOWd2P/GazcL1xQZzKCfawR1R79fwvfscAII4vZr/A2MNJPcE609fGaXJxtLUZe9BEcHfYMDxOUjoQ7vXrIxigEWPchqtIErJ6WE8FhgwALIeMIymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 04:55:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 04:55:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>, "bharat.bhushan@nxp.com"
 <bharat.bhushan@nxp.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Thread-Topic: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Thread-Index: AQHZrmjmjixANg4+sU2QQB+pIVxfpK+qnCOw
Date: Wed, 5 Jul 2023 04:55:59 +0000
Message-ID: <SJ0PR11MB6744FA4E41101F7EED607E9C922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-3-eric.auger@redhat.com>
In-Reply-To: <20230704111527.3424992-3-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: d4e5e700-70d7-4f8b-e306-08db7d14202d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gj7UjfR9GWHAs3tOom4sCyfe9LI+jU6gUf2+AluFX4nBbrENVrm0b17iYQG2BlQFGXaa2dUiEcdIct54H8pkNaLJ4NAWm8a+zqBYQON5JSNXzIGyEcQKY9cGr64L7j3SDgDhopIDYLt/vy1GubjMtpUXJ2yuCsdzlSc+nH3n3Q1nKFRYQgl8BzPDQWBTNSboa9CBKXKQbtxH6dRMQRbRwweNy620tI4WhLd7bo8MItoDRLo1bK7nOLGtUvbiD/QeXBi3HyVwTaN7XMaNzwXvlL0asbQgjjjP6mYfaJTV8HdagviR4rC5c7S2C+wQi/ctKHEUftADXTnFOY0+1xgD3oUho9LYn1i7q7/+nhNeNigi/eeRs6CmLf9pqEvhME4gZw61Om8qVrZ1veOESTy7zxMBnBeSt88h4axXj7sFy0d+uGvsI9+T/lLRaSioInulYN6gFzOLoiEBVUfBil1Z4C6qq1Cq3ZZodd+bSsyrFNhAROwI/haF+byz4URgl/VUIM8GppD25TdTVxx/aEVss6cvdoMcvFQsfdOb2yG4yh80w6NN0dIlolwWbRZZuEwcDW6gAX2qMIkTFwBhl5Dk+MfvM+y0HkN5fRV0dZgkNCExMkjeIF1KQ371yglSr3Iw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(8676002)(8936002)(6506007)(186003)(26005)(2906002)(66946007)(76116006)(55016003)(5660300002)(52536014)(7416002)(66446008)(41300700001)(122000001)(7696005)(82960400001)(71200400001)(316002)(4326008)(66556008)(33656002)(66476007)(64756008)(83380400001)(110136005)(54906003)(38070700005)(478600001)(9686003)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aeRqTa1lVUnay2nk3GR8giWhednbXuf6xtMx4zh6O+5/koeS1/R42UDJu963?=
 =?us-ascii?Q?JJNVviFqnqt8PpkKvKQ4KvPBYfB1U/4y6+AyoGKqSP8+92UtOCzV/6dyp7Kq?=
 =?us-ascii?Q?DQ+NAazhnRu1vxEHf9nraKyB30PkXqqeaacu6Ad4l0/NiR/2bTajYZ+3dCI4?=
 =?us-ascii?Q?purmHHPxBw7UahGj144B2F+xFbsM2PgIJySNzc2dAE5mNKHa563kGnfY930o?=
 =?us-ascii?Q?SkpvbDFCcMKywSCZQJUt/FoeSrM9ghBlzuJ1VWtryiCm1Qd6bESQxKIAZI+8?=
 =?us-ascii?Q?rKkdu+JiSWw5XPWaUj49MBFBShzD5aZIH1j7nqD8phnrv0mcKQ02fTpxct/D?=
 =?us-ascii?Q?6HYnHg1DXcCwfX3WR1F/UjNjux3wXXJc1+qVVHli7aL0Y3BDqxXhXDQLAP/l?=
 =?us-ascii?Q?ZSyAdIWoM+vMM21aEw+8tGdoE9ayyU0XlRpzOhy5MEJhVROPodbLigKnODGK?=
 =?us-ascii?Q?FlrMhMtX2SQogOgR5pZsVZvQ7PmhSdQV7PEXLBtNA0KcALLWOXGIH8LmYaRz?=
 =?us-ascii?Q?8Iv8xd4DFEZcpMbleoGBcPsjaHjdPiFBJxlFORJvCxNyThvxF/Mn2mmrFMGJ?=
 =?us-ascii?Q?e7gPo9FKqZfXzCWkTlRkncibUxkMmt220gcHxup9zopHTfndeQ7v4I2HItx5?=
 =?us-ascii?Q?ABbt1BJKxEcZktWel4tPwpLycREms+ieEDu55Mm0/eUBx/Piv1J3RiHjTrfb?=
 =?us-ascii?Q?7oBrPghkG1wOpacbrRgvaTYPINggz60/DgW0cY9NAgc9Iu76hcjmPAkYWgPC?=
 =?us-ascii?Q?XQ7eVn3aCwjYxQRUp1fXGf40XUrdr2sCSiEYPSJ2ITufB8DalS+XmEjZQLci?=
 =?us-ascii?Q?68WKl7QJKM5WFQ7H4lBmdmowkYQjheXDCWIenX5mUu68ep+L8rtY0WF6RTd5?=
 =?us-ascii?Q?f2bt5B/tdwGvJ0h16TvvMiirQSc7fZiBKiJpHl/1vuBzJq45V9rj2ua/RKrr?=
 =?us-ascii?Q?QSTWYuEnuzkSzUAy6OrmBkbz/zzixmojEoezS7+LsjetlKGwWDryIKHh5V0z?=
 =?us-ascii?Q?l0gSNS9VdPjbEOG3uWIf4j4PRcH41jHilhJZDz6vR78TiVYkLGT1hVkLQ+SH?=
 =?us-ascii?Q?NWqfVqToUG3UJgPQFLhrKw7FQ2Y11ff5U0vqhWvKJWy3hlhmw0tFn9GstNOU?=
 =?us-ascii?Q?zIqmfsWqqOB2VZKoNokDT8VfW160zwtIKUD2neGhftU6ioW1+06fwp0mD4dk?=
 =?us-ascii?Q?cYWt0yLYuReFTCg9CEjokJSNbFXwGB/hdayGM7gG3GcEfzVwv5Be2efo8wLF?=
 =?us-ascii?Q?ICKUwnjdHz0X/ycMYVyuu7LlgVVtcTpVBnElaUfnGp8WSVCcHhWIb/jTOKdA?=
 =?us-ascii?Q?d6ET8iKRU+NfpPI6iIJ2ZOJvkaRcS5Hpcdj0vlIU9fIMgA664J8312+vBqcx?=
 =?us-ascii?Q?/eDtbpJhBgUH4BbIzk4hAx/FqnMtnJ1QfnbXwJgrGwmZM92r84YSQI56CkHK?=
 =?us-ascii?Q?iTpa4RUs3iF7/vh3sfCfjx5nS5C3AoyX1py2mz8WI5XNYEynOf2yczdDuFgy?=
 =?us-ascii?Q?PlSUS6SfuhOhDIKJR7WeLJ/fBG4EX4+A381IN8U8J7spwH61wX9NbKUVMyhd?=
 =?us-ascii?Q?+P4tuht+c3lkXQUxKx8AZ4v2ZzD3DgryUyDeQKJj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e5e700-70d7-4f8b-e306-08db7d14202d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 04:55:59.5308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oDkHiLxvXpC93JaOETMi3BjcyrfR8XyGaA1us21TKDd7+pI5J1C3VpdReKb2xQ0We2MH9u2UZTm9+R4rzA01SyROk/SItBCMh5k5QDd3FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
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
>From: Eric Auger <eric.auger@redhat.com>
>Sent: Tuesday, July 4, 2023 7:15 PM
>To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>devel@nongnu.org; qemu-arm@nongnu.org; mst@redhat.com; jean-
>philippe@linaro.org; Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Cc: alex.williamson@redhat.com; clg@redhap.com;
>bharat.bhushan@nxp.com; peter.maydell@linaro.org
>Subject: [PATCH 2/2] virtio-iommu: Rework the trace in
>virtio_iommu_set_page_size_mask()
>
>The current error messages in virtio_iommu_set_page_size_mask()
>sound quite similar for different situations and miss the IOMMU
>memory region that causes the issue.
>
>Clarify them and rework the comment.
>
>Also remove the trace when the new page_size_mask is not applied as
>the current frozen granule is kept. This message is rather confusing
>for the end user and anyway the current granule would have been used
>by the driver
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/virtio/virtio-iommu.c | 19 +++++++------------
> 1 file changed, 7 insertions(+), 12 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 1eaf81bab5..0d9f7196fe 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -1101,29 +1101,24 @@ static int
>virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>                                           new_mask);
>
>     if ((cur_mask & new_mask) =3D=3D 0) {
>-        error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
>-                   " is incompatible with mask 0x%"PRIx64, cur_mask, new_=
mask);
>+        error_setg(errp, "virtio-iommu %s reports a page size mask 0x%"PR=
Ix64
>+                   " incompatible with currently supported mask 0x%"PRIx6=
4,
>+                   mr->parent_obj.name, new_mask, cur_mask);
>         return -1;
>     }
>
>     /*
>      * Once the granule is frozen we can't change the mask anymore. If by
>      * chance the hotplugged device supports the same granule, we can sti=
ll
>-     * accept it. Having a different masks is possible but the guest will=
 use
>-     * sub-optimal block sizes, so warn about it.
>+     * accept it.
>      */
>     if (s->granule_frozen) {
>-        int new_granule =3D ctz64(new_mask);
>         int cur_granule =3D ctz64(cur_mask);
>
>-        if (new_granule !=3D cur_granule) {
>-            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
>-                       " is incompatible with mask 0x%"PRIx64, cur_mask,
>-                       new_mask);
>+        if (!(BIT(cur_granule) & new_mask)) {

Good catch.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>+            error_setg(errp, "virtio-iommu %s does not support frozen gra=
nule
>0x%"PRIx64,
>+                       mr->parent_obj.name, BIT(cur_granule));
>             return -1;
>-        } else if (new_mask !=3D cur_mask) {
>-            warn_report("virtio-iommu page mask 0x%"PRIx64
>-                        " does not match 0x%"PRIx64, cur_mask, new_mask);
>         }
>         return 0;
>     }
>--
>2.38.1


