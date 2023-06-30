Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03F743BBE
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFD2W-00083N-90; Fri, 30 Jun 2023 08:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFD2H-0007sq-0r
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:15:40 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFD2E-0002Gt-PP
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 08:15:36 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5634db21a58so1193341eaf.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688127331; x=1690719331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XOz68jeNNCrkM4h/QTA8gjG0fkB2qRFff6RjnTf1moQ=;
 b=EzmY/jQYjMvL81WBFEwC66OaxEwDC2G24jRhzFCfXLuEIhQONYSMpdtNA6r7wqtZ0W
 CwOi78qdeHrMis43OESolGc+3iGTVuvdoB3iIoOJqZ6hqISj0F23ao+7WCqD0ayuhBbg
 K3gs+hUFzah/3z3KbCAiEm+uZpTWnNZYaUGfRmMChKmO9B2zUAG2nMF3QK/SP2o/DzM7
 p51eJ1kpr1r8ZlfqFBvgVfen5oaogtFI3wGUIvCl+moMEqfa8bKNi4MA+ZeLc04kFXrA
 cVovclZwEYoyPOgrZmhrHmodCwh5Ykry/MOl2zHhbZqFBbEcz9yjUvELBNGMCOLUjZDg
 mzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688127331; x=1690719331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XOz68jeNNCrkM4h/QTA8gjG0fkB2qRFff6RjnTf1moQ=;
 b=NaExE+RKifXwDBoFhVISZzIUV/JM6TopHlUOrEqU4mqZD7ZnI8tBqDm9Wq6w/GDK+I
 f33nZxzmETkBI1Yc3IE1duxc9pWGJySGmMg8DXKvfd1Vcm2H3zKloUwcPUN8H47aal1p
 cFpw9VginTmo39zwLIXQh4Ww8zE8e3ISAw2jwTGY/m8W6CMxco6BsuTPxp4kuY+wvC3X
 77VMtDNRT5Bx2kJ4qrO4GWrslFxw/pg8QvHCaCc73M4raaV1tLujeTKPcN00DqBAqSBa
 d1ujSnmzme9YaiNzb/0GFPpzzpPA/uKgFXbE4eSkLyXMRCfcOPicpkK5hR/n2ab2lAEv
 rxiQ==
X-Gm-Message-State: AC+VfDxvf3UkZnL9Yerwo7gzuYUbtu9RstMAPKxPS44snx82oZtscAtD
 /DGS/xo9fv7/WODMiFf6PEnW3Q==
X-Google-Smtp-Source: ACHHUZ6fzOMmWp+ZFF0UysZbbUu+Q9e/cWGUXjFcdjTyaKuyxE45KrgsK3Zn5oIdr8Tl0hjfg/JbEg==
X-Received: by 2002:a4a:490b:0:b0:565:cf26:5a10 with SMTP id
 z11-20020a4a490b000000b00565cf265a10mr2208286ooa.0.1688127331387; 
 Fri, 30 Jun 2023 05:15:31 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59?
 ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 e26-20020a4ada1a000000b0054fdb673104sm5866299oou.9.2023.06.30.05.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 05:15:31 -0700 (PDT)
Message-ID: <405f870a-9a28-57c6-d68c-5718dc74a70d@ventanamicro.com>
Date: Fri, 30 Jun 2023 09:15:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] target/riscv: Restrict riscv_cpu_do_interrupt() to
 sysemu
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20230628063234.32544-1-philmd@linaro.org>
 <20230628063234.32544-5-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230628063234.32544-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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



On 6/28/23 03:32, Philippe Mathieu-Daudé wrote:
> riscv_cpu_do_interrupt() is not reachable on user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h        | 5 +++--
>   target/riscv/cpu_helper.c | 7 ++-----
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index cc20ee25a7..ab6aa7e3ea 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -409,7 +409,6 @@ extern const char * const riscv_int_regnamesh[];
>   extern const char * const riscv_fpr_regnames[];
>   
>   const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
> -void riscv_cpu_do_interrupt(CPUState *cpu);
>   int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                  int cpuid, DumpState *s);
>   int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> @@ -442,6 +441,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
>   #define cpu_mmu_index riscv_cpu_mmu_index
>   
>   #ifndef CONFIG_USER_ONLY
> +void riscv_cpu_do_interrupt(CPUState *cpu);
>   void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>                                        vaddr addr, unsigned size,
>                                        MMUAccessType access_type,
> @@ -465,7 +465,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
>                                      void *rmw_fn_arg);
>   
>   RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
> -#endif
> +#endif /* !CONFIG_USER_ONLY */
> +
>   void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
>   
>   void riscv_translate_init(void);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3c28396eaf..3f5ba2b4ef 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1580,7 +1580,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
>   
>       return xinsn;
>   }
> -#endif /* !CONFIG_USER_ONLY */
>   
>   /*
>    * Handle Traps
> @@ -1590,8 +1589,6 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
>    */
>   void riscv_cpu_do_interrupt(CPUState *cs)
>   {
> -#if !defined(CONFIG_USER_ONLY)
> -
>       RISCVCPU *cpu = RISCV_CPU(cs);
>       CPURISCVState *env = &cpu->env;
>       bool write_gva = false;
> @@ -1784,6 +1781,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>   
>       env->two_stage_lookup = false;
>       env->two_stage_indirect_lookup = false;
> -#endif
> -    cs->exception_index = RISCV_EXCP_NONE; /* mark handled to qemu */
>   }
> +
> +#endif /* !CONFIG_USER_ONLY */

