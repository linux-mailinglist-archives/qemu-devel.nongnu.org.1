Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 436547D1223
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr1d-0000Az-Ov; Fri, 20 Oct 2023 11:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtr1c-0000Ap-8l
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:02:56 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtr1a-0000Z4-9v
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697814174; x=1729350174;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cNxwCRvicAr4eap/2aSgxnlcDqn/WpgM97OH99ETcJk=;
 b=TDk948T4hXeSH9qjLYAQ5IwvWvNprPvUHEgQ2BfCrIjItTuE1RpiuhXY
 jTj1a54g790pxv9d49lfjsq/DTY6Lr2yEOv4CJXS0FiJ7Ag7fSAwrnPH5
 wE5psZGjybZBU6PT2U0vNbcFlLUK3cCmUhbs9skV5yQ+IxMniaylc7x6t
 2uqMuRyyxUn5LUQZeYxm4E4sPNvSpa9/t5bghq0TvA0NRxyC1JObjPYET
 ecacEn3jKJSU7nfbOQWhEFY8MDPMtVlogG/hEvtXmolihMH+1zhpNsqLK
 xzKdAcwUiwAIX1qizvAt/V4U3Oq4SW7MDYzq//I793TA3vplNW3xpNYBq Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366740682"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; d="scan'208";a="366740682"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2023 08:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1004631250"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; d="scan'208";a="1004631250"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2023 08:02:49 -0700
Date: Fri, 20 Oct 2023 23:14:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: Re: [PATCH 2/3] target/i386/hvf: Rename 'CPUState *cpu' variable as
 'cs'
Message-ID: <ZTKZU2DQQA+gQI7W@intel.com>
References: <20231020111136.44401-1-philmd@linaro.org>
 <20231020111136.44401-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020111136.44401-3-philmd@linaro.org>
Received-SPF: pass client-ip=192.55.52.151; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 20, 2023 at 01:11:35PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri, 20 Oct 2023 13:11:35 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 2/3] target/i386/hvf: Rename 'CPUState *cpu' variable as
>  'cs'
> X-Mailer: git-send-email 2.41.0
> 
> Follow the naming used by other files in target/i386/.
> 
> No functional changes.
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/hvf/x86_emu.c | 92 +++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 46 deletions(-)

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index cd7ef30126..5b82e84778 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -45,7 +45,7 @@
>  #include "vmcs.h"
>  #include "vmx.h"
>  
> -void hvf_handle_io(CPUState *cpu, uint16_t port, void *data,
> +void hvf_handle_io(CPUState *cs, uint16_t port, void *data,
>                     int direction, int size, uint32_t count);
>  
>  #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
> @@ -666,13 +666,13 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
>  void simulate_rdmsr(CPUX86State *env)
>  {
>      X86CPU *x86_cpu = env_archcpu(env);
> -    CPUState *cpu = env_cpu(env);
> +    CPUState *cs = env_cpu(env);
>      uint32_t msr = ECX(env);
>      uint64_t val = 0;
>  
>      switch (msr) {
>      case MSR_IA32_TSC:
> -        val = rdtscp() + rvmcs(cpu->accel->fd, VMCS_TSC_OFFSET);
> +        val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
>          break;
>      case MSR_IA32_APICBASE:
>          val = cpu_get_apic_base(x86_cpu->apic_state);
> @@ -681,16 +681,16 @@ void simulate_rdmsr(CPUX86State *env)
>          val = x86_cpu->ucode_rev;
>          break;
>      case MSR_EFER:
> -        val = rvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER);
> +        val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
>          break;
>      case MSR_FSBASE:
> -        val = rvmcs(cpu->accel->fd, VMCS_GUEST_FS_BASE);
> +        val = rvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE);
>          break;
>      case MSR_GSBASE:
> -        val = rvmcs(cpu->accel->fd, VMCS_GUEST_GS_BASE);
> +        val = rvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE);
>          break;
>      case MSR_KERNELGSBASE:
> -        val = rvmcs(cpu->accel->fd, VMCS_HOST_FS_BASE);
> +        val = rvmcs(cs->accel->fd, VMCS_HOST_FS_BASE);
>          break;
>      case MSR_STAR:
>          abort();
> @@ -745,8 +745,8 @@ void simulate_rdmsr(CPUX86State *env)
>          val = env->mtrr_deftype;
>          break;
>      case MSR_CORE_THREAD_COUNT:
> -        val = cpu->nr_threads * cpu->nr_cores;  /* thread count, bits 15..0 */
> -        val |= ((uint32_t)cpu->nr_cores << 16); /* core count, bits 31..16 */
> +        val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
> +        val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
>          break;
>      default:
>          /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
> @@ -767,7 +767,7 @@ static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
>  void simulate_wrmsr(CPUX86State *env)
>  {
>      X86CPU *x86_cpu = env_archcpu(env);
> -    CPUState *cpu = env_cpu(env);
> +    CPUState *cs = env_cpu(env);
>      uint32_t msr = ECX(env);
>      uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
>  
> @@ -778,13 +778,13 @@ void simulate_wrmsr(CPUX86State *env)
>          cpu_set_apic_base(x86_cpu->apic_state, data);
>          break;
>      case MSR_FSBASE:
> -        wvmcs(cpu->accel->fd, VMCS_GUEST_FS_BASE, data);
> +        wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
>          break;
>      case MSR_GSBASE:
> -        wvmcs(cpu->accel->fd, VMCS_GUEST_GS_BASE, data);
> +        wvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE, data);
>          break;
>      case MSR_KERNELGSBASE:
> -        wvmcs(cpu->accel->fd, VMCS_HOST_FS_BASE, data);
> +        wvmcs(cs->accel->fd, VMCS_HOST_FS_BASE, data);
>          break;
>      case MSR_STAR:
>          abort();
> @@ -796,10 +796,10 @@ void simulate_wrmsr(CPUX86State *env)
>          abort();
>          break;
>      case MSR_EFER:
> -        /*printf("new efer %llx\n", EFER(cpu));*/
> -        wvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER, data);
> +        /*printf("new efer %llx\n", EFER(cs));*/
> +        wvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER, data);
>          if (data & MSR_EFER_NXE) {
> -            hv_vcpu_invalidate_tlb(cpu->accel->fd);
> +            hv_vcpu_invalidate_tlb(cs->accel->fd);
>          }
>          break;
>      case MSR_MTRRphysBase(0):
> @@ -848,9 +848,9 @@ void simulate_wrmsr(CPUX86State *env)
>  
>      /* Related to support known hypervisor interface */
>      /* if (g_hypervisor_iface)
> -         g_hypervisor_iface->wrmsr_handler(cpu, msr, data);
> +         g_hypervisor_iface->wrmsr_handler(cs, msr, data);
>  
> -    printf("write msr %llx\n", RCX(cpu));*/
> +    printf("write msr %llx\n", RCX(cs));*/
>  }
>  
>  static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
> @@ -1417,56 +1417,56 @@ static void init_cmd_handler()
>      }
>  }
>  
> -void load_regs(CPUState *cpu)
> +void load_regs(CPUState *cs)
>  {
> -    X86CPU *x86_cpu = X86_CPU(cpu);
> +    X86CPU *x86_cpu = X86_CPU(cs);
>      CPUX86State *env = &x86_cpu->env;
>  
>      int i = 0;
> -    RRX(env, R_EAX) = rreg(cpu->accel->fd, HV_X86_RAX);
> -    RRX(env, R_EBX) = rreg(cpu->accel->fd, HV_X86_RBX);
> -    RRX(env, R_ECX) = rreg(cpu->accel->fd, HV_X86_RCX);
> -    RRX(env, R_EDX) = rreg(cpu->accel->fd, HV_X86_RDX);
> -    RRX(env, R_ESI) = rreg(cpu->accel->fd, HV_X86_RSI);
> -    RRX(env, R_EDI) = rreg(cpu->accel->fd, HV_X86_RDI);
> -    RRX(env, R_ESP) = rreg(cpu->accel->fd, HV_X86_RSP);
> -    RRX(env, R_EBP) = rreg(cpu->accel->fd, HV_X86_RBP);
> +    RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
> +    RRX(env, R_EBX) = rreg(cs->accel->fd, HV_X86_RBX);
> +    RRX(env, R_ECX) = rreg(cs->accel->fd, HV_X86_RCX);
> +    RRX(env, R_EDX) = rreg(cs->accel->fd, HV_X86_RDX);
> +    RRX(env, R_ESI) = rreg(cs->accel->fd, HV_X86_RSI);
> +    RRX(env, R_EDI) = rreg(cs->accel->fd, HV_X86_RDI);
> +    RRX(env, R_ESP) = rreg(cs->accel->fd, HV_X86_RSP);
> +    RRX(env, R_EBP) = rreg(cs->accel->fd, HV_X86_RBP);
>      for (i = 8; i < 16; i++) {
> -        RRX(env, i) = rreg(cpu->accel->fd, HV_X86_RAX + i);
> +        RRX(env, i) = rreg(cs->accel->fd, HV_X86_RAX + i);
>      }
>  
> -    env->eflags = rreg(cpu->accel->fd, HV_X86_RFLAGS);
> +    env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
>      rflags_to_lflags(env);
> -    env->eip = rreg(cpu->accel->fd, HV_X86_RIP);
> +    env->eip = rreg(cs->accel->fd, HV_X86_RIP);
>  }
>  
> -void store_regs(CPUState *cpu)
> +void store_regs(CPUState *cs)
>  {
> -    X86CPU *x86_cpu = X86_CPU(cpu);
> +    X86CPU *x86_cpu = X86_CPU(cs);
>      CPUX86State *env = &x86_cpu->env;
>  
>      int i = 0;
> -    wreg(cpu->accel->fd, HV_X86_RAX, RAX(env));
> -    wreg(cpu->accel->fd, HV_X86_RBX, RBX(env));
> -    wreg(cpu->accel->fd, HV_X86_RCX, RCX(env));
> -    wreg(cpu->accel->fd, HV_X86_RDX, RDX(env));
> -    wreg(cpu->accel->fd, HV_X86_RSI, RSI(env));
> -    wreg(cpu->accel->fd, HV_X86_RDI, RDI(env));
> -    wreg(cpu->accel->fd, HV_X86_RBP, RBP(env));
> -    wreg(cpu->accel->fd, HV_X86_RSP, RSP(env));
> +    wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
> +    wreg(cs->accel->fd, HV_X86_RBX, RBX(env));
> +    wreg(cs->accel->fd, HV_X86_RCX, RCX(env));
> +    wreg(cs->accel->fd, HV_X86_RDX, RDX(env));
> +    wreg(cs->accel->fd, HV_X86_RSI, RSI(env));
> +    wreg(cs->accel->fd, HV_X86_RDI, RDI(env));
> +    wreg(cs->accel->fd, HV_X86_RBP, RBP(env));
> +    wreg(cs->accel->fd, HV_X86_RSP, RSP(env));
>      for (i = 8; i < 16; i++) {
> -        wreg(cpu->accel->fd, HV_X86_RAX + i, RRX(env, i));
> +        wreg(cs->accel->fd, HV_X86_RAX + i, RRX(env, i));
>      }
>  
>      lflags_to_rflags(env);
> -    wreg(cpu->accel->fd, HV_X86_RFLAGS, env->eflags);
> -    macvm_set_rip(cpu, env->eip);
> +    wreg(cs->accel->fd, HV_X86_RFLAGS, env->eflags);
> +    macvm_set_rip(cs, env->eip);
>  }
>  
>  bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
>  {
> -    /*if (hvf_vcpu_id(cpu))
> -    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  env->eip,
> +    /*if (hvf_vcpu_id(cs))
> +    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cs),  env->eip,
>            decode_cmd_to_string(ins->cmd));*/
>  
>      if (!_cmd_handler[ins->cmd].handler) {
> -- 
> 2.41.0
> 

