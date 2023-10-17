Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE397CBD5E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfQy-0003ng-28; Tue, 17 Oct 2023 04:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsfQv-0003nV-AM
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:28:09 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsfQs-0004dE-FY
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697531286; x=1729067286;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VrGCKr5PXmyFCse+cs5dzWKzHi5I1B3iT+zAoqkUZxY=;
 b=WynxcrdTXocraJ2FFxdpWjnzfFFOfiEnA2W21//aK0dLC1Gy6uHHLoQe
 q88izywQxkQ/SsmWyJ83WUYa140JmmrYMrbuScGtErWiB36K5IyCBw9RD
 FGt08SM8TfIP2swjjtMan7lDiZFGRGdjRXZfDu87T6IxUZGOF6XzdW9b3
 5BehQsfFBJrDLRPR6hUs+JRr2Z/Tt59jY+c24SiiMQmykh5oQF0Tuk2yV
 fy1Ol/nBqeXBogZo1KhhWaiwTqVo3zU+bvWW9cXk3YWowT3YQJ6medz6M
 oAdC3tiVwJixj16rG8BfzeOmn/XnYeWndZ5PxjRs5iej9gd7fuNKjXLVq g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365082866"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; d="scan'208";a="365082866"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 01:28:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="791163015"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; d="scan'208";a="791163015"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Oct 2023 01:27:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:27:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:27:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 01:27:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaGsWB2F8JEVkjraHZ6fFsVXAwbl4Xk/3Ho6DF9BhCON8AJISAQhUGZLxD0bwpcUCQw7zY0Z6btUlvSAAC6Ysu14y1tL21ieSUb3MLEmz0lizJIxKDH4rgmMGccFeRjRZsgJMExQruq6N1FeC4uX8RKrSF1qycieJRIY917nesqAXZOhEf5/wvmehPtE2XgMbjtCJB+xQuxMHQiOy6yesMQy2ZiD/WXIlu4ZL1LPwDG5dGfCTmFgYoF5ReL8uyGo1GVS95BoMeBPTDibk0IGNC2ng6UPEKDggp/IM8lkeE1kuC0MfpxW5I5LHWuyci0FHLSSHXI1UOcx033F1d9q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KmOpKWBkNIyL8Xddtk2UTtr+nn19eQKG9Gdzvz2fac=;
 b=SrqXIfneSJjywihQ0EuuoXrLvxMjyoBaQwPFh67zOjqHL5uw/vVdrLgK5o7jsmpIOiA+cqjF7RxzSO//Bth0IyWDBYNsTDS/E461pNHBySAQmcVprjAfzpqDEIOCdgFsOuqmPJlWzqtKdHzzCAMusV7RSLIMTrJS/RT48KltDR3+rLdWFIr0DoSDcSHL8XDQ7B6TTAYVLSGQzkdPj2VGT5bE7LPnFDpJKdIY/v2JSSKjP7baj3TmJ/6jJAEuDj/KVJqRH3kSF5dykq+bTyl83drwDWuAoQ400IbKx8cejCzr1EeYARxkkORJH1N13xoGQNqYCHX0buCh3pzwooEXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 08:27:47 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.043; Tue, 17 Oct 2023
 08:27:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Daniel_P=2EBerrang=E9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>
Subject: RE: [PATCH v2 17/27] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v2 17/27] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaAA2PXAx4/rmqukuTR8KNfnCnYbBMT5lJgAFQ6uA=
Date: Tue, 17 Oct 2023 08:27:47 +0000
Message-ID: <PH7PR11MB6722C443D1C993DB687D61FE92D6A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-18-zhenzhong.duan@intel.com>
 <878r82ixwb.fsf@pond.sub.org>
In-Reply-To: <878r82ixwb.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW6PR11MB8440:EE_
x-ms-office365-filtering-correlation-id: 65c9a37e-2a25-45e6-d54e-08dbceeaf19c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2eW/bE+Fqmh2AcMylAv5FqjDU7LiqYedohuOHV4zRnvVVmY9cfi5WgySMH/AYrDt7JzOQcDj203rt7tFWyj/8TAonp6loMPaAKlSd0KOUoUqJ/hyc5A6tEhxWureXP7ayMPKe72st6jXrrDcWaPRULWBZexkU5/A3XPAYifg01Q5/billgp6RURGbwL6kiAOwNw2jqhzQ4nv8QiOZRzuU7eCAwDkgTtimZRong3AYPVIaLs7S48sQSswSyqgO9fmMlcRjRdfwVGpRSqUNjSGhe0eo7pMZXyGIyvN3mDM+exjdM+wVcIWqI5OpBvh/X/iwFSqmNMaJZZhWrpp6XvsDhc0N6PQM8SG7Y+8eZea5uAVPlRlgN2oNoNBaDNINckolU+DDy6L/sqPQPv/QCj2y18agnfpAU6C9TM11x5etAVRaYQFpeOzmP6z5bEo2dQkArfdCHv2ebeRNg8vMmt2ZAnWFYnPKWNlkNs9pEJMNZ8ViQ1cK9C9jFUHnPnOjgZhaINfBUmrb4AllYMd7aHsML66KudYls9/QNV0sDBT75MNeFsGXuc6y3pjcFYHdwOKk/pXNvGV8wnU3jfbLFpya5O4VF5zCk2dAbWDYwfk4rh42h4eRyL4Sau7I/9hg+pJI+xOkQ2S/OE4IvZTevlNYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(76116006)(6916009)(66476007)(7416002)(478600001)(64756008)(66946007)(66556008)(9686003)(26005)(54906003)(7696005)(316002)(2906002)(6506007)(8936002)(5660300002)(8676002)(52536014)(4326008)(41300700001)(71200400001)(86362001)(33656002)(82960400001)(122000001)(38070700005)(38100700002)(83380400001)(66446008)(55016003)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w/LIOuAj7lTNU0fhsXeBt/hDflmthiCAv1ArpBV0m42vT6rUtPJQx6yz56?=
 =?iso-8859-1?Q?TqFaPNRlJiUTcRmv0ZlTxIwXJlvQrIsRcBo0lcY9N5eHYDS62rj3Pb4OVN?=
 =?iso-8859-1?Q?TecxoOuKeBKENi4eT/5/4YcDN+W/HSuL9JK6xume+h+iQPpk3aIiDwJ7ZG?=
 =?iso-8859-1?Q?loNKg6CYauFuMQez1WQGyRFww1cCH3nqPOp14mpZDDLnYx4/81KvXNPkcQ?=
 =?iso-8859-1?Q?JsohvH9mskB07qfFBlaMXqn1br1qO585iz+2oviRAVQdCEj8Luzvn44fRV?=
 =?iso-8859-1?Q?7T9G/rfr9VEZF7DGNC7+I90j1RGuZX+v82pLN56WgXGCu0uUnqdWaBoMOm?=
 =?iso-8859-1?Q?iOL7Zd4nQe9hd7k4IEMOb2+Xfr3MdX7FS7JCfuZuHUF4cWkdBI+kRiC0pf?=
 =?iso-8859-1?Q?cdCyVeUV83qx1FDj9slseXC41FT2RBZKsr9kqjTh8vw7lXG0/SZoiV3Ksl?=
 =?iso-8859-1?Q?yUy6/U/7rKm3VIufZLJMDRrgwEm51VWV/G3FDJt/ug4dFkumva4kuTTU5e?=
 =?iso-8859-1?Q?B7kInS13HeZcYZDNZQbUHL6saPUfL1aJ+RzaFbgHf3PTzOsoLltNYp7DeJ?=
 =?iso-8859-1?Q?s3FvdLY0Dizv4hOZ1Jp6jdCep3lQlO5goNMoNrSK6279Kc0/AM+nfCXpCj?=
 =?iso-8859-1?Q?hBsp5K6eIly1MzQjSnAnpKnod/8IJyglXuMyj7WiSGJ666Lw9NNyhCn0EZ?=
 =?iso-8859-1?Q?DipG14ozPk9pM/f5E2mLqxaOa4qEk937Yt3mENfs9n4aaxK3caz/lCYxw7?=
 =?iso-8859-1?Q?IrERa6ODEIJzidnZ5Ne6OZN4Ha6SU05YJzBb0XtQDtaV9AobshIDPJHacJ?=
 =?iso-8859-1?Q?0HsurMvGEUbB+N0fSUoc8ZufayliRtj9o7G2fNfSme0OxySLyFuwEkdkJN?=
 =?iso-8859-1?Q?sC6hofYZPJIDnoYMxHtT34p2IQsyPto93txXt4RHBr2h2zaZxq+ceEg++C?=
 =?iso-8859-1?Q?dOp7q68cfOen3PsiKlIl56qYiidKd8H0p+Dsp2hZr1gm3ehcitrEt+7sDY?=
 =?iso-8859-1?Q?5bIMiPk2cGYicYgz92k0PY4EqIjgv7FqysqgbVrIFCWHGkL1q9A1rUQfkM?=
 =?iso-8859-1?Q?5AfN7orT6TIhwRN5t1U/yVFCwgYrlAxIBw+KEoLlMm+ZsHbtsacASixCrE?=
 =?iso-8859-1?Q?1co9pVO9xsBvOanezRvBLg5SLRIwsLIts8KEnHIOuafKvEegQ/E11WD9lY?=
 =?iso-8859-1?Q?KxuxMERrCz1qEksUsl1dveAWYxgCXpP33h+bmxdpbw2clbkYpggfxBuTAZ?=
 =?iso-8859-1?Q?YEszjdSfO16BqolV2tLf7K72ff73xBsNaV6HeD9rdxn4FazFgPe6On16Gq?=
 =?iso-8859-1?Q?HtgtWKdplaeSD9oJIpjJZqqu7mzIWhbBAtOZwytE7StJcq38qqvRsa3pr5?=
 =?iso-8859-1?Q?REXARdGJhqJcfvuFj9QGdkn12HsPTosX40Rq6jhg+l56PQAGKgnGcbXqlA?=
 =?iso-8859-1?Q?D41FdvbbwOy1qiQhZ0lLx4X+261FLUc36pd50hHCmxKLrjhyCi+j5J/OOJ?=
 =?iso-8859-1?Q?hOsSdL+9SIM58/ZCwSTQg8MnM9FRLArtkBvRSIY9o9VzfkuxguH54uIgeR?=
 =?iso-8859-1?Q?jm4F4kMU0Swoy0S/h8i8TDGNDXueMC+CS/4v1nzchIocreuMQcN4eGLolM?=
 =?iso-8859-1?Q?27ytEk8O/6aO5xrNyoSaJxW6V7MuQx+Uwu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c9a37e-2a25-45e6-d54e-08dbceeaf19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:27:47.3843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7D9MG21C14Ud/zz+1IvOFo3/yN84OrxXrRuHXvTiZaUOrBgnYwenuOEkgUmf/1Lpp/RQsznsh3HcPY5eoEeXONgtbSC/dFshpMmQ07wTeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
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

Hi Markus,

>-----Original Message-----
>From: Markus Armbruster <armbru@redhat.com>
>Sent: Monday, October 16, 2023 6:01 PM
>Subject: Re: [PATCH v2 17/27] backends/iommufd: Introduce the iommufd obje=
ct
>
>Zhenzhong Duan <zhenzhong.duan@intel.com> writes:
>
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> Introduce an iommufd object which allows the interaction
>> with the host /dev/iommu device.
>>
>> The /dev/iommu can have been already pre-opened outside of qemu,
>> in which case the fd can be passed directly along with the
>> iommufd object:
>>
>> This allows the iommufd object to be shared accross several
>> subsystems (VFIO, VDPA, ...). For example, libvirt would open
>> the /dev/iommu once.
>>
>> If no fd is passed along with the iommufd object, the /dev/iommu
>> is opened by the qemu code.
>>
>> The CONFIG_IOMMUFD option must be set to compile this new object.
>>
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  MAINTAINERS              |   7 +
>>  qapi/qom.json            |  18 ++-
>>  include/sysemu/iommufd.h |  46 +++++++
>>  backends/iommufd-stub.c  |  59 +++++++++
>>  backends/iommufd.c       | 268 +++++++++++++++++++++++++++++++++++++++
>>  backends/Kconfig         |   4 +
>>  backends/meson.build     |   5 +
>>  backends/trace-events    |  12 ++
>>  qemu-options.hx          |  13 ++
>>  9 files changed, 431 insertions(+), 1 deletion(-)
>>  create mode 100644 include/sysemu/iommufd.h
>>  create mode 100644 backends/iommufd-stub.c
>>  create mode 100644 backends/iommufd.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9e7dec4a58..a7cdeb7825 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2081,6 +2081,13 @@ F: hw/vfio/ap.c
>>  F: docs/system/s390x/vfio-ap.rst
>>  L: qemu-s390x@nongnu.org
>>
>> +iommufd
>> +M: Yi Liu <yi.l.liu@intel.com>
>> +M: Eric Auger <eric.auger@redhat.com>
>> +S: Supported
>> +F: backends/iommufd.c
>> +F: include/sysemu/iommufd.h
>> +
>>  vhost
>>  M: Michael S. Tsirkin <mst@redhat.com>
>>  S: Supported
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c53ef978ff..3f964e57f5 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -794,6 +794,18 @@
>>  { 'struct': 'VfioUserServerProperties',
>>    'data': { 'socket': 'SocketAddress', 'device': 'str' } }
>>
>> +##
>> +# @IOMMUFDProperties:
>> +#
>> +# Properties for IOMMUFDbackend objects.
>
>This is the only occurence of "IOMMUFDbackend".  Do you mean iommufd?

Yes, will fix.

>
>> +#
>> +# fd: file descriptor name
>
>Awfully terse.  Like many existing FOOProperties.  Would it make sense
>to document what objects of type iommufd are good for, and how they use
>@fd?  Or is it already documented elsewhere?

Will add more comments here, thanks for point out.

>
>> +#
>> +# Since: 7.2
>
>Since: 8.2.

Yes.

>
>> +##
>> +{ 'struct': 'IOMMUFDProperties',
>> +        'data': { '*fd': 'str' } }
>> +
>>  ##
>>  # @RngProperties:
>>  #
>> @@ -948,6 +960,8 @@
>>      'qtest',
>>      'rng-builtin',
>>      'rng-egd',
>> +    { 'name': 'iommufd',
>> +      'if': 'CONFIG_IOMMUFD' },
>>      { 'name': 'rng-random',
>>        'if': 'CONFIG_POSIX' },
>>      'secret',
>
>Please keep the members sorted.

Will fix.

>
>> @@ -1029,7 +1043,9 @@
>>        'tls-creds-x509':             'TlsCredsX509Properties',
>>        'tls-cipher-suites':          'TlsCredsProperties',
>>        'x-remote-object':            'RemoteObjectProperties',
>> -      'x-vfio-user-server':         'VfioUserServerProperties'
>> +      'x-vfio-user-server':         'VfioUserServerProperties',
>> +      'iommufd':                    { 'type': 'IOMMUFDProperties',
>> +                                      'if': 'CONFIG_IOMMUFD' }
>
>Likewise.

Will fix.

Thanks
Zhenzhong

>
>>    } }
>>
>>  ##
>
>[...]

