Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86673B39C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCd8B-0005Mt-SU; Fri, 23 Jun 2023 05:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCd86-0005HI-HP
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:30:58 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qCd82-0006vX-SD
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 05:30:58 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso46787266b.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687512649; x=1690104649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gg9zIbc417MBuIr1lkhMjAFT9Jq4tyBzgm/w3nMVAow=;
 b=Dc3Uy3dzWJLp0a4XmDXlb5W4U8zYObAG/F+vM3B8Qr1YSMjns7GwO0H4kTAgJdd9Tx
 iWqi9t6ArOI9a5OdkJNKZ1GPlyUbezankVPkdGA6gxCs1y+hmScPF2iwSMLd2H6HY8Fh
 DC4eiCxibxJpegqeZglVMWH/COuu1DqDcJczyzpKoKymiuULgz1qvUx3WCOdFl4vPjVj
 Mmc1XiXTKxaBEAKwOuqGkB7VFdZ+Gx64bHCh4YrLYsItmLMsyVFiilMmZdH0KDSN71pe
 66kSSXoE/UGFDSDd0VZJjzKmj2oTL9yt6R29D9snHAJ+HcZylyWKnzwSeHdmckg1Yp1M
 DuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687512649; x=1690104649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gg9zIbc417MBuIr1lkhMjAFT9Jq4tyBzgm/w3nMVAow=;
 b=T8Usku7vfI1OCTnwSjIR0+PMscOe3OJgKQM5AovmzRABrLFmK/ecLJGKIm5ptoXxE8
 +80Z+k6bD3K6i7pewYNkWGTeGv1RqVFzmbHdOOKKPS1g8H5/3R7V+kb7x4a6XVz5kkq7
 4i5aauj+s1OiX+8tApRP9jAvDfXszQZ+hu5h0BvmJRcSYXQeam5ar0FkT/50rQYW7TO4
 88Kolxc4sJaHO3Y+c9lvT0n/A9VjRSxD9d5F9EVLHYcqscEwqEYFEUAQQtubG+XfeClY
 8jJ/8tNvXTnDGtE18F8n31Jf9Y1QbJWLtMQmK3CiZ+xzZ9uCIx97Ajmmn6m6LAFEjkH5
 qdxw==
X-Gm-Message-State: AC+VfDwF5iAtl+MU366SLlfjHI+BBLpDH8oWv9y4NXrTQQPGKBV0BSM9
 8IbkhMd/J+4kCXmBdSF391rPNS4+3uz7+xJxAaE=
X-Google-Smtp-Source: ACHHUZ6tnVUbI8NUHO/cmy9NxECby7fu2UWIbZYZyrHTjSj6c/KKpV2Dii3WhKuPcPwB7Xf5YIUblA==
X-Received: by 2002:a17:907:168c:b0:98c:e3a1:dbba with SMTP id
 hc12-20020a170907168c00b0098ce3a1dbbamr5940759ejc.4.1687512649375; 
 Fri, 23 Jun 2023 02:30:49 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a17090624cc00b0098d2261d189sm2179422ejb.19.2023.06.23.02.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 02:30:48 -0700 (PDT)
Date: Fri, 23 Jun 2023 11:30:47 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 11/19] target/riscv/cpu: add misa_ext_info_arr[]
Message-ID: <20230623-cf3b4377313609ed5535c1ce@orel>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
 <20230622135700.105383-12-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622135700.105383-12-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x630.google.com
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

On Thu, Jun 22, 2023 at 10:56:52AM -0300, Daniel Henrique Barboza wrote:
> Next patch will add KVM specific user properties for both MISA and
> multi-letter extensions. For MISA extensions we want to make use of what
> is already available in misa_ext_cfgs[] to avoid code repetition.
> 
> misa_ext_info_arr[] array will hold name and description for each MISA
> extension that misa_ext_cfgs[] is declaring. We'll then use this new
> array in KVM code to avoid duplicating strings.
> 
> There's nothing holding us back from doing the same with multi-letter
> extensions. For now doing just with MISA extensions is enough.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 60 ++++++++++++++++++++++++++--------------------
>  target/riscv/cpu.h | 11 ++++++++-
>  2 files changed, 44 insertions(+), 27 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 641bec3573..0e5d8b05a2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1566,33 +1566,41 @@ static void cpu_get_misa_ext_cfg(Object *obj, Visitor *v, const char *name,
>      visit_type_bool(v, name, &value, errp);
>  }
>  
> +const MISAExtInfo misa_ext_info_arr[] = {
> +    [RVA] = {"a", "Atomic instructions"},
> +    [RVC] = {"c", "Compressed instructions"},
> +    [RVD] = {"d", "Double-precision float point"},
> +    [RVF] = {"f", "Single-precision float point"},
> +    [RVI] = {"i", "Base integer instruction set"},
> +    [RVE] = {"e", "Base integer instruction set (embedded)"},
> +    [RVM] = {"m", "Integer multiplication and division"},
> +    [RVS] = {"s", "Supervisor-level instructions"},
> +    [RVU] = {"u", "User-level instructions"},
> +    [RVH] = {"h", "Hypervisor"},
> +    [RVJ] = {"x-j", "Dynamic translated languages"},
> +    [RVV] = {"v", "Vector operations"},
> +    [RVG] = {"g", "General purpose (IMAFD_Zicsr_Zifencei)"},
> +};
> +
> +#define MISA_CFG(_bit, _enabled) \
> +    {.name = misa_ext_info_arr[_bit].name, \
> +     .description = misa_ext_info_arr[_bit].description, \
> +     .misa_bit = _bit, .enabled = _enabled}
> +
>  static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
> -    {.name = "a", .description = "Atomic instructions",
> -     .misa_bit = RVA, .enabled = true},
> -    {.name = "c", .description = "Compressed instructions",
> -     .misa_bit = RVC, .enabled = true},
> -    {.name = "d", .description = "Double-precision float point",
> -     .misa_bit = RVD, .enabled = true},
> -    {.name = "f", .description = "Single-precision float point",
> -     .misa_bit = RVF, .enabled = true},
> -    {.name = "i", .description = "Base integer instruction set",
> -     .misa_bit = RVI, .enabled = true},
> -    {.name = "e", .description = "Base integer instruction set (embedded)",
> -     .misa_bit = RVE, .enabled = false},
> -    {.name = "m", .description = "Integer multiplication and division",
> -     .misa_bit = RVM, .enabled = true},
> -    {.name = "s", .description = "Supervisor-level instructions",
> -     .misa_bit = RVS, .enabled = true},
> -    {.name = "u", .description = "User-level instructions",
> -     .misa_bit = RVU, .enabled = true},
> -    {.name = "h", .description = "Hypervisor",
> -     .misa_bit = RVH, .enabled = true},
> -    {.name = "x-j", .description = "Dynamic translated languages",
> -     .misa_bit = RVJ, .enabled = false},
> -    {.name = "v", .description = "Vector operations",
> -     .misa_bit = RVV, .enabled = false},
> -    {.name = "g", .description = "General purpose (IMAFD_Zicsr_Zifencei)",
> -     .misa_bit = RVG, .enabled = false},
> +    MISA_CFG(RVA, true),
> +    MISA_CFG(RVC, true),
> +    MISA_CFG(RVD, true),
> +    MISA_CFG(RVF, true),
> +    MISA_CFG(RVI, true),
> +    MISA_CFG(RVE, false),
> +    MISA_CFG(RVM, true),
> +    MISA_CFG(RVS, true),
> +    MISA_CFG(RVU, true),
> +    MISA_CFG(RVH, true),
> +    MISA_CFG(RVJ, false),
> +    MISA_CFG(RVV, false),
> +    MISA_CFG(RVG, false),
>  };
>  
>  static void riscv_cpu_add_misa_properties(Object *cpu_obj)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e3e08d315f..3e08c8da51 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -41,7 +41,10 @@
>  
>  #define RV(x) ((target_ulong)1 << (x - 'A'))
>  
> -/* Consider updating misa_ext_cfgs[] when adding new MISA bits here */
> +/*
> + * Consider updating misa_ext_info_arr[] and misa_ext_cfgs[]
> + * when adding new MISA bits here.
> + */
>  #define RVI RV('I')
>  #define RVE RV('E') /* E and I are mutually exclusive */
>  #define RVM RV('M')
> @@ -56,6 +59,12 @@
>  #define RVJ RV('J')
>  #define RVG RV('G')
>  
> +typedef struct misa_ext_info {
> +    const char *name;
> +    const char *description;
> +} MISAExtInfo;
> +
> +extern const MISAExtInfo misa_ext_info_arr[];
>  
>  /* Privileged specification version */
>  enum {
> -- 
> 2.41.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

