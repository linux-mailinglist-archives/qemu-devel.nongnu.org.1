Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA80977F066
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 08:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWWF1-0002Ht-MU; Thu, 17 Aug 2023 02:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qWWEy-0002Gx-PH
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:12:16 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qWWEt-0006n7-Oq
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692252731; x=1723788731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/Dqy8zEa0euSOiK+7f9eaIv+xk1iq/vaByx32G2UtXQ=;
 b=GKkrdcbHd8KTaL7DEk8MMD5nPFCWd0SiHIaqtX2ARiRVOyOw5oHvgjpk
 +bQZ3dDQd44B3FUL0YJbvqvIOZYeJpuZpvINcDrU8zXI4LVNn3XeHJvlJ
 5k4S5/MK6/o+YtUi1zlLUrcnIlyE3Uf8hc7huFKZgZcNHPCpv8KVLxSsF
 aw1hhcdNZyAKV8OMCjIRCRbt4wi5mw5vr4lBykIW9ivDWd73KjtzTdDLQ
 u+7vSUgpYT/a1FSsdz3EbH9R9mpI+esB8SITncDo42UrJPSNSog5OyBxG
 o2tkb6lvcygccPyFU+i+833IDhxBl8IFMcTVbBJOO8ShN77Bc2t54mgAB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362873948"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="362873948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 23:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848762174"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; d="scan'208";a="848762174"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 23:12:06 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 23:12:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 23:12:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 23:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUWWWjI/0PpFbV7gR9MkrrSVzyhqIjGyMoHAfpXjd2J2qAzoYdVh1CrWf0KMiJWU7WxMyQNvXkV1cYPqbOQJYR4O8ZxadLLbAI+CL697EwNdrHb7sEDInrfuDHAHBPpp+827m5npSoy/1eXeaV5GLDDD0qTqQ7Vz24ud3NznVpX1Rjiwh89d6DbE8GvR3PyVMmqJBIkzAguBk8DbybIAOngccFiRaA3QZeUZLwuSYVNfVh/u5PmWRLJcTCecUnCjdEy0MMYfDT3G8gDJfDkmdZkkwgFmkfxcW0QBu4AnRFDnDmDvgKzMAQF/4O9rRr6ZvpJ73YMHtP9gPDk7CntsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvbpsoi6lQ/FeiQS8m+d75lljyMN6Yfovzpz9X6GT/g=;
 b=YnbnkcGQAS6sELwVZeqr1GGXEAcr1TcH+kzpBgLPy30Z3OQ2C4tPnCAkVjKcCIRKaE7jBoPDq9jCDf5zNNHCgGR0omvtetbokeRwLIj3Gn8JQEbp3Q1QkR3l3AUeW/y0UF30yHZ2GSAJotuTJgNfmkq6X4HrHnCrLEX4JFFUzJgY5Ghi+1F2wnKBrl/PNhov9g+fvtSXAsLbhXZ+Ps3f1xVKQkWOo/OY92ooQPPSeqCR9seqFF8MMtbtku8jZJDSpXU3JnN8CqXsOujlEMYzSbTgavPH52xF63TVnVY1ZmKf+c3ccALcBvuQ9qzabhFZ+c74OBcQPdNXxIDZvCyYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Thu, 17 Aug
 2023 06:11:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::2f37:eebd:8bbc:e0c6]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::2f37:eebd:8bbc:e0c6%5]) with mapi id 15.20.6678.025; Thu, 17 Aug 2023
 06:11:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [RFC PATCH v4 22/24] vfio/pci: Adapt vfio pci hot reset support
 with iommufd BE
Thread-Topic: [RFC PATCH v4 22/24] vfio/pci: Adapt vfio pci hot reset support
 with iommufd BE
Thread-Index: AQHZtJQi/wJ3ky0V+E+hyhx4vt0SGa/uLVMAgAAKW1A=
Date: Thu, 17 Aug 2023 06:11:59 +0000
Message-ID: <SJ0PR11MB6744B5AA8BCEFB8900244CDD921AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <20230712072528.275577-23-zhenzhong.duan@intel.com>
 <ZN2vTISmC+S/p6hO@Asurada-Nvidia>
In-Reply-To: <ZN2vTISmC+S/p6hO@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: b724f9bf-fd27-4a15-37f1-08db9ee8ddbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SmMxYllIY1lptbj8LFx0fFadTqic54caPJr2JEzadWjkm/LsTWLKLkJvPJPKuckMHV96StcAxDV0i1LB/VOtwfiWo93FSdtVmI/muwhl0SV+Y9Nl2ZZ/7jji2bC9hbTCV0+1+cot5GGY17O1r3scTWJ3SXBBlgeLQvGHBXphr658iUjifhKfGen0Pbn2x0nduwGTL4PYWArJm9K1rAz8ohyCn8IwPLXPVH+0EHH02jpFUZv6OJmqKPsUR1vQWVOTAf+i7QIRwDT5DTcKtBnGTR/yR/ZcTKInNCtYyt6aLXDALJ06/0kC3mKxnjpiDZLFM5Qv00Dg2SAuqYOZ7GV1luowSpWH6dCsLVfS35hunSC7rAo4E8mRR0iJO4CEJX9Ip58S/fXrhLsAPL51FJTTncKmeXaseObkE+nIPWBkNY2sGhPIwDsYH++4PRbkhhdbEf+A9+GMYcbZQ6s0brF2lvamFz8dMbuQE68geE5HMPV2BWpjT6PYpEdjWDxU/M/8nOuPvh/FDtGFI6E96lWTst6HG/ydmz+Ud3kYnq9yiYkO/vUTN9VUCWUD5IJs03KdCzfPYC6PNUWZX6LtO4uzqWuELXj/yDwwhbkAtzHYAvUaL+a4sCnlkOwhmDYfglzePE1iCBElxfLo7KpjlkB14g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(66556008)(66946007)(64756008)(76116006)(66476007)(66446008)(122000001)(5660300002)(41300700001)(52536014)(38100700002)(38070700005)(4326008)(8936002)(8676002)(82960400001)(26005)(2906002)(83380400001)(55016003)(478600001)(86362001)(9686003)(33656002)(7696005)(6506007)(107886003)(71200400001)(396324004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GlNdSX+zYH0N1BwGzweX/geq6zaokq42YHtcS5Alea5cOBg2MjL0ub5bIiTq?=
 =?us-ascii?Q?waiMD6U2v2bzp1HMwqQFaiUpOlJbOM2ugZPpwdbmCiv6fA+mtKDYXPCtza8v?=
 =?us-ascii?Q?iLaF2pheM9KcF+mQzChPE3XEqiuCpnY9cl5btB0SxRIXCoHO/vlKie2SYWQM?=
 =?us-ascii?Q?n2OMrM2jpxCWtwaWkX3AY0jExt3WVo/sxiU2ogTwUtmBnq67QYPUSL7C35Gg?=
 =?us-ascii?Q?LhmtWODwFLf0nll3bsc0CZZr7gcXk8hVyqPIpSe9EZY8hWgjzRVdgGLjJ2RX?=
 =?us-ascii?Q?fpscfQWh9v55ZlLP4IQQlWqquwPQvU9CnZV89tDV+l13xzS8H5Dv4DCGkDtf?=
 =?us-ascii?Q?Fvvghz2gXNZ0kCLEOjugHZlGt+BTYCOT962k9UFbly9DAOBA1hMkRtDd/i2s?=
 =?us-ascii?Q?NBvPhgJjrWGNR5vsg53Yzb7GF54gx6i5D/LSfiY4tu6PofDTQej2wid2f9Y3?=
 =?us-ascii?Q?TDzhmEUejvX1CaW4YqNl+x85P63Zm9w+iS+wBmn53RllwGFUC3y830jMk2Jl?=
 =?us-ascii?Q?QmMzI3S1GeVS/YCoUEWO/IItoH8Avs+93uRcmtO433K9Kbq9FlDuTKZIgM6B?=
 =?us-ascii?Q?uP1ldAypl9QbD4Y3DSIodRvjAx6iN8Dgk2GXXFeqnDpiFIFqTPRHuZ20/Nxx?=
 =?us-ascii?Q?L8frgOqy6RUgqzERmx65x5XLrab3KGOiYBwmYVPlflb8YAU00oVZia9a2IFj?=
 =?us-ascii?Q?9nbUqfTQtxFwr4/MTx47ZCacUndVp3DgY285aXAZtYbIuV+u3/uXrC4xqMwl?=
 =?us-ascii?Q?PMOaG59/ccxd0eheIZYFlv4UnIR8f2WJEPqufbyu1Bw0gPe7gmDeS1QCFMXZ?=
 =?us-ascii?Q?vfrI2Jd9kNc9ebqig3nBsxqkVaGDFqUnPG7FoxW4XNmTBohPFXRJsCeN25yC?=
 =?us-ascii?Q?QmqvBiW5qPseHfV4bLSNHxSqP1IMfrqhr+Fl25TS7D7iorMt7nMuS8lTyJFx?=
 =?us-ascii?Q?ewAL6+Y8FHgf20DCEfjkKq+or0L/JvuXgSVuqQLiql+3TMf6quuX0Xs2Sl7F?=
 =?us-ascii?Q?0aBsa2r+4hIPIeYISIhZ8tF9lvVNqkbwg1oRd7pehddF8oWNV9g+FeNeZFNT?=
 =?us-ascii?Q?OQz5X+1rie/2LOO1FMpKgJILo4V9oa2CSbsMPGhJ3c+o9q8zTf5raooGT1Js?=
 =?us-ascii?Q?pMhtMijH3oDN7pCZLL1ZzYYqhiNRnYCQ4S/asiyuPGgFk313hrWNn8CNSrCR?=
 =?us-ascii?Q?mCVsEk1LIN7EKVvzIxxvtnDdewgMN4sp8eWZAB01EgNm1O3dhTqZm7lUYhIL?=
 =?us-ascii?Q?doKu7UGD86gCz1Y9u/mitCIf2gKXtctUXxoAPKEwKjFGV3vtvmbuBAfpF/7S?=
 =?us-ascii?Q?S9hTUpk1johrlz7Dg9IvnHdK+thxzfWW0s+ehtAzB21N+4MZAleHhGv/lg8e?=
 =?us-ascii?Q?AbutSeyMi1F6SNemitAsp+BUgFWCHHj+DLUNHr66WnMCjTAdRL5VUpJmGfJw?=
 =?us-ascii?Q?1wOpGOHzqBjk2ZcRMKmuboUk7S3n6WMGPprj0TMp1Wf6udErUpHqvQjggDrK?=
 =?us-ascii?Q?a193rFf71/NarfnwEqY3avHs8jIOxDYThj03HN+zj1/rrjtvV5yQjw24wjHL?=
 =?us-ascii?Q?mwu3CT7+Sf9pVnafSP5RVvjP38V7NPBF+Iy11hSY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b724f9bf-fd27-4a15-37f1-08db9ee8ddbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 06:11:59.2788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+MmABRWXSPOfUiE+tWRUU1kiZJd3zw74wgXcidsDQU7J6t2gq7X1Xla3Yt/ILn7kJ04YzVrTI1xgln7HQTpEXwGvtpxeGVHKWuZCye6LaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>Sent: Thursday, August 17, 2023 1:26 PM
>Subject: Re: [RFC PATCH v4 22/24] vfio/pci: Adapt vfio pci hot reset suppo=
rt
>with iommufd BE
>
>On Wed, Jul 12, 2023 at 03:25:26PM +0800, Zhenzhong Duan wrote:
>
>> +#ifdef CONFIG_IOMMUFD
>> +static VFIODevice *vfio_pci_iommufd_binded(__u32 devid)
>> +{
>> +    VFIOAddressSpace *space;
>> +    VFIOContainer *bcontainer;
>> +    VFIOIOMMUFDContainer *container;
>> +    VFIOIOASHwpt *hwpt;
>> +    VFIODevice *vbasedev_iter;
>> +    VFIOIOMMUBackendOpsClass *ops =3D
>VFIO_IOMMU_BACKEND_OPS_CLASS(
>> +
>object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
>> +
>> +     QLIST_FOREACH(space, &vfio_address_spaces, list) {
>
>Indentation here doesn't seem to be aligned with the lines above.
>
>> +        QLIST_FOREACH(bcontainer, &space->containers, next) {
>> +            if (bcontainer->ops !=3D ops) {
>> +                continue;
>> +            }
>> +            container =3D container_of(bcontainer, VFIOIOMMUFDContainer=
,
>> +                                     bcontainer);
>> +            QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +                QLIST_FOREACH(vbasedev_iter, &hwpt->device_list, next) =
{
>> +                    if (devid =3D=3D vbasedev_iter->devid) {
>> +                        return vbasedev_iter;
>> +                    }
>> +                }
>> +            }
>> +        }
>> +    }
>> +    return NULL;
>> +}
>
>By a quick look, the "binded" sounds a bit odd to me. And this
>function could be vfio_pci_find_by_iommufd_devid()?

Sorry about my poor English, yes, vfio_pci_find_by_iommufd_devid is better,=
 I'll use it as function name.

Thanks
Zhenzhong

