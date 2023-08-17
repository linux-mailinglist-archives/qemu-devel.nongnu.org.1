Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51477EEEB
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 04:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWSNS-0002gF-Sv; Wed, 16 Aug 2023 22:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWSNN-0002fl-Bd
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:04:42 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWSNK-0005mw-BS
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692237878; x=1723773878;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DNYw+YCcY/tlIRQpuxoMmRjqO6ardsEAG8IT7vyJ1Ic=;
 b=cvrIO8SIDdSkUFqQrrnOtoq+txrKVZuaReYe9+I8qnNnKlW+WFT0B8UJ
 TEPdnoAANdJJjmn3ZsC6dy8semAB7Wy5dgGb2Biik7H694NzgU3QLWzvU
 pLr/h3ZSJJHVa2C+Qf6noe7VUy/7dc1cVV9wOBpGUSX4zg2teMX36GHyc
 oTvWyDu2oYaz2jdNZjj7A8xI2fEum+PRf4xOR1P/k/JasS3ULZrjkHTs+
 xsbtnu9vT9+Xe9f5ShjzdNBRRV3pI+X3uzJXEeKtFvTSacZw11a3ssjAS
 ssvmORNhdbpwyZAsJ+lQOCgCPwOOrvKXUplwf1uPGIo3pKtrN5A9afB7q A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403670199"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="403670199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 19:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763853770"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; d="scan'208";a="763853770"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.8.54])
 ([10.93.8.54])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2023 19:04:32 -0700
Message-ID: <375d49ef-192a-6bf2-ef8e-d1dd1baf048a@intel.com>
Date: Thu, 17 Aug 2023 10:04:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] target/i386: Avoid cpu number overflow in legacy
 topology
To: Qian Wen <qian.wen@intel.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 babu.moger@amd.com
References: <20230816080658.3562730-1-qian.wen@intel.com>
 <20230816080658.3562730-2-qian.wen@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230816080658.3562730-2-qian.wen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/16/2023 4:06 PM, Qian Wen wrote:
> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
> Vol2:
> 
> Bits 23-16: Maximum number of addressable IDs for logical processors in
> this physical package.
> 
> When threads_per_socket > 255, it will 1) overwrite bits[31:24] which is
> apic_id, 2) bits [23:16] get truncated.
> 
> Specifically, if launching the VM with -smp 256, the value written to
> EBX[23:16] is 0 because of data overflow. If the guest only supports
> legacy topology, without V2 Extended Topology enumerated by CPUID.0x1f
> or Extended Topology enumerated by CPUID.0x0b to support over 255 CPUs,
> the return of the kernel invoking cpu_smt_allowed() is false and APs
> (application processors) will fail to bring up. Then only CPU 0 is online,
> and others are offline.
> 
> For example, launch VM via:
> qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
>      -cpu qemu64,cpuid-0xb=off -smp 256 -m 32G \
>      -drive file=guest.img,if=none,id=virtio-disk0,format=raw \
>      -device virtio-blk-pci,drive=virtio-disk0,bootindex=1 --nographic
> 
> The guest shows:
>      CPU(s):               256
>      On-line CPU(s) list:  0
>      Off-line CPU(s) list: 1-255
> 
> To avoid this issue caused by overflow, limit the max value written to
> EBX[23:16] to 255 as the HW does.
> 
> Signed-off-by: Qian Wen <qian.wen@intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 97ad229d8b..5c008b9d7e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>       uint32_t die_offset;
>       uint32_t limit;
>       uint32_t signature[3];
> +    uint32_t threads_per_socket;
>       X86CPUTopoInfo topo_info;
>   
>       topo_info.dies_per_pkg = env->nr_dies;
> @@ -6049,8 +6050,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               *ecx |= CPUID_EXT_OSXSAVE;
>           }
>           *edx = env->features[FEAT_1_EDX];
> -        if (cs->nr_cores * cs->nr_threads > 1) {
> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
> +        if (threads_per_socket > 1) {
> +            *ebx |= MIN(threads_per_socket, 255) << 16;
>               *edx |= CPUID_HT;
>           }
>           if (!cpu->enable_pmu) {


