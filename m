Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487097F7A39
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:18:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZoM-0004ce-J4; Fri, 24 Nov 2023 12:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6ZoC-0004Ms-82
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:17:41 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6ZoA-00084g-Hd
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:17:39 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a00a9d677fcso298506466b.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700846257; x=1701451057; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4ssoAPZeWgBblBh8RNleEQCH85LsXMl5zyETMsXY2m4=;
 b=GLmDRm6XwfoRAhQZnPPGYd5h3UOcW80Fnzt41ZGdGLy653MQCh/l0Vf698kBl0ruBn
 cdD8wyhWc3xZPIErL1pMZOUrsRM3ZrU9+vN07n9c7K8TxW0y42LFrBF8gY5PSIWEIXwd
 fgt5pbU6E85IhL3OgQEI848mH3IuEjcjSATcCpHaG074YdMEr3VxDZcMdk16Y0BRv7e0
 MAjNrbvzNum5ChwjE7jG1PtSm+bviW7l38Z0L0HQUDvEGIudXufHG1yqTbtN3hXWR6Hj
 DretLC1KuAOJEIQsZ8FuTc64bObyiEsL83XlmD2wZc+VaO5M2aTJqQiOMbmsushxm/mw
 3Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700846257; x=1701451057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ssoAPZeWgBblBh8RNleEQCH85LsXMl5zyETMsXY2m4=;
 b=KbkHIeeF3p6lTf6NnvUkO0q7kVcIl9LZpt0+cvIlbgdVyUQo4hb1bqAq0w/poK+YLR
 8aCARQpX3cYF3/A2pkv/stD0LlJKJZv5u31MpOxF2T3Wt7g2dQknKTAsQiNqM1F8Ipdf
 CKwCXheN/pxReTnogwmOudvp6yBR/0T8GspSJWXENbMBBnJsO0zAaRdrApxUEp5isjsa
 sUt2dETHrrv73xwswN5ep4CkRK3BqKBD98JOHsuoKcoG0UHtmudU99jgZbkKs25ZhTBu
 6M18MM/Xl0Hy9K9bE7q9KKYtAMWRJdRp80CA5k5AdtN4aQ8abJdQoZJiLC3b4qRQjiB0
 jVIw==
X-Gm-Message-State: AOJu0Yyciw9QnDk10Da7FyQNSR6POPp0gt4dCUs/7f53JvBhGMnX/5xY
 tPR3Uf/szNb55D7yCPKkoqEwXg==
X-Google-Smtp-Source: AGHT+IEAcibprdkEJIPQAp5O8Qfc96xh9i3MlRfKxg1ZSzAc5CC2WM1d+rRnmmUQahFcPCDeLOjPLw==
X-Received: by 2002:a17:906:d8ab:b0:9af:4561:591d with SMTP id
 qc11-20020a170906d8ab00b009af4561591dmr3031201ejb.18.1700846256687; 
 Fri, 24 Nov 2023 09:17:36 -0800 (PST)
Received: from localhost ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 a18-20020a170906191200b009e6cedc8bf5sm2286699eje.29.2023.11.24.09.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:17:36 -0800 (PST)
Date: Fri, 24 Nov 2023 18:17:35 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-9.0 4/7] target/riscv/cpu: add riscv_cpu_is_32bit()
Message-ID: <20231124-534f3edb379494bade73e9f8@orel>
References: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
 <20231123191532.1101644-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123191532.1101644-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Nov 23, 2023 at 04:15:29PM -0300, Daniel Henrique Barboza wrote:
> Next patch will need to retrieve if a given RISCVCPU is 32 or 64 bit.
> The existing helper riscv_is_32bit() (hw/riscv/boot.c) will always check
> the first CPU of a given hart array, not any given CPU.
> 
> Create a helper to retrieve the info for any given CPU, not the first
> CPU of the hart array. The helper is using the same 32 bit check that
> riscv_cpu_satp_mode_finalize() was doing.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 7 ++++++-
>  target/riscv/cpu.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a395c77bda..2b79fe861b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -53,6 +53,11 @@ const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
>  #define BYTE(x)   (x)
>  #endif
>  
> +bool riscv_cpu_is_32bit(RISCVCPU *cpu)
> +{
> +    return riscv_cpu_mxl(&cpu->env) == MXL_RV32;
> +}
> +
>  #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
>      {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
>  
> @@ -980,7 +985,7 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
>  #ifndef CONFIG_USER_ONLY
>  static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>  {
> -    bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
> +    bool rv32 = riscv_cpu_is_32bit(cpu);
>      uint8_t satp_mode_map_max, satp_mode_supported_max;
>  
>      /* The CPU wants the OS to decide which satp mode to use */
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1f34eda1e4..485d2da3c2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -695,6 +695,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                            uint64_t *cs_base, uint32_t *pflags);
>  
>  void riscv_cpu_update_mask(CPURISCVState *env);
> +bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>  
>  RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value,
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

