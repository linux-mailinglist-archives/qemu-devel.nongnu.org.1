Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F96771BF1
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 09:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSv7c-0002mY-Gb; Mon, 07 Aug 2023 03:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSv7X-0002la-CD
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:57:44 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qSv7V-0006tr-9K
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691395061; x=1722931061;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NYZpLkReYUsWewankUCV7uLdFU24UWLPxFG61oQNmak=;
 b=AtbwQKX/96HqdFgsjaReQhHsG+O6bWGWN+UUTB/lhBzqMiLsU8fzEUVl
 JPvJ72riIqOWodnetnJAndNv90hjsosZnBcq5CE9JKenler124aC/oROW
 8wbvWnQ7KsdLhNdSnr+zRhxrikr5bIQESNDCaQ+VwCKCEUWUsriCwYIGo
 1wcwp5WSUgyGcdIMqt1epky+2tUpI6VuwlHIEIPGNeCCm2r9nlvEEXlYW
 fJbofWM8vz0ycyLswY+p4cns/Qnqi+WBePWPJEMo4yZUe82RLBgbFBKF3
 YX1/vUHlxnaNe9l8qun9jPpQ6NypmCIg/3zs6TMg9JTIFy7qLd3Wj4lxW Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="374151924"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="374151924"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 00:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="730855088"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="730855088"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga002.jf.intel.com with ESMTP; 07 Aug 2023 00:57:35 -0700
Date: Mon, 7 Aug 2023 16:08:04 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Qian Wen <qian.wen@intel.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com
Subject: Re: [PATCH] target/i386: Avoid cpu number overflow in legacy topology
Message-ID: <ZNCmZJg0Sv1byFNM@liuzhao-OptiPlex-7080>
References: <20230728080150.2958048-1-qian.wen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728080150.2958048-1-qian.wen@intel.com>
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 28, 2023 at 04:01:50PM +0800, Qian Wen wrote:
> Date: Fri, 28 Jul 2023 16:01:50 +0800
> From: Qian Wen <qian.wen@intel.com>
> Subject: [PATCH] target/i386: Avoid cpu number overflow in legacy topology
> X-Mailer: git-send-email 2.25.1
> 
> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
> Vol2:
> 
> Bits 23-16: Maximum number of addressable IDs for logical processors in
> this physical package.
> 
> To avoid data overflow, limit the max value written to EBX[23:16] to
> 255.
> 
> Signed-off-by: Qian Wen <qian.wen@intel.com>
> ---
>  target/i386/cpu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1294be374ab2..70589a58b727 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5356,6 +5356,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t die_offset;
>      uint32_t limit;
>      uint32_t signature[3];
> +    uint32_t threads_per_socket;
>      X86CPUTopoInfo topo_info;
>  
>      topo_info.dies_per_pkg = env->nr_dies;
> @@ -5397,8 +5398,18 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx |= CPUID_EXT_OSXSAVE;
>          }
>          *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        /*
> +         * The vCPU number more than 255 needs support of V2 Extended
> +         * Topology enumerated by CPUID.0x1f or Extended Topology
> +         * enumerated by CPUID.0x0b.
> +         */
> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
> +        if (threads_per_socket > 255) {
> +            threads_per_socket = 255;

Straight encoding to 255 is good for me!

-Zhao

> +        }
> +
> +        if (threads_per_socket > 1) {
> +            *ebx |= threads_per_socket << 16;
>              *edx |= CPUID_HT;
>          }
>          /*
> -- 
> 2.25.1
> 

