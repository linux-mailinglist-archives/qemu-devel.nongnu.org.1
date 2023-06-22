Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76373A713
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNvy-0002Rx-MN; Thu, 22 Jun 2023 13:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eddie.dong@intel.com>)
 id 1qCNvt-0002Rj-E1
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:17:22 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eddie.dong@intel.com>)
 id 1qCNvr-0004mZ-BU
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687454239; x=1718990239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2jaoODSy3ULbEMsCHyP/pQrnwVL4meMVG6Jl/yxMhfQ=;
 b=Oal8mcEqnPUjxLIOvuEd1/8UL3ClcciHWSPPXUk18LbdmzCHY0xRsYtF
 knCnL4abi5s3VOh+bOi0cErNvqmOAwBKyUlH0GVtpjbCHerKgVoWB+9w8
 jgxEPTs+j9Jkqh7WOzCXzEniNtt0i0NiyoTfMpfXtxE8dgOJmc90J/FBz
 qTyHCq4AWuEDsBfHfFKaeoP4Ahvss+OORKz0tXOh7Sh0KDpRBB9H9/Ymh
 qYxDAxgTW82LGD+Akhzkm6ItAmFr/5N5dfBdGMi6lMgmwQ1SNre7gEZyK
 XPsvU2jGcQbXBCGGwtj0WzuUuvnbLYedq0/0yL9hJFlUo9NYc0Sdc2DPL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="360587111"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; d="scan'208";a="360587111"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2023 10:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="839148826"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; d="scan'208";a="839148826"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga004.jf.intel.com with ESMTP; 22 Jun 2023 10:17:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 10:17:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 10:17:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 10:17:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS+VdwXzOpk3Qp65vtg600oE5UZf/DWqcPeU6w10tdp9pQSOM0de1s3AfqhOugHZcgtEt/beH/bXtQQpuJOAl6Ze5I4LNCJ8zsg2jy/R/HUMeXa3uOsH8mt6UUaYWj1a9QUduA9apMyP5crdxYhgeq07DGmsrdZFzb2F2UpF9cT+PBkZbsKWWiDP8FaM9HfNs2Q/qEzkuAfYp6qCQ6dyMg8oqsd4IcrH5g9dyik5fgcsTn7V89W1LqFYpPCm1lZZ2LdxCnHvOraojQgSKaKiBJn8XlhBuS4boTJ/VsSTJN3q8Vi4i9OjPVxa2KGEUdL2lBEokZCSNNWzfj7wivMhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO+daIwAi9+Q2+IVks3kGdUMZJbCaE73AKdMS63fiK0=;
 b=jpeULyHwBTenT6DIIK8Bn1KPiJfnGqZQ6wzyQulZU+I6mm+oyAyLwu8V8JE+3K+IUwUJ2i7cW6PjlcrJOjoUTBGNXLHTsJl2BYaST5qILc+nvCJZ/W56tTBET68b0IjuY0xL1tOt8pgs8xLMLAY/nyekGJL4mezaAhJPLqx01vgCt/0d8FT+Bqtqtytze64e/56SAbhKdslfcg/Q/uuYmEsTjH1NlVtHxYIXWOyuDqplFRftlsyVx5LAXi+OPiJ1pi5FbhWrGRrPc1asrh90hO8s0UVebeH/LtO3iAXz2oDEu1vRibKSD0b1dCX0ewZU+YPZNYD2s/SIRuG8DVFN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3042.namprd11.prod.outlook.com (2603:10b6:208:78::17)
 by PH7PR11MB8501.namprd11.prod.outlook.com (2603:10b6:510:308::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 17:17:05 +0000
Received: from BL0PR11MB3042.namprd11.prod.outlook.com
 ([fe80::59ba:4a19:43ed:b66b]) by BL0PR11MB3042.namprd11.prod.outlook.com
 ([fe80::59ba:4a19:43ed:b66b%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 17:17:04 +0000
From: "Dong, Eddie" <eddie.dong@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
CC: "Zhang, Hailiang" <zhanghailiang@xfusion.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Subject: RE: [PATCH 1/8] colo: Only support the same qemu version on source
 and destination
Thread-Topic: [PATCH 1/8] colo: Only support the same qemu version on source
 and destination
Thread-Index: AQHZpQNmOltlC/QChUubQDk3txDT/q+XEG0w
Date: Thu, 22 Jun 2023 17:17:04 +0000
Message-ID: <BL0PR11MB30423A1ABF3C53240E3ABD878A22A@BL0PR11MB3042.namprd11.prod.outlook.com>
References: <cover.1687429356.git.lukasstraub2@web.de>
 <9acf84c3a558357d1c834923b832ddc1d2aa7548.1687429356.git.lukasstraub2@web.de>
In-Reply-To: <9acf84c3a558357d1c834923b832ddc1d2aa7548.1687429356.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3042:EE_|PH7PR11MB8501:EE_
x-ms-office365-filtering-correlation-id: c4772e45-622e-4c67-66d2-08db73448026
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vg8DAqxANJ4LVaXJ1AjrQ4OswDL+B7OF0zPEgME9IY32lZtAcPChMiAKKRzVNxYF/iEzc9gXbRMNX7VijQZez1p9W6MtAluwZ1hZVq6iJdoDZAvt7+7/h6Jx4l3z+yrXD97x4y406ryunnyQkMsJ0dbqUCR6sxXWpttmFYYcfHMfbJfhMnhgAMPxkquVVrHLvy0cWPKJeOVF1D9ZBxDGUaw+WS8ZHNNF7M5xgDISpLDX/B2A0FbicwtJm4lhEuLlwDb5rll5kEfEyARPjxGIv4S5xuv2i5Ua1cfcKvg5XqElbPFcdnWBUWipl4+zwHNIIoQ8cGdfz/a7POjeh588w6fn63IOYeu8PrYvuotbQ+jhNTsxEo/DUlVsDlaW7xZkHNJFMtBLDu4dH2iXS74MrNa2hZnK2owAZW/Pok/CYBW4dgbUCyTvJ/GxMzvsBegJINDOYRPJ6AP64faFBm674JiadazEbCzoxufieIB/3/kaYdc/jFyrWajDCxJqEafQZ4homDvaYNB+YWXWq95e0oLTaVpQwHLKLrLcccMwixMWqg9BG1vXXMK/5a1SkNtVt+V+UGUyb5ph0xRUo7l7K6oSW5EYkbLFjij/+k58Nxz8LDKdIr92sl8d/xN3wfp8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB3042.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(54906003)(82960400001)(33656002)(110136005)(55016003)(122000001)(52536014)(38070700005)(38100700002)(5660300002)(41300700001)(86362001)(8936002)(66476007)(4326008)(66556008)(64756008)(66446008)(66946007)(76116006)(316002)(8676002)(7696005)(478600001)(2906002)(71200400001)(107886003)(186003)(9686003)(26005)(53546011)(6506007)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o7gNcIfVZbXQV009bcBF8Ys/pkJ6mrgREiI+j543Ze6Qp6yhHfywTbacQfFt?=
 =?us-ascii?Q?VQk/6zQL4B7RFsImEGNceeKkBIYq/MmjoaxdPaAoD/6TwTOQcM5ld237BwsI?=
 =?us-ascii?Q?JdNhAM9PsNORhx/ObHqcE4eFMt1l+2XvqbpW6e+PyQ/75XCFkU7PIOJFYbCD?=
 =?us-ascii?Q?bfTXJa5NiYc9/PmcUM3ttk457jqnrjan6UfgXI7LQuJXIRexaYTocvY0kPSA?=
 =?us-ascii?Q?u979oWhB4vb26J5NaZEPJ7iTIpq8WC+9fO1uO4xLgX9SPn04iXwp//5SGEYR?=
 =?us-ascii?Q?EeoGa0w+mCOiU2+Vh91wr22XpxxEGRC86hJzCecB5wpUNvrgA+Dua3h53PHK?=
 =?us-ascii?Q?v4hLKtd4AnhB9tqHNzDAB4eTXpsKMuRvhG0yD+SxLGmX97ctDTwpK6MCXpK4?=
 =?us-ascii?Q?bNzkm51imheTx6tD12he3t0C2jN2x9zi6jb/w/aEevdRAnG0kJeEHR8Alnl+?=
 =?us-ascii?Q?y2XqTG+NtnVGNQJqO9bpRNsd2wj0JP25qfT49+CgJ8ExGPaRhfBAAYbbpLmv?=
 =?us-ascii?Q?5klBx/RhMulJ3aAco1SYuVniIpJK73ZbKvK3wx5qO157fdysLUDRUn4vBdAQ?=
 =?us-ascii?Q?G/sAyE5cr2kVXaC8Gh0sM8/HbA7UlwLZoIDJWXYE1eJJ8quGdFapHbvLH3U5?=
 =?us-ascii?Q?5wt8uoRPFPchUr289h39RDH9eYxVdhofEZljaC62wi/rVBoVtlnTLDRAZ4k7?=
 =?us-ascii?Q?YvDS3SP6N9YlrPGQFDpvrCxxZyEZxsS3daueA47k0WPE6efcRyTzh1/i1tm0?=
 =?us-ascii?Q?pSp45O8dJvBWiH/TNI1PGqrVXlgxHY4MeQWu0rxfHHDH1YIWE1qVSk3cXa6L?=
 =?us-ascii?Q?C8tSMlREhBlO/DavV1YK8qQcAa5rYAt2Tr6sCumx3DLfVLGTc64yDKDzxBNm?=
 =?us-ascii?Q?tI8wz2yKBaNKDq9CpP4WG1qQeUSduFg3P1RmVBBP2Gs3rHCBFx0YC47OvEsu?=
 =?us-ascii?Q?NTtEyNEjkwU3zRFejGATaVkboaA5BIh4HA32+1ND909DWLrgFt7quC/DXKZu?=
 =?us-ascii?Q?nesRd41XDagdioVy4epbOqvfUsyQe4EzW/aMpr/XiGmEK7OX66+lsyzqjuRC?=
 =?us-ascii?Q?RCy1zXhHqb+ugRbQSdAMX1JUMrReAZZZhWnVN4F6g+kkDn6ZrrsDcdlwGZen?=
 =?us-ascii?Q?gk3JOtSIH8TQEaCK+gUYEKKHzksq9vfm3QUgQsUUE2ZIdZzjBdn5iZq3LerB?=
 =?us-ascii?Q?//feiH34hbsSX6xrftH3zVx3t9yvl8t+o8/y7zL/cIbV2qSVZvuIIoxsHpF0?=
 =?us-ascii?Q?lSTyLwBVUF65JpQ0XbKOJpqwYPmdnuxOJ27aTFhUrgXJqOZDoIzQz3CQmJXp?=
 =?us-ascii?Q?Cooy6gRnul+/B9JM+QTDUM51Nt7CX7jCgY8uBFyc+Xa/QTjRfjwKHHs08CZq?=
 =?us-ascii?Q?ti987TIYrQ4ud6zfO+wBEea3doEeIc1ohZMFdDNEq0cxsTfMcYhGHqMHdCRZ?=
 =?us-ascii?Q?JpO33y/3zp3vGHT0MVS6fsrS9FAOhlY9FFW3cmWLdcECBGZ4vd4hrXXRNt8a?=
 =?us-ascii?Q?F34Wc/4WnAAdgrCWYQ47J/EKjRXAce6sxKu6x1PYXdUhVQIj/tgUJgj5Q6p6?=
 =?us-ascii?Q?GBawPPf8UhDBMD/AC1lWKMJ/bQ/sloHjxNmYiHB+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3042.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4772e45-622e-4c67-66d2-08db73448026
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:17:04.7965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFXhb0Xe6qUut5/TKWquPuIjixTgqXjJM2SQ+zAuBKV1+hX/YHOGGlv28FDZpTMDFNFO+Ro6GJTfkQwiGAEpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8501
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=eddie.dong@intel.com;
 helo=mga14.intel.com
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



> -----Original Message-----
> From: qemu-devel-bounces+eddie.dong=3Dintel.com@nongnu.org <qemu-
> devel-bounces+eddie.dong=3Dintel.com@nongnu.org> On Behalf Of Lukas
> Straub
> Sent: Thursday, June 22, 2023 5:15 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Hailiang <zhanghailiang@xfusion.com>; Juan Quintela
> <quintela@redhat.com>; Peter Xu <peterx@redhat.com>; Leonardo Bras
> <leobras@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH 1/8] colo: Only support the same qemu version on source
> and destination
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  docs/COLO-FT.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt index
> 2e760a4aee..8e64480dbd 100644
> --- a/docs/COLO-FT.txt
> +++ b/docs/COLO-FT.txt
> @@ -148,6 +148,8 @@ in test procedure.
>  Note: Here we are running both instances on the same host for testing,
> change the IP Addresses if you want to run it on two hosts. Initially
>  127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
> +Note: COLO is a experimental feature,=20
an experimental feature

>so currently is should only be
it should ...

> +used with the same qemu version on sourcee and target.
>=20
>  =3D=3D Startup qemu =3D=3D
>  1. Primary:
> --
> 2.39.2


