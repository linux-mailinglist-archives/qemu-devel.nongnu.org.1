Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80A75DFEA
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 06:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNR55-0005Gx-Ft; Sun, 23 Jul 2023 00:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1qNR51-0005Gi-5s
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 00:52:27 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1qNR4y-0006ua-ML
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 00:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690087944; x=1721623944;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sHxU9Ya/jv7UkommnMbw74zjRgJZtGK7NP8nDiJ5G7Q=;
 b=DwNtSy3Mja7qcKwHAnPt1cmrjTTOssQyuuSAt+Rhqch/WtxmS+uySYKk
 satQXs4hlEQWZ7x86RTPVIBtTlBdHGBOPwhidb9QxAQFY/gcxAyOung1/
 3B9V4nqco5lcJSmlBpCQfXem7JpX3tGaw7a4bGH4iRPri8GIszkAFz2fv
 cJf1KOj4KgQJ0UiNNvcV43cxFocUkZjAZ/swbfeDgMj6jhubNV5zsIaDZ
 b44rwQ9H3mNjqIk5eHNV7DYA0keWffAAO0Vpn4qMdV9+5phcxFuy7xLJi
 m64IqPPdGwcoiMAU1G4xU+K4g103eRZXPEZrgeVvzExhux565ONSC3Vxz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="398147475"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; d="scan'208";a="398147475"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2023 21:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="675475092"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; d="scan'208";a="675475092"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga003.jf.intel.com with ESMTP; 22 Jul 2023 21:52:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 22 Jul 2023 21:52:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 22 Jul 2023 21:52:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 22 Jul 2023 21:52:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDPZUikcOFzcYin0efJWPq5OUAu4C+mA4nZ5zpEk7Zan4fSQ4qtoYNy/jdsJQ39Oep96FAtyefIlguXZao9+pbPyktzAt6CQRamiqBHrEcX6OdFFw8vTUU2Dc8hflxOQmvoD3B0Q6oF93NPsQ29bX8L7UI/sFCO7hXEa/3fX5VKIQ7OZ7ttOpCKsxx3g1VuFfevcMgHct/8wkI/VzJMbcFKuUCglXLi9jQMr4EBxaZgF5Oo8TZqybgZQ1AXZAhqYEoaJGtE/VhJIu52q0Q0JN3PMY1s98fPURadU1HJdOJpN20S3zEpqMVsvZ3RemumJqLIRWtVYSfUFmxKUoh3eNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ9vPw5L17uS1T2JRkSMQ3HWr1QhJDFZVebM6FD/RWs=;
 b=NrtcyHcZktD52bHXbLyxHroviISXEp/+2Vos65kgMkgqeWG07NVtD0/FU2bEAGLyPHrfos6/MkzUSFUB8u5v+HXXFEFJUxXPj1gs0voT3NymQbOJWr771Ovkr22AEVZFxwPF0swYecTr66psVpfoXO5iRLbdFP32C9BNkOHItVfzjaITQ1YCq1FgPwN+b2zyjtAOahZHjWhw85j1G05GCA1g3n+coOVVcl/fdnnpxFIELRF6O9f5m6wEMyA+wlZOGnGU+18VsTbZAvaOIJYHuhYtFf0PvNIam+DCKzOLeEpy1ixVvDuFgTE0xTvVK5L38N196jl1RGa5dS5h1NkySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 04:52:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 04:52:11 +0000
Date: Sat, 22 Jul 2023 21:52:06 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <nifan@outlook.com>, <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
 <cbrowy@avery-design.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>, 
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 Fan Ni <nifan@outlook.com>
Subject: Re: [Qemu PATCH 0/9] Enabling DCD emulation support in Qemu
Message-ID: <64bcb1f6ee016_760de2943b@iweiny-mobl.notmuch>
References: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: cacee5e5-f0fa-415d-bc4f-08db8b38932b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mmzV+CgxbwtQHRh/UXC0W8I7Z4SbSl1aIkfiT0JmqIfrFeXIqcoCKxKCsCh1z2YeytdFnoHa93nTJEo/5FzJo7stAWK4Tx67hRcjdcCzE7jiZ/NxapQQrIK5LC2GkQcZHe//OFevBA9IvjGp4gfwfQKtSzQZQoH5+8oHAS9uQfFW9yjf9j7/w2hHjjqLm12oMR5FevOEcApDFeKJZa7X32YyUaSworx5A18+bXW9/Oq2UcFi8ezq4ktFxlhaGvnQZXA4+dPjQHpS1bneHT1EW6rgx/Vt0xtRqvqQJqV37p+9G02wUstQe9LPtAGKvsKzPaQl+6HoX2UXjfbz1kW5qmqZU/Wy5wT9MbeT2ppgd7aVggDihxkBk1S8cjkzrfZXb0TTggWTMyBpLA2Fad34TwUundnNUAKhX6+fwikBSHUIgTFyul+YkPWUy3g78q4u7VRjMfV/9HPJxcUlnULJQz8h6edjXGT8tmxDnjoE7iF/p+jhe7llGl8ngdny6f9bT9X71b2OKpaXeF5xUUWLCdKVZUKPbghGUC3YIiFYfrN4SvHMGD3lB8A2yjsnSxV+5ImUuJvUcT6zORt9fDCDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6733.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(38100700002)(83380400001)(8936002)(8676002)(7416002)(44832011)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(6506007)(45080400002)(966005)(6486002)(6512007)(6666004)(9686003)(2906002)(86362001)(82960400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svRODLIl0iVE0C+fMxYxuQc83ngAI9xlYKX4nCoSPo/GG+uwXrT6XttncVnQ?=
 =?us-ascii?Q?HU7q7DhU86OZSWQR3mt6YgGwCoeV/L9Rdr5rL5LmAihfDKII8xUu0Z+J7PGc?=
 =?us-ascii?Q?65XjeLfP+LjubjQjUnrLFsnIBjbigRReIXg7wI+dd+goN+pKvOqsFi5+SGPh?=
 =?us-ascii?Q?UUEL1jvqpbgUrW57G8aZiUmhadEnpsBxWY24ilCY+OjHK32km/lkh8XiuUbp?=
 =?us-ascii?Q?WIQbaGcIiyHW4qpFqpoQMS0SCxD2Ox4HAnBWGZXul10w2HdJwDg4NB8k20iA?=
 =?us-ascii?Q?F01LmcMtdsO/yuaME13Tp/UooZMyQ1DPM2layb7asSb9q2/zou//mDXbhDKS?=
 =?us-ascii?Q?ryDOYEplWoP1L2oKALbxy3CzGCw1wUtpC1xkDHVQehadg86+Xcrb2hqxXgpm?=
 =?us-ascii?Q?nb0FmW0j8pAtyLZF6rgekPtwXAU6EppLqUu7qYrJ2DvaukFKDTpkNoadSTT/?=
 =?us-ascii?Q?pmhVAzGQ/lD4zZDSsO16S0xyqJEn30F6QL7k/hLjdjbCag40yYle9QZgWzQW?=
 =?us-ascii?Q?x8GlWOo8hjqcSoma/bN4q1jHrOQnUk3HlbkTib8djQKt3/XANm9VVS34bUnS?=
 =?us-ascii?Q?ozSW/9GAn2CTOaMKAzFR4xAro0jsnmP/xy2SHnNYz3Qn+D2aA1jXDkkdQWrd?=
 =?us-ascii?Q?BecFqOUaqX+U3fLU38rjUpsXPPMc4PyhfsKw7sx1W/WS0N9knlb0nd+JVdpI?=
 =?us-ascii?Q?dWqk8HYOXIMbSf1tO8F2xHU8lMNqJq6L3cWMnMVKZPPJiXp2aNF2MvKboprL?=
 =?us-ascii?Q?NqBf3iN2gXLYhJWob/xVJnckdlnvNs+YLZRkphltWlqIEz/7eTLmoJgZTk3Y?=
 =?us-ascii?Q?fZ1kvNuVlme3NCWnyebq0y6OsKvFMyvAHWm6FQKJ9w+9dcu5yJl96rpYnZxL?=
 =?us-ascii?Q?4SsU1erQa0G1y9l7w5W3ekT1CL0NWlgh5V3VK20DFNwpfJ+yETyXWehK4J75?=
 =?us-ascii?Q?w4BhxyMcaz9HiNwUA2Th5ryWvs8OELWn1UJitmnUQhYiHQCuswv57//u/6Hr?=
 =?us-ascii?Q?L0/yw7hzpN/oObV0osgLr+JCnjToBhPV9O6cz29Z8mfZ7Mogi11AQwxKZGRV?=
 =?us-ascii?Q?vqsIZRxsic68qiYVMj5ncvVqPUBZwCHXOvXqqD2E09VfdH/4LPNDJDc0DeVH?=
 =?us-ascii?Q?C7CdgMiCPiZgznE5bEoXqWa5ROXUG8eH9/iqX/srZT7Q/UqSwjBf/s0m9Zzm?=
 =?us-ascii?Q?W/Lk9ndJO+hLQknqsIiFWsZ3yXU5Z1W/NcuT2lbTensFQIjZPafq4CPQgDKl?=
 =?us-ascii?Q?5IvT+q/x7d7n2xkHTyPa3rVhQ1dc0fHJ6PsACV9qT3Z6QmxWSAOUZUB/VVUK?=
 =?us-ascii?Q?Ht96EWxUF3Fg9w5SixTZdWozU042byaDZkrz7VlCFE96urLC0v1xohQQvoD9?=
 =?us-ascii?Q?pQE1IdBM4ZTlLj6EEt/XpclHVPCVN+qYXG5VYtnSh82RIyIITEwc1xQ32fdm?=
 =?us-ascii?Q?VIBjPlyA+s1+hbtnMavjoPGKnzX9ihe3vohe9FL3v+d+5lSPSR5cSjmK/md2?=
 =?us-ascii?Q?yfz+cTru91OT91qsgiHNc2+yPymmDGuNytCeIgffNeXGv28+HayY9a6bFdTO?=
 =?us-ascii?Q?NZxRDrX0MB49/xhj9scMw8Q9cnk1Gh2vHgLTMoDR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cacee5e5-f0fa-415d-bc4f-08db8b38932b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 04:52:10.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPqc1DrFELIUN210kVByFHU/c/lOoTs2LDgjGgP22E3MjBfoDMU6Z9j5Ye7odcYGdTr1IGaHGzZXmYh7tEy7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=ira.weiny@intel.com;
 helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

nifan@ wrote:
> From: Fan Ni <nifan@outlook.com>
> 
> The patch series provides dynamic capacity device (DCD) emulation in Qemu.

I don't the patches on the list.

https://lore.kernel.org/all/SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com/

Did they get sent?

Ira

> More specifically, it provides the following functionalities:
> 1. Extended type3 memory device to support DC regions and extents.
> 2. Implemented DCD related mailbox command support in CXL r3.0: 8.2.9.8.9.
> 3. ADD QMP interfaces for adding and releasing DC extents to simulate FM
> functions for DCD described in cxl r3.0: 7.6.7.6.5 and 7.6.7.6.6.
> 4. Add new ct3d properties for DCD devices (host backend, number of dc
> regions, etc.)
> 5. Add read/write support from/to DC regions of the device.
> 6. Add mechanism to validate accessed to DC region address space.
> 
> A more detailed description can be found from the previously posted RFC[1].
> 
> Compared to the previously posted RFC[1], following changes have been made:
> 1. Rebased the code on top of Jonathan's branch
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25.
> 2. Extracted the rename of mem_size to a separated patch.(Jonathan)
> 3. Reordered the patch series to improve its readability.(Jonathan)
> 4. Split the validation of accesses to DC region address space as a separate
> patch.
> 5. Redesigned the QMP interfaces for adding and releasing DC extents to make
> them easier to understand and act like existing QMP interfaces (like the
> interface for cxl-inject-uncorrectable-errors). (Jonathan)
> 6. Updated dvsec range register setting to support DCD devices without static
> capacity.
> 7. Fixed other issues mentioned in the comments (Jonathan&Nathan Fontenot).
> 8. Fixed the format issues and checked with checkpatch.pl under qemu code dir.
> 
> 
> The code is tested with the DCD patch series at the kernel side[2]. The test
> is similar to those mentioned in the cover letter of [1].
> 
> 
> [1]: https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.com/
> [2]: https://lore.kernel.org/linux-cxl/649da378c28a3_968bb29420@iweiny-mobl.notmuch/T/#t
> 
> Fan Ni (9):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> 
>  hw/cxl/cxl-mailbox-utils.c  | 421 +++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 539 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |   6 +
>  include/hw/cxl/cxl_device.h |  49 +++-
>  include/hw/cxl/cxl_events.h |  16 ++
>  qapi/cxl.json               |  49 ++++
>  6 files changed, 1034 insertions(+), 46 deletions(-)
> 
> -- 
> 2.39.2
> 



