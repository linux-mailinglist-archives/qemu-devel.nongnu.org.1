Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBD8502C9
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Feb 2024 07:48:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYh8i-00052G-Mj; Sat, 10 Feb 2024 01:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYh8f-00051t-NM
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:47:01 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYh8e-0007yB-6z
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707547620; x=1739083620;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Edr/QixjhSAh1oDEvRB9bvpuD4apIg0vgBcbncVoRbs=;
 b=n2hG4ouHDRg632pepB4RnXsWZKAAjDHSuJ0yjVoGJpsuK72+n9qka200
 o/1PVVHtIss0+YKJ35UH/78aVs4XpngGthjurdBmhyl34dipxpsrwaf+b
 767Hb9yEhvFw3lOwBBJxq4gYAEaDRT+9qoUYdPPKQ+vgVDEomu+jrbPVw
 jUIG/1b1Wyj1Bwz79WnArxB/fqvdYxkzfGS5Q0fuK/XrixsVVI05o9uja
 VSlDHKBtd2zbmiZZTxPbXcScNPv54O2QVX8VTf0aBF0iHjodOgo/Ww7Tp
 XhstCcx7C9jgtcA/ZzkvqWyHU3psUw4GM3OowMjy3qy10MT8NKb5OQ+On A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1679286"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1679286"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 22:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2106547"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Feb 2024 22:46:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:46:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 22:46:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 22:46:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/ksLfSh7TYS1aS0nnuZR2jURh5qytfQAwlS/GOwFq/UkO4MEJ0gLfXl60y27u9Fl3WhJH5ZXzbjAgl3BPW1yuloAUiQMG5PUZtEBX6pxk0GO8es8yoigA9AQZEaHk7I9rnqLq9CwSR5ss23A9nBIFbaTNA5ShiNcp08lZbZwcgKjQ5h3sGGALZVouxWbsL/IbbtEaykefWe3318PH0XuwC7YVgg+39/0QkHNZ9cfChZmPJGJEWvIdNWgWUFotEA99VSJVIbMRfkH57XzLWjbBMC4i0iF741iKmDcRYLgBgi1ij7i7smdXB8j6XTVPN8oro9zv4Vm6EPJm0KFuX7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttYYZECwCp/B9OpFPzvqCSsoSmPpxryIwSo+lfkCAdQ=;
 b=aV39KLk8M0eElEIvK/io2FiBi+otg1AVhW2TYC/+q77lSLRPISFbz2fpySoqO+w7k85iuSuO9lkkeaCKxr6nJkT0dnIeCwrYz/nQcrdLx8kw67p9hS3o7Q0JTsAYeWnriK278xQdYhG1tjnWz3HP51rXVPGEiWZ1ow3WCRDikNjQ8Vz8NMM6MwYo5gd2VIIHAv8sB71qROoVNXDjnWLDNzqIyerYl4RdNLJ/I+okpDRfXIvGvO1kD42SdS/yk57VlsT9BbzY21h8aDZljKCeiIkTWZk0xsZYYndqAB9dRKLxZM7iQfHSt3HHKfRpSxkq3uN008AG8c7wpIsbCAxWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Sat, 10 Feb
 2024 06:46:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 06:46:54 +0000
Date: Fri, 9 Feb 2024 22:46:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH 3/5] cxl/core: introduce cxl_mem_report_poison()
Message-ID: <65c71bdc81927_d2d4294f9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: a173e642-9941-4647-1924-08dc2a041186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ny+RBFRgkZu+TWdT5wjqt7duQlB0yjL8y2Op7JJONGfiB8G3LbaVlM0ARH4jZbeSA+6bfzmojU0nrrVxPcKxaUrk201D8i/0o+jFkXGb/xdI/d55V0UUrfRo03POvHbYj7d8MP4Xe45dLY5uFKxKXcjAtztt2A9iWRnu3Lm6ik6uyDtXviROqozJ97wPz/a4ptAK7PmLXWZFksBuWslKTxxwmPgX2XyiEoo/l/FUkEg8cqhkFTAvg7N85ec4HSHr7dR3JdG6n3F2mVzjTXPkfx7eusFyeja7cxjCh8+vU/qa4X4B/FGtEL1DIP50459ykLKdf4ChFr92yRY3txFjW9qz4hBGOinI7sntuvsIcO0pKvLgDdLUcheRRLQKPe4F2JuR1579TdTyh+FHKP5iWuONdoipF5kL1uTo065n8RSXmNGWXG9ncmhZ3P/NeAkUIW+Cba/zSvN+7aFPzsAwCdyeUNTpjt8OJ0IjffTKEfqdFewLT/mXeVr5SaZwKonRA4K/IDOJUvU3gYkL/3FdNa1ZM3XIB/UPI5Mak2fHsWC2lIs0kOHGzDlnxBrPHO31
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(4326008)(2906002)(8936002)(41300700001)(8676002)(5660300002)(82960400001)(83380400001)(86362001)(478600001)(66946007)(6506007)(66556008)(107886003)(316002)(26005)(6486002)(38100700002)(6512007)(9686003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8aEPAsXq92M9JymHoqpCnGcYuAAr5wOuCtG0CND0s4z2WalFxes6KfvrXGx?=
 =?us-ascii?Q?2ZdHl4wZEW0A9OF3Nyr2fNffLhP27wsRWTnaseZBQeTm8Z8PEhShyX4CVeW8?=
 =?us-ascii?Q?gfJhnITi8cInL+d4EHzq8FssWUGmhyLe3d9wf81flNCtZwKzmkLaOlnU4gmJ?=
 =?us-ascii?Q?HpnXXoMhlQyxNZBn8OGFS6dxE8AEWaA7puFT6prOfWsoI2CvcGIF/pNgp+t4?=
 =?us-ascii?Q?FZ+/xgvEtm4UMKkeuR1jERP6CT0OTcnwvzcOsM5kXUu0kHS0J/2t7Kp5bqBf?=
 =?us-ascii?Q?Q4hvv4MZvbStsa1nEBbU7ywAcMjvbu6ysyaJllTISJ3fR9Sf8WiQ/v9HuWEB?=
 =?us-ascii?Q?ryvGWHKBmh7Kg3U16mrj6I40esV/nqicN4bn3iW5W5JS4rjPlUh07KE3sMgO?=
 =?us-ascii?Q?CG8jtu8M99UEem+2C+9uG/VN96MPfxZhlGyCZPDYAcTIOCUfnNEi1yxnONqK?=
 =?us-ascii?Q?vXvTMFteN95J4hJL+NGsMl9BNiks2vy9I/Yhiwx9yrw2sKVVtzNqWJjos7Q5?=
 =?us-ascii?Q?jtVkXeThJb44KLLEdoKaLqqxR6pef/NaHivmauS//lSN6Yged4EoGVkauT4Z?=
 =?us-ascii?Q?U7dsgkMdSAyyM+ehoKBiml2j/Gd9ztAcXHu2PPbAAsQOFOOlT+ijCNuAV+TF?=
 =?us-ascii?Q?N9Pdrq9gWk3ZodHRSi+cQC2ihz4Up1LRC4bMvzReJKaYku1WzugO0/VXteby?=
 =?us-ascii?Q?PuW/a5r/6l+GT8q0S1BOyTaLkCU99y68nOyqxtqnGF8RJHYZVtQ+QxBJh3TJ?=
 =?us-ascii?Q?ioLp8anLawBlzIVyzZixGYb8qui0hsBqgxmRUi0S9ks4LDrlwWoGfiYhTts+?=
 =?us-ascii?Q?HURYEkDHmrI5aiPENwOII/TafuKtB6ZnE/hhsJfq/XIEzqo3Ui782Fs+vWtm?=
 =?us-ascii?Q?XUpxmnebm9goX+tObPv9uFlvBcbgqS9nu3DwoLlKJGqLGRF7BP3Ijb422Ptq?=
 =?us-ascii?Q?qcGEnaJ8gwFJTnL0ampwQ9/IIK61tsROTQqRzvKxIAXWEBnanxzTuq3UPVjH?=
 =?us-ascii?Q?FPErUySITrx+X3VVnWwRp4LmTIWKaSEahT3YVL3lsxLZnkMEO6OcaWUGfJs0?=
 =?us-ascii?Q?kCL6l9fRQ2fqhhRoYYUDk2r/Jl8GFfkKOdy05l8eTPLFVOYKQuH7gPdIB0lo?=
 =?us-ascii?Q?+OKw2IqbydtdLrjSUlcCFsoziVvBz5BY2cAWRQGy6lq5cJZmGtfHAnGe+4RR?=
 =?us-ascii?Q?qcud/4VoHREmhv55yRQP7ZmIbYRcs11xSlsvGJ1FiH+Vt12Guwg1eeisDpke?=
 =?us-ascii?Q?U/W0HQpbx1XRUwblxiFhCyeDee3a/3WKrqAynXiNWzCct2FafQZoeDlFUA98?=
 =?us-ascii?Q?whmgWHJAl6CCgss8H0z7QavKDmFgv9olpmMkyA7qQgIK6olLnOw0lRst7Yqu?=
 =?us-ascii?Q?wNdGoU8GqPUNib4Vg/O2AmmnY3m5VK8d5GXLsZSMJbYJB2aaQ4OW3JfJ6sWH?=
 =?us-ascii?Q?gmTzNbnjeSZgR5evkhWRYu/tyEgAljQH4brHjnWs+zDLgcY/jWzxe7gcMKJW?=
 =?us-ascii?Q?TkSDY3CS3kxSDWeiua4x1m236RMATQRt5F2B+jrgAW4hv1CDEOjJ5npWoLoa?=
 =?us-ascii?Q?ncRUgrRb76lyCvC0zvTCE/+CmKsAyxpnz/BxM8ROBWz3jAdI5J1rbplc7HMJ?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a173e642-9941-4647-1924-08dc2a041186
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 06:46:54.4152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u08VAg4X3iuqa+0RBZpaD5h5/oPxxrtOnrfxlzTDC76LxYQiX4E8A41GqULcEQ9OqgZT8g6jO9Hwn8ywjzRlBbRyNth3wHKazOETcIMHl/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
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

Shiyang Ruan wrote:
> If poison is detected(reported from cxl memdev), OS should be notified to
> handle it.  Introduce this function:
>   1. translate DPA to HPA;
>   2. construct a MCE instance; (TODO: more details need to be filled)
>   3. log it into MCE event queue;
> 
> After that, MCE mechanism can walk over its notifier chain to execute
> specific handlers.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  1 +
>  drivers/cxl/core/mbox.c        | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index bc39252bc54f..a64c0aceb7e0 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -131,6 +131,7 @@ void mce_setup(struct mce *m)
>  	m->ppin = cpu_data(m->extcpu).ppin;
>  	m->microcode = boot_cpu_data.microcode;
>  }
> +EXPORT_SYMBOL_GPL(mce_setup);

No, mce_setup() is x86 specific and the CXL subsystem is CPU
architecture independent. My expectation is that CXL should translate
errors for edac similar to how the ACPI GHES code does it. See usage of
edac_raw_mc_handle_error() and memory_failure_queue().

Otherwise an MCE is a CPU consumption of poison event, and CXL is
reporting device-side discovery of poison.

