Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E29B82A038
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 19:27:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNdHL-0005m4-68; Wed, 10 Jan 2024 13:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNdHI-0005lV-3k
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:26:13 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNdHG-0001bw-AP
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:26:11 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d9bee259c5so2765436b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 10:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704911169; x=1705515969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vH57QS3GpCPRyTxw+0Wf6Wt6n6YVM5kYbKb5iKtrHCo=;
 b=ARJgxGuz4UBPKPJWVy6E5mvEDT12tQ9xj6sSV1NYn65Rzb1aqSO2Lka0+BkG97/A4c
 rPB/wUPdvVGvPieLSzQWaHwaCapfCGdBOx0YuRuhqk4Zooe8c3foWIf4RF1khWNeEMON
 O5b+AzMBOEhy7NltTFYITROACJhcYoSjz39csh3LtBNXeHUS+LibX0/AhSEnooJRq5Fa
 Qx8PKMt3/IVG+BBfxdc83yvRJ9oIE7Mjdt0beqJaeNg499AeuyPelnEvU4sNrshHgqDC
 wOte09q1btVcbD+8/kN7zZF39tIrSTi2OXRAoKXQmrtN9E5fsugDj7T5sQ8a2uCkfGFG
 GSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704911169; x=1705515969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vH57QS3GpCPRyTxw+0Wf6Wt6n6YVM5kYbKb5iKtrHCo=;
 b=POkOH0HjdE/JIRANV4NuxJEftQkrLXay9U8H6CVGMvIlmLG9RyRPNyEihxFx1clYNO
 A44IWvr6D4YZd2rublTh/IXGehwr/HlCUy8UdbCM4vvRhwQwwJ3mkMvfooFEL6USJSPR
 XQAb/b129uFDfQgaUEJ+tntMKN+MNEMdCPabjKggyTdMoUSnU7rsjrVtm+j3gSgx2dYW
 NckVC+2uq7AQyj2ie+9HDmMK9BLfe7XbjauawFIfz5eTu2a9GWJDT+ixadr8zNFfQE0c
 4L7oHfJWLceK5tyWj1WvBsrffaEu/E3NYixI5cTyrBWXGiT1TIA6tmt3sWUPXtxu5dgF
 DOcw==
X-Gm-Message-State: AOJu0Yx+sXnlU+pmnWlvhD9jWaHTwJqDTMy2odJ9sJa3KHKAAZTeWNh4
 bW4yMVRddkro/IUe8jJzf3z301Mh8Oa+zw==
X-Google-Smtp-Source: AGHT+IEcjQGytGqP8jUKJiFx/4nmFGGyIDLNRJv6GYED+6PdzyOFJM88JrZ26BAuvtsOUiHa0PuLOQ==
X-Received: by 2002:a05:6a00:38d8:b0:6db:1a5f:ad70 with SMTP id
 ey24-20020a056a0038d800b006db1a5fad70mr62810pfb.2.1704911168968; 
 Wed, 10 Jan 2024 10:26:08 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 h34-20020a63f922000000b005c66e25497dsm3811372pgi.83.2024.01.10.10.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 10:26:08 -0800 (PST)
Message-ID: <07cbdc64-3965-42af-b106-30e6afdc48ee@ventanamicro.com>
Date: Wed, 10 Jan 2024 15:26:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/riscv: Add step to validate 'B' extension
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-3-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240109171848.32237-3-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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



On 1/9/24 14:07, Rob Bradford wrote:
> If the B extension is enabled warn if the user has disabled any of the
> required extensions that are part of the 'B' extension. Conversely
> enable the extensions that make up the 'B' extension if it is enabled.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

This patch doesn't apply cleanly on current master. Which is normal, since we just
had a RISC-V PR merged.

I'm afraid you'll need to resend the series rebased on top of master (since it's newer
than Alistair's riscv-to-apply.next now).


>   target/riscv/tcg/tcg-cpu.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 

I fixed the conflicts and applied the patch and it works for me. So:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>



> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index fda54671d5..f10871d352 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -273,6 +273,35 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>       }
>   }
>   
> +static void riscv_cpu_validate_b(RISCVCPU *cpu)
> +{
> +    const char *warn_msg = "RVB mandates disabled extension %s";
> +
> +    if (!cpu->cfg.ext_zba) {
> +        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zba))) {
> +            cpu->cfg.ext_zba = true;
> +        } else {
> +            warn_report(warn_msg, "zba");
> +        }
> +    }
> +
> +    if (!cpu->cfg.ext_zbb) {
> +        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbb))) {
> +            cpu->cfg.ext_zbb = true;
> +        } else {
> +            warn_report(warn_msg, "zbb");
> +        }
> +    }
> +
> +    if (!cpu->cfg.ext_zbs) {
> +        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbs))) {
> +            cpu->cfg.ext_zbs = true;
> +        } else {
> +            warn_report(warn_msg, "zbs");
> +        }
> +    }
> +}
> +
>   /*
>    * Check consistency between chosen extensions while setting
>    * cpu->cfg accordingly.
> @@ -309,6 +338,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
>       }
>   
> +    if (riscv_has_ext(env, RVB)) {
> +        riscv_cpu_validate_b(cpu);
> +    }
> +
>       if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
>           error_setg(errp,
>                      "I and E extensions are incompatible");

