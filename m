Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D86276AB2D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 10:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQkqp-0002Ee-LA; Tue, 01 Aug 2023 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qQkqm-0002E7-QH
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 04:35:28 -0400
Received: from [192.55.52.115] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qQkqk-0004dD-2Z
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 04:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690878926; x=1722414926;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k7NyhfMrU7pXSqD+MrN7iRFek1ENvHlqfiPDlD0xruw=;
 b=dhlv5hRtoMDFi32nwstI3N9AUMn2uWTSe5WTTZfLT98pQ3cVkvTHYCdw
 V9TmDidf9c/DP0IlAlQWX8B1YFcuCTMsrcRzV7W9X87tbwROiN0EZBoxF
 GyEV/sWQNBvFU6niL7PXkJvR9ztVMWkWyLqXjwEMKp1M5B5UP+Dare7Ls
 mRv04z7IBNDJDmIOaG+/+ZvI24NV0LBKHBFRtjdjpVqUKZsUgEfmY/qS4
 2v9IGtvkSPCQQiTf9jW+15e53A4ELl7YTJM4UXaJnBb3VNNlQMvTeIzqq
 VkWwBIhSsFsOYsyk0iIlkfe8MteqYkgLzhQE+kY0OjBZS8vP8xfnSgGNV w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="369231280"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="369231280"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 01:28:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728604779"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="728604779"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga002.jf.intel.com with ESMTP; 01 Aug 2023 01:28:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 01:28:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 01:28:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 01:28:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 01:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMXuWVWYG6Oh8mFSshUIRRT6EmdSjA13MkKOhCGz0+NargmNecy/e4W6s2WJWfcbKXGBcrG4Puv8NZBYfRrVjcqe5fjMe3xkgSVgww2MH3ZTB3YdCosMeMgJpYTGKOaHmYb38k1KOVg/AYcROcnj+9uqgVwMBWIdPMcaF4T0SOUxQ+OC1Uk++cBCM+NZ9Gn0ZQhg5e/6st1OIFZbUBDB2fpNpJdkK77fGqAssDgoYF21JBvxDep+WPQhrY/WjeAxtoTi+kJmIKT2W0m1uqoD98KKpmyGdUnI2nhYji9CBLGuIh8wDb2BEa4qF6O2p+eD9bCqXk56Ytr5nHnGbl/JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxgy0SsIsOtp4Uf7TGp9Nd7m1yHRzbTxT6VsOlSWJt4=;
 b=RokCLvpbDwSFc+KFXKVEW+WlhTyacBDFoF5DCyca4zVJeRUmepdiAkpXmBwmkyXLrsgdYn6ODxZYQRQL9UtOxqRVzIUhkIYd7oP/T8HnTkJxvcYz72kys3AmL9obJkkI7bnyVBdaS4BGhl1xyX2qkKLPRPvggp1y6Qa7i7rhCO4dPhZ/V6A3Gqiu6taZPFnI7o9vcET618m6s7fcXNIXKIeQijoBlTPWJPiFKnLXxnBKpFNyHTzkF5BagxkGrWRjMOKFZUUxf8NonfNx2ukDi/JAmDeqWhi2s+8U5q3Tg3iFdfddLb1drIUc8VDkyvlIPR3QM+hzk/ucFDNQ8j/+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 08:28:02 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d406:c54f:33b5:1569]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d406:c54f:33b5:1569%2]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 08:28:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>
Subject: RE: [RFC PATCH v4 00/24] vfio: Adopt iommufd
Thread-Topic: [RFC PATCH v4 00/24] vfio: Adopt iommufd
Thread-Index: AQHZtJP022BoYWDTBEap0F8lp4sSXq/VOl5w
Date: Tue, 1 Aug 2023 08:28:01 +0000
Message-ID: <SJ0PR11MB67442D288CD3705A0705CC21920AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6623:EE_
x-ms-office365-filtering-correlation-id: 7c981441-9f6a-46fd-5a65-08db92693883
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xlsw0M77ZVkvtUBJVVlI+Um2axvzl/kpHUU5peM0lbh6egsXIgI62rulV9SFrsG0iFTw+A5+WwP91PKF2UIGmQmW7reNEGUUsr3KZ6QaTnfgEE9j+z9vu3qVlNkIPfB/uG9UlufhVGy7CyM93PoWPxjPwo2JNbZ7pKFEvFJbD8UPOeHTojtJMaL8laBT8g7k/87zKwua1G7AY9TS4z8NUOc5ph3aNamqddKwgrWClTdMs8Ktb/I4Z+KoSoYxq+0X0skeZcv+tjXb/EBI0XW0fLPJ945IUUUY2CgKWiSjLuPPyg62Y8dwqrAJYjLJNrAvpd7jgAPdz5ZulXr5syu4IbfK6nJqxoSsai3UBdii+lG1RSwPnhhZciJEmne2yTkF4WJMhHdQYCx0jQNI59l12ncIyVgNhYIRZOH9et6KKaRwbzkbOSeK9rT5mF02TRwH5yfOPZKWyx2OlIfNFjnV72OlrDRX/ZeAW5zyFdzJXKMyqwtUqxIRuPMSI25sLCItZ31kMqcweB0wGdcXVQ+fLFJoz+MjOIs6UD5O4qGVde7K7qAmNfq2ycK1Lpt8Jt8My57oEvpVgv/PowGGakk5Lx8H84b9ihpudpk8rbSRxgM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(2906002)(5660300002)(8676002)(8936002)(52536014)(4326008)(316002)(6916009)(66476007)(64756008)(41300700001)(30864003)(55016003)(66946007)(66556008)(66446008)(76116006)(38070700005)(71200400001)(33656002)(26005)(186003)(122000001)(82960400001)(38100700002)(83380400001)(9686003)(7696005)(478600001)(966005)(6506007)(54906003)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/DcBiFjrGGTPWuOtFZn+VP5bQM2xHmIo8LMFdICNmfSQMO4eF3bHzKI0AFS?=
 =?us-ascii?Q?knSpXqvWAlQFMgRUqy/9TyaOCOTdZ6R+s6MJwkGWkhvY7blnw974Cjgt/prX?=
 =?us-ascii?Q?Wd3TRnlp0VmnFwsJAWDzopMpYVe1Min6sUTU6AfKu06FWBaa+cBvIJ/OcKg3?=
 =?us-ascii?Q?7/cfYZDfgrKHSLLDZgC7qtWlXgm06TYTTwqUuEc1DfLEMgiivx4IliaaZxgY?=
 =?us-ascii?Q?QE3LTMLOVe2B9xPRzh+3wElHjk0vPauLtg4/L4TLvhMuJEZwUijESD8DM4Om?=
 =?us-ascii?Q?EQlxhKpqGz6iAur/ymgzdFva/TPrgCRqeY9tBrgJ0saWcd3jQ6O2NdP5zYtF?=
 =?us-ascii?Q?EotKO+u0SfxtxZ5Actdr+O1frUya+UNPPlos+AdDE7USXqfeBQJ0tXRfBWAf?=
 =?us-ascii?Q?Ep45u01fraMe9m5z3cX6Z6HMLq0rip5x7mjba5yyOO4FL8ykkNO49E7xu4fu?=
 =?us-ascii?Q?nfhneNqsAhrbJFGdBJzxNUk0xp4crJORDYSkSoufKmg2qwAtJND30jKna5N9?=
 =?us-ascii?Q?EtD/qh9T0rIbDzyqXKx8dwNzyykA5WU88SDAALkoqw0FvitKO91Y0lFqdrdr?=
 =?us-ascii?Q?mH+f0/n4Q80zEbiQrV3Zpjm3NECE/2bZT9XVgHwIhHeFN7lq7463hkBF/EsZ?=
 =?us-ascii?Q?ZE6zIkVGtk45iGXqowZLAaUYx/BbrnakEvYx+WV/TW1G73ceatE1+r85Qunm?=
 =?us-ascii?Q?dNrNiiHjEpUVhBYtmCi5p42YpEprs3F3W6HAQWLd4zEIidqe5OzZnjnXg8p9?=
 =?us-ascii?Q?cP7/a7SBeL4mDQFMJHaa3mBchzzrw/2ra+zr5cFTpQbn6R0c0YOH5aRHFXIE?=
 =?us-ascii?Q?CxnsDRkFu182fRT7d8pZpxlEOm1a/NmVx+4fuwZxjgxev1wsLvrGNFciOl+x?=
 =?us-ascii?Q?h2R1XN10+Y3dCLaTedbP/X1C1qf4Xwa3nm/xS4iL8vK10MgJuOI1Dhnd8gKd?=
 =?us-ascii?Q?Q4OuVLfTfA1dZJr90Mg/2JFMUm4+0kVi/CPo0yD6HIp4OkQCnmxbtrAfTLcq?=
 =?us-ascii?Q?zIophXbH6kB3c4dwv1BYggpx+Imln9nbN1FfGLjn8DHW91goKx5qp3R13V1y?=
 =?us-ascii?Q?Q6mp4lAoYZcN/53Lqp01Ung2eiVVn66kHqA3SPO+8OKT/4U0nfEl9menOg8h?=
 =?us-ascii?Q?uEYpZPA9v4ZtwHTZT2fei1tI3V3ijglmdiEGpt6rcPmLhCcqiygNqcneetMe?=
 =?us-ascii?Q?Ke3cRaQOcNcWfQeoab5AUzjNEb3BfVklQBgwKAxeFLhi+PXGKUk+A6+6PtPj?=
 =?us-ascii?Q?nixV4xavwzVcCnKelcVftBX1Ya4zl98rXLGo1uMCQePcnkw0CPqq+iJ5Q+Vp?=
 =?us-ascii?Q?KCM21oBxLgznEcyH1aMew/pE6PZjswnP/5qTdmcQOr0prKZ1vOh1k++NvO0K?=
 =?us-ascii?Q?+yHjzmNPyymIzoUhD5G767N95u6WpynOSN/o1CdmhPrPKpPB24SlocgxcIUi?=
 =?us-ascii?Q?st8ub1537Cmyh9Qf8xfTAYG6HEyPGrKV6ZXcwrRYhmsN453Sfgs+tC8vNL5A?=
 =?us-ascii?Q?lTZIfKS3xpQJJP1AU8mwiKNiOPghsEOYXUXb08kG4CfdbRuWtW+9ta67K2cC?=
 =?us-ascii?Q?G9ZwICt6cIFDyy/+Lfn3nGJnV7xVS1qWWcX53Beo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c981441-9f6a-46fd-5a65-08db92693883
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 08:28:02.0396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UI27BLoOzVu+WyzSsHbmyuUrZ9f741tV/8jI7YxWhUOOjOBsaSw/fOhX2SlHOgX11uymWlObmgT1pNEp8fXGqOjcWFn98WY5rVTofFkHm18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.115 (failed)
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ping, any comments or suggestions are appreciated.

Thanks
Zhenzhong

>-----Original Message-----
>From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Sent: Wednesday, July 12, 2023 3:25 PM
>To: qemu-devel@nongnu.org
>Cc: alex.williamson@redhat.com; clg@redhat.com; jgg@nvidia.com;
>nicolinc@nvidia.com; eric.auger@redhat.com; peterx@redhat.com;
>jasonwang@redhat.com; Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L
><yi.l.liu@intel.com>; Sun, Yi Y <yi.y.sun@intel.com>; Peng, Chao P
><chao.p.peng@intel.com>; Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Subject: [RFC PATCH v4 00/24] vfio: Adopt iommufd
>
>With the introduction of iommufd, the Linux kernel provides a generic
>interface for userspace drivers to propagate their DMA mappings to kernel
>for assigned devices. This series does the porting of the VFIO devices
>onto the /dev/iommu uapi and let it coexist with the legacy implementation=
.
>
>This QEMU integration is the result of a collaborative work between
>Yi Liu, Yi Sun, Nicolin Chen and Eric Auger.
>
>At QEMU level, interactions with the /dev/iommu are abstracted by a new
>iommufd object (compiled in with the CONFIG_IOMMUFD option).
>
>Any QEMU device (e.g. vfio device) wishing to use /dev/iommu must be
>linked with an iommufd object. In this series, the vfio-pci device is
>granted with such capability (other VFIO devices are not yet ready):
>
>It gets a new optional parameter named iommufd which allows to pass
>an iommufd object:
>
>    -object iommufd,id=3Diommufd0
>    -device vfio-pci,host=3D0000:02:00.0,iommufd=3Diommufd0
>
>Note the /dev/iommu and vfio cdev can be externally opened by a
>management layer. In such a case the fd is passed:
>
>    -object iommufd,id=3Diommufd0,fd=3D22
>    -device vfio-pci,iommufd=3Diommufd0,fd=3D23
>
>If the fd parameter is not passed, the fd is opened by QEMU.
>See https://www.mail-archive.com/qemu-devel@nongnu.org/msg937155.html
>for detailed discuss on this requirement.
>
>If no iommufd option is passed to the vfio-pci device, iommufd is not
>used and the end-user gets the behavior based on the legacy vfio iommu
>interfaces:
>
>    -device vfio-pci,host=3D0000:02:00.0
>
>While the legacy kernel interface is group-centric, the new iommufd
>interface is device-centric, relying on device fd and iommufd.
>
>To support both interfaces in the QEMU VFIO device we reworked the vfio
>container abstraction so that the generic VFIO code can use either
>backend.
>
>The VFIOContainer object becomes a base object derived into
>a) the legacy VFIO container and
>b) the new iommufd based container.
>
>The base object implements generic code such as code related to
>memory_listener and address space management whereas the derived
>objects implement callbacks specific to either BE, legacy and
>iommufd. Indeed each backend has its own way to setup secure context
>and dma management interface. The below diagram shows how it looks
>like with both BEs.
>
>                    VFIO                           AddressSpace/Memory
>    +-------+  +----------+  +-----+  +-----+
>    |  pci  |  | platform |  |  ap |  | ccw |
>    +---+---+  +----+-----+  +--+--+  +--+--+     +----------------------+
>        |           |           |        |        |   AddressSpace       |
>        |           |           |        |        +------------+---------+
>    +---V-----------V-----------V--------V----+               /
>    |           VFIOAddressSpace              | <------------+
>    |                  |                      |  MemoryListener
>    |          VFIOContainer list             |
>    +-------+----------------------------+----+
>            |                            |
>            |                            |
>    +-------V------+            +--------V----------+
>    |   iommufd    |            |    vfio legacy    |
>    |  container   |            |     container     |
>    +-------+------+            +--------+----------+
>            |                            |
>            | /dev/iommu                 | /dev/vfio/vfio
>            | /dev/vfio/devices/vfioX    | /dev/vfio/$group_id
>Userspace   |                            |
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D=3D
>Kernel      |  device fd                 |
>            +---------------+            | group/container fd
>            | (BIND_IOMMUFD |            | (SET_CONTAINER/SET_IOMMU)
>            |  ATTACH_IOAS) |            | device fd
>            |               |            |
>            |       +-------V------------V-----------------+
>    iommufd |       |                vfio                  |
>(map/unmap  |       +---------+--------------------+-------+
>ioas_copy)  |                 |                    | map/unmap
>            |                 |                    |
>     +------V------+    +-----V------+      +------V--------+
>     | iommfd core |    |  device    |      |  vfio iommu   |
>     +-------------+    +------------+      +---------------+
>
>[Secure Context setup]
>- iommufd BE: uses device fd and iommufd to setup secure context
>              (bind_iommufd, attach_ioas)
>- vfio legacy BE: uses group fd and container fd to setup secure context
>                  (set_container, set_iommu)
>[Device access]
>- iommufd BE: device fd is opened through /dev/vfio/devices/vfioX
>- vfio legacy BE: device fd is retrieved from group fd ioctl
>[DMA Mapping flow]
>1. VFIOAddressSpace receives MemoryRegion add/del via MemoryListener
>2. VFIO populates DMA map/unmap via the container BEs
>   *) iommufd BE: uses iommufd
>   *) vfio legacy BE: uses container fd
>
>This series depends on Yi's kernel series:
>"[PATCH v14 00/26] Add vfio_device cdev for iommufd support"
>https://lore.kernel.org/all/20230711025928.6438-1-yi.l.liu@intel.com/
>and
>"[PATCH v9 00/10] Enhance vfio PCI hot reset for vfio cdev device"
>https://lore.kernel.org/kvm/20230711023126.5531-1-yi.l.liu@intel.com/
>
>which can be found at:
>https://github.com/yiliu1765/iommufd/tree/vfio_device_cdev_v14
>
>This qemu series can be found at:
>https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_rfcv4
>
>Test done:
>- PCI device were tested
>- platform, ccw and ap were only compile-tested
>- FD passing and hot reset with some trick.
>- device hotplug test with legacy and iommufd backends (limited tests)
>- vIOMMU test run for both legacy and iommufd backends (limited tests)
>
>
>Given some iommufd kernel limitations, the iommufd backend is
>not yet fully on par with the legacy backend w.r.t. features like:
>- p2p mappings (you will see related error traces)
>- live migration
>- and etc.
>
>About TODOs in rfcv3:
>- Add DMA alias check for iommufd BE (group level)
>attach_ioas will fail for aliased device, so I think that's not a problem.
>
>- Make pci.c to be BE agnostic. Needs kernel change as well to fix the
>  VFIO_DEVICE_PCI_HOT_RESET gap
>I didn't make pci.c fully group agnostic because pci device reset is
>device scope operation, force mapping it to container scope callback
>isn't a good idea. Instead I added iommufd code in pci.c and fixed
>VFIO_DEVICE_PCI_HOT_RESET gap there.
>
>- Cleanup the VFIODevice fields as it's used in both backends
>- Replace list with g_tree
>This TODO is not viable due to iterator callback depending on list element=
.
>
>- Add locks
>I think it's not necessory as BQL already ensure that.
>
>base-commit: 887cba855b
>
>Change log:
>v3 -> v4:
>- rebase on top of v8.0.3
>- Add one patch from Yi which is about vfio device add in kvm
>- Remove IOAS_COPY optimization and focus on functions in this patchset
>- Fix wrong name issue reported and fix suggested by Matthew
>- Fix compilation issue reported and fix sugggsted by Nicolin
>- Use query_dirty_bitmap callback to replace get_dirty_bitmap for better
>granularity
>- Add dev_iter_next() callback to avoid adding so many callback
>  at container scope, add VFIODevice.hwpt to support that
>- Restore all functions back to common from container whenever possible,
>  mainly migration and reset related functions
>- Add --enable/disable-iommufd config option, enabled by default in linux
>- Remove VFIODevice.hwpt_next as it's redundant with VFIODevice.next
>- Adapt new VFIO_DEVICE_PCI_HOT_RESET uAPI for IOMMUFD backed device
>- vfio_kvm_device_add/del_group call vfio_kvm_device_add/del_fd to remove
>redundant code
>- Add FD passing support for vfio device backed by IOMMUFD
>- Fix hot unplug resource leak issue in vfio_legacy_detach_device()
>- Fix FD leak in vfio_get_devicefd()
>
>v3: https://lists.nongnu.org/archive/html/qemu-devel/2023-01/msg07189.html
>
>v2 -> v3:
>- rebase on top of v7.2.0
>- Fix the compilation with CONFIG_IOMMUFD unset by using true classes for
>  VFIO backends
>- Fix use after free in error path, reported by Alister
>- Split common.c in several steps to ease the review
>
>v1 -> v2:
>- remove the first three patches of rfcv1
>- add open cdev helper suggested by Jason
>- remove the QOMification of the VFIOContainer and simply use standard ops
>(David)
>- add "-object iommufd" suggested by Alex
>
>v1: https://lore.kernel.org/qemu-devel/20220414104710.28534-1-
>yi.l.liu@intel.com/
>
>Thanks,
>Yi, Yi, Eric, Zhenzhong
>
>Eric Auger (9):
>  scripts/update-linux-headers: Add iommufd.h
>  vfio/common: Introduce vfio_container_add|del_section_window()
>  vfio/container: Introduce vfio_[attach/detach]_device
>  vfio/platform: Use vfio_[attach/detach]_device
>  vfio/ap: Use vfio_[attach/detach]_device
>  vfio/ccw: Use vfio_[attach/detach]_device
>  vfio/container-base: Introduce [attach/detach]_device container
>    callbacks
>  backends/iommufd: Introduce the iommufd object
>  vfio/as: Allow the selection of a given iommu backend
>
>Yi Liu (6):
>  vfio/common: Move IOMMU agnostic helpers to a separate file
>  vfio/common: Move legacy VFIO backend code into separate container.c
>  vfio/common: Rename into as.c
>  vfio: Add base container
>  util/char_dev: Add open_cdev()
>  vfio/iommufd: Implement the iommufd backend
>
>Zhenzhong Duan (9):
>  Update linux-header per VFIO device cdev v14
>  vfio/common: Extract out vfio_kvm_device_[add/del]_fd
>  vfio/common: Add a vfio device iterator
>  vfio/common: Refactor vfio_viommu_preset() to be group agnostic
>  vfio/as: Simplify vfio_viommu_preset()
>  Add iommufd configure option
>  vfio/as: Add vfio device iterator callback for iommufd
>  vfio/pci: Adapt vfio pci hot reset support with iommufd BE
>  vfio/iommufd: Make vfio cdev pre-openable by passing a file handle
>
> MAINTAINERS                           |   13 +
> backends/Kconfig                      |    4 +
> backends/iommufd.c                    |  268 +++
> backends/meson.build                  |    3 +
> backends/trace-events                 |   12 +
> hw/vfio/ap.c                          |   66 +-
> hw/vfio/as.c                          | 1555 +++++++++++++
> hw/vfio/ccw.c                         |  122 +-
> hw/vfio/common.c                      | 3078 -------------------------
> hw/vfio/container-base.c              |  146 ++
> hw/vfio/container.c                   | 1218 ++++++++++
> hw/vfio/helpers.c                     |  598 +++++
> hw/vfio/iommufd.c                     |  546 +++++
> hw/vfio/meson.build                   |    8 +-
> hw/vfio/pci.c                         |  354 ++-
> hw/vfio/platform.c                    |   43 +-
> hw/vfio/spapr.c                       |   22 +-
> hw/vfio/trace-events                  |   16 +-
> include/hw/vfio/vfio-common.h         |  109 +-
> include/hw/vfio/vfio-container-base.h |  158 ++
> include/qemu/char_dev.h               |   16 +
> include/sysemu/iommufd.h              |   47 +
> linux-headers/linux/iommufd.h         |  347 +++
> linux-headers/linux/kvm.h             |   13 +-
> linux-headers/linux/vfio.h            |  142 +-
> meson.build                           |    6 +
> meson_options.txt                     |    2 +
> qapi/qom.json                         |   18 +-
> qemu-options.hx                       |   13 +
> scripts/meson-buildoptions.sh         |    3 +
> scripts/update-linux-headers.sh       |    3 +-
> util/chardev_open.c                   |   61 +
> util/meson.build                      |    1 +
> 33 files changed, 5601 insertions(+), 3410 deletions(-)
> create mode 100644 backends/iommufd.c
> create mode 100644 hw/vfio/as.c
> delete mode 100644 hw/vfio/common.c
> create mode 100644 hw/vfio/container-base.c
> create mode 100644 hw/vfio/container.c
> create mode 100644 hw/vfio/helpers.c
> create mode 100644 hw/vfio/iommufd.c
> create mode 100644 include/hw/vfio/vfio-container-base.h
> create mode 100644 include/qemu/char_dev.h
> create mode 100644 include/sysemu/iommufd.h
> create mode 100644 linux-headers/linux/iommufd.h
> create mode 100644 util/chardev_open.c
>
>--
>2.34.1


