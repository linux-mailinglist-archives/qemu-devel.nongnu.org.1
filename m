Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D80AF8789
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 08:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXZVV-0001kF-Me; Fri, 04 Jul 2025 02:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZVF-0001jo-Mr
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 02:02:30 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZVD-0005uO-7N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 02:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751608947; x=1783144947;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HSF0YPztBs3o2kgo1im0JCr/WFUyW0ehjeq+hU2vTpc=;
 b=GpbkkZnVwVQN0wsCt7X0K17iGy5J4twfLxEKCjheXEVEkNHoJRRC5g47
 FhgGg1bHjSPEha9s26FqmHdG6SsSjdEMI0igCgfZuYTMP+kfRUNDzpH9O
 pdvlP9fLhbjUDHPxuTvEdN3hz1It0Lo5qsRvNaaQsblKtf4qdi/IjLEg2
 FYhirMu1MtgM6u1ZsF2kx/+N+29eGMGF8DqVLJ8ngfaSJBulIbpxZhgk/
 Hvdhhg+02hS/PevH9PdvsmjLuUxT7D50wPWRRzdaDFHWUdhBf8IDndkHW
 JWVkLMR0e7wqkPYWfofz7/alqVmfx1SOG6sPlvSXcjBH1rxty4JuPxltD A==;
X-CSE-ConnectionGUID: /gTOEy+nRJSLnLDrCULFSg==
X-CSE-MsgGUID: ZG4iAkuLRY6/grYo1+ZWjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53865539"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53865539"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 23:02:25 -0700
X-CSE-ConnectionGUID: LwVKagpVTueUiPH8KgCxZA==
X-CSE-MsgGUID: 3TsSFvmaTIKzOwSQddv8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154930608"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 23:02:23 -0700
Message-ID: <06dc9c3c-ccd5-43e8-82eb-3198c7f358a6@intel.com>
Date: Fri, 4 Jul 2025 14:02:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/39] accel/kvm: Remove kvm_cpu_synchronize_state()
 stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-22-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
> to accel/kvm") the kvm_cpu_synchronize_state() stub is not
> necessary.
> 
> Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

BTW, as what you do for HVF in this series that moving vcpu methods from 
hvf-all.c to hvf-accel-ops.c, do you plan to move 
kvm_cpu_synchronize_state() from kvm-all.c to kvm-accel-ops.c ?

> ---
>   accel/stubs/kvm-stub.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index b9b4427c919..68cd33ba973 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
>   {
>   }
>   
> -void kvm_cpu_synchronize_state(CPUState *cpu)
> -{
> -}
> -
>   bool kvm_has_sync_mmu(void)
>   {
>       return false;


