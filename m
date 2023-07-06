Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61CF7497D8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 11:02:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKrd-0007k8-8d; Thu, 06 Jul 2023 05:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHKrQ-0007jO-C9; Thu, 06 Jul 2023 05:01:22 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHKrI-0006dl-Ow; Thu, 06 Jul 2023 05:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688634064; x=1720170064;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=izLICs78BUPs4Klisf+dkqAwYV6QeH10E3P/5lOrKLY=;
 b=VBM3WrOkp4HvvX8+CfLXlpgdREnREA1LWhJYVmKcUvTI9eI7Moi3yRt8
 wSiYwVQ03VnQMIG7TH3GA4P1Qb5y6yJdeaoydSRvvebT+rxlHqOYRdnMM
 JAkVRDql2kBHpYXG8F56TOYrglVCKpuc4heCTfnky3oCkOpzE+9GYqK3W
 OKZW/WJXnyaZ3pvwr/VNoPLAue5y/G8UqfLJaddmH58oPUSuVTX5Um+iT
 VqM5xIwC8LQ47MeSG/Kx6VS7ljPOzpwo1vY81IEpCqBYmVDqbWzt85cYp
 RQHp7PmJR+0EGLM0/ZvaRctmte3mxatzHYuJXxf5guHygtJufD7v+eyaQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363574997"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="363574997"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 02:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="832868333"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="832868333"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2023 02:01:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 02:01:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 02:01:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 02:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIPpF5DOOs0cPP5TvpWVjBedR6S9IzIP2Banef35jrCQg5tzALtSv0No+csYsKg9iVgGQC6+GCBvi4HVuZL9XzfcMUfRLo6Jh0iFbp/gq+DfrT6tE/Ua17hU4fX560zcRAzl3e3HT8Zj/DMnOp8QG1Wvb5IdH+/nrfRlAwnWhobMmpmftx9+ztLi8I/SaPBdZR2U+gB7+fjhOpaNWMK7I4Rbe5xJHoBx5KDbbB9l12NAK5H6bz7Ub+Sqsia0EtDvBKPJBvpv4hIJnOmo/67hIigTTZruP0V33VkrZILSyfA5pceWQoIOjm7rEfBl3Uk1aJhmtvig24KQIwHC4lhY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYdRp/Folb8BzwjLGH4kwzk+WiuucPdJBcAwrD1eZKs=;
 b=Qj7fhBys06m3XsYiOpuuYuHhQaY5n7QraP5gvDP+KLSPDAVNE0hXq71x46+SyBqtOXNzB+5AwF1vc41GvYnIrkEyGGzqxuaRXP6isOaA7s21hfCfD+XDGj840qnZcI/f1V2vX8dHZRaA3eL1kywzPzUzaKUz6tpLgnqPdcjkDJMEcJR5hv4MILijKJKQcYEwQBGGKoIVNY8tUZkZPOXxRnnQHbiXtY+1pavxDSB9wzV8xI4wj3YYSnDqBgaR3L9xT3tT0w37bbInznX5fVtvuvyLGfd7pwZIzTXM/C3lP1Tzx4UUtXBg2mwHzHogLZa8Dvwu55zay+sPGcSEGOc5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 09:00:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 09:00:58 +0000
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
Thread-Index: AQHZrmjiQzWi8iDMQE285Hu7NzFLv6+qlagQgABDBwCAABlkcIAAGgiAgAFmqmA=
Date: Thu, 6 Jul 2023 09:00:58 +0000
Message-ID: <SJ0PR11MB6744C671C7899DE1B81EF959922CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-2-eric.auger@redhat.com>
 <SJ0PR11MB674435F2BA42A8925ABA336F922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230705082902.GA2234638@myrica>
 <SJ0PR11MB674426C1F9AB893C82E371A4922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230705113305.GA2267040@myrica>
In-Reply-To: <20230705113305.GA2267040@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7258:EE_
x-ms-office365-filtering-correlation-id: 48ddcd27-1978-42cc-c6b2-08db7dff83b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iD/AWOEzhcg5C+LKI4c97SjtUvUN5546URUn6Tu5CrUzGm4ZDjqtvOBSyowb1zpiW7q5rGdYCU8IFEM9iHFuZi9lTS5pcnGcFko8O1hrIeqOLzjJoMvtkqiZiV64YtL4aUQczyMk4rWaRC4NUfK6Qz/93aawVAQsMQQ6/fMGLpcDcHzL39goRPJDwjT+Ec2heiWgqa9VFw4s+zpBYtRpKo+y3aHZzroXwJOc6vvad+scsq7bnC39JphPwPPPY45nYeOAdLCk4tOhQwUU4vD95iTwgfriebQoDZ7j1BTKB10ua/DAb8G3xPuYXeYl30mPB+rBJhd5ydv5Fju6lLb1rHccWwVxDwsb5GhzmvGWO8+uL9GvSceVir+pGrhFaqy4rlM9WrxYLjHbaTHTzxw+8SdjfJecRXrOILXGrdOECoG6uQoJv/QhKqbhyu8z+Tcuz3+AFiDUQTiDC/A8S2tJ3TnQsJ+1ff3j6bfHDnOgJXXVwJEyHGnrdakIsvTotwXFnrPB/kxXdlo00kcMkEPt3nwJ+HCwBKUV74/mHyuPLpeEZ8igA1nNMCI1LvROSbG73rFGuSOu1uGj7h1cTvgZoSAFhxFAR74f8zSYA384n+0xgNPCZmwWo0PofpUxqE9p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(83380400001)(7696005)(2906002)(7416002)(86362001)(5660300002)(6506007)(186003)(38070700005)(8676002)(41300700001)(9686003)(26005)(316002)(8936002)(66446008)(64756008)(6916009)(66556008)(66476007)(33656002)(52536014)(4326008)(66946007)(76116006)(122000001)(478600001)(82960400001)(55016003)(54906003)(71200400001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WSHZN+rc4oXIbH5K+cK3ozTjEAVzFsYpJUxWVDX/7qjZbVIi1vaY+LZGgxtc?=
 =?us-ascii?Q?mu778yw1qynEBMRJ/iE/DMMRkY9ZmptBMhoXtv9MuQFUB7z1l+rNLe0ZbCPG?=
 =?us-ascii?Q?dP5iLLNAfKLOZcai9kHZNdbFPiqtDwQnQHOChTRI+25l1EJXb1XK6Tbcx12T?=
 =?us-ascii?Q?sqyWhAMCYkjwFyd4Gf/H1Wcdb7ilSMJKMNQzEVfui6fKSguu6YR5UZM0ABnf?=
 =?us-ascii?Q?OCFYLs77e05xpxZSFm06XkoXHfdjGYjShT67Oz3vjahf+8THYG9NeZDM4aeH?=
 =?us-ascii?Q?FclhG01H6y5QnLs6KFwj2m0GNAAWkIuaQW5/97izaWI7WZCwoLOllzOqsSiZ?=
 =?us-ascii?Q?PUaQmAHuvF2vTMx23/J4hFCsV86b5JggMCVYs0K4r8Y5hWyiH2mEXWbr95fv?=
 =?us-ascii?Q?qgkAzCNo5Z5KfW+aaYp1/CKlOeUjtm4SvG44Xtl22ip45soneCvFBZLcZSWS?=
 =?us-ascii?Q?lwto9gSepY0Mg8Dlldd2Rmt9qE0pk09Veaxu0SG1MmIq2Ndp0dMNHY2OasRP?=
 =?us-ascii?Q?AFnHi6IXs46u36L7UcAgsVQOHVNC3THcj3DiCZZ3YTVW2JCNkm9ywFa4UOAl?=
 =?us-ascii?Q?GM/2/gE3JcfOc0tcxq6VSJ9xywwOlacw5kK3KG6ClGiWnRLtR8KAaNZtn9rI?=
 =?us-ascii?Q?GgRyTKom/myOZiSXXZv7pS4vJGH1/Yb/0VYnKWfUbW6KkKBnMnMm7AJxIzN8?=
 =?us-ascii?Q?cBQvfDt6whVp1e82qNPoXgHnc7B1DZLTf0XgWNRlHAhY9tfi0xeyP5M1MH82?=
 =?us-ascii?Q?3jBQWCwtOWKrbEogZACXONCO/GNZJAhWWVUj1tXHvMcRgYYcjOQMgeE4UQaX?=
 =?us-ascii?Q?rnzVjKngCK5eQVXeSM6wwz/iZB8LBjvexohVdla1PfYajOD81UOstuGbTW+e?=
 =?us-ascii?Q?sgii2LNAmaYMBKnny6AWb2o8TycpYiqjB/YZnFFbVZh3VLNeJ6qj/fpyuAbV?=
 =?us-ascii?Q?U/yRjoisO03v/807pPWcVR/kgqGtCt/86JFvDh7zmJPvOe1SpdFEVMVJO/n/?=
 =?us-ascii?Q?8mviWJPqkS/18Uu9I52CwBjNx1zyAyIF71awe/XppTG0474z0pyn+2x8ufCJ?=
 =?us-ascii?Q?19Zj1opNL89Dpr+ITOJS8Xuvm6ChfGDc49724gsYRq10jcLZqmkhEgzauGN6?=
 =?us-ascii?Q?AegUVtTr/fYCYu84BGxhmPb2JTyzQRcLDsnsiiuLjxnGbGxAi6i3JsjoB3ng?=
 =?us-ascii?Q?jW+1lSiq3+CLPy+PKYb4MeNpmJ+PCJl7fTTcWs1bN7cIe2oruZfSjxEsxk1c?=
 =?us-ascii?Q?AxQEWxJDZh0ulZ9cSDl8f8bL1UHfS9cjR7vMv74djq1cmI+u3/+n2GaISuEu?=
 =?us-ascii?Q?a0C1HGZztFpu+Kven4HjE0HG2xzPoxLo/VEF+ibDTbTRJKN1n5PijEcDw+je?=
 =?us-ascii?Q?GMbQqtSrsUTR95x6/FcvTqEoWUdVTSgBfM7b4SIt92Vc6SeKGg/2lvhrgPog?=
 =?us-ascii?Q?HPk6O9XOJBKKG8vd86IziyLwGFhMNpDPC8nkFbkQIXOGdcqjRPJOQuoA/egW?=
 =?us-ascii?Q?9hbhfzWfyPOoh4y/IfS8jq2gDTi8OS/QZeYnYKOsObGMA7krsWmrZ0g8EVKg?=
 =?us-ascii?Q?p14OhOvZmNiCLxgGTkVxI+DlE6dqeZuaXJLeQv4Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ddcd27-1978-42cc-c6b2-08db7dff83b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 09:00:58.2181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKlu22Ct8A4Mva6ZXNbhTBdwIZmB2X/HexEmZqH3pPNY3p3szQ4BWi6+hUXQXitGy4ycscrijTC5g5RP9dpHEMURIKrSLqE5FX95Xc725xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mga14.intel.com
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
>Sent: Wednesday, July 5, 2023 7:33 PM
>Subject: Re: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
>assignment
>
>On Wed, Jul 05, 2023 at 10:13:11AM +0000, Duan, Zhenzhong wrote:
>> >-----Original Message-----
>> >From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> >Sent: Wednesday, July 5, 2023 4:29 PM
>> >Subject: Re: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO
>> >device assignment
>> >
>> >On Wed, Jul 05, 2023 at 04:52:09AM +0000, Duan, Zhenzhong wrote:
>> >> Hi Eric,
>> >>
>> >> >-----Original Message-----
>> >> >From: Eric Auger <eric.auger@redhat.com>
>> >> >Sent: Tuesday, July 4, 2023 7:15 PM
>> >> >Subject: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO
>> >> >device assignment
>> >> >
>> >> >When running on a 64kB page size host and protecting a VFIO device
>> >> >with the virtio-iommu, qemu crashes with this kind of message:
>> >> >
>> >> >qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is
>> >> >incompatible with mask 0x20010000
>> >>
>> >> Does 0x20010000 mean only  512MB and 64KB super page mapping is
>> >> supported for host iommu hw? 4KB mapping not supported?
>> >
>> >It's not a restriction by the HW IOMMU, but the host kernel. An Arm
>> >SMMU can implement 4KB, 16KB and/or 64KB granules, but the host
>> >kernel only advertises through VFIO the granule corresponding to host
>> >PAGE_SIZE. This restriction is done by arm_lpae_restrict_pgsizes() in
>> >order to choose a page size when a device is driven by the host.
>>
>> Just curious why not advertises the Arm SMMU implemented granules to
>> VFIO Eg:4KB, 16KB or 64KB granules?
>
>That's possible, but the difficulty is setting up the page table configura=
tion
>afterwards. At the moment the host installs the HW page tables early, when
>QEMU sets up the VFIO container. That initializes the page size bitmap
>because configuring the HW page tables requires picking one of the support=
ed
>granules (setting TG0 in the SMMU Context Descriptor).
>
>If the guest could pick a granule via an ATTACH request, then QEMU would
>need to tell the host kernel to install page tables with the desired granu=
le at
>that point. That would require a new interface in VFIO to reconfigure a li=
ve
>container and replace the existing HW page tables configuration (before
>ATTACH, the container must already be configured with working page tables
>in order to implement boot-bypass, I think).

Thanks, clear, it looks different from x86. For x86 guest, 1GB mapping on g=
uest side
may be shadowed with 4KB mappings on host side in my understanding.

Regards
Zhenzhong

