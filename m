Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E37EAEC1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 12:22:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2rTJ-0003tI-9f; Tue, 14 Nov 2023 06:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2rTH-0003sx-Pc
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:20:43 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2rTG-0001HY-5b
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:20:43 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc29f39e7aso34902075ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 03:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699960841; x=1700565641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nuOCvN68DpIA+eH3/8+OASw2MwSNBc35QJvzI7sI8RQ=;
 b=ieD0P+05OQtittRbJIC22SXZNT4KLazIk9HikWwszEMquqjFSRr0+0puHzb2vkMqKG
 YCEsumbYsuppBgYaOIDLnXPCFZcKaHGVxaDp9OEqFWmWfaN0yZrlcUbG9fxmpjN+6zyM
 kkDzGgTpqJ8i07BadlePMtIPqCvNULfkpkw4cIWJqdrbiH2IXUejouRrA6tztkRQ1x9L
 AnuVJxQOQPyTpIzshgWx3DJmiK9/HMlcG21/OVotY7LwY1AwcWbnVW2PIm1wWdBgrc62
 1pTHdCH9UG2jSCE+nT1nv978mCj0H6XurgH7GQzwzOEGpfK2O0XAKot+ZdsVzA+vONSH
 M+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699960841; x=1700565641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nuOCvN68DpIA+eH3/8+OASw2MwSNBc35QJvzI7sI8RQ=;
 b=mXjrTt0tb/fFPiobRHT31Mq8zbbd+AedjbGYDwEdyr3wGZCUOZoqjijPXQ2UMHGT0t
 O/5YlAAAIG65YIFx98lfzy//dyH7/DwhGf6X2op0wOfikrEiCqNW2j0cGXNnBr+Kp/wV
 tHDhX/MyiwDv/qDOU/mDxX+hO68wy4cyddAOj7c3adR7aoGjrgZrQiTgs7doQWui1/U8
 gkI5N6y4HF6oCihKt9iTyFuj1tOfp9fb2QpSpXyLpyWJgSlHBkdLUosd4O6GZ7us6PNQ
 SUmphfzlEN8480VK6O3hWJZo+hHWmiliYC7qeVlvDQMYpJ80HXYWmeM2nvoGBvROXYnX
 a9Ug==
X-Gm-Message-State: AOJu0YxFPVp0YQP7LHEQ5Ua6B64z+s0VCmalN1FqNxQTS7I391+y3V8O
 /7U9HiAZVhTot2kHJnyVrzSqXUYyf6diduLNM8c=
X-Google-Smtp-Source: AGHT+IFTtqMvc/RKc+BMTfF6Ff90wBrCOgjVX3blDfQm+ZIt6J30cbyOrbUorrKSDf7vdIG84Z6RNw==
X-Received: by 2002:a17:902:f685:b0:1cc:dade:2784 with SMTP id
 l5-20020a170902f68500b001ccdade2784mr1943810plg.22.1699960840636; 
 Tue, 14 Nov 2023 03:20:40 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:f7fc:9d46:b65e:128d:39a8?
 ([2804:7f0:bcc0:f7fc:9d46:b65e:128d:39a8])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170903244c00b001c877f27d1fsm5473588pls.11.2023.11.14.03.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 03:20:40 -0800 (PST)
Message-ID: <6439d06c-7b9b-4fe7-83dd-a33be98ef98e@ventanamicro.com>
Date: Tue, 14 Nov 2023 08:20:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: don't verify ISA compatibility for zicntr
 and zihpm
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng@tinylab.org>
References: <20231114094412.413408-1-chigot@adacore.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231114094412.413408-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
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

(adding maintainers in the CC)



On 11/14/23 06:44, Clément Chigot wrote:
> The extensions zicntr and zihpm were officially added in the privilege
> instruction set specification 1.12. However, QEMU has been implemented
> them long before it and thus they are forced to be on during the cpu
> initialization to ensure compatibility (see riscv_cpu_init).
> riscv_cpu_disable_priv_spec_isa_exts was not updated when the above
> behavior was introduced, resulting in these extensions to be disabled
> after all.
> 

Please add the following tags:

Fixes: c004099330 ("target/riscv: add zicntr extension flag for TCG")
Fixes: 0824121660 ("target/riscv: add zihpm extension flag for TCG")

> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/tcg/tcg-cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 08adad304d..8a35683a34 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -250,6 +250,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
>       for (edata = isa_edata_arr; edata && edata->name; edata++) {
>           if (isa_ext_is_enabled(cpu, edata->ext_enable_offset) &&
>               (env->priv_ver < edata->min_version)) {
> +            /*
> +             * These two extensions are always enabled as they were supported
> +             * by QEMU before they were added as extensions in the ISA.
> +             */
> +            if (!strcmp(edata->name, "zicntr") ||
> +                !strcmp(edata->name, "zihpm")) {
> +                continue;
> +            }
> +
>               isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
>   #ifndef CONFIG_USER_ONLY
>               warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx

