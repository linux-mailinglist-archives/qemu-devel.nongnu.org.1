Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A677E625D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 03:46:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0v2u-0005qV-4b; Wed, 08 Nov 2023 21:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0v2s-0005qK-2z
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:45:26 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0v2p-0004mj-En
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699497924; x=1731033924;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5zWi9po+TguMX3RcGFNImBd633z/LBOGIgvOa2RPF+c=;
 b=WWOTfMigaL9KTfGKDQljsZv4G0BQP4mvJEkNnbZZmXan+d6j6k23OTRV
 3MceAVMSHGcMNcI2eO4vnJYCMYhBQoXGBtsMgr/kWZIGMm+R+iF6x42tj
 QvCRuclyc5xj1MKFmq3sDmjzkama6yEocUVl1/jLdPH1pdXxgq/C3kXbR
 1Qy/wXGOf1HvaKyJc1IZ0/5vQZL3sbsdXxh8XZRCDlegsnRHfguLauFHi
 Y7PYqLEkkofbkiPua6PS6PF12F6KPG67YTPlUCUu8XZJd/IBYNWlWHJ7o
 nEupV8jukhmvwZuLNV+B1rVVCGy4tpzdVmItliJQbYneohkabLVpDgdNS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="11455874"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="11455874"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2023 18:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="886856824"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; d="scan'208";a="886856824"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Nov 2023 18:45:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 18:45:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 18:45:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 18:45:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 18:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ked8a9gLynCNLnLdqjpOSxMZbaEqIrBkM+358t/mJ+QfCll/Q44MCUbU/XbrahsYntBacz3/ThvYOkSH9pXYkYLXJTdiQZEkQc6E8DIUJLP/SXfodME5BTPcoX7j7yYIHTKSVY9K38VRWPHBof8KYqO8tzye2zzRLAQHm/ICG44z8Rf9f4ziWyAe2vrgsWcvftLHSMUMJggr33DMSYJj3/va24QFFZHIxOvPyDuNFzgND/SqkTcSrmbJ/3nSAA7uRlz1V7pZNnpOCkswSymEZ/iz7/I7IeWzIWCfwMMUdevYFw/QCLKOpG4AB5GdC+1B8Q6qPrmntVVpJN3xK/6tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zWi9po+TguMX3RcGFNImBd633z/LBOGIgvOa2RPF+c=;
 b=efm9gfsWnjgGiyoHNSV++jOAf0SVEEJ50ZKiz8CcLFeJ03kfUIjV6AdEobD+YpzMCR6NLK/vBMRyb09LjjOqHtETBLYAhXLjHhHdF8+arOT/nLPqI9TwKyCduMRrLAiN8vp2XARptyeRNTyGCn2fRzIHXj3m5RHcPo61FwsN5LpVaxxFFZ8MJACXLAG8eWa8i3yCWQd2mOoLPJ7heWCPZtbq7BQCMNN3jc8enixgvkrQh1MCuu4f0to77PyeR9bxKjGGd1IDtRNOFteosohJq+Vnvz0ZgS7odjKrfYNEI5HfIiocD4BHlI0s9mLyPcccWX3ZC41dDP2nyhiAZVoCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN6PR11MB8170.namprd11.prod.outlook.com (2603:10b6:208:47c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 02:45:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 02:45:10 +0000
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
Thread-Index: AQHaDV58rXzWcAbguEiSUs8ukZNa17BvxJKAgABFgECAAF7hgIAABUPggAAULQCAAM8cUA==
Date: Thu, 9 Nov 2023 02:45:10 +0000
Message-ID: <SJ0PR11MB6744EEE3F0B22ADD14E2923C92AFA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <SJ0PR11MB674482451CB0D2A7BB4DC20292A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108141920.GT4488@nvidia.com>
In-Reply-To: <20231108141920.GT4488@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN6PR11MB8170:EE_
x-ms-office365-filtering-correlation-id: fe4f4bbf-40da-43e7-8484-08dbe0cde3ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71MPFChIW2WfXojxRZ4cvRrun1drkf5vhL9nWx/FbkBgQU+IgKPALBYZLMb5a7jBZauYF7MJlodI1zCJ1LydaEGSZijdM1KSLn5LdmthXCQ6v4z5nr23ppl0sphDzz7dqS6oxUZBDJv9l0jjQpp5LSA02GsEokyYit2dypaj6f9RBIHUfq1sFUXqn9nF0wlWWYzcNRoeUNeZo2ol5blWgZOugOEdEjpByPjku2pDxBS0MKFwWBjkkvNmxvrnVKGkexEKao9DcPAWm5sFpHo5qHiKLi6TW9CwNxUJEPTBb37MQDA9ysqb12fp113dM/ki4YiknMfBe258qFPUHjPJ8uhqW2C26iw4E0ia52AmSSxe7YOZa9Z68+WMpm659PjsJPop96/y3X7J1LlcYLpC61W9E8/cztqLRjoy/CGzBt6rejsmK0FLyEa3xmrOvykMkRceOJasoufU0Qsd48bXgdNKGA2L4j8jiis2ewQQeHRvrqRbbFhyJDZJ0g/FEE+w13L7kYG+B2D5J3DvVNrfEqg3Iu0nsCqkpZifBOYy9Ol5JUMZblJV5ZnGEIz9ewymXOPvcJMtj6wtLxSBOJEmtq/ecNPkQ5G/SmyX+cla4xLbKY/CSHJ40D+Rc5cx/QEW10FmuQw9FcS9HKm063VXCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(55016003)(83380400001)(33656002)(478600001)(52536014)(8936002)(38070700009)(4326008)(86362001)(41300700001)(8676002)(2906002)(38100700002)(71200400001)(6506007)(6916009)(316002)(82960400001)(122000001)(7696005)(7416002)(5660300002)(66946007)(64756008)(54906003)(76116006)(66476007)(66556008)(26005)(9686003)(66446008)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZdMEP4i+x+OmLNZUTbEdzi9dYLJ5v76nQN5p2EwWwONHefKi2Gz8Cm+r/36F?=
 =?us-ascii?Q?tcvhOKnB98wWEwj2qlnsTDmQFLV3qVy0BCD4rLjl9aLubLSxxS6RaVJ6HfaV?=
 =?us-ascii?Q?RYP0FFxYDLOBDgFvLR8BdlFjQ5VH/6OaUCywmKxYSrFlTJmTDICevAt5g/KA?=
 =?us-ascii?Q?vwW/yYWwjqV1vc+dR/oHBETjvzgorPqVCDpc6BBDnbqimWfYLxDbVZeM8sD5?=
 =?us-ascii?Q?JwasnBsbHohT1Zv1N4I5Dcfq0jdfixdTx80xMucee3z1VSFK1FM3Vju9orrt?=
 =?us-ascii?Q?YDPvIFPRiQUy9bldpfZmtaUMBhVVjHi2jm2pv/46+6WM9glu8OS+Lit9wI+E?=
 =?us-ascii?Q?t70mPkhjeEuvEC6Ii4wnePEAID/B99+XtE0O0BYV8ByVpY2VJ0oeK1KwDmmh?=
 =?us-ascii?Q?TfQmC7c97TYbx/uydn+4bORg8BE0Ednr3iRnT/DF+rVLzrpNr6zDHnAXuC5C?=
 =?us-ascii?Q?nVsbi2bBvcLkdE1Qs1zmdNK78fMYiG34tp4v8xTWP7aZ0CQAdyPn4yN3BcKU?=
 =?us-ascii?Q?0DcDvy8Hbu6xQ8LqxivGRA2G0ciIHYfUYXWsu/L7jgGA/JURT6FcMMNOkX6q?=
 =?us-ascii?Q?R7icq1BxBIVYlMxKqWxybIvoOPQuQYXcJvFF0r0LLpn7hNAaiGL3fs+k+Qts?=
 =?us-ascii?Q?59zaffJyaxFk2VmF3mpY8zOSiZ7UgaiOCphy9J9VSTkuO3HJaSEne1TQSATS?=
 =?us-ascii?Q?hp9LMwb1nJH/6zSPbtw10ak8QwXmIzDQZNywKWFOSNuIoTP1TcliDlI45/Ka?=
 =?us-ascii?Q?P1CWl4NdWFgAXUQg5gs4+Vgfq/jHbCXqzdmsc3S/cDDXtj9FlEPPgEkcru+/?=
 =?us-ascii?Q?/0HpVsSY/+ItM2gyDSIe6EggsQap6Zyo7Y9EaHYmEOGJBqVluneRGqe6pUDv?=
 =?us-ascii?Q?jh46j9fawV4QpC4TBzp+j36Evt/lHUfV2TQiK+cVa9B8l5NEZ+lCFbLb1Ha/?=
 =?us-ascii?Q?+pFYrPPF7Mm+xObPHiAIJh0u3GJsKBJAGycYH/RRQRmdVGL/eo3xRw6Efn2+?=
 =?us-ascii?Q?oyDCJtG3yrDDcSybmtMggTMYyNjqRD6FuuVzifimj7l7w1EXo4MBUXIxJPvq?=
 =?us-ascii?Q?AHglYN/0EMDhyF+58izftLEFYFYGsJczBwrjSdMjZvWkQ3xBAmnDRcnWd4w2?=
 =?us-ascii?Q?cpGk7yMKSnL5/EqK1YMBBo8RIE/Z8DEm7rXzYASI+p5rQXhXUJ0gmfd5zG1J?=
 =?us-ascii?Q?L+629uEBUiYalt80/9ymV3sytSCxlOPrP0ceEFWkY5Bp1PDJVt+11NJNElX3?=
 =?us-ascii?Q?Mz4EBiJ0nLYI/AazhRcb746emiZYIL2ogIH+b77fxBy2uAfbBRKgxi7HictW?=
 =?us-ascii?Q?6pQN4bI34dmrENI1xiSYtqvUu9UgEhjvkkY/gcBb0XKZn/iEGPVFKZD8f2h1?=
 =?us-ascii?Q?JztDU1eZBDO6my0VGYuislp0+F2QSD7b7Gcu9gfzRl2TXf9qjh5EuV1DlnLF?=
 =?us-ascii?Q?IBTtCGWxt2xbH0PycbC/U33jCX/YeQ5PWi1tJab90TOq0Kz2TicBkwwb+bZf?=
 =?us-ascii?Q?dLDs59xofvfNTcfZq2Cc2W9qSWi1YQFa9GF9+3G4s42iz773LXfaArhStlij?=
 =?us-ascii?Q?eo1AyH56MaoJZKEzpqMnlcwZs9hbY7xquLFp8aRh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4f4bbf-40da-43e7-8484-08dbe0cde3ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 02:45:10.0791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Ver4u9MNcjJb/GzR4yUoqQVJ2gfFbtpeKafqaeh/hr02rFrrxsEe+jJYlpI1hEaMx8pqn3K/Qf1bYqcWhnHgx5ZfEsgtNOM9SeNVEoX6Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8170
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Sent: Wednesday, November 8, 2023 10:19 PM
>Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
>
>On Wed, Nov 08, 2023 at 01:25:34PM +0000, Duan, Zhenzhong wrote:
>
>> >I was expecting that hwpt manipulation would be done exclusively
>> >inside the device-specific vIOMMU userspace driver. Generic code paths
>> >that don't have that knowledge should use the IOAS for everything
>>
>> Yes, this way we don't need to distinguish between mdev and real device,
>> just attach to IOAS. But lose the benefit that same hwpt could be passed
>> into vIOMMU to be used as S2 hwpt in nesting.
>
>If you have a nesting capable vIOMMU driver then it should be
>creating the HWPTs and managing them in its layer. Maybe the core code
>provides some helpers.

OK, thanks for suggestion.

>
>Obviously you can't link a mdev to a nesting vIOMMU driver in the
>first place. Mdev should be connected to a different IOMMU driver that
>doesn't use HWPT at all.
>
>I think it will make alot of trouble to put the hwpt in the wrong
>layer as there shouldn't really be much generic code touching it.

I'll send v5 with your suggested changes.

Thanks
Zhenzhong

