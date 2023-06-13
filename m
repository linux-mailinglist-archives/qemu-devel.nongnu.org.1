Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122072DB3B
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 09:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8yde-0003S6-Ed; Tue, 13 Jun 2023 03:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q8ydX-0003Rx-GU
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:40:19 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q8ydV-0000kY-3m
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 03:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686642017; x=1718178017;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=o8hEeE4HwU48gtUCL9j1erNn8pGkt043DP657Sg6I2s=;
 b=c1vMT0DbxbyvI0ohmbbLc9NQsd4K3ijDLlpwQto3GiPyYINuEc/4H43C
 UEKqp7lD4IYyZcm63rD+CwijZD+SEb2JUXWfgtdtw1d0LBt9hDH8Ve0EW
 uwTn2QxR13m3/w+5gcXtKpnDdBDtTLq/iF0F2TZt5cMsDxnmYz2Ca+Sad
 pS6nLgjVSeLPsy9NmATppfJ47RAeP0xCYgkETKmegUFpzd/Rnou4vk+mn
 0y2E0NP+RGYXuiArQ0Bk3z6yJeOUqV0BnE0bA2cSzxzz6XU+3KfYokwl4
 z8nkgMrlM2jcCOcAaBpMzoYwtzi8WPSw1A272RcQWI6Yb4WkdkKyPIWq1 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="357139269"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="357139269"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 00:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="824282154"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="824282154"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 00:40:09 -0700
Date: Tue, 13 Jun 2023 15:49:48 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] i386/WHPX: Fix error message when fail to set
 ProcessorCount
Message-ID: <ZIgfnG7E47u3F2Zg@liuzhao-OptiPlex-7080>
References: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga04.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Just a ping...

Hi Sunil, could you please take some time to look at this patch? Thank
you!

Regards,
Zhao

On Mon, May 29, 2023 at 08:43:31PM +0800, Zhao Liu wrote:
> Date: Mon, 29 May 2023 20:43:31 +0800
> From: Zhao Liu <zhao1.liu@linux.intel.com>
> Subject: [PATCH] i386/WHPX: Fix error message when fail to set
>  ProcessorCount
> X-Mailer: git-send-email 2.34.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> 003f230e37d7 ("machine: Tweak the order of topology members in struct
> CpuTopology") changes the meaning of MachineState.smp.cores from "the
> number of cores in one package" to "the number of cores in one die"
> and doesn't fix other uses of MachineState.smp.cores. And because of
> the introduction of cluster, now smp.cores just means "the number of
> cores in one cluster". This clearly does not fit the semantics here.
> 
> And before this error message, WHvSetPartitionProperty() is called to
> set prop.ProcessorCount.
> 
> So the error message should show the prop.ProcessorCount other than
> "cores per cluster" or "cores per package".
> 
> Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/whpx/whpx-all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 52af81683c1e..5882bf22d0a1 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2613,8 +2613,8 @@ static int whpx_accel_init(MachineState *ms)
>          sizeof(WHV_PARTITION_PROPERTY));
>  
>      if (FAILED(hr)) {
> -        error_report("WHPX: Failed to set partition core count to %d,"
> -                     " hr=%08lx", ms->smp.cores, hr);
> +        error_report("WHPX: Failed to set partition processor count to %d,"
> +                     " hr=%08lx", prop.ProcessorCount, hr);
>          ret = -EINVAL;
>          goto error;
>      }
> -- 
> 2.34.1
> 

