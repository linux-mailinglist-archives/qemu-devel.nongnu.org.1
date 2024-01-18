Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4866E831301
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:12:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMYE-0005lz-Vw; Thu, 18 Jan 2024 02:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQMYC-0005li-1Z; Thu, 18 Jan 2024 02:10:56 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQMY9-0005Ch-8M; Thu, 18 Jan 2024 02:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705561853; x=1737097853;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+H6H5v3lD2NJml+mj083Xt8iKGHTp9/lqs5Nhddjxyg=;
 b=BUcVgY+VWnpvyBB3O6eEIIBmP4kV0QOvQcByJlZrld4o+3KDwTxaPvWm
 sjVyLGgG6opzQy2H597eOe6WZMCBtxE2gam/M2HSJ5tLaVXfbWNDIkMrZ
 fOk1cTcmcmq0We/7Kzmw3GfQh9tY3TNaicSl65Sl6NC8+rdFgqbhyYHeA
 iHBznPZyFNU56yelTDDeiuQeDhilMytDAFuS4hMgxMv7UPc2X7tqrWx0N
 Jn9RPIv4zEFyU93YZzyODL6IUg0zmb0ju/2Zy4CHAmHaWlzR4WXpPD+c3
 BY3vRAq2CdtVVCmlHPeR1mW+zxrborwECPUREVBWG5rja1yM1cWI0kBdM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="390816538"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="390816538"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2024 23:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="323921"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jan 2024 23:10:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 23:10:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 23:10:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 23:10:48 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 23:10:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neNvh39NP5uz0J7Z46DNnUtsvQu/Si1cCWXmMu0Rajw5wVXU84LO53S7HqeZjjOD2KJGEAZws8rlcTjBtwM9ZDEPgOth/hzS/3X2eW1ZTTsIBYE7YElak+6SOQfp21+Sg4TfCInll32P/OTSmRipqFRt5TPFStgvTX6cNHcAomjqBVG3i53hLkz9h4vSOuBtuqSo5RJ1eGtyaRbotmi1mciKlIs+prJ39tQNrMQlvSXGudu7e5vheACoGWRoE4TIotKvyDuarGm8T2ETq1sNATxPb9LovVs9ij+fk0WzNIuWHPe9im4vOkJubUTn4BpZCKOPiuCcw++9QKKK6GVlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ65gqA8eCZ4TbAok2gR3PiHet1JZY6sxkwZFJJGczs=;
 b=BF7NrxjFEGNdEjoezx3PZZl/r3zbbH8GS9PRZzokg1vXhHnrgZkMeCXHNoQVOkJ/NuRzE3Dspk42sS2Gh+G6s5irm4kP40juOhb9CPdimWpNMnvIq7kmUUVrrl0kg05GWdfelbsoXSftr1SZlmuIj60c1Z1hWfWXfhKhlXOwWkPw1IWgdIfvGV6T+IpK6SmAV+CH8hMSgAK1e3rSGPQS3+98O9voM5H0jTd4rH7hAF1J961sZ9PLj4Cd+vbZW4wkHkGE9h28LiIugIm75sDKTh+HWH9EFMggyQ9MYTiX2CK7ULiWUidT5U1K8byWc6d6m9+djY7r8kxub2X/F3/fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 18 Jan
 2024 07:10:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 07:10:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
Subject: RE: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
 hotplugged devices
Thread-Topic: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
 for hotplugged devices
Thread-Index: AQHaSRvYYeFgLORM0EqKETYNluqp/7DfAs3w
Date: Thu, 18 Jan 2024 07:10:39 +0000
Message-ID: <SJ0PR11MB6744C50921CC63221A93C75492712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
In-Reply-To: <20240117080414.316890-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6554:EE_
x-ms-office365-filtering-correlation-id: 11253977-8bc8-4192-5035-08dc17f49376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvlKwDGwsh9wfOfIEQPQQc675Wr/WsAkxU38Ip1tGDvC60M1AcGS2CRNEIfdWEbqtaAOLp4aQBPcnoG5rBwTdCV2DDPkJ/UIT+fiTAL0TMvMUu5FTWF9oTQzvn/6nC7NYwnUKsvD4A0MKBIf0YDquSyQugFub3Be9qUsjp+MDgUP9DjyttUZwjbYepZeJXA0qGiP50wot+nmkazEs942oigldImlSHHPmjIUK0zR0lsgSE8cAlqPf2Itc50/RFKymaK5eNMEM2ZMRNkFOV11f5ox3WCBvViMXmMyPX+aKHYc6suH4cj4rSuBdgfRdLAQ0m7SN6jOwx1h87VgInMldGpOiL7/CNNhcRRbsHv6Gng/oSWK/k7enoQPgIH2rtDfw0imp7c492qOUDmvhaw3QYv/hnE/e8P8Z0U2dMxV2XIMe+UeEjezrP8e78cxMTy1Fvudn8S+t2qxc5BIxTB8dQXCCmu2IBNC+DH4m3n4jtfLwa4ITKVxtQyb2N7WDGP2Zd1/GfJ8jvAglS02AtG+TUm7obFYvz024b6UwhFFSfbJWjK2lD2mG0fjKcMwgVNJ75ScoXR+jmpTWaXi8dmBIkg7uCTfPwLaHDTnZszZzLYbjNcm2nupmpuJUtZ1tUKf6BXj9hwu/H45o1wb5sexGgvV01kiFN7Qk/WP5fweiJQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(64756008)(66476007)(9686003)(26005)(38100700002)(54906003)(4326008)(8676002)(5660300002)(122000001)(76116006)(2906002)(52536014)(8936002)(7696005)(478600001)(316002)(966005)(7416002)(66946007)(41300700001)(6506007)(66556008)(66446008)(33656002)(83380400001)(86362001)(38070700009)(82960400001)(71200400001)(921011)(110136005)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1OshuAd8dwqq5idxAesrAE4+xql5UXvr6X7aJl773g8Xn+pZOjsdJxHy/sov?=
 =?us-ascii?Q?yx5Sp+VRjOF9K5AeERjG1h1wE6y0yt0RKE+c0I5qb12KQI30wGlt6bGrlXkC?=
 =?us-ascii?Q?GL+Xvmfq/A+iDKp1aiaArdoSEh5aITOJxVhrFDfVSvoTAs7hSVceBiO0eOp9?=
 =?us-ascii?Q?Sv33KP9i17tDDWuF0x/vCh/iC6B1t9nihoCnAb8s0P6tmrTJOmNwCSAN67bW?=
 =?us-ascii?Q?Ynfwwpwm5cUpsZhjtR0AhqGFzfZV/s9s1EboG25aooUKpZwOQUSs/hj38ht/?=
 =?us-ascii?Q?yrzakomReJCxHdAkXg7CSw2C87de8SG2FnhYcq7tFgds1kh+QecpqnAHc/vs?=
 =?us-ascii?Q?ox5CQx/6DifoDh7pKz9qEo4y2Ie5CwVrX2k3GUknrG8IgWwg4SKjjbta8X+n?=
 =?us-ascii?Q?mhEmb2gLkl4wYxVK6l3mYjt/YMxnxGYdMuv6dBzJaFsHaAYCX5SuFeLbl9u1?=
 =?us-ascii?Q?4HfsQMY8DBcf2eW2K2MsOLl8HcjwOTwp0RplD+yyK05LXi3IZvoucRIWGeEY?=
 =?us-ascii?Q?z/QYdvZfv8QzP6KakgJq4TTzDq+W8wLFwqMGAzRkKzFKZKBJj+sT2vnN0FLD?=
 =?us-ascii?Q?+Q6hGmZ8S/0irR4Dq90QjrpCRirAiNtCAY10jz2qYDEcfp86d7IDqx3u9B1L?=
 =?us-ascii?Q?h41RKknwzM+fEWwLzFqkAUq9ZY9XRy/PTESao0IUwXPuYBQb7KrpaxFVzvqZ?=
 =?us-ascii?Q?hwZvvP7YGJZ0yiacLHtdmfCO01wZs5uyKVRQdIfAV0UbNtuMxsYoNeKD612x?=
 =?us-ascii?Q?QkpsnuyGmJY25pQbXWOUR3BIx8+0QMB2RDu3QrHfZYn1U+DB9qXepkefZQk1?=
 =?us-ascii?Q?uTU/Hrly4dp5iRIMkAQTHNOs6WyN2vJhSK6OfH9RH/ZLaKR4zgtlTx6Oo76o?=
 =?us-ascii?Q?xphMz0evBdjQszv/9VH3Cf5HrLpH9YNLlEssHvMYqdpIUCgqzGLuIbfQClii?=
 =?us-ascii?Q?/s27/O9Bn4BKbOWvgHJETK2NlFcYPmNbU2CiSMd0ceEi4UxZFSC8yf+NNP5J?=
 =?us-ascii?Q?rdYJKJCP7SHRkPNMcU+fXTSiUfij8ms73nQuM1N0JGshoD21+TfX+7cswOAV?=
 =?us-ascii?Q?FjlyAPAWZszKfxrc4s251geZXYd3yUEnD0QFLE3PGoxd56XG+j2iE+tyiJv7?=
 =?us-ascii?Q?4UyKXvuhWTTCnfGwvxEcyk7KkfRJelIWbg4hq+DrObXa/NeN+CPCdmlcGBui?=
 =?us-ascii?Q?XQfg9smKihGn94RNtquMm5BgslOInLsMj3RkgPn0lWm9wR8wm2TJcaw8J75s?=
 =?us-ascii?Q?0j8EqDPmkUzuQ/OCczqbNTDKjA8Gb/S0JaMw2ai7HPqLTyDwNM+1KMDZJudE?=
 =?us-ascii?Q?aYmj3P75ed/5a3fpbrj4FaHyR5Z4CPX9Dt602Cld+ZMC2E56Wof183NMyDtc?=
 =?us-ascii?Q?+gzrP6ND8cnFSkGTBccX5rA7yamFOpzhKQspRsK6HAG8XYL7yIUYOydqkrsd?=
 =?us-ascii?Q?0wSQSkte0N/C8G5TPfPcEYPaxIYxVCh0rkNJRzPDuk4sWwsG9jvxL9ScAe3h?=
 =?us-ascii?Q?HQoSDnb2Uz12q6V32O7k4XLqjCxW+kMBWIKs9uxHpOtdvyaGhhOr3R+FKXLW?=
 =?us-ascii?Q?grlfsxxV2qVb+xItFKanyv4pY8c4OQR99LwgsO1N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11253977-8bc8-4192-5035-08dc17f49376
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 07:10:39.2986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +A18z+8dKKuOPKJIW8rlEiebi5bzoNn9bRTH1TIwhYE9Oc8Tw6AmlxlBEfRHTkC77Hm1ogJZ+LWX3XWtnIBNPKhkARPXEb9qmpuAkNJ/zRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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
>Cc: mst@redhat.com; clg@redhat.com
>Subject: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
>for hotplugged devices
>
>In [1] we attempted to fix a case where a VFIO-PCI device protected
>with a virtio-iommu was assigned to an x86 guest. On x86 the physical
>IOMMU may have an address width (gaw) of 39 or 48 bits whereas the
>virtio-iommu used to expose a 64b address space by default.
>Hence the guest was trying to use the full 64b space and we hit
>DMA MAP failures. To work around this issue we managed to pass
>usable IOVA regions (excluding the out of range space) from VFIO
>to the virtio-iommu device. This was made feasible by introducing
>a new IOMMU Memory Region callback dubbed iommu_set_iova_regions().
>This latter gets called when the IOMMU MR is enabled which
>causes the vfio_listener_region_add() to be called.
>
>However with VFIO-PCI hotplug, this technique fails due to the
>race between the call to the callback in the add memory listener
>and the virtio-iommu probe request. Indeed the probe request gets
>called before the attach to the domain. So in that case the usable
>regions are communicated after the probe request and fail to be
>conveyed to the guest. To be honest the problem was hinted by
>Jean-Philippe in [1] and I should have been more careful at
>listening to him and testing with hotplug :-(

It looks the global virtio_iommu_config.bypass is never cleared in guest.
When guest virtio_iommu driver enable IOMMU, should it clear this
bypass attribute?

If it could be cleared in viommu_probe(), then qemu will call
virtio_iommu_set_config() then virtio_iommu_switch_address_space_all()
to enable IOMMU MR. Then both coldplugged and hotplugged devices will work.

Intel iommu has a similar bit in register GCMD_REG.TE, when guest
intel_iommu driver probe set it, on qemu side, vtd_address_space_refresh_al=
l()
is called to enable IOMMU MRs.

>
>For coldplugged device the technique works because we make sure all
>the IOMMU MR are enabled once on the machine init done: 94df5b2180
>("virtio-iommu: Fix 64kB host page size VFIO device assignment")
>for granule freeze. But I would be keen to get rid of this trick.
>
>Using an IOMMU MR Ops is unpractical because this relies on the IOMMU
>MR to have been enabled and the corresponding vfio_listener_region_add()
>to be executed. Instead this series proposes to replace the usage of this
>API by the recently introduced PCIIOMMUOps: ba7d12eb8c  ("hw/pci:
>modify
>pci_setup_iommu() to set PCIIOMMUOps"). That way, the callback can be
>called earlier, once the usable IOVA regions have been collected by
>VFIO, without the need for the IOMMU MR to be enabled.
>
>This looks cleaner. In the short term this may also be used for
>passing the page size mask, which would allow to get rid of the
>hacky transient IOMMU MR enablement mentionned above.
>
>[1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
>    https://lore.kernel.org/all/20231019134651.842175-1-
>eric.auger@redhat.com/
>
>[2] https://lore.kernel.org/all/20230929161547.GB2957297@myrica/
>
>Extra Notes:
>With that series, the reserved memory regions are communicated on time
>so that the virtio-iommu probe request grabs them. However this is not
>sufficient. In some cases (my case), I still see some DMA MAP failures
>and the guest keeps on using IOVA ranges outside the geometry of the
>physical IOMMU. This is due to the fact the VFIO-PCI device is in the
>same iommu group as the pcie root port. Normally the kernel
>iova_reserve_iommu_regions (dma-iommu.c) is supposed to call
>reserve_iova()
>for each reserved IOVA, which carves them out of the allocator. When
>iommu_dma_init_domain() gets called for the hotplugged vfio-pci device
>the iova domain is already allocated and set and we don't call
>iova_reserve_iommu_regions() again for the vfio-pci device. So its
>corresponding reserved regions are not properly taken into account.

I suspect there is same issue with coldplugged devices. If those devices
are in same group, get iova_reserve_iommu_regions() is only called
for first device. But other devices's reserved regions are missed.

Curious how you make passthrough device and pcie root port under same
group.
When I start a x86 guest with passthrough device, I see passthrough
device and pcie root port are in different group.

-[0000:00]-+-00.0
           +-01.0
           +-02.0
           +-03.0-[01]----00.0

/sys/kernel/iommu_groups/3/devices:
0000:00:03.0
/sys/kernel/iommu_groups/7/devices:
0000:01:00.0

My qemu cmdline:
-device pcie-root-port,id=3Droot0,slot=3D0
-device vfio-pci,host=3D6f:01.0,id=3Dvfio0,bus=3Droot0

Thanks
Zhenzhong

>
>This is not trivial to fix because theoretically the 1st attached
>devices could already have allocated IOVAs within the reserved regions
>of the second device. Also we are somehow hijacking the reserved
>memory regions to model the geometry of the physical IOMMU so not sure
>any attempt to fix that upstream will be accepted. At the moment one
>solution is to make sure assigned devices end up in singleton group.
>Another solution is to work on a different approach where the gaw
>can be passed as an option to the virtio-iommu device, similarly at
>what is done with intel iommu.
>
>This series can be found at:
>https://github.com/eauger/qemu/tree/hotplug-resv-rfc
>
>
>Eric Auger (7):
>  hw/pci: Introduce PCIIOMMUOps::set_host_iova_regions
>  hw/pci: Introduce pci_device_iommu_bus
>  vfio/pci: Pass the usable IOVA ranges through PCIIOMMUOps
>  virtio-iommu: Implement PCIIOMMUOps set_host_resv_regions
>  virtio-iommu: Remove the implementation of iommu_set_iova_ranges
>  hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
>  memory: Remove IOMMU MR iommu_set_iova_range API
>
> include/exec/memory.h    |  32 -------
> include/hw/pci/pci.h     |  16 ++++
> hw/pci/pci.c             |  16 ++++
> hw/vfio/common.c         |  10 --
> hw/vfio/pci.c            |  27 ++++++
> hw/virtio/virtio-iommu.c | 201 ++++++++++++++++++++-------------------
> system/memory.c          |  13 ---
> 7 files changed, 160 insertions(+), 155 deletions(-)
>
>--
>2.41.0


