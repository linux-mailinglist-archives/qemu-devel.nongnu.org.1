Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE9F771B9B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 09:38:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSunX-0006h7-18; Mon, 07 Aug 2023 03:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSunG-0006fC-9C
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:36:47 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qSunD-0001R5-8u
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 03:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691393803; x=1722929803;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jxRiPIQgf7XgmiRj3diDE9LJMsri9hP9J9WpIzrFH2Y=;
 b=hDGc3oJTfpsDPWhvjnASpt/QkC3xOPj5tbwiNGMj0o12h+z1VMTsO+uM
 iTfrCIXgGvOFf+sRqmGNtKuv+pZRrw1E8JHI4bLyavUFl0KoXMjTQKiNB
 NchOt5LHI4JfmYT6b64QmfWDVi1WwbGaaxOyAH+s0UMnWkC08PuLxCHKf
 bfOl6Ia8llacHSYXSc7Zg0s5xsZa1JDPq5uVI00van+pTR8VgPlT2+IAo
 SmZs4HU/sZ0S7SJFB6L80p/v7MRRYlIRbRvwPvdwiwG6Zt9Qx7KHcG1xC
 EOiN8dYlQtPJK1+6/WxbpJF7xwhqKmp7lbrIL2pmQ7q1hZ261paY2+7D3 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="367936720"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="367936720"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 00:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="724410970"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; d="scan'208";a="724410970"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.81])
 ([10.93.16.81])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 00:36:38 -0700
Message-ID: <8b4fd5e9-8c0b-1ece-ebb1-85d027cc1155@intel.com>
Date: Mon, 7 Aug 2023 15:36:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH] target/i386: Avoid cpu number overflow in legacy topology
Content-Language: en-US
To: Qian Wen <qian.wen@intel.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20230728080150.2958048-1-qian.wen@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230728080150.2958048-1-qian.wen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-4.139,
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

On 7/28/2023 4:01 PM, Qian Wen wrote:
> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
> Vol2:
> 
> Bits 23-16: Maximum number of addressable IDs for logical processors in
> this physical package.
> 
> To avoid data overflow, limit the max value written to EBX[23:16] to
> 255.

It's better explain what's issue when overflow happens.

> Signed-off-by: Qian Wen <qian.wen@intel.com>
> ---
>   target/i386/cpu.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1294be374ab2..70589a58b727 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5356,6 +5356,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>       uint32_t die_offset;
>       uint32_t limit;
>       uint32_t signature[3];
> +    uint32_t threads_per_socket;
>       X86CPUTopoInfo topo_info;
>   
>       topo_info.dies_per_pkg = env->nr_dies;
> @@ -5397,8 +5398,18 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               *ecx |= CPUID_EXT_OSXSAVE;
>           }
>           *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        /*
> +         * The vCPU number more than 255 needs support of V2 Extended
> +         * Topology enumerated by CPUID.0x1f or Extended Topology
> +         * enumerated by CPUID.0x0b.
> +         */

the above comment doesn't explain why it needs below.

you can explain only bits [23:16] represents the maximum number of 
addressable IDs for logical processors in this physical package.

When thread_per_socket > 255, it will 1) overwrite bits[31:24] which is 
apic_id, 2) bits [23:16] gets truncated.

> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
> +        if (threads_per_socket > 255) {
> +            threads_per_socket = 255;
> +        }
> +
> +        if (threads_per_socket > 1) {
> +            *ebx |= threads_per_socket << 16;
>               *edx |= CPUID_HT;
>           }
>           /*


