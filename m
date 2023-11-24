Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E147F7A18
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:10:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZgT-0002zS-86; Fri, 24 Nov 2023 12:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6ZgR-0002z6-FI
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:09:39 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1r6ZgP-00064D-KY
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:09:39 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54b0310f536so1123604a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700845776; x=1701450576; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2BDIF4spFbrfhl3yluURJjMa1USR/6aeW7LY/8yTZwg=;
 b=fVOUUoarBAmB44dg7tYUolAgNXds4MsIFBE1j9o6NKJG+dVGFWeQKm7GBMgGzr02qG
 BQidf2TPwgGKbR8qkbYMR23s39V/CzlivW9UF/avVpvGwqB1QVRqXUCjCQyrMVyVMW40
 xjxqI8GZLwD5Ixrk1j/YdaHWACDyRaAlTtzBVwGpy/NGVNycZx20Ecirok6aubmJMhlE
 CGKU6N7t7blygU12jA7omJaFcN578FN51oiWxICTVKhaqRXiGCma5d27hCu4gy4rNA7I
 j7+nteImz2RKx71vNzNOzB7wX/7eU8dBL1W1lXiuf81XVOwTJmkAf3NRKYQsiaL6mgsP
 yUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700845776; x=1701450576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BDIF4spFbrfhl3yluURJjMa1USR/6aeW7LY/8yTZwg=;
 b=xC54jHFllo80hfvPlGG+COJMT0amMQXHKdnFvw0tpFd1SlhLmlu7j1HFvxfj0nP7w5
 H52sR4jVqita43udpMs4VMqQmVPS0Zd2bZCFILtC1a7AQPJQQ3kdbXgW1N049R8PyQ83
 4dO4SfNLSuLsPATWSKYWYJA6lKgm3xc5iFKFPHBc5ktzRDPcp8Zm/ow8x8c9vakwOtNI
 Qb1FEYXU4ctdeSWDUymo9pz7qd1szRenVhLbEDz8jxcqOdGQJs5zcOWFBGGVluv/4hZk
 0mutCokDB9r6XL4Ra79vNtUfslvvA7hEed9XhK3U4m4v0FauOjXeCvlAy8N2Kp/H6FLI
 wcmQ==
X-Gm-Message-State: AOJu0YyxhojUBG/5jAwkILE7yZ2WGdTfqFMP1z553sOPxSjC9isZ3wNC
 08tVcGRO9hgmfKkzaRTw9dXmcQ==
X-Google-Smtp-Source: AGHT+IHmRuU+9GigIdZR0//MJw1hBpTHUKl3EgyUtcICyVIfhNlYSVS91QASA4hU3ZDeC9Sm8YLvuA==
X-Received: by 2002:a50:ccc2:0:b0:548:a1cd:a92c with SMTP id
 b2-20020a50ccc2000000b00548a1cda92cmr2999167edj.5.1700845775821; 
 Fri, 24 Nov 2023 09:09:35 -0800 (PST)
Received: from localhost ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 h22-20020aa7de16000000b005489a1f9a94sm1966518edv.80.2023.11.24.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:09:35 -0800 (PST)
Date: Fri, 24 Nov 2023 18:09:34 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH for-9.0 5/7] target/riscv: add satp_mode profile support
Message-ID: <20231124-52cb65adbaa1a06f89582d73@orel>
References: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
 <20231123191532.1101644-6-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123191532.1101644-6-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x529.google.com
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

On Thu, Nov 23, 2023 at 04:15:30PM -0300, Daniel Henrique Barboza wrote:
> 'satp_mode' is a requirement for supervisor profiles like RVA22S64.
> User-mode/application profiles like RVA22U64 doesn't care.
> 
> Add 'satp_mode' to the profile description. If a profile requires it,
> set it during cpu_set_profile(). We'll also check it during finalize()
> to validate if the running config implements the profile.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         |  1 +
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 41 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2b79fe861b..a77118549b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1543,6 +1543,7 @@ static RISCVCPUProfile RVA22U64 = {
>      .name = "rva22u64",
>      .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVU,
>      .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
> +    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
>      .ext_offsets = {
>          CPU_CFG_OFFSET(ext_zicsr), CPU_CFG_OFFSET(ext_zihintpause),
>          CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 485d2da3c2..6c5fceb5f5 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -82,6 +82,7 @@ typedef struct riscv_cpu_profile {
>      bool enabled;
>      bool user_set;
>      int priv_spec;
> +    int satp_mode;
>      const int32_t ext_offsets[];
>  } RISCVCPUProfile;
>  
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index a26cc6f093..8cfab26915 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -775,6 +775,31 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>      riscv_cpu_disable_priv_spec_isa_exts(cpu);
>  }
>  
> +#ifndef CONFIG_USER_ONLY
> +static bool riscv_cpu_validate_profile_satp(RISCVCPU *cpu,
> +                                            RISCVCPUProfile *profile,
> +                                            bool send_warn)
> +{
> +    int satp_max = satp_mode_max_from_map(cpu->cfg.satp_mode.supported);
> +
> +    if (profile->satp_mode > satp_max) {
> +        if (send_warn) {
> +            bool is_32bit = riscv_cpu_is_32bit(cpu);
> +            const char *req_satp = satp_mode_str(profile->satp_mode, is_32bit);
> +            const char *cur_satp = satp_mode_str(satp_max, is_32bit);
> +
> +            warn_report("Profile %s requires satp mode %s, "
> +                        "but satp mode %s was set", profile->name,
> +                        req_satp, cur_satp);
> +        }
> +
> +        return false;
> +    }
> +
> +    return true;
> +}
> +#endif
> +
>  static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>                                         RISCVCPUProfile *profile)
>  {
> @@ -784,6 +809,13 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>      bool profile_impl = true;
>      int i;
>  
> +#ifndef CONFIG_USER_ONLY
> +    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
> +        profile_impl = riscv_cpu_validate_profile_satp(cpu, profile,
> +                                                       send_warn);
> +    }
> +#endif
> +
>      if (profile->priv_spec != env->priv_ver) {
>          profile_impl = false;
>  
> @@ -1083,10 +1115,19 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>      profile->user_set = true;
>      profile->enabled = value;
>  
> +

stray blank line

>      if (profile->enabled) {
>          cpu->env.priv_ver = profile->priv_spec;
>      }
>  
> +#ifndef CONFIG_USER_ONLY
> +    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
> +        const char *satp_prop = satp_mode_str(profile->satp_mode,
> +                                              riscv_cpu_is_32bit(cpu));
> +        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
> +    }
> +#endif
> +
>      for (i = 0; misa_bits[i] != 0; i++) {
>          uint32_t bit = misa_bits[i];
>  
> -- 
> 2.41.0
>

Otherwise

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

