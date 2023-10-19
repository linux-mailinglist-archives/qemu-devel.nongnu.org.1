Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B457CF0A6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtN6i-0005UQ-ER; Thu, 19 Oct 2023 03:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtN6d-0005QH-GZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:06:08 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1qtN6a-0007NY-9h
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697699164; x=1729235164;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2vYYdaSNvFufGJ5UaXHzxeWsXskL7X0l8axOdiEA3k8=;
 b=mHqVpJPcXCIIwd85bdxYgbLvyXdgTiRJrsXhjlndrwxgZ70hIgDQ2IvH
 aQnMIJcrPlPTOrO5kiZpyGsIjywP+njA6/qo79cr1Iucw/xnwezUrSe5a
 tiQfMiLg2qkaOCN1mO1DvC4Spwh6X++nH2PwxXEZHD4T7pHurhJFuN4VI
 z9UTt40Cebs5xmLhVIYG98bYgsW9IhL3VhdfNQUKSJlBj5JWyikD31Wb+
 PzXjWKvq+SHXsGWdQvK/BjxGE+wqfhOj65jcfwNEjvPNCP4OdAWgYzCif
 9dq2Twn2PhpalGCJHbiPP70Bps1sre3D2bCyfU5y3bwPGxaTaCuKDe0Oa Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7741501"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="7741501"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 00:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="827219863"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="827219863"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2023 00:05:58 -0700
Date: Thu, 19 Oct 2023 15:17:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 25/78] target/i386: add fallthrough pseudo-keyword
Message-ID: <ZTDYD5yadW7Fw+R6@liuzhao-OptiPlex-7080>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <76c17deab18b857ea01ed4b7f06a2d56d1977ff6.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c17deab18b857ea01ed4b7f06a2d56d1977ff6.1697186560.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Oct 13, 2023 at 11:45:53AM +0300, Emmanouil Pitsidianakis wrote:
> Date: Fri, 13 Oct 2023 11:45:53 +0300
> From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [RFC PATCH v3 25/78] target/i386: add fallthrough pseudo-keyword
> X-Mailer: git-send-email 2.39.2
> 
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> ---
>  target/i386/cpu.c                | 2 +-
>  target/i386/hvf/x86_decode.c     | 1 +
>  target/i386/kvm/kvm.c            | 4 ++--
>  target/i386/tcg/decode-new.c.inc | 6 +++---
>  target/i386/tcg/emit.c.inc       | 2 +-
>  target/i386/tcg/translate.c      | 8 +++-----
>  6 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index cec5d2b7b6..f73784edca 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6133,7 +6133,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                                          eax, ebx, ecx, edx);
>                      break;
>                  }
> -                /* fall through */
> +                fallthrough;
>              default: /* end of info */
>                  *eax = *ebx = *ecx = *edx = 0;
>                  break;
> diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
> index 3728d7705e..7c2e3dab8d 100644
> --- a/target/i386/hvf/x86_decode.c
> +++ b/target/i386/hvf/x86_decode.c
> @@ -1886,6 +1886,7 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
>                  break;
>              }
>              /* fall through when not in long mode */
> +            fallthrough;
>          default:
>              decode->len--;
>              return;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index f6c7f7e268..d283d56aa9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -553,7 +553,7 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
>                  value |= (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
>              }
>          }
> -        /* fall through */
> +        fallthrough;
>      case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
>      case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
>      case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
> @@ -1962,7 +1962,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              if (env->nr_dies < 2) {
>                  break;
>              }
> -            /* fallthrough */
> +            fallthrough;
>          case 4:
>          case 0xb:
>          case 0xd:
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 7d76f15275..0e663e9124 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -1108,7 +1108,7 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
>              *ot = MO_64;
>              return true;
>          }
> -        /* fall through */
> +        fallthrough;
>      case X86_SIZE_ps: /* SSE/AVX packed single precision */
>      case X86_SIZE_pd: /* SSE/AVX packed double precision */
>          *ot = s->vex_l ? MO_256 : MO_128;
> @@ -1220,7 +1220,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
>  
>      case X86_TYPE_WM:  /* modrm byte selects an XMM/YMM memory operand */
>          op->unit = X86_OP_SSE;
> -        /* fall through */
> +        fallthrough;
>      case X86_TYPE_M:  /* modrm byte selects a memory operand */
>          modrm = get_modrm(s, env);
>          if ((modrm >> 6) == 3) {
> @@ -1538,7 +1538,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
>              (decode->op[2].n == decode->mem.index || decode->op[2].n == decode->op[1].n)) {
>              goto illegal;
>          }
> -        /* fall through */
> +        fallthrough;
>      case 6:
>      case 11:
>          if (!(s->prefix & PREFIX_VEX)) {
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 88793ba988..0e0a2efbf9 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -209,7 +209,7 @@ static bool sse_needs_alignment(DisasContext *s, X86DecodedInsn *decode, MemOp o
>              /* MOST legacy SSE instructions require aligned memory operands, but not all.  */
>              return false;
>          }
> -        /* fall through */
> +        fallthrough;
>      case 1:
>          return ot >= MO_128;
>  
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index e42e3dd653..77a8fcc5e1 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1004,7 +1004,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
>      switch (s->cc_op) {
>      case CC_OP_DYNAMIC:
>          gen_compute_eflags(s);
> -        /* FALLTHRU */
> +        fallthrough;
>      case CC_OP_EFLAGS:
>      case CC_OP_ADCX:
>      case CC_OP_ADOX:
> @@ -1047,7 +1047,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
>      switch (s->cc_op) {
>      case CC_OP_DYNAMIC:
>          gen_compute_eflags(s);
> -        /* FALLTHRU */
> +        fallthrough;
>      case CC_OP_EFLAGS:
>      case CC_OP_ADCX:
>      case CC_OP_ADOX:
> @@ -3298,7 +3298,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>      case 0x82:
>          if (CODE64(s))
>              goto illegal_op;
> -        /* fall through */
>          fallthrough;
>      case 0x80: /* GRP1 */
>      case 0x81:
> @@ -6733,7 +6732,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>                  }
>                  break;
>              }
> -            /* fallthru */
> +            fallthrough;
>          case 0xf9 ... 0xff: /* sfence */
>              if (!(s->cpuid_features & CPUID_SSE)
>                  || (prefixes & PREFIX_LOCK)) {
> @@ -7047,7 +7046,6 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>      case DISAS_EOB_NEXT:
>          gen_update_cc_op(dc);
>          gen_update_eip_cur(dc);
> -        /* fall through */
>          fallthrough;
>      case DISAS_EOB_ONLY:
>          gen_eob(dc);
> -- 
> 2.39.2
> 

