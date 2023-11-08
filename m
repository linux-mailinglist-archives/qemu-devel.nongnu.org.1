Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 770CD7E57EC
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 14:27:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0iZ8-0002Dk-7K; Wed, 08 Nov 2023 08:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0iZ3-0002DA-NH
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:25:49 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0iYz-0000W3-Mh
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 08:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699449945; x=1730985945;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GnXyL+GehL7psf4iKXqMxqR5CeLDw4LfvDonVB68wrw=;
 b=FbPZNbNS3pOq05IKqWeYcMyB5W5vPtTYeyMRuu0lZNFjuam+jCYYxDSU
 H3w6TIcnOZdM6ZM2cPqT8/98rV5XRmycY8eOTdRcNzzoR9FC6tp1lDMbp
 agXLg8Gx61WvX1zrlMEnJAE8p2Ywoy/qF+owTy0BDWRARgOagvoEQSavP
 nIIXS1abaOrbajokljMAx305sbCLC83R2jit3PpTAqThnzTAIb+50iCEK
 WFtqhteXqmxWRLOYDkEW/RY37RhEqs+kjwZSPAeHH0K9tE/Au20g4hN38
 psWEr5R7T+Xw9RKE5GS2lUUVYuZj68XpXyEPcJrIXbQKOIVOyNjqIPNhJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="386933059"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; d="scan'208";a="386933059"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 05:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="766645961"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; d="scan'208";a="766645961"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Nov 2023 05:25:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 05:25:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 05:25:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 05:25:37 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 05:25:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyhDXm2d2+gR1jfGXXz9xSLsd90wrM4XH0Aq7jHuotc4CGD88QwnzAwmjV9gf0E51xGuYS5IZJiTeSsvFGLfAZ+6lKOBzNlni2DMGICZx8KtgSz+yTsLSlMGsGOkOjbuBz4+Z9OXoQSeDDHF0n8sy29kIUBFkHw/fAfolOO0GOsI+aawdhXzpTHvPzo4uA8gFwW+e+bcvP4WEeW477XVxYDS1K8KDSGlTx4uZjVgLJpLbosdnGL1LSLUKnOtbgSvv9X6QDE3zjOXMp8ST9GFTdtmW7Wky71bvNNhL2WczPyJ4/hd913GmvVXtABubN+DkraigBktegCoTFw6G+KT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Rg1eIoKqFm66T3dW47ezNbCtSCzmGjalhRNcJ2bFLs=;
 b=j5AZwGlpqyZalDHbIo9IW4RTnkIXAoB1Vxux917nNSTWB/4Do2SgByR0yusQQ9JPFj9j8+q8UYhbwC8bwsigsOPrZqmW++CASI014fexYwXXV7R5HRBqeP40m8Kj8fBuP2Vs3jLHhFG3vlBksvyW9sM4qgg60wjG/rCgVmvL6rPVy+CxkOSwdX9lW4vft8sx7RQB6ke11b/Lf0SfU779yzQiMUyjtyjPGvsHbHkR7d6V8daln2fdU3d8bsk7un49QZOzuNZ5OLorEz86uasVWu7V3JeY8+3vuJqYUtTRuZToidSKV3KeQtW3iYY0NCQ1WQxmF93ehuaq8hOxZDT+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 13:25:34 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 13:25:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Matthew Rosato <mjrosato@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, "Jason J. Herne"
 <jjherne@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Topic: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Index: AQHaDV58rXzWcAbguEiSUs8ukZNa17BvxJKAgABFgECAAF7hgIAABUPg
Date: Wed, 8 Nov 2023 13:25:34 +0000
Message-ID: <SJ0PR11MB674482451CB0D2A7BB4DC20292A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
In-Reply-To: <20231108124817.GS4488@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8386:EE_
x-ms-office365-filtering-correlation-id: 42b2ca48-9c4a-4f81-1147-08dbe05e302f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFWUiHsvZjx12EBKfriBWJF8NikZOmTeIsPeWYjtp1zykLb4axDHYV6GImKze8540qF8pgM7mA+zaiksorHyNXVMClEqALg+rf+87ig0botu3AECIwbIfnu2PGG7wRdwuZbnU2XNj28aD/QkkQupInzg1obe9D2Dg1iwca9FQ2Z8+7one9rzfJGalhMQxvdI4AwEpRhYxv0SvUnR7rw5zG+U0rlMKM25qVALhnpi+U984U92mCDiZXqgemL7vjt+yzs1kLAPhHgIuO3OuE9XzZ1EAX74WwaCP9pHcpVf6Ehg9LDvOCNT0o6pOKctGtrHuJPlcr5trsYd8ZBEVWabRtsQDNGnMkA5waLasWvFnWVZi/iHTtpZs5+vccpiZaLdFne6XNkumpiBxk5PngDoccX7j+kV8A8K86JamnzWuoJ1vbnrh3gUNoeNzuo+gx2h2KABAg6OC6adouTGQCzrwxCS3QRzectyfSUPnJXFyMYD7uDD4uIbn5WMkhf0qZL9dER5b2/cLN4h4IASuTWwNxkwCpYCjcHl3kRva3ZgS8hW7SmIB/saDYtDKuHtAZtQIFa9cNIhnxzxgXRpQY6mcXnH08710VbPAGdrvR2jmuURTfWRf6kJQFZQkVN5Fd8g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(38100700002)(7696005)(6506007)(71200400001)(83380400001)(9686003)(82960400001)(41300700001)(122000001)(33656002)(86362001)(7416002)(2906002)(5660300002)(52536014)(8936002)(8676002)(4326008)(66446008)(66946007)(54906003)(66556008)(316002)(66476007)(6916009)(76116006)(64756008)(478600001)(26005)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9J7rRh2/HKFu3IRob6DNxzVGgdR7/8AVl2i3jvUGBe+AHumipXecfpMGN7c6?=
 =?us-ascii?Q?G3xYgkjzV8afVjJR5V2PBqrkWoWSplUxXY9o0ALY0wjmHsqk4M9ZlxVuvp0u?=
 =?us-ascii?Q?OCWBiRQTnG09VIZBJzulbn8Lf259JsG6zio1L3axhjI9ehJeUIfKw3m8Pj1K?=
 =?us-ascii?Q?tDfMAtWB5A6ldleYooW+BYhh2IKxHm16pYA/kTto6Tn7dTXBdOrMUu2otkf0?=
 =?us-ascii?Q?tqcCJlkf3uj5aXw42vOOgAE3aZgNz/lYddxnuOPcEhQVSXezEP6ZlRfLimCn?=
 =?us-ascii?Q?kOoQKU26a0vtsaSwIyMgpnAFTFQNidxv60+WEsIBX4WWwCqgcYqdAl9qbD++?=
 =?us-ascii?Q?6JRqc4yfEE6Dp5W56zoPC8w7Ju68/xoDT8N3po+DxR6wqXFUNd3wWzy3DPws?=
 =?us-ascii?Q?MuaS9fRxMXcqcNeVzZYaTpA9EMN4qkmtUE5jmdCsF3UGdENDFhIlJ/9OhKoz?=
 =?us-ascii?Q?WUl/TDXZmVq3WPoKkexxw9PvuJPzDw8R45jPV1+A5CZ6cpFwPvi8qTpxvTwO?=
 =?us-ascii?Q?WIyWXFCNX7NeRwmqH3pafaRdf6f0azx8EPbCFDlg0k1/qzAPG67NyL0rIs/K?=
 =?us-ascii?Q?JFuVUlIGoh8E9vD3mdr75SW1997uTDK810k7DrVmIe5zX6cYKS2d8nnZywve?=
 =?us-ascii?Q?If3DorP//vA4pkXlDnuv8ZSTHEpN6pkcQhNigawD81SKexET1cn5MUGvnGOJ?=
 =?us-ascii?Q?hT10FzEDilnHPpJVHoi04ledY3gZ8LMF42pOtXzsrhxKKr/4f/aWv0EGRLnq?=
 =?us-ascii?Q?qOVw0ITwsGSflXg6wsm/nSiJm+Hf1toTKXGz6LzPtwIDgme1zI+kPrudTEbK?=
 =?us-ascii?Q?h9f52U6ChX8d4THWApjzTHDXhJWeDx5D7wLw2GsxWoC7/qbH75qLa77GuYNT?=
 =?us-ascii?Q?SQVoBJ7hIGmDsp85I8lB+7DBWkjK8wA1WqqcHQ8AW8FVAKVvDG4Chk25DLUZ?=
 =?us-ascii?Q?wDRyyLDvdDxZcCY3HUWPwrcS/dYB5bPS64ThJcn1O+Zb96utInOdWQLYK/Kr?=
 =?us-ascii?Q?wQaLrYbxJy1N2sRM+vP5+rHNbmKmec2K0stMB1hcuOF4Cy9HszJbCQRyOHLv?=
 =?us-ascii?Q?xwtoFPsG2s/kniozHidI2x/8gVpp+7dQdFavq8UtaP+QP65qqmYCdxxssu6A?=
 =?us-ascii?Q?zNosEduHuyLnjcQvZfN+v0feMZ2d3QcZmNChP6mO/rwGn0XGV0ca8du3nVr3?=
 =?us-ascii?Q?NN680s+HQQXnPTkOPJMDWCngXUepAdSauB0Vuh1ZzMGAwkK94393tWTvoljA?=
 =?us-ascii?Q?gde2t6IZVjhv+FKcHZNA2QXAz3iQlfN+CmFFlElfNRrsJHxq/1jmsi9mC9b2?=
 =?us-ascii?Q?BXw9Smwr/DKfTYIu0H8vJJ0rI15VnsJcjOXtQ/YL3ZofBmAwkmeHNZMex5bL?=
 =?us-ascii?Q?AcjbWg+OVdSLIDbyKENr1jDSmMCHKMH3wSnp0XdlbhUzXg0VfuDgqzlFgaBC?=
 =?us-ascii?Q?aaedbOv+p7l4za2z7lKuG1hsIzXavAK0XJsnjD3WPaahxQbSnMUtYjURMRXS?=
 =?us-ascii?Q?OTefrxerfg0NsUMRIz7N3I7A0Co0y4FMhDFrq2bF4XS1Q94wDMn1rmEDIych?=
 =?us-ascii?Q?KbpY1lNEIfoNc6oyplQ8HtwfxTiNvTiGxR2lsfdwOFQgpeWoTt1ailYYN19a?=
 =?us-ascii?Q?mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b2ca48-9c4a-4f81-1147-08dbe05e302f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 13:25:34.2825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6D8Y41mHj3H+mH++L1fklurnCke5f67cxlT3f/plg1z/30GgERD1Lx0RlMIXLlzv/3qkppGO+pCZDcGSPrExD6TtaXE1sDC8kOSn1B22nA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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
>From: Jason Gunthorpe <jgg@nvidia.com>
>Sent: Wednesday, November 8, 2023 8:48 PM
>Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
>
>On Wed, Nov 08, 2023 at 07:16:52AM +0000, Duan, Zhenzhong wrote:
>
>> >> +    ret =3D iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>> >> +                                     container->ioas_id, &hwpt_id);
>> >> +
>> >> +    if (ret) {
>> >> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
>> >> +        return ret;
>> >> +    }
>> >
>> >The above alloc_hwpt fails for mdevs (at least, it fails for me attempt=
ing to
>use
>> >iommufd backend with vfio-ccw and vfio-ap on s390).  The ioctl is faili=
ng in the
>> >kernel because it can't find an IOMMUFD_OBJ_DEVICE.
>> >
>> >AFAIU that's because the mdevs are meant to instead use kernel access v=
ia
>> >vfio_iommufd_emulated_attach_ioas, not hwpt.  That's how mdevs behave
>when
>> >looking at the kernel vfio compat container.
>> >
>> >As a test, I was able to get vfio-ccw and vfio-ap working using the iom=
mufd
>> >backend by just skipping this alloc_hwpt above and instead passing cont=
ainer-
>> >>ioas_id into the iommufd_cdev_attach_hwpt below.  That triggers the
>> >vfio_iommufd_emulated_attach_ioas call in the kernel.
>>
>> Thanks for help test and investigation.
>> I was only focusing on real device and missed the mdev particularity, so=
rry.
>> You are right, there is no hwpt support for mdev, not even an emulated h=
wpt.
>> I'll digging into this and see how to distinguish mdev with real device =
in
>> this low level function.
>
>I was expecting that hwpt manipulation would be done exclusively
>inside the device-specific vIOMMU userspace driver. Generic code paths
>that don't have that knowledge should use the IOAS for everything

Yes, this way we don't need to distinguish between mdev and real device,
just attach to IOAS. But lose the benefit that same hwpt could be passed
into vIOMMU to be used as S2 hwpt in nesting.

If you don't have a strong opinion to use IOAS for everything, I'm thinking
about adding a bool variable is_mdev in VFIODevice, checking this bool
to decide if attach to manually allocated hwpt or IOAS.
For vfio-ap and vfio-ccw, is_mdev is set to true, for vfio-pci, we check
"/sys/bus/mdev" from vbasedev->sysfsdev to decide if it's true.

Another choice is to add VFIO_DEVICE_FLAGS_MDEV in vfio_device_info.flags
on kernel side, qemu can know if this device is mdev by checking the flag f=
rom
kernel, this works even in fd passing case.

Thanks
Zhenzhong

