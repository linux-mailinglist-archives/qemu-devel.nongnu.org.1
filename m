Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E2AF6B4B
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 09:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXEDg-00085e-UH; Thu, 03 Jul 2025 03:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXEDa-000858-BY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:18:50 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXEDW-0007LZ-UW
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 03:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751527127; x=1783063127;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=y/Iecl85y+ckLurPf5zWK8lSIDvcS82wO6Az/OPu2bw=;
 b=hNC9TKtZUjmqi7JBtWAiiDTmA6o9T9YCkqYYN/O54PNUyUVK2dn6LbJo
 4T+R2FWnRoTKKfNHK0mCmM5j0+saC1PFytcyFWA3ogmU+D9XtIndy5gQD
 zPZPEzY/VPGuCc2+4xXp4FkaUP51x71dtwDckAW7pU8xkaP7o29wReAd4
 wbOvyGmOGU44G+pXO3quRlux+c0y9Lzcjx+kzuFTtcYK2yQRa7s6L1ZIW
 wa50TC4hMZX0G8EW3PdWQvLNAzb2DlM5UKuHghdwyaANCPjg/IRj+0cwH
 NTw5vCh468Q573HQ/WFuwu0vVkC/mzIIaxOCuJTKzEg8oIfu18tGc9aIE A==;
X-CSE-ConnectionGUID: 5b5znadrRh2zkpIQ4aPmsA==
X-CSE-MsgGUID: 2VMpzUZ3Ti+7PEygAk4hAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53711115"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53711115"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:18:44 -0700
X-CSE-ConnectionGUID: drtH/3P+TfyL2GOQOs2hOA==
X-CSE-MsgGUID: UFlvVw7oScOo3wAK/iF1Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="159798915"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 00:18:39 -0700
Message-ID: <8d2b621f-3a3d-4657-8013-2f181b05d17a@linux.intel.com>
Date: Thu, 3 Jul 2025 15:18:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] i386/cpu: Add legacy_amd_cache_info cache model
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-11-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-11-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.19;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 6/20/2025 5:27 PM, Zhao Liu wrote:
> Based on legacy_l1d_cachei_amd, legacy_l1i_cache_amd, legacy_l2_cache_amd
> and legacy_l3_cache, build a complete legacy AMD cache model, which can
> clarify the purpose of these trivial legacy cache models, simplify the
> initialization of cache info in X86CPUState, and make it easier to
> handle compatibility later.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 112 ++++++++++++++++++++++------------------------
>  1 file changed, 53 insertions(+), 59 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ec229830c532..bf8d7a19c88d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -643,60 +643,58 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
>   * These are legacy cache values. If there is a need to change any
>   * of these values please use builtin_x86_defs
>   */
> -static CPUCacheInfo legacy_l1d_cache_amd = {
> -    .type = DATA_CACHE,
> -    .level = 1,
> -    .size = 64 * KiB,
> -    .self_init = 1,
> -    .line_size = 64,
> -    .associativity = 2,
> -    .sets = 512,
> -    .partitions = 1,
> -    .lines_per_tag = 1,
> -    .no_invd_sharing = true,
> -    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> -};
> -
> -static CPUCacheInfo legacy_l1i_cache_amd = {
> -    .type = INSTRUCTION_CACHE,
> -    .level = 1,
> -    .size = 64 * KiB,
> -    .self_init = 1,
> -    .line_size = 64,
> -    .associativity = 2,
> -    .sets = 512,
> -    .partitions = 1,
> -    .lines_per_tag = 1,
> -    .no_invd_sharing = true,
> -    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> -};
> -
> -static CPUCacheInfo legacy_l2_cache_amd = {
> -    .type = UNIFIED_CACHE,
> -    .level = 2,
> -    .size = 512 * KiB,
> -    .line_size = 64,
> -    .lines_per_tag = 1,
> -    .associativity = 16,
> -    .sets = 512,
> -    .partitions = 1,
> -    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> -};
> -
> -/* Level 3 unified cache: */
> -static CPUCacheInfo legacy_l3_cache = {
> -    .type = UNIFIED_CACHE,
> -    .level = 3,
> -    .size = 16 * MiB,
> -    .line_size = 64,
> -    .associativity = 16,
> -    .sets = 16384,
> -    .partitions = 1,
> -    .lines_per_tag = 1,
> -    .self_init = true,
> -    .inclusive = true,
> -    .complex_indexing = true,
> -    .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> +static const CPUCaches legacy_amd_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 64 * KiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 2,
> +        .sets = 512,
> +        .partitions = 1,
> +        .lines_per_tag = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 64 * KiB,
> +        .self_init = 1,
> +        .line_size = 64,
> +        .associativity = 2,
> +        .sets = 512,
> +        .partitions = 1,
> +        .lines_per_tag = 1,
> +        .no_invd_sharing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l2_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 2,
> +        .size = 512 * KiB,
> +        .line_size = 64,
> +        .lines_per_tag = 1,
> +        .associativity = 16,
> +        .sets = 512,
> +        .partitions = 1,
> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l3_cache = &(CPUCacheInfo) {
> +        .type = UNIFIED_CACHE,
> +        .level = 3,
> +        .size = 16 * MiB,
> +        .line_size = 64,
> +        .associativity = 16,
> +        .sets = 16384,
> +        .partitions = 1,
> +        .lines_per_tag = 1,
> +        .self_init = true,
> +        .inclusive = true,
> +        .complex_indexing = true,
> +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> +    },
>  };
>  
>  /*
> @@ -8982,11 +8980,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>          }
>  
>          env->cache_info_cpuid4 = legacy_intel_cache_info;
> -
> -        env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
> -        env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
> -        env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
> -        env->cache_info_amd.l3_cache = &legacy_l3_cache;
> +        env->cache_info_amd = legacy_amd_cache_info;
>      }
>  
>  #ifndef CONFIG_USER_ONLY

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


