Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCD823781
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 23:10:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL9Pf-0008OZ-Fn; Wed, 03 Jan 2024 17:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rL9Pb-0008OB-QT
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 17:08:31 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rL9PY-0004sR-1w
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 17:08:31 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d4c3393f99so16532375ad.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 14:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704319706; x=1704924506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/eTTFbrv6dlsZWhQ1YSFmXMRMJ1j9PfOhE9AOL0gnrg=;
 b=ORg329/jrsAMNt6UDF58a10Cc5+I7623JWUxsu3kZIKUm6G6IN9EYq1RHUxKzBUc3o
 QXAjfVTRAzZ9ilF1UvXTPOItX5s7UZSPGvxqcfTT/OUbXOJdjkwD0IsUVxx3SLp4pe5K
 HeEvB/jLSlG5hgVK6ZIs/yqsGfI3uM2+Y+49D0Gt30O8SI6fItLNyILEyY4KVudwiktH
 DRgZKnQ23w0r/NWXojt4gRSas9nUFZpzx4w2rIuYLPB7Bdn/w+JmzQliLFVyGs6OrIP5
 0nOpJZP/hIKpdnNuSBLPll5lE54VQhuUtPFZzT1sh0GAWzAa2RrnAP2o9M8l1jCzs4lQ
 7B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704319706; x=1704924506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/eTTFbrv6dlsZWhQ1YSFmXMRMJ1j9PfOhE9AOL0gnrg=;
 b=O+iga9m03z5AOeCnCJmji/pj+fjK29imfdY5elW2HKhI3aAdwo+psE5wHG58/aH2Ip
 4rr0WeotZQPD7MATwc9cwRBYMYxz1fSQ3wl8cU4fMvBRvRKCu4PD5nH3TmwjHDtRObie
 5RRprobUO8uDPGkt+3c3TEughNNfLvOyyjtdZZDYbJOOR6ukFzKfHF11LhjZA+chyKLy
 eFp+2ZtrgdOHpXDyel9zdCTA6SFFkjl43lmh+YsnNXUWEE36UAOjdwlUMXOnVK5hA0T2
 bFPHukipGDXDAiTf5uWiKmbMXiaXV01bk7M8l26bje8GXvNLBUECbN3Dk3f70BMGdSV1
 XeFw==
X-Gm-Message-State: AOJu0YyXEaPtksGuFD1QTJW7Tm91JG0midspnVhdbr/L8dtpGpVp9H33
 Kan4zhJZlvJK4QVUpHx5zcl4c7JZ1e+YNg==
X-Google-Smtp-Source: AGHT+IHDl/Mc6Z49uGqyCYuhtbGC6UwegHbT/2hM6/FJ7/7e/yItiV3EtGQkFMSLE3Y/Nu03NRsgxA==
X-Received: by 2002:a17:903:41c8:b0:1d4:5276:7674 with SMTP id
 u8-20020a17090341c800b001d452767674mr22189661ple.64.1704319706237; 
 Wed, 03 Jan 2024 14:08:26 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a170902bc4100b001d4cd7bf923sm2228046plz.68.2024.01.03.14.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 14:08:25 -0800 (PST)
Message-ID: <47177ca3-e190-42b1-a6c2-d3a2be8cedb6@linaro.org>
Date: Thu, 4 Jan 2024 09:08:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] target/riscv: Add pointer masking tb flags
Content-Language: en-US
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240103185716.1790546-1-me@deliversmonkey.space>
 <20240103185716.1790546-5-me@deliversmonkey.space>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240103185716.1790546-5-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/4/24 05:57, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---
>   target/riscv/cpu.h        |  3 +++
>   target/riscv/cpu_helper.c |  3 +++
>   target/riscv/translate.c  | 11 +++++++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c607a94bba..4df160494f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -546,6 +546,9 @@ FIELD(TB_FLAGS, ITRIGGER, 20, 1)
>   FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
>   FIELD(TB_FLAGS, PRIV, 22, 2)
>   FIELD(TB_FLAGS, AXL, 24, 2)
> +/* If pointer masking should be applied and address sign extended */
> +FIELD(TB_FLAGS, PM_PMM, 26, 2)
> +FIELD(TB_FLAGS, PM_SIGNEXTEND, 28, 1)
>   
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 4c34e12ee3..b8d8a622f3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -68,6 +68,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>       RISCVCPU *cpu = env_archcpu(env);
>       RISCVExtStatus fs, vs;
>       uint32_t flags = 0;
> +    bool pm_signext = !riscv_cpu_bare_mode(env);
>   
>       *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
>       *cs_base = 0;
> @@ -135,6 +136,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>       flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
>       flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
>       flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> +    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
> +    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);

You should avoid setting these fields (i.e. leave them zero) when they won't be used...

> +    if (get_xl(ctx) == MXL_RV32) {
> +        ctx->addr_width = 32;
> +        ctx->addr_signed = false;

... like so.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

