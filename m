Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC0D77F05F
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 08:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWW8Z-0000Od-Tq; Thu, 17 Aug 2023 02:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qWW8X-0000OS-6v
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:05:37 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qWW8U-0003Q5-JT
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692252334; x=1723788334;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GZgiA5OZMdQ6anqmPeTce4eIhIttqF32pGczvhtxe4E=;
 b=jd2piT8Kyw5wAo9jozMtODONsy6VM4G6Ux3d/8BNejzzTKht101rasfi
 f/89Q5CoGBlcy5ZcxqVqrhZLd/5CT2escuKmRx/v47akVjqfpxNltqspO
 7daR+xFAIjzY4oUI4AtVG0R23tJsf+48MAmtJbhLqXrSJWnutZSA5PEAU
 WN/pXyhZNzlC8MIbd7MawxBg+xrVoC6IM+D3owNU7khxe99d1vBxJjgRN
 v1uYa6Ny6qEFboBv59vpHM2Ampf7dcnFtCihOrizzg5RZBEedumqUEy4/
 wq9Tt4KhOjJO8gTLU3LvUoW7JoGjej3f2cdtwCHzjec6Ha8e2LZMIcEby A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376457464"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="376457464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 23:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="684314572"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="684314572"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP; 16 Aug 2023 23:05:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 23:05:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 23:05:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 23:05:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 23:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVdIZyDY0KTzYNIb+1jx3NMS693b8yqMGYQ0AtCee3xzzEhmslSP/r11tbqxEJu+kXxT+9NWerPmAD25c7r1qmm2lb3sgVXpi6v4wXvGwcpVimd00P15cH/2Lk9fdwmJXI8M+m+ftOLesolwpJrUb0cbKfS7HEbWAVIirqhVngYfiv5ytbkP39M/CZrGFo7Jco7bb5I1+DH4Kim+nNVimu00avvUZvtFuFWHwuUwWbzTYV49q80XPlgCT0/GEfEbokfjXgE4HfR8UTi6rWx2icWNxKaoRY+OzKgfhD3ckIC8awWpr9EMA5KaiHnFpf9vaHktzBpZSvLLnX0C7/8BtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6Ey3AwpRaDHIiuEte/sgORThEerrGSJY5m9hQy9P/s=;
 b=Kib7ysMfMlRQ860kF3BkRVmLG8L9I0l2exBlB/67KQka7SRHmuht8EQS9YLHSYLZrzGYGBd+esL4ln4VzO+6aufwALs/prWwECuFKl5U2D81j5JaBB7pfr0lOgNk6iXV5QnP0tuekE1ieP03aFNo4zYJRa1fxWYJroGFIl/Z8jkFsduqpS8guYLzRcTJzlRtyHvKttYHyRBIQa3aXxcb6cQknxwJCfZ4m+864FUcJqQlpMK4Yk8QGnOhri616Ay2cMcArkaRDzTr3g14o1l3CDNdOaoBquqR9QwlAffm5y7WLYAZYgocjelKvAJFJCYLoX5pUc90QjF3Zen27ZvOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 06:05:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::2f37:eebd:8bbc:e0c6]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::2f37:eebd:8bbc:e0c6%5]) with mapi id 15.20.6678.025; Thu, 17 Aug 2023
 06:05:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [RFC PATCH v4 21/24] vfio/as: Add vfio device iterator callback
 for iommufd
Thread-Topic: [RFC PATCH v4 21/24] vfio/as: Add vfio device iterator callback
 for iommufd
Thread-Index: AQHZtJQggPlFNtBxt06+3gyHKaaW36/uM8AAgAAEBaA=
Date: Thu, 17 Aug 2023 06:05:26 +0000
Message-ID: <SJ0PR11MB6744EDBF756FEECF47ED8667921AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <20230712072528.275577-22-zhenzhong.duan@intel.com>
 <ZN20sOmGkTQtGso8@Asurada-Nvidia>
In-Reply-To: <ZN20sOmGkTQtGso8@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7243:EE_
x-ms-office365-filtering-correlation-id: 57e65483-3ea2-436b-95b2-08db9ee7f367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZodFQif+MPrMgajGkPuZexkcOeTchMw8FpwSikPQDPnN44D3KIJpUFXgTp0bDnDbrMjfc1MKz3dwVcmr2WB0xXabE3af03SwLX2zKiB9+VTrrcpB04cC9Fd1rgfRsCsoaD3eWPdv+GqGm93tpkYo2npyYPE/6X49wXpU9fol8Et0IRLjMT0G9EJIZye1MXHBi5zVCHZq2fg0RnsAPiQt5dMAn0lb9v0pdIKWb1fcbVOD4VYsUy1o0ufMdKI32GMIjT/AcAqkCBvLCfd+IcZHbcsY80k9F7yIhdYS0/ABHtDiOKjCQynrU7yh5l7+22AwjGzfFhCSXSmBRP+nwr57UOZ5ptN3NF8Cyw2iJRH7fX+dNtCPjHNaV8RDD71PU3QjgdQbDrqsDrSDdgKPJIa0WKJryXWoVYRz3UzRz9q2die5+mspOBIa8MOJ4qPq9ulogu4s5o7gb/2Kp2tSViRaIGGC363LhISdMC85jtuoOFkJ/m4H21aW9WQ4+S+iAVmgoVM7aJbMjhd+F+y9BvBKB5xpyEVm7M+Sf02cb2b3A9PJKU36USY2oPKI6plwjcqxL7ItpPzqrcJAHLo7sUhkSC6y4h7jJn4bkN3qtrt3rjTdsIyo+bC5xamRMfBjZreS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(66556008)(66946007)(64756008)(76116006)(66476007)(66446008)(122000001)(5660300002)(41300700001)(52536014)(38100700002)(38070700005)(4326008)(8936002)(8676002)(82960400001)(26005)(2906002)(83380400001)(55016003)(478600001)(86362001)(9686003)(33656002)(7696005)(6506007)(107886003)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2nl3BlJYuAUSGxIRrqroBfp8jAHjboIXWfirJYcm9ogs5CNGV4Mi+LGQ+aQ8?=
 =?us-ascii?Q?efHkPsfUxr+/IC+1l3IjLF1B4eTtiqYuu02v2AfDQ4kyqPkK3zYQhB/FseEL?=
 =?us-ascii?Q?7oHbY1mw3AL6PmaTeHXbGAIIiGnxxgZmRAMSSRJChHj4oQtzWkjWO+TNK5O8?=
 =?us-ascii?Q?/cDdUCz0zGLWRPPLf/9B4R4uufZM4X78GIInnehdPbKgYTOLotQ+6r36qF63?=
 =?us-ascii?Q?aw2lCUQIS3H6f9bIKIQ3CmU7oo4M4EBjH5GlhO0qw0BwTTubBdnXxfQKK3ec?=
 =?us-ascii?Q?oEKQ2UkIlW2KKFVB7UMiY3XN73bq1L/vxvue/5LpWarhgqsoF6qMvWQx4d9/?=
 =?us-ascii?Q?AwUYuwSnPZ0emdvhIkE0Tn8mc40BkYSGILJVYYw4V21ojgR3KI3YqlCxLLSD?=
 =?us-ascii?Q?+L7I/sy80DD6+4X333XBcDR4nAu0WbZ0G5md0ixlAMhucN8Yo+ssW1tocXOS?=
 =?us-ascii?Q?3U++M0oRhN6vItpfMKBmAOD0Qz00fuNq54dA99d6oIO5Ifd7i0J8LYkrlZy9?=
 =?us-ascii?Q?U5sgOmQTX2rAnLPj8HShv4GtQy1NBWD+Y/Zz6AGp/O4+5NsdO5m7tD+e1vAX?=
 =?us-ascii?Q?SfYt0HIdYLXFzqI4wjbU5DPMO1Wf9gGLa0CsUfFB//pMedCYQTWWFj2qRUii?=
 =?us-ascii?Q?KcBGedTX+f8ccwjHw1EnZfd7bboA53ycpj612QoS+aROnGrNu0LRISdSYWae?=
 =?us-ascii?Q?XTFbGX9Uy/ohYrqmoJJCyXvT/Tg3sgFLeoTgMMQfrg5P4Ty7yhffRF0msQ2M?=
 =?us-ascii?Q?pYChNH3umg9lrApoz7DZl+OW464AOf6G66UgrzYaRi8yp+eaPxzueOqoVeJ/?=
 =?us-ascii?Q?01yydstt2TnQcz7v+bMDeRy+q5p4GZWY46w1CB+g+UFmyiVWq8SQxwNBMiWE?=
 =?us-ascii?Q?WA8T5Km1TxKTV9/xQG5ZBd03mCqn7grFtZPhMjcC6xCOpiQISqc27MsJkuWn?=
 =?us-ascii?Q?C/7E4VRA68Zv9cq3vxkaBe31k3XkV+sWoFZ7kveVJzKjGaX0j5MOC23ApIRS?=
 =?us-ascii?Q?XP6rzS/X76NdILMeY2DbCw+6ZndrpSNToQHECpn3r9FcFPEFa3ND+SJzQaDY?=
 =?us-ascii?Q?7bNAYbt6hB8YvZGVb7ZHMJdPL/p014SVd2SvZ2YifOpO0IMWFXT1sKtsbZ0a?=
 =?us-ascii?Q?BPUqitqHed1zJ13Rm9RUkUTUKjcovwyLw8C0uxqE+j91CB6ueViWP+VpNfX9?=
 =?us-ascii?Q?PH1+sBxBqPVJO7TXtwXI1AFnosC/62OVRByga86TIGzETvCkMGO7Q2D2g+sj?=
 =?us-ascii?Q?79rQh+vf4r1plS1xWeSMlJjzNQ/qhtaD3yB29BkmCofk96vIYxYEZ22kaANx?=
 =?us-ascii?Q?EUcppqUt4W9TZxA3Py20kM4HAOTp5S89m+x+NVmo6dmtlgBDGE5eHzCs9cC/?=
 =?us-ascii?Q?IsOK7Y15TnDNMkycp1Ka+2zL9jgVWWJPycmzLc0Cbx4hTjA6EBXG181KNzwH?=
 =?us-ascii?Q?/5CO96O/V8795YXUothr8xY1QZLFrHsKjV9F5oi9+21FlwhKCpgN9TzAGlFG?=
 =?us-ascii?Q?T8j3TcASN70X08mR3B2I34P0cvrO4yvI8hAsM8qTUmsAdE8Tfhd3bahZQTpy?=
 =?us-ascii?Q?TZXnc67MOcEKh0W/hevQkcJeMgjhCKOi1Vr9BsbC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e65483-3ea2-436b-95b2-08db9ee7f367
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 06:05:26.1098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGYl6A1B1yTaRPbaVTdKMxUfX53IOgfw9QmkmO5VrDvIo/CNg/jImPTjGUezQx5pgDl7VbT/XjhJZehT3qRqA7Ft2Bwbaqar/rdxsO8MXQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Sent: Thursday, August 17, 2023 1:49 PM
>Subject: Re: [RFC PATCH v4 21/24] vfio/as: Add vfio device iterator callba=
ck for
>iommufd
>
>On Wed, Jul 12, 2023 at 03:25:25PM +0800, Zhenzhong Duan wrote:
>
>> The way to get vfio device pointer is different between legacy
>> container and iommufd container, with iommufd backend support
>> added, it's time to add the iterator support for iommufd.
>>
>> In order to implement it, a pointer to hwpt is added in vbasedev.
>[...]
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>> index 6434a442fd..d596e802b0 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -133,6 +133,7 @@ typedef struct VFIODevice {
>>  #ifdef CONFIG_IOMMUFD
>>      int devid;
>>      IOMMUFDBackend *iommufd;
>> +    VFIOIOASHwpt *hwpt;
>
>I don't feel quite confident about this, since a patch prior just
>added the following function:
>
>+static VFIOIOASHwpt *vfio_find_hwpt_for_dev(VFIOIOMMUFDContainer
>*container,
>+                                            VFIODevice *vbasedev)
>
>This feels a bit of conflict in the same series. Mind elaborating?

Good finding, I'll move " VFIOIOASHwpt *hwpt" to the prior patch,
then vfio_find_hwpt_for_dev() could also use it.

Thanks
Zhenzhong

