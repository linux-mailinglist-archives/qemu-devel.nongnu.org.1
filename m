Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC77D1227
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr39-0002SA-9D; Fri, 20 Oct 2023 11:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtr30-0002Qo-Iv
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:04:22 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtr2y-0000ly-QY
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697814260; x=1729350260;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=z33wH462J1EjqkMGMvU6PPVscHiLJ3N7fr2qGp0obTA=;
 b=Az0qWvz0bEK2a3QpFxuog/vSL39mbrhqQL88xFLG41nYQKM972KiRDBK
 hItFABitLBtFXPDNtzq7fB6iN96R9i6XV9JfYdhatfdPAc9OPlKU4zi71
 XSF+vkpWsWTZSXdvlOdYRl8fawQ3nJ0jbrXkzRq8V1taJJxTNbOSrGzgr
 Tb+xnUZarz0YH/cy8ksi2zSXQTaYknhw613Fc5M95Gp4G4WNmooTrB0Wv
 V3jW50ryRtOipJ2vAQke//+cSEFdToPhvV2fwJJ5UMlFC3lpF4yjdsH0N
 Yg+naSQGlxmTCx5OgcHnlYEF5IqiJ/PLjHR24W4z/ooZL/MXHB23YXiBB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="390399091"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; d="scan'208";a="390399091"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2023 08:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="873936062"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; d="scan'208";a="873936062"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 08:04:12 -0700
Date: Fri, 20 Oct 2023 23:15:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: Re: [PATCH 3/3] target/i386/hvf: Rename 'X86CPU *x86_cpu' variable
 as 'cpu'
Message-ID: <ZTKZpZeiuKGIxUDT@intel.com>
References: <20231020111136.44401-1-philmd@linaro.org>
 <20231020111136.44401-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020111136.44401-4-philmd@linaro.org>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Fri, Oct 20, 2023 at 01:11:36PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri, 20 Oct 2023 13:11:36 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 3/3] target/i386/hvf: Rename 'X86CPU *x86_cpu' variable as
>  'cpu'
> X-Mailer: git-send-email 2.41.0
> 
> Follow the naming used by other files in target/i386/.
> 
> No functional changes.
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/hvf/x86_emu.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index 5b82e84778..3a3f0a50d0 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -665,7 +665,7 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
>  
>  void simulate_rdmsr(CPUX86State *env)
>  {
> -    X86CPU *x86_cpu = env_archcpu(env);
> +    X86CPU *cpu = env_archcpu(env);
>      CPUState *cs = env_cpu(env);
>      uint32_t msr = ECX(env);
>      uint64_t val = 0;
> @@ -675,10 +675,10 @@ void simulate_rdmsr(CPUX86State *env)
>          val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
>          break;
>      case MSR_IA32_APICBASE:
> -        val = cpu_get_apic_base(x86_cpu->apic_state);
> +        val = cpu_get_apic_base(cpu->apic_state);
>          break;
>      case MSR_IA32_UCODE_REV:
> -        val = x86_cpu->ucode_rev;
> +        val = cpu->ucode_rev;
>          break;
>      case MSR_EFER:
>          val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
> @@ -766,7 +766,7 @@ static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
>  
>  void simulate_wrmsr(CPUX86State *env)
>  {
> -    X86CPU *x86_cpu = env_archcpu(env);
> +    X86CPU *cpu = env_archcpu(env);
>      CPUState *cs = env_cpu(env);
>      uint32_t msr = ECX(env);
>      uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
> @@ -775,7 +775,7 @@ void simulate_wrmsr(CPUX86State *env)
>      case MSR_IA32_TSC:
>          break;
>      case MSR_IA32_APICBASE:
> -        cpu_set_apic_base(x86_cpu->apic_state, data);
> +        cpu_set_apic_base(cpu->apic_state, data);
>          break;
>      case MSR_FSBASE:
>          wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
> @@ -1419,8 +1419,8 @@ static void init_cmd_handler()
>  
>  void load_regs(CPUState *cs)
>  {
> -    X86CPU *x86_cpu = X86_CPU(cs);
> -    CPUX86State *env = &x86_cpu->env;
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
>  
>      int i = 0;
>      RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
> @@ -1442,8 +1442,8 @@ void load_regs(CPUState *cs)
>  
>  void store_regs(CPUState *cs)
>  {
> -    X86CPU *x86_cpu = X86_CPU(cs);
> -    CPUX86State *env = &x86_cpu->env;
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
>  
>      int i = 0;
>      wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
> -- 
> 2.41.0
> 

