Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13802710C65
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:51:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AQN-0008B7-QI; Thu, 25 May 2023 08:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q2AQL-00089w-Dn
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:50:33 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q2AQI-0002zO-6E
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:50:33 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6af896f0908so1101637a34.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685019027; x=1687611027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwdOgWlcsRKOGUe6kYsdBCRu82E3MTbgsMGIobPIl8E=;
 b=P8fcIdAzVEX7/n1a8x3562gjLyBERF3Ery/ymBelW0Wkq+xt7SXevbDOFRB0f6QJL2
 7QguMFOo54aeKEOo9OsggBuFOXboagHp2KmRiSsWmKNtSULuVZ2t8DCLDZuWRf2QEMCK
 4QOSFxmbenJNDiHFdRzIkHbW5uyoSK5eoBd1lIYNl24p4jRXvsRpW2ks2odG/gsNkowQ
 oBROnKfY4nNsvtHwo4oUMJpwbbpr2DnfFlJl0+qWjf7HZME7p/DN6cbNki/TNgCF+vzU
 jnAnBtcKfJODgycwN6gPoAwwmxMMLjngh4Mu5YU6y9FMc7DFqaFMoAGsi/uxnUt2z/5F
 T2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019027; x=1687611027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IwdOgWlcsRKOGUe6kYsdBCRu82E3MTbgsMGIobPIl8E=;
 b=ZOqWSm0zYnx71dCwaDJxCKpbFPMXKI0LVzbs3l/SxuF97mCVd5vpRYa2cGqUUhx/AN
 BK12ihlVlO/y6HadF9vbB9Ub478JOf4uFmKoP9CsWx4tYpjyggRFhNc/dv/BRgqKHPgR
 RQ43Gok4ITjpdCrkmpSeqxFU5CCM1QxAg7eh3wGPbHczDSbGSaPIbjjjnqI4qrfDYOV0
 yyFxvEJZ93GCkVLOMf/Yh9bJBprUgzZTeqfILc+Tassh5TdAIwjcZIUH+WgevTroDUto
 CtUZjUKYMIj/XzlCXf2xgfaHL9OnkZ90wzlb9zo3DVEgVPOEGFxh8ICsfFxtCK6429vN
 ImoQ==
X-Gm-Message-State: AC+VfDy+RckXhTfTyrvl8IM1IlSaRPRQBoa9bh4zAe/OgC9D+EZK4rVk
 mu6sTGt858o7l+FkuFejWGRIiQ==
X-Google-Smtp-Source: ACHHUZ6F8kQx/esXMjwvWAEJpc+GDqqkFfDdQqL+YWXSREVhnDZ7c3IPDBMzxvMSbApAEfHiB7NdiA==
X-Received: by 2002:a05:6830:1bc9:b0:6af:987a:162d with SMTP id
 v9-20020a0568301bc900b006af987a162dmr3349392ota.31.1685019027124; 
 Thu, 25 May 2023 05:50:27 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 l13-20020a0568301d6d00b006a647f65d03sm589573oti.41.2023.05.25.05.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 05:50:26 -0700 (PDT)
Message-ID: <dba73ae8-4253-d1ce-81ea-70dedd324f07@ventanamicro.com>
Date: Thu, 25 May 2023 09:50:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/4] target/riscv: Add Smrnmi mnret instruction.
Content-Language: en-US
To: Tommy Wu <tommy.wu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 richard.henderson@linaro.org
References: <20230522131123.3498539-1-tommy.wu@sifive.com>
 <20230522131123.3498539-5-tommy.wu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230522131123.3498539-5-tommy.wu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 5/22/23 10:11, Tommy Wu wrote:
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> ---
>   target/riscv/helper.h                         |  1 +
>   target/riscv/insn32.decode                    |  3 ++
>   .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++++
>   target/riscv/op_helper.c                      | 51 +++++++++++++++++++
>   4 files changed, 67 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 98e97810fd..00f1032086 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -112,6 +112,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(sret, tl, env)
>   DEF_HELPER_1(mret, tl, env)
> +DEF_HELPER_1(mnret, tl, env)
>   DEF_HELPER_1(wfi, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
>   DEF_HELPER_1(tlb_flush_all, void, env)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 73d5d1b045..e0698f9dfb 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -111,6 +111,9 @@ wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
>   sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>   
> +# *** NMI ***
> +mnret       0111000    00010 00000 000 00000 1110011
> +
>   # *** RV32I Base Instruction Set ***
>   lui      ....................       ..... 0110111 @u
>   auipc    ....................       ..... 0010111 @u
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 7c2837194c..0c1c2db5c6 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -108,6 +108,18 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
>   #endif
>   }
>   
> +static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    gen_helper_mnret(cpu_pc, cpu_env);
> +    tcg_gen_exit_tb(NULL, 0); /* no chaining */
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>   static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>   {
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f563dc3981..2de3f102b5 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -359,6 +359,57 @@ target_ulong helper_mret(CPURISCVState *env)
>       return retpc;
>   }
>   
> +target_ulong helper_mnret(CPURISCVState *env)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);

You're not using 'cpu' for anything other than reading cfg flags, so you can use the
riscv_cpu_cfg(env) inline nd avoid an env_archcpu() to get the 'cpu' pointer:

> +
> +    if (!cpu->cfg.ext_smrnmi) {

Here:

       if (!riscv_cpu_cfg(env)->ext_smrnmi) {



> +        /* RNMI feature is not presented. */
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +
> +    if (!(env->priv >= PRV_M)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +
> +    /* Get return PC from mnepc CSR. */
> +    target_ulong retpc = env->mnepc;
> +    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> +        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +    }
> +
> +    /* Get previous privilege level from mnstatus CSR. */
> +    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
> +
> +    if (cpu->cfg.pmp &&

And here:

     if (riscv_cpu_cfg(env)->pmp &&



Everything else LGTM.



Daniel

> +        !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +    }
> +
> +    riscv_cpu_set_mode(env, prev_priv);
> +    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, true);
> +
> +    target_ulong prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV);
> +
> +    /*
> +     * If MNRET changes the privilege mode to a mode
> +     * less privileged than M, it also sets mstatus.MPRV to 0.
> +     */
> +    if (prev_priv < PRV_M) {
> +        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
> +    }
> +
> +    if (riscv_has_ext(env, RVH)) {
> +        if (prev_virt) {
> +            riscv_cpu_swap_hypervisor_regs(env);
> +        }
> +
> +        riscv_cpu_set_virt_enabled(env, prev_virt);
> +    }
> +
> +    return retpc;
> +}
> +
>   void helper_wfi(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);

