Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B050F7E958B
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 04:32:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2NfE-0007Me-1L; Sun, 12 Nov 2023 22:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2NfC-0007M4-5W
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 22:31:02 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2Nf9-0004ZW-ET
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 22:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699846259; x=1731382259;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Eui/Dj2pEVv/c3LZleqUeu7HmARCAD+WnYz8p08iPr0=;
 b=dVAJ+tiC4WGxK7smATFZbeuChvBeq2Ac3/NWkK/qZAlSHpItuiYjUP0T
 ulKwAGP4lnDBzrz2AdiEpfx1Zvjsve8tVNQEmgpx1vFht/n/xloC1p+2C
 dw7P5L/PiJu503k0gFzFuUecbLC7UVdotI/1hcccpBKp3/HLj1mUPgb9F
 Wy1z1ISpoZhPqnIlGwB9VeXPwCR2YUPJn4JchQUhAUepzsYDbguBOouLX
 JE2xa1TlATt5Zo3X+boLyFycrJqz9ReRbBPEJvIzMtnHZx4RGB/eWGk3n
 XLzUvCmbqS8VZkI3g1M1Nj6Xp7246FHD5DUoqHwj6yZsomOby4bRE4Lq4 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369700600"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; d="scan'208";a="369700600"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2023 19:30:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; d="scan'208";a="11983991"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Nov 2023 19:30:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:30:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:30:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 19:30:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 19:30:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou2zLb0mcijo/RLlfJeZ+eY7pJ4381B+Yd2GPjwOPmziqaS4QKuwoNubU0pI6bRv0tOtMGUC+sN3d0/0FIqq0MT1TRZcpaxEudapBXcNDnNlnqgwCnMMglEBfv2J0Cj5h8Mb/m2OSmSKS4/9ubvGFX+hPBbQPZISyhK5ArF7CgD1hWaXeTro8q/wGYVqRXV73KmJ+CGMkxBRPIWf0T2zajjZsBW0LG/9nQZC+Aic3bJVh+2KPSpFq7LJMSgYiDahsjNkAHOCyIJiqWIYz0y8aXUfx2lUTK/HGbeWx+8gsYSFBRhAE7p8EqtbzD9iyePHkQ9PjRjnM8U87gPiagXr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REzMsyzl5QuDWizp6XRhqX815ut0QpbVrnLud80g538=;
 b=UehTHwqIA9llzFyBxHsivXAHfmpgu16ha2xtiVwRHgakT7EIOefrKqkIU5rlx5O7CvhdeAIVrjpyZn26KW2rF2Jb9ygd+cSsCl1H7hbfiO/lPAboGFDKaU9oQ09JCi5ItyUliqNeuWAVnNhZ/HSA9+DcbvOh8mhIwMry8XlSIid/QF8u2ejDXehxTary0qRjH8goTUGN8pNUVXc9TncnTGS1xQ0pmw1MqmR2B7/aK6PtXD6CK08Trb4Y4B4qEmZuC3ST34dZ8Jcz5zDeDTOKEKPDH5UcdA1I+S3ukb+MPfUJjvozIwEnsKfmHcDPxWzWGHixCnxIZsGMJmkBfk9PoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB8260.namprd11.prod.outlook.com (2603:10b6:510:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 03:30:52 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 03:30:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
Thread-Topic: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
Thread-Index: AQHaEwR42BCiZCWwBkSSnflOiOwKYLB1aDCAgAIyjFA=
Date: Mon, 13 Nov 2023 03:30:52 +0000
Message-ID: <SJ0PR11MB674461D88CFCEA4C8C5A314B92B3A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-4-zhenzhong.duan@intel.com>
 <ZU++JT3FBbGhJIKH@Asurada-Nvidia>
In-Reply-To: <ZU++JT3FBbGhJIKH@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB8260:EE_
x-ms-office365-filtering-correlation-id: f75b289c-b754-4ff1-c98a-08dbe3f8f005
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bL361DsjB/aTesj/bUJ4UVBYcAufdQMkgXPgRzFF9X29FCiIbpxYLaLmanpV7aDIhRfg/ruGvK1Q9QTo1S4UH8JyaJFJCy2VgnMZ389Bwb4cXTlphZG4bS/3beRTTh1o31h/D3FpfA3U1BaJg0X0crQZrsX0hM41dWVID6vbcdTVGVai/UuCSmsHeWARStKwFasxWwpvR3PK/5Vz/uxtepQTQJ02Gvm4BmYSX+6vwGksbaau0CZXkHUSXXzjkHVXA3Xe57MiQx6M4G7wxmy0Bq9pmP2dOqSV6Ffoqa5qR+YtmNR1CATu1BSL/RG3xol31MLxJVKPUDJ8jswxc/FX/ykklgfuqpOyjWTa1+PXGFULd91lslNqnyV1y/L/LX0KoyFPiGcgsgbJYD1A3G0bATZgGU1CCfp5UUWwdTjgC4hQxuHWh8ic730g3BoEdoUmZjDe0LguimP46rZWS69z9o397FIs02978xtsLag7FgoDfJZKr4WYY6OuHJCc5NGpZG97XqrhnD4++ReqEejh5pfCc73Q2mYuaz/vnfhYjxgDDGcjsnKxRWOw6cdIJWlgwrLTFftkh/R1E9DdPmVwp5hublxNVswa2iUURazfaGdGQFf4k1lMb2A00XvdRnKJYPY121i7+gLJcAb2e03MZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(71200400001)(86362001)(5660300002)(38070700009)(33656002)(41300700001)(2906002)(52536014)(4326008)(8676002)(8936002)(107886003)(38100700002)(122000001)(83380400001)(26005)(82960400001)(55016003)(6506007)(7696005)(9686003)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yqLiuNuXeuBdyIQqZSS35IYnaNnM3bsIY0mqiVGZio0umsO/ZOpSuhyRPHSK?=
 =?us-ascii?Q?mVHFIydaczp914OUf2lU9fI9EeCWCaL/8LLb95+3wgVI6AK3jUOEm+IQenhS?=
 =?us-ascii?Q?jBH/2742Pc8dYHzteEQ+l3ZvTBFdQw0t75NG9WkadrGGlMMHTO5da5D5V0Hd?=
 =?us-ascii?Q?0XjYWAaTaflBKsw3/Zp6TvhKnPH0of2I1GjO164xQbIbq2NT7VuArZLwECst?=
 =?us-ascii?Q?eS6bROS9aLKzNHa3NEWpjxZf1PnjY890UImU945kW22HrcgauusAiqa41DUe?=
 =?us-ascii?Q?kU7AfpLwg21HJzAY691Z7SDxOB/Mi4YU3vC7qQEDPtsdDqi2wyUm7MTcC+cN?=
 =?us-ascii?Q?szFKOr4egXNEWYvyIVrPg+hp4mOOK/Cnj+Wj/KKPratTPbigM3WKfkuKRNdS?=
 =?us-ascii?Q?KNkyw7FKQdtk0HP6v178paocZsM0b1Mb8BtEKLeVSNWrnpgca/3Qs0kSQqwG?=
 =?us-ascii?Q?z5FLPNLIzcZDmZoB7ZpaFKXS2MCDKFL+mN9/P1i3gxuKizVYxtnI18dDI7yj?=
 =?us-ascii?Q?G/CZQHBgg3ygtob+IGSwUO3AFnPwyFJ9vQP/AoHydUm3sje6RKRF9XO3yM6M?=
 =?us-ascii?Q?IUD+SK6LpaGNJ+nqFqUg+ln9bVcTJ9KBIpKu3fzNSTK4zQhWPPjWqnpQUBSw?=
 =?us-ascii?Q?V2mByNCjxsegeAqu1KKiYUMKq0LhhrL30Tj9+c95vMqHRL0HFHRxmNC0EvIJ?=
 =?us-ascii?Q?C2WDMUNz8mmUwYukUJvP4aVn4y3iF39IhwKKbJQ7SgcJpBXnqrunsaUaGdFR?=
 =?us-ascii?Q?1k/4CARvJ3CUwpXu811rsBiSgxCCByX3gwGd6nSQ8d8jau8mjj+eFFRHTSnA?=
 =?us-ascii?Q?MflZNUd7ZVzJaUi5C40ngv0zp4QVTW+k8Hxz79HOgVUdKqA5BE2YO23+44Lp?=
 =?us-ascii?Q?CHDTAUlzliBybX5v5FHasZ31hagR1a75n8k3O9+61Mm2YVqujmx5cwkHIuAS?=
 =?us-ascii?Q?tDzUAMTk7sH+7Re4OILzHT09q1rw56b5PIeqnCKbJecooOAJ700Q3AKXGUDz?=
 =?us-ascii?Q?3DjapQAypimbdFLo5/xvbE8RgO3vfuN5RvB/lz3T2VGEhyaoHTfZRhWMnuZV?=
 =?us-ascii?Q?OHldMDeEUJiC5ti1YlUmnWeS/gHNiNoGOgk2FWj68P8fIBZ7F/fAbHCoUJLD?=
 =?us-ascii?Q?8BrHA01TAaEAoZz6b7yuGqIzQafqCIkWIPgw2lIAZWhH2LvLIciTaMzOF51s?=
 =?us-ascii?Q?EiNhHLB3mmiFJaFZBZBlO9C0D9Mh3/zPLSQE/QXG9NTYyMsl6SGOaX3l6nLt?=
 =?us-ascii?Q?k6YJzoV/SPuzsMS8xYn1aHD4m8Y/C9C2iklr2AuaviiqqvHAdorZpOJAv7MH?=
 =?us-ascii?Q?8dD816i0KnLPrQhMjREUZn2Zgg8WHcvuO3XbmgGTcJk25UPj17/T+EaNPLcO?=
 =?us-ascii?Q?zkJMDevYWW6BHEsPa9ggG2Mi7jC0std2hb8yBQfbn5yy0tOJI5bfhoLgPLZL?=
 =?us-ascii?Q?8iBd0rekvw156ncpL45i7+h/eqUI+Unc7VDBXtVYXHuMx8ZcSHQ0GL5fwlOs?=
 =?us-ascii?Q?00g5IRrwAnQWIsvSjt8BAM/bgFm5dmjXCzN+643N/cc3n+SFZkZKeuN8cOna?=
 =?us-ascii?Q?XudLgTvuO0UP1e5tufKgmMfH5MmhYOmRejLRL9sS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75b289c-b754-4ff1-c98a-08dbe3f8f005
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 03:30:52.0899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aX3e1aiyDHxJUIfPsbz+jB5DhHy0a2HvgdFFJumOEMCqe/FlxHvH4OmYqbrVPnJ4LGanbtvFR4mtiXfGgJ+xUJlxB3qPGDJLkA+iBd9kVoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Sent: Sunday, November 12, 2023 1:47 AM
>Subject: Re: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
>
>On Thu, Nov 09, 2023 at 07:45:12PM +0800, Zhenzhong Duan wrote:
>
>> +static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, bool
>is_ioas,
>> +                                         uint32_t id, Error **errp)
>> +{
>> +    int ret, iommufd =3D vbasedev->iommufd->fd;
>> +    struct vfio_device_attach_iommufd_pt attach_data =3D {
>> +        .argsz =3D sizeof(attach_data),
>> +        .flags =3D 0,
>> +        .pt_id =3D id,
>> +    };
>> +    const char *str =3D is_ioas ? "ioas" : "hwpt";
>> +
>> +    /* Attach device to an IOAS or hwpt within iommufd */
>> +    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT,
>&attach_data);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno,
>> +                         "[iommufd=3D%d] error attach %s (%d) to %s_id=
=3D%d",
>> +                         iommufd, vbasedev->name, vbasedev->fd, str, id=
);
>> +    } else {
>> +        trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
>> +                                            vbasedev->fd, str, id);
>> +    }
>> +    return ret;
>> +}
>> +
>> +static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, bool
>is_ioas,
>> +                                         uint32_t id, Error **errp)
>> +{
>> +    int ret, iommufd =3D vbasedev->iommufd->fd;
>> +    struct vfio_device_detach_iommufd_pt detach_data =3D {
>> +        .argsz =3D sizeof(detach_data),
>> +        .flags =3D 0,
>> +    };
>> +    const char *str =3D is_ioas ? "ioas" : "hwpt";
>> +
>> +    ret =3D ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT,
>&detach_data);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno, "detach %s from %s failed",
>> +                         vbasedev->name, str);
>> +    } else {
>> +        trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name, st=
r,
>id);
>> +    }
>> +    return ret;
>> +}
>
>Being a bit late to the game, I might have missed some review
>history here, yet any reason why we changed the attach/detach
>APIs to specify is_ioas? The attach kernel uAPI generically
>handles this without requiring an is_ioas input, and it could
>be interpreted to attaching both ioas and hwpt (auto). On the
>hand, the detach uAPI doesn't even care about id. So, I don't
>see a value of the is_ioas except the trace logs..

You are right, only for trace logs and error logs to be more accurate.

This also takes nesting into consideration, the same API will be called
by both QEMU cdev and vIOMMU. For cdev, is_ioas is true, for vIOMMU
which creates hwpt, is_ioas is false.

Let me know if you'd like to remove is_ioas totally or only for detach,
I'm fine with any.

>
>If we have such a hard requirement somewhere, shall we create
>an IOMMUFDPtObject structure that holds the type (ioas/hwpt)?

It's not a hard requirement. I'm not sure how IOMMUFDPtObject
can help on this, especially for vIOMMU hwpt attaching.

Thanks
Zhenzhong


