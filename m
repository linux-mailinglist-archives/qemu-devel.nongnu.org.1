Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74847740791
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 03:23:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEJsa-0004fX-Pa; Tue, 27 Jun 2023 21:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEJsX-0004fE-8k
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 21:21:53 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEJsU-0004YY-Cw
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 21:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687915310; x=1719451310;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nl3xuL/8ajDXxgn5S489YsW6O7AaS1H4+YB88kbrKgs=;
 b=PtE+vqwp1UWdHBs4ZYkQAoh6+O/TnmTVk74vT6WsBmFVENymig/Ls272
 zcetMhMn1QJSPpYt4YUYwAfOPxPdduecsMCH7QOX3uX/R3EBgQdagtdrr
 nXx1HaBs+JYoRh6yIfT4BYhS1DpPXU4modfEgtIAlj6YX5eTRbdN6o9xb
 kMgrFYUyy4o1kP55hPbVVd+/xxe64M+PiDaBU9CisDKhE6vFqzy5ruqG5
 JFsIs4oj+zCAyeMXcA9YRTuC7DAzYR6B1JrzaVGPfQJbQH36lszqpUFxJ
 FQn7RKmwxEuyzKvO1RsXb5/5s34nM1+hSTSBguAPeMqMQB2jBaXl8GWJC Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448106443"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="448106443"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2023 18:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752019040"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; d="scan'208";a="752019040"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga001.jf.intel.com with ESMTP; 27 Jun 2023 18:21:44 -0700
Date: Wed, 28 Jun 2023 09:31:43 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] i386/WHPX: Fix error message when fail to set
 ProcessorCount
Message-ID: <ZJuNfxzqfCTRu4Kv@liuzhao-OptiPlex-7080>
References: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529124331.412822-1-zhao1.liu@linux.intel.com>
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga05.intel.com
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

Hi Paolo

Could I add you for this patch's review?

Let me add more background of this cleanup:

This patch is one of my cleanups of smp.cores.

I am trying to introduce hybrid topology. in hybrid topology, different
clusters will have different number of cores, so calling smp.cores
directly in i386 code will have problems. So that's what I'm preparing
before trying hybrid topology.

I split this cleanup from my previous hybrid topology v1 RFC [1] to
facilitate review.

[1]: https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg03205.html

Thanks,
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

