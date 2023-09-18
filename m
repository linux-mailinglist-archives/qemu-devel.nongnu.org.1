Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918C7A54EA
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 23:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiLa6-0007JE-Km; Mon, 18 Sep 2023 17:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1qiLa4-0007J5-Hy
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 17:14:56 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1qiLa2-0007jK-AP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 17:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695071694; x=1726607694;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=j72CG2syAtagt9fBz5cYIOLZb0rr2NkYOJem1Qy4YYU=;
 b=MkM89dPYfM/CGxm3JsPYIjeMq9EctRxfjx/n19PcufchyG6H9J4LEYOp
 1uocCWrpzrTIsQ8dWVoj05611UKDLLMG2csJwjPeDz6TdzVbUa7j8n/gg
 7sT+Wmk278oksxyH15399kTLSmBtziiUoIZCfP2ZYorhC6hqMjlNEwRno
 1W8JTf3T4E1MX/3dDCk/te1G31cNPEeSKnxUBqxUjXvg/B0AkRLU5fgxu
 cSQdzcsXqVqEdmIYycP3658GXsS9BG508QBvP8NcKZx4BMiXs7WlgavrP
 ZBiciu4RF1q87oikjayTvI9VLJOBlC5Fb2OK+d9mvUvAIo4S8n+AIZKUu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359184730"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; d="scan'208";a="359184730"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 14:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992877387"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; d="scan'208";a="992877387"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Sep 2023 14:14:48 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 14:14:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 14:14:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 14:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Hg2gTANE9hIUDvKit0csOIz5ID/SmWK6FHUFvbv6k8vjFhvmMgrVySs0qff6KZwYkoqn7TQeCleb523T1RIfV+lFNV/EWDAvAznBw8HZq8sG+l961iK1WrLC37YzfuWU7HjzsvWTyIjKk9gA5t1QnkdPF1G5BXQIyNV+A1YlR+HyjYs5Zf3WRBAuMUC4PmiDg11sJzNLWxQCZdF3IWpIKK9K2t6IFICBNxEDWlOVq6FhVb87FkzuC9mm8gkpV2IRAAFqjTr+9kNxybstvhWtuAD1uR557NAx+U181Yv1FxkjNFGs0ZZ1fgi1ES2vcHiG2pN4cvFL0E59nuTqLokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qRI/cidNjYU3T5YqwbQ8/Y1NmINahnJT7UvrGjiO2I=;
 b=GZ8UZa/Aa7pJ9VT/Wh1MR2KTeHId5/ICbq/ePAc3M7GV5qMLE54LcWdAswtLQL8y3+oKDwayqLQkpwu9y4/Kx6DE0s7dMtYFFoF6qp+DZEPGr7pq6o3qQVnmSn4UTtmtt7/6eoFFJxnv1EHnkPh5YNVbJDjN3ZpVN44ngNEOvV+X7WQjb+GUIouR0gMv1qVOkg+weUyW9SmN2QGfGqaAZCuo06aOBu19KC76SkOpZkjhTijuLw6hrG7IhJoW4a5foW/DDo4YHNhmqbLciWLa3qcJLBrWp0AM8VkZXlElWNdoD2xGVcPXCs5saB2IYZgg98GIUWYvuB34MJzzb9/PgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6340.namprd11.prod.outlook.com (2603:10b6:208:3b4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 21:14:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 21:14:46 +0000
Date: Mon, 18 Sep 2023 14:14:40 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, Philippe
 =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, <linuxarm@huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
Message-ID: <6508bdc0befbc_3947ba294b2@iweiny-mobl.notmuch>
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
 <20230918180013.000035cf@Huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918180013.000035cf@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a74d91c-cf6a-42a2-77e7-08dbb88c47d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q260uDSR+oTZRa2jYFrnBuSvbUGHgT04boObYnJV30pByYaCSrT/NvTxVsePglBPxeO7HhnQhEq3fT4idQ+5wLkJc0+qDLhGgY5sl19ODh69T8nUQ/oiosm9XcBJzssdP3tlnz9mQRCtQ1/GfeQMMdPhnEWhGRnCL4bybOf6l10roafMKJfd1FenN8gz1JRRpS77El6m1y89xhV2krqyCE6Yo8slqalqShOrmkKhq7hm2vwzKQOBsEWNsPIORcYCwWEYAXZcqBiOSMbnD5mxAMo3ttGK/Yqyd1iNyMnmQnpI+BfG6TMjuArfUH7QFvtR+nMNEtRFA+Ufx05eFiczYP4r9yr3jXdaG2rzwtiNu1DSneSjHnctpzdPeKB8awS4LZ4YX0x+JjRIzPJjKO5MJUK71Oh2yV2UhIMx5xLS6WXxnjB2wjpoQsfQz+m+WXmlW8WSWtXvCIizzJQ/gMDjKHJSIk5X/TlOl2CUSZjqlBYv2+JrrmwRV6zkXocfScYUw9rr8/VwFPYv2aS4Ni5U0+gm3/rrbgCXksWW/vLMbKYH1mI11h5fxahiifo++mEj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6733.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(136003)(366004)(186009)(1800799009)(451199024)(66899024)(82960400001)(4326008)(38100700002)(8676002)(107886003)(8936002)(110136005)(9686003)(54906003)(66946007)(6512007)(41300700001)(66476007)(66556008)(86362001)(2906002)(316002)(5660300002)(44832011)(26005)(6666004)(6486002)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ykDqwVOgeazdk1/+pH4ad9uhQanDBRM1OMQimtu3/QowQfhNbRLiNek1Vy?=
 =?iso-8859-1?Q?kh1cGufaTVj2CWHkqQcM0wNr5C+3EQG+Jx7Xk65Mh0M/eNnq+DOr2X0C1q?=
 =?iso-8859-1?Q?Jdw9oCVwib94g2C2OggEUuMP7iOIT+4BaeMOsllGUkTlYbDtLU9dsjDwij?=
 =?iso-8859-1?Q?p1C5WNa5mrfAmQpGNN5obK8UGOuzVEmq8i7zwU0+nFEGjkkUGj3Iykwmrd?=
 =?iso-8859-1?Q?NmhrGNcjPs94bz6v0K5zcsbgqkTgjf0TiW7vBHLY9TOclVxwGCDeD8tg2x?=
 =?iso-8859-1?Q?fgwd5byadZKhmBEBLR6fmItWy9BUjzBMnFhAHEi6OknunHDamAts4vHHNo?=
 =?iso-8859-1?Q?aTOxou1M/eetAnz/J+bSYvC4J8whrPQLpVKQfzumzvQErpWFgarZDDollP?=
 =?iso-8859-1?Q?864zk2OQerJpkjWJ13+g2PZ7GUN7YajVkpEtWcmzlR/EmLCGqkk7j9zCrC?=
 =?iso-8859-1?Q?LQRC3lWORHkb6yMu2CoS9Iu0I/JqZWSujJHokKU8Os5Zoo0ZkqefEDrbYc?=
 =?iso-8859-1?Q?WQEo3xWiOblb80u1mtnnYKmZdlJbLPoKyPTExXfoubkMuew34SEV+XElqz?=
 =?iso-8859-1?Q?Yvaa9PCVLilig7bVd6ro6yJqUpgt1kmUlBldnr6ydPN92Z+jBZRo7geO+3?=
 =?iso-8859-1?Q?Dw75rxDtWjN3E+Dpnl3FvgioZ2K0y2bJyNY8iamiUdfewj8XXBsnz0b2y+?=
 =?iso-8859-1?Q?00jB2HGbe+CiCdONK9o/Dfv17TZG0J/gSiVGCVTJF1ncERXRiD+geIvMzq?=
 =?iso-8859-1?Q?rwMilgpOxuqtasZ8ywjs3JUQbXVxbuQRrcGyTfGgKxjmn/brwYMfWooBT2?=
 =?iso-8859-1?Q?cd6iI5NGHvMpwHnAty5wgxeeeyJ9aaeKJnOLiZv8/M5A2yJx6OW0zfcKIG?=
 =?iso-8859-1?Q?FFKRQwfDtBLwhYgnLrnEwXR/ROT67pmtwOLr9ZRe4DeuAS0p8tKSBe5F0o?=
 =?iso-8859-1?Q?YmZbWMpwCQfleq1ObUgYw7hQcuC6M7IUZtjHZWbQg3Xrtt4f7fHe42iIYi?=
 =?iso-8859-1?Q?jXYn3T8t3acTGCdLy1lueSjo8fgGsE4QL+z3H/rPSgAg3AG5NIWBwaDqzo?=
 =?iso-8859-1?Q?cikaILSwz6KwzUxpi99n33tp8bopdhMtQsgR6z6uBGZF6yllfCRzJmn3H5?=
 =?iso-8859-1?Q?RFEd/ZniVTre7w5zJupLPGQyu2e56PO6NCtSNurjlMgns2q7YfFuq9Eb4S?=
 =?iso-8859-1?Q?PGDNJbK9FNFPMzAOaubpP/yr56DkkxckIpQvROhHuTgP7jGBz01dP0Qr+G?=
 =?iso-8859-1?Q?9CI4jxmW0jWV5tj06FpLxm+GZIWvY+ntRlZidvmNlSrzs0KwnWOQ/bzbv6?=
 =?iso-8859-1?Q?0tGco7ECrAM65KQIScHSUFCM/w7x2gGVqnWRgOe3lFOtNaxfQZjVWTD/1Z?=
 =?iso-8859-1?Q?BverifvzdPYvA1P4gkuxkUkbBSX6eo8wjxknuHJMVhDesq5sQwGDUSLnQD?=
 =?iso-8859-1?Q?LhKr84URwLX8J8NO6ufN1wqnt6UZJiwuEO/pRRohJluapsvXPYpXozagJT?=
 =?iso-8859-1?Q?JDqqu07p9ckixnUBW+sQQzbmxsRhnFpQWETjR594iD01SHptfLE87Xjycn?=
 =?iso-8859-1?Q?nU0vwITQw6odasIIj6f0ugS5ObTtSqwaRu9oULo3uwgqeJxCPW77x5lW1g?=
 =?iso-8859-1?Q?sT+aHXQTWX58+w4pByLns/+F+KjYMmlqz4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a74d91c-cf6a-42a2-77e7-08dbb88c47d3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 21:14:44.7356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+lYWvkg+vvVVe4STAZixsOSOVp5cZy+Uhp3efwidGGeoqgJPQHPUQ1gURcLxiEaWP0AU4W1DTFsiP1QqgU+IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6340
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
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

Jonathan Cameron wrote:
> On Mon, 18 Sep 2023 17:31:38 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > This has been missing from the start. Assume it should match
> > > with cxl/cxl-component-utils.c as both were part of early
> > > postings from Ben.  
> > 
> > Sounds plausible -- is there an Intel person who could give us
> > an acked-by for this?

While we are at it; what about .../hw/mem/cxl_type3_stubs.c?

> > 
> > (Ideally we wouldn't have let more gpl-2-only code into the
> > codebase without a rationale...)

I'm curious about this statement.  Does the qemu project not want gpl v2
only code?  I agree with Jonathan that this is the intention of Ben's
initial submission; so from that PoV.

Acked-by: Ira Weiny <ira.weiny@intel.com>

Going forward I'd like to better understand the qemu communities view.

Thanks,
Ira

> > 
> 
> I've +CC'd the kernel CXL maintainers from Intel a few of whom
> have also contributed some of the QEMU CXL code.
> Hopefully someone can ack.
> 
> > > Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > > ---
> > >  hw/mem/cxl_type3.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index c5855d4e7d..ad3f0f6a9d 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -1,3 +1,12 @@
> > > +/*
> > > + * CXL Type 3 (memory expander) device
> > > + *
> > > + * Copyright(C) 2020 Intel Corporation.
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2. See the
> > > + * COPYING file in the top-level directory.
> > > + */
> > > +
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/units.h"
> > >  #include "qemu/error-report.h"  
> > 
> > -- PMM
> > 
> 



