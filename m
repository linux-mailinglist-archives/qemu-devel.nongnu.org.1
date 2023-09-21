Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E81D7A919D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:05:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjCnD-0000mD-U1; Thu, 21 Sep 2023 02:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjCnC-0000m3-5g
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:04:02 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjCn9-0005js-Aw
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695276239; x=1726812239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cMiRQr5aWkcjk1tif1iTcJz9vzXQ0dU5UqJKaOohObM=;
 b=AYJS/RjP8/f8wZYyYm8e/mtKehWWLnmFI/zapIoJ9J0mzXh1crTuIAEg
 3DzgCpRUsCyYTix5N8PofE4MHbQe2uxWRygthokf2FK6YN17rmU+5cUx+
 Ed6EWLXXuLWiUGqrZUpF39AIn6/5uCgDNrmeI+UwpGrEnl6qBUj6FaZF3
 FG3CB12irYHNFihUoethL5nYkkPx0FDCfX+u0Xo/0bHijqMRWCgHpEW5c
 iuaWVJmOWV2BClSD/xXyRm4LB5JnhWQaZyZSnQ9ze20pRoTD+Z5PVgjc9
 4GXlndROZrhcioGZO9CywdBToNRgPbxqXu1eJYdRIzPuBHcUioVv61Nrr Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444529820"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="444529820"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 23:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723617101"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="723617101"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 23:03:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 23:03:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 23:03:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 23:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZ/h8kEnOtPu1X+1EWDpQdHjZWBRM4z86om9SA0jZm8/OTjVqsJzPTRbq68Zt7X7uM0AE0HrePIGaUK7rayNlJSYcVPFjOjy9jRMT42lcTmq1zNqebK0afRrKzuk5cUEVLav6CFbYq9vc0B667Kooz5h4hExHgl8wtMd7CGjKz5sTzRcbNBQMWHtxIAUyufG8ZQ4DzyzYubDu7qQh4YwBYbkjeD5xpj5BCUYR42cs80ZHkZFlVNjoW3pIt7t1jjDn1z7xrAoDeGxIICKyIoD5+iM7jf7GaAPJr0Bz+CVXnkwkPh7OnS6kQYmADGT66mNUpvmWRfvZUaFEN890qCcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDStreZZtj4cdCP2Ng9YSgTpprUHJr5gJKh562td6rI=;
 b=a/sK2sZ+Mxkx/VJKCFVMr0nwASdfgzjLcrXKYqh4bNG/RZgn9CYxxc+IfIeeGqCwSiH2cJpzB3iKoRHAa7uV3SALiSroYDFbZGV0F10RtyTCO7L0l0PEkvN05k0ZVj7peeCayFOikrXoOY6cJeb0MhmCgNr46HvpG+HKSBPuq5+YxDU3qQCZxwGZvqaB5uN2Bz6DGUxAGAK1fg5WfODwe/gB+POsEQytn06WGsjAX9Ro5tBahuweS00QhfQQG40Aw6yP9MqG5s005oPA3i9zWalYFyVTri8f8ibaWLHxK9bDUi1H9Zwdnf6LCAT7BHCDDJNBPhONtEu2rZLIQ0yHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 06:03:52 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 06:03:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Thread-Topic: [PATCH v1 05/22] vfio/common: Extract out
 vfio_kvm_device_[add/del]_fd
Thread-Index: AQHZ2zAjqlgYZoGXuEGtL1+wwj7B+LAkX5iAgACKURA=
Date: Thu, 21 Sep 2023 06:03:52 +0000
Message-ID: <SJ0PR11MB674451E167A95FADC6B3034E92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-6-zhenzhong.duan@intel.com>
 <20230920153951.2f2ebc1a.alex.williamson@redhat.com>
In-Reply-To: <20230920153951.2f2ebc1a.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: f701b946-a5fb-453d-9455-08dbba688833
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cF1e4iyglRX+w0XaiDNCOQGiOp/x4XwzFvt+0ma6wFf2dStbBZ/fHBXPJDFyKdLdyk4kXdVCyazA55z91Plrr1Opv7QMtTjtAWMnuDncK+UF+4ZYvNvrXqf+NVEaImPC21EScTtIRei5e3J5Ycbfju13B21WC8tgv1EuezgExSvSJyN3wN7rKS34os+MgaJIwWxvf6N/4Tg82KbIBhPL4mwjBaW/LB0wmjG+f4JLYxpCIXLCS90wJ0q6VFdhdKi0cJpP1vNc5ElUnGUVjlD/XWy5WglB7tbiHueeD7cPi6DrRNOYjwsB+3MI8pHq4vA6WEmYFErDtkyfRPtPX2ReM2RnR7ifjRAm1SrwjaWzsGR9fizwuZTIW+TGEOMcuDioGX1Q+/vwSUygEBuVwelwY1MkaEUS7t9atsG1At9Dnd6oHyzu8anDKYqY3vs2yayxhiU08Iz4ZPyVaze0MN3GsHJiq7xfZhOwYjVoyHzAMXwTPrrgP88ObrOnK7+w4K5JKxHFNLz+Vn3pp6WFpC6YXsmGbEGLoqO09yJDV1fNBA8Q0FsiMh8wPW3CMKTkXvGHHZDGDtYl2YyZvtb8eQoJRtZtlGLo3QHtBMDT0PAVNgRQUsEhhsFrvFIUxTIO0Bjn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(1800799009)(186009)(451199024)(7696005)(6506007)(83380400001)(33656002)(82960400001)(38070700005)(38100700002)(55016003)(122000001)(2906002)(4326008)(71200400001)(9686003)(478600001)(8936002)(52536014)(64756008)(41300700001)(8676002)(5660300002)(316002)(76116006)(26005)(6916009)(66946007)(66476007)(86362001)(66446008)(54906003)(107886003)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DGiJLF13y8hsCDtP68LJ2ftjpXve/naqbaA6qFZieYaVtKx3W8zObEPt72fM?=
 =?us-ascii?Q?8HEChRySth7Xnnw8oo2sWJTwLZBVfCtq/9FyTdwgveJIHXT8DOjY1b8AfkAI?=
 =?us-ascii?Q?jJH0CSO+rNT8vGcAmevuCHZnBkfmfs4jqDIH0YR+A+uBwgK2urqYv3N2R6GK?=
 =?us-ascii?Q?JX2Fnu0JIoj2RikkA/Fd1YnYwwRCBpq0TjPTjAzU0EA2c+bu9jMcgAsifPWv?=
 =?us-ascii?Q?luqyAAE7Zsl3jH7M7m/Um+eYXTYgXpFvDZZe7Ow5VyAisXtc4ig+vJfJfzzi?=
 =?us-ascii?Q?mll5+atFGLykLfv6g7mpeNeThz5pcO7aFv25mJmZ+uKQD0SfhBBYcn/PL7+k?=
 =?us-ascii?Q?AWjjuSZ/ju8nInzzHO0h2X9Nby3eiwSjC7JeUJILvieGjMuzVBGTE0U/c9gq?=
 =?us-ascii?Q?xHDROfQmJxGyfnnDZNM9A0VBQHfcN+4xLAFhu+rdlfQmdk4d0Y0Gf2HHMDQ9?=
 =?us-ascii?Q?8y0Rx0IFo2qw4KmkUg9gPJP8e/uhqb2RJkTAohYlcAe4hb/JHpYo6An1ezEM?=
 =?us-ascii?Q?FtYQjO9j2KHeHLZMqgSP7A67eQKsse4+oLUO4YydH5a/NB/r0/s7RMLv/HrX?=
 =?us-ascii?Q?SGuhfb6c0rtqvbv011dJFV08X6LIB0LDNlUSpnhhUQudcC79hIhXIa1VMKqE?=
 =?us-ascii?Q?xQAqFZAO/m/GBGsLW3AZqXfU8G1fHVehbkeoUYXhH9j/9KJFtwqpSd9asUHj?=
 =?us-ascii?Q?xrBvM6Fw6erQbObuvjKeGZ3rcjzQ3W9eqG7G1AMnlER+lhmkiwz2RTAJxkL0?=
 =?us-ascii?Q?D8oql3ZsdvZJEd+Yd2j7aTSH/sq0FWsuwuq/zZa+y+q8TBYY2JzJL7xa9ura?=
 =?us-ascii?Q?y/e2T6XCRuFCvjko0Z7qjA8Dh1GaY2k2eVOeJg5nvCSPGV0iHKO4L6Li2fkG?=
 =?us-ascii?Q?yLIJTEdf8ofWCF8poPssFAxsUi8oIcNY2Aezk/eQuZbOfQTyat58hOIA8hpR?=
 =?us-ascii?Q?Hn0I22vLSF8nl653UBswoxsmt+RCNeWSes5VqcISNNLSYXGW1Y39+qslab4j?=
 =?us-ascii?Q?+7MN5Akc2oGO4ozno9MWwsMbPo32cyNu5E59/4NzhS/rupUdaHnr/1oq/BAV?=
 =?us-ascii?Q?Jy2UAtshphtjZSxE3aczdNwptgg4neDczdalk8Qg4oy3InDIbf8LwVsiyRZE?=
 =?us-ascii?Q?H6ZyCbbGuIxRY9pWkOdIlWB8czVwvvly80ldFo4BbxAA3p8HlgUwiOjK3gQw?=
 =?us-ascii?Q?Ip97x2wmkZjtlGHIeL06Vb0ZiQ31kyne3G5QAyM9lUDgxYpzmI2UlRtk+oAi?=
 =?us-ascii?Q?k0UII+23xLo/7y9dF2j0PZOLmvgMqh+KUi7SN2/G6+KrDffkd54LSaGQ0CRx?=
 =?us-ascii?Q?9SZXiqBJjDdxWwJXXYp/N6V6oyN0NN0pQwMXb/niwQp//X4UCNI+oJXA+ZKB?=
 =?us-ascii?Q?O50T0UeLizbIo/oL3B3K/l710AItntEZC0IV72NlUKtkeE8U784DD7PLPRT8?=
 =?us-ascii?Q?FFye79eIksfL4wVLaZS2297IlkBTQhqUbHA+MMZ+KOGp+VioRnnuF2dDyUVV?=
 =?us-ascii?Q?yQntti5Y+elGj/pBKSIKpPcKmB3yxy9OCGU3sWSTdoMWsxEWge0HgLOAOGJr?=
 =?us-ascii?Q?irIYd/J12y4Ak/0I4AOoWiwEIPlPP/Em8AgCTOwtFYAqc4VGccBnDHAQIShX?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f701b946-a5fb-453d-9455-08dbba688833
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 06:03:52.7456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/7f92Te0tFC7+GxuxPydEaZ8ssz2jyr5tXOT2Gr07txXXkfsuHtWkfk7sjLOhNBEGQH5h6N4fks6PvsfF+jSGum9oWTDn+rVz1oTMwHVX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
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
>Sent: Thursday, September 21, 2023 5:40 AM
>Subject: Re: [PATCH v1 05/22] vfio/common: Extract out
>vfio_kvm_device_[add/del]_fd
>
>On Wed, 30 Aug 2023 18:37:37 +0800
>Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
>
>> ...which will be used by both legacy and iommufd backend.
>
>+1 to Eric's comments regarding complete sentences in the commit log
>and suggested description.

Will fix.

>
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/vfio/common.c              | 44 +++++++++++++++++++++++------------
>>  include/hw/vfio/vfio-common.h |  3 +++
>>  2 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 67150e4575..949ad6714a 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1759,17 +1759,17 @@ void vfio_reset_handler(void *opaque)
>>      }
>>  }
>>
>> -static void vfio_kvm_device_add_group(VFIOGroup *group)
>> +int vfio_kvm_device_add_fd(int fd)
>
>Returning int vs void looks gratuitous, nothing uses the return value
>in this series.

Will return void.

>
>>  {
>>  #ifdef CONFIG_KVM
>>      struct kvm_device_attr attr =3D {
>> -        .group =3D KVM_DEV_VFIO_GROUP,
>> -        .attr =3D KVM_DEV_VFIO_GROUP_ADD,
>> -        .addr =3D (uint64_t)(unsigned long)&group->fd,
>> +        .group =3D KVM_DEV_VFIO_FILE,
>> +        .attr =3D KVM_DEV_VFIO_FILE_ADD,
>> +        .addr =3D (uint64_t)(unsigned long)&fd,
>>      };
>>
>>      if (!kvm_enabled()) {
>> -        return;
>> +        return 0;
>>      }
>>
>>      if (vfio_kvm_device_fd < 0) {
>> @@ -1779,37 +1779,51 @@ static void
>vfio_kvm_device_add_group(VFIOGroup *group)
>>
>>          if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
>>              error_report("Failed to create KVM VFIO device: %m");
>> -            return;
>> +            return -ENODEV;
>>          }
>>
>>          vfio_kvm_device_fd =3D cd.fd;
>>      }
>>
>>      if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> -        error_report("Failed to add group %d to KVM VFIO device: %m",
>> -                     group->groupid);
>> +        error_report("Failed to add fd %d to KVM VFIO device: %m",
>> +                     fd);
>
>It's not nearly as useful to report an fd# in the error log vs the
>group#.  Thanks,

What about checking the return value of vfio_kvm_device_add_fd and
error_report in vfio_kvm_device_add_group. But that will be duplicate
error report. Is that acceptable?

Thanks
Zhenzhong

