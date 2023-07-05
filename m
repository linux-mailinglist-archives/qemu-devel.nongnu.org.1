Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B74E3747F42
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxht-0005bL-2W; Wed, 05 Jul 2023 04:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGxhq-0005as-2s; Wed, 05 Jul 2023 04:17:46 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGxhn-0007fE-Q2; Wed, 05 Jul 2023 04:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688545063; x=1720081063;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9N10Iwwo/H7sGxF/HarS4yeJ06DDtC9eZMPoUqecCy0=;
 b=mb9/kl2x9YSm50+9S4NGDwxgsLiYGLkwzI9bkyAACF0CvhEXyptlbbIL
 WEHk8XVZzraORato4I7ovKun3zM3VPqzSlU4OzIP6UNJBATTU6z/R3c4f
 RdkN0JB7W3W3USNlAzW1sB+JgG27usUnWB8gdcQeWtcZM1jDASLv0BqPy
 zccYWhyW1XiZ0N0jscMe2SJEV+uqtXqqlTSeVYsCybZHCe+01zNXV42GG
 r0IzcjkTENBTlMULs7HxrjnRUzgxTMfRDG2s4T1uhY3N8hlVvfyfb+dMC
 ShyP6D5Y75JTUofN0rRo0Qjouo/OroRHKhteWsez7wFav/8J2lZ5aYx2b A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="362146748"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="362146748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 01:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="748639418"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="748639418"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 05 Jul 2023 01:17:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 01:17:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 01:17:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 01:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMZ1gBIaZDkmns4Sv8pbmGBBIelA4Qdng5++SI0l/LF1tPfdsg0D4CLLiwDeridW0UsweHRxRyS+R7kp4Nufu6PsfoMdfAa3Nbr3gZ0jFW4Zk1n9hXFPa9LTJEUdsj9vcjZsBI6wm7bfcbN1G6doCYOcSAeajY+3bEQ97J5IyQ14hrkNr66BFALigDfKQr8lBF+pLmWtbmx9XmsGSSo/hRYxAPvYz/P4VWVK9f/DPU356XdwldAqIoVMkgb88gVSsDmQhTt7iRDd1nUR1gjHyA+dOiN6Xttbs7d4fmQOT1ax2tOEKqb7RS1edHgdU7DzDbGB6bSEj84ZtxC9xSk/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF/DiPmRuD1rAxI39yJjEi45JQDUNmA+Nu8FQhbptI0=;
 b=XgZYgxd4lGMBhUVqWfr7Q50BoVc8rP84hQOgWCMkzSMLC9q9LWU/o3geQqZ4kFihYuso+LyTBi2p9s+W3pj3GVVUAUhIhnUq6yE1OdPRaIWMMfon/HXOwQjqOUaxLHvPVwWZxZ4GOQ5RZXL4wGGgw83CkA3tLoVbQN5nUQGSGjiqOYYUBpYPKCEXv148/ma2dWefs+X0gXIiWraIaVC6J0Ssn34AkbE5YV62EeMnKy62lRRnJCxFwShit34x3iEDwsiXIljrX90Hi3nULeO9ai07Xr1TiugTPCOAG4xiudF7TUv+K/9AJh0FlF1RA/ttmdcZ+OuM7xu1W0IyRIUHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:17:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 08:17:37 +0000
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
Thread-Index: AQHZrmjmjixANg4+sU2QQB+pIVxfpK+qnCOwgAA38RA=
Date: Wed, 5 Jul 2023 08:17:36 +0000
Message-ID: <SJ0PR11MB6744AEDC41BE576A59908A30922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-3-eric.auger@redhat.com>
 <SJ0PR11MB6744FA4E41101F7EED607E9C922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744FA4E41101F7EED607E9C922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB8541:EE_
x-ms-office365-filtering-correlation-id: 5316f222-3bff-40f0-730b-08db7d304ace
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzwM72xrv14cI25KPazqsIQHMp9h4TKWGxnrb9bYOBAsFxt3tmBtagPfMRe2TKdAQJtQcLeemX++9WabmjjVW1txbzgaDWa295wlrCay1DDklE7cglDP4lxITgWX5ebIFDIadm9E+KG1B8OUrqujYQWpHj/iZgZTOKUzW/w6qnwKoFBGGRDCf48JtTRrps74NjtEsqxxz+G+mti2g2kc/itMcEySHUBesEuYrMSD+c1KTAtaqSIEWmVD19Swn38ye/QOlQy0ykTFXlbk3nRCBe98x5eaMu5FedxoIgwW+1b4eObPXD2OAp41Yr0fx0asHiqYMJ4UaCgAVpMdZ3Oi41QhZl6q5yOLDnNucc27cjEt3aR0m9uC1wldiqr+HgV3IM43T9lCI4rkiqiOHPve7ck93HJTP5FHSnb2AfF+3f66Fnts/+MeE4I3SFU9I/SrOX5Qz28VwZLUpv59SOE+rtTVPEq95MNAy1jSe0yipZfppIXrzF/HAPSXGm5jeLhrcuzYht6j2WubXExveyBRN8ozQ+SZxW9Dta/MBKpgv4BL4Y5hNqunAYz+UPfR2IdFjsJT3xBagAhmxWR+mmnnty5j0CSp2Ohq2p5AJCt9DtuACxMLRSxeqSaNbjwFGwGA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(41300700001)(54906003)(7696005)(38100700002)(83380400001)(71200400001)(6506007)(122000001)(186003)(2940100002)(82960400001)(9686003)(86362001)(55016003)(110136005)(38070700005)(316002)(478600001)(66446008)(66946007)(76116006)(66556008)(66476007)(4326008)(64756008)(8936002)(33656002)(8676002)(26005)(7416002)(52536014)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BxosOcpd0ETde6eMj7P1wLu0Pmoo14iH52IV2PHpxk9/yCpv/oZmwL5dCFwC?=
 =?us-ascii?Q?py3kNd6hx7NkYalgTr9QVgOWETyWPYIVcUn8gHeC/d07ucCFQAHkdZ5usXwL?=
 =?us-ascii?Q?e0WsjsPUD2TkhSsUnQ0nuZDmJ3Ba48hxCXp8NB328YK9J2zDZLjm0K1abIxJ?=
 =?us-ascii?Q?Y3o9hvA0g5ygUmxP9q6DSpoy4Trn/MH+Mebl4yIjfOP/3FHSLFshx1Xn4p9h?=
 =?us-ascii?Q?PcbrW6eGeuv6VkKCVmSIWIBqdM+84qU8HVh89csguHRb6ZnnJap1HyPPQ8pH?=
 =?us-ascii?Q?muO34xo4jvRr1nVoHzHiRdXXLKRIVZ4MUodmlahWpEm+WuVzb8pQfgy92oyL?=
 =?us-ascii?Q?YG58AbEyf8nDk3/d8BkOoq4dqWkrY1+MmNX6PoUzqFQmuLafcnIBgpYkOF0+?=
 =?us-ascii?Q?0Ol7y4KHBi3pj61A4w17y5moVFUenBFx5IUzEy7MAZ0VQo88qKCvlbpkYfaw?=
 =?us-ascii?Q?cohjp01Frgu8sEgsTtt2vYvB9p1IPmyWGL71jtaopfjY/3ALXvP7CYJOeKIF?=
 =?us-ascii?Q?PN2D/WMua4VCAekrpy6yoaqzBXd+NKgwanJg1sE7u+roTX8YXzlkLSsgS5gO?=
 =?us-ascii?Q?TzGS/U3609Es0kxAcVd9FOJxLnfrecFDdhTo7JEuGg+Ub43kpGn+9RbkSoUN?=
 =?us-ascii?Q?Fi7TCg0vSUBobgnndClh3DFXt3yLZ1XOaUkOHkB3Nw9o3I/ED843VVxEKREI?=
 =?us-ascii?Q?UZx3u0Cuae9NUojWiW+BB7Zts2v2R+m4EDbQa+zSg7ZY6nxu4Kul1L92uqQU?=
 =?us-ascii?Q?HK/aA2MqT2P1iUXbSnUuyLbhE5MtTMeJMgoj8fCyBc4z2yPlZNyGbxDP+B/l?=
 =?us-ascii?Q?nSs9q1y2rEDFFpAz7NsJhG0Dw64KqQ1DGw9Ioy8npr8q1ZN4nxOw8zIbf4ZA?=
 =?us-ascii?Q?aee3etGhEsVRG9tdQMus74gWuhHOB+N5X1L8K1uEj+DvX2Vji5PqbZAZ0KXd?=
 =?us-ascii?Q?ewh7bhR4fSE0alIYSAjeWcNYauEFBKBvH3o5qdg0h2cSOYq/G5oYvYz8xFrP?=
 =?us-ascii?Q?7KKDKepmIQntBUz+Z7JygPWZlqw3d5zsSqgjRdjH5RPopaW1wWvPryDEvohD?=
 =?us-ascii?Q?f0uAeeuiVGqk54FzYJWvKclMrw+dw08nhMjBO/ikPeDOZK0q967XMsWniLnp?=
 =?us-ascii?Q?vlk5bwhtU4nlanHjLDUPXPtitgXoMM8QuwDZhizUZFxOyai11RC5BRe9erx1?=
 =?us-ascii?Q?xScz39TWq7TazV/orWLwvw29FbwxsOZC55I1whB6upp4aRn8tgvmYZ4MA/Us?=
 =?us-ascii?Q?dB1iRAgTQ7yiVBb4F3uoz6yncLNGQqIDuk7iwmJjajgh8R8FucXvCduSDnSi?=
 =?us-ascii?Q?YHCG76TMKdPEwZgxLNalUgJ26xTQ4sljGNtM2+kEsT42IXRfO5htu1oMDrHn?=
 =?us-ascii?Q?TuESq/L3hys2Q8y4m4E4diuv0J2lhn7oUmkkU5/OZr8werMd7V2qkuDODP5S?=
 =?us-ascii?Q?89JGFptvu3P7TZaIZEUdspcC2bI62h8GWX4+8PTzX7QDaLtrDXa7H66GUGOa?=
 =?us-ascii?Q?8M+PGBf3i6w6ynJm9b+EK5JZ1Skq3jrkh4kOVknPgxDoiAZmU4sDDXGt6/Y1?=
 =?us-ascii?Q?TL7+8GPr0atDNX4/86Rxsaeeh9yofeIjbGyYFyOQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5316f222-3bff-40f0-730b-08db7d304ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 08:17:36.9408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ROGMU+cFMTa8LDZyxtjQtyUFg6TonY6ef4jUccihVSI33QXdw8OuBJfMacgmiAesbVTLRFFZjLYdPjGQMTPa2glj1rJ3iL5/6hhWUyQwXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
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
>From: Duan, Zhenzhong
>Sent: Wednesday, July 5, 2023 12:56 PM
>Subject: RE: [PATCH 2/2] virtio-iommu: Rework the trace in
>virtio_iommu_set_page_size_mask()
>
>
>
>>-----Original Message-----
>>From: Eric Auger <eric.auger@redhat.com>
>>Sent: Tuesday, July 4, 2023 7:15 PM
>>To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>>devel@nongnu.org; qemu-arm@nongnu.org; mst@redhat.com; jean-
>>philippe@linaro.org; Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>Cc: alex.williamson@redhat.com; clg@redhap.com;
>bharat.bhushan@nxp.com;
>>peter.maydell@linaro.org
>>Subject: [PATCH 2/2] virtio-iommu: Rework the trace in
>>virtio_iommu_set_page_size_mask()
>>
>>The current error messages in virtio_iommu_set_page_size_mask() sound
>>quite similar for different situations and miss the IOMMU memory region
>>that causes the issue.
>>
>>Clarify them and rework the comment.
>>
>>Also remove the trace when the new page_size_mask is not applied as the
>>current frozen granule is kept. This message is rather confusing for
>>the end user and anyway the current granule would have been used by the
>>driver
>>
>>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>---
>> hw/virtio/virtio-iommu.c | 19 +++++++------------
>> 1 file changed, 7 insertions(+), 12 deletions(-)
>>
>>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
>>1eaf81bab5..0d9f7196fe 100644
>>--- a/hw/virtio/virtio-iommu.c
>>+++ b/hw/virtio/virtio-iommu.c
>>@@ -1101,29 +1101,24 @@ static int
>>virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>>                                           new_mask);
>>
>>     if ((cur_mask & new_mask) =3D=3D 0) {
>>-        error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
>>-                   " is incompatible with mask 0x%"PRIx64, cur_mask, new=
_mask);
>>+        error_setg(errp, "virtio-iommu %s reports a page size mask 0x%"P=
RIx64
>>+                   " incompatible with currently supported mask 0x%"PRIx=
64,
>>+                   mr->parent_obj.name, new_mask, cur_mask);
>>         return -1;
>>     }
>>
>>     /*
>>      * Once the granule is frozen we can't change the mask anymore. If b=
y
>>      * chance the hotplugged device supports the same granule, we can st=
ill
>>-     * accept it. Having a different masks is possible but the guest wil=
l use
>>-     * sub-optimal block sizes, so warn about it.
>>+     * accept it.
>>      */
>>     if (s->granule_frozen) {
>>-        int new_granule =3D ctz64(new_mask);
>>         int cur_granule =3D ctz64(cur_mask);
>>
>>-        if (new_granule !=3D cur_granule) {
>>-            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
>>-                       " is incompatible with mask 0x%"PRIx64, cur_mask,
>>-                       new_mask);
>>+        if (!(BIT(cur_granule) & new_mask)) {

Sorry, I read this piece code again and got a question, if new_mask has fin=
er
granularity than cur_granule, should we allow it to pass even though
BIT(cur_granule) is not set?

Thanks
Zhenzhong

>
>Good catch.
>
>Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>Thanks
>Zhenzhong
>
>>+            error_setg(errp, "virtio-iommu %s does not support frozen
>>+ granule
>>0x%"PRIx64,
>>+                       mr->parent_obj.name, BIT(cur_granule));
>>             return -1;
>>-        } else if (new_mask !=3D cur_mask) {
>>-            warn_report("virtio-iommu page mask 0x%"PRIx64
>>-                        " does not match 0x%"PRIx64, cur_mask, new_mask)=
;
>>         }
>>         return 0;
>>     }
>>--
>>2.38.1


