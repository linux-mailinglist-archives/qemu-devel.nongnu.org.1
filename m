Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5D774504
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:35:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRXJ-00057B-Bb; Tue, 08 Aug 2023 14:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRX8-00056C-3s
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:34:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRX6-0001W8-8f
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:34:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-564ca521549so3078170a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691519654; x=1692124454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfv/0YUe50N4HB3HRGmu5pzHL3KpJ/bsW1sRVIv9M/U=;
 b=hQwcnB99mB8pHmCdIJ/HvkBKesIF89CKpLhiWMXN9dzaPQrk4u7E4HuZz6bkd27KuO
 O4XRULwFpcAH7lQGiGg4De2ZZe9AA7WRqV8N1ME92OsT1hXTdDDn9ETa8ZrlCJ68nvhL
 OnzB6Eo1sn0bim3Xr1Oni/hWuFSTRqjJuLkBo5Y+fVsoFAW+uka6xFeBvAFeafkI4Rsg
 Tg9bssLS8NJ7758P2uFC1Fu/ciXAqMg4cyFYJElofoNIaeArOlDllGACwL4Mm1PBrtp7
 ce6VDbKcCCuz6CVFmU6S7zz5BcJbmwlN2E54zO9aZBiqGFxWGrC2R3lvd2kXGne0Ha9R
 qpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691519654; x=1692124454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfv/0YUe50N4HB3HRGmu5pzHL3KpJ/bsW1sRVIv9M/U=;
 b=RZ13/DPrNrUwUx0zj0u4ch6VlMJ6uf1m1++o83UwzBnfqKD+JWTXJPu6M8zeS69oBt
 cGfFY3jKhLDrpbOL9wSBCs1df1XoEvGZbjHCcNuD4ksK4hjRuyGa9gK4tABXri+ouVli
 dJ7cyTlSh/lRRm+cGDXQkfs473Q6cBT9fn4j4zn4G1MgFUhfzUQvHseTNZnHG4ZIidBI
 QuZMmnLdL7CSzpkrWl+7vT2s9vs/fi8g/y/3GJoa+DYRmVjJF/we760dIMKxDUw+dKTE
 qygbXqaI9FsyPHMWRTXNottCMdgDvxE3jPFQrdlkA23l2EB0t7q8/bYneuqZ/4Y463g0
 DCYQ==
X-Gm-Message-State: AOJu0YyRAy6dm1Es4DVy0HSsSNrT2O2p1AZZZ8HwFu4FJEjBGuEgJk8n
 dGEF6z3Ti3+Zp8bnTJH7mbTZkvwUE7qttwfOeE4=
X-Google-Smtp-Source: AGHT+IHyQMi0Xb7UPQLYzslUg9KrfLtTnN7hPmMWpNpVUwTmJt4kqFpW7EQjuC4zI6Ejc5K43DnYoA==
X-Received: by 2002:a05:6a21:3b48:b0:137:40ba:d91f with SMTP id
 zy8-20020a056a213b4800b0013740bad91fmr351982pzb.10.1691519654605; 
 Tue, 08 Aug 2023 11:34:14 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 b14-20020aa7870e000000b00687790191a2sm8407066pfo.58.2023.08.08.11.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:34:14 -0700 (PDT)
Message-ID: <44e5fb7c-4773-b8a1-5eac-c656c4a0a92f@linaro.org>
Date: Tue, 8 Aug 2023 11:34:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 03/11] target/loongarch: Add GDB support for
 loongarch32 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-4-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-4-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> GPRs and PC are 32-bit wide in loongarch32 mode.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   configs/targets/loongarch64-softmmu.mak |  2 +-
>   gdb-xml/loongarch-base32.xml            | 45 +++++++++++++++++++++++++
>   target/loongarch/cpu.c                  | 10 +++++-
>   target/loongarch/gdbstub.c              | 32 ++++++++++++++----
>   4 files changed, 80 insertions(+), 9 deletions(-)
>   create mode 100644 gdb-xml/loongarch-base32.xml
> 
> diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
> index 9abc99056f..f23780fdd8 100644
> --- a/configs/targets/loongarch64-softmmu.mak
> +++ b/configs/targets/loongarch64-softmmu.mak
> @@ -1,5 +1,5 @@
>   TARGET_ARCH=loongarch64
>   TARGET_BASE_ARCH=loongarch
>   TARGET_SUPPORTS_MTTCG=y
> -TARGET_XML_FILES= gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
> +TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml
>   TARGET_NEED_FDT=y
> diff --git a/gdb-xml/loongarch-base32.xml b/gdb-xml/loongarch-base32.xml
> new file mode 100644
> index 0000000000..af47bbd3da
> --- /dev/null
> +++ b/gdb-xml/loongarch-base32.xml
> @@ -0,0 +1,45 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2022 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.loongarch.base">
> +  <reg name="r0" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r1" bitsize="32" type="code_ptr" group="general"/>
> +  <reg name="r2" bitsize="32" type="data_ptr" group="general"/>
> +  <reg name="r3" bitsize="32" type="data_ptr" group="general"/>
> +  <reg name="r4" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r5" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r6" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r7" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r8" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r9" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r10" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r11" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r12" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r13" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r14" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r15" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r16" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r17" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r18" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r19" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r20" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r21" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r22" bitsize="32" type="data_ptr" group="general"/>
> +  <reg name="r23" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r24" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r25" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r26" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r27" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r28" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r29" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r30" bitsize="32" type="uint32" group="general"/>
> +  <reg name="r31" bitsize="32" type="uint32" group="general"/>
> +  <reg name="orig_a0" bitsize="32" type="uint32" group="general"/>
> +  <reg name="pc" bitsize="32" type="code_ptr" group="general"/>
> +  <reg name="badv" bitsize="32" type="code_ptr" group="general"/>
> +</feature>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 3bd293d00a..13d4fccbd3 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -694,7 +694,13 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
>   
>   static gchar *loongarch_gdb_arch_name(CPUState *cs)
>   {
> -    return g_strdup("loongarch64");
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +    if (LOONGARCH_CPUCFG_ARCH(env, LA64)) {
> +        return g_strdup("loongarch64");
> +    } else {
> +        return g_strdup("loongarch32");
> +    }
>   }
>   
>   static void loongarch_cpu_class_init(ObjectClass *c, void *data)
> @@ -734,6 +740,8 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>   
>   static void loongarch32_cpu_class_init(ObjectClass *c, void *data)
>   {
> +    CPUClass *cc = CPU_CLASS(c);
> +    cc->gdb_core_xml_file = "loongarch-base32.xml";
>   }
>   
>   #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
> index 0752fff924..0dfd1c8bb9 100644
> --- a/target/loongarch/gdbstub.c
> +++ b/target/loongarch/gdbstub.c
> @@ -34,16 +34,25 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>       CPULoongArchState *env = &cpu->env;
> +    uint64_t val;
>   
>       if (0 <= n && n < 32) {
> -        return gdb_get_regl(mem_buf, env->gpr[n]);
> +        val = env->gpr[n];
>       } else if (n == 32) {
>           /* orig_a0 */
> -        return gdb_get_regl(mem_buf, 0);
> +        val = 0;
>       } else if (n == 33) {
> -        return gdb_get_regl(mem_buf, env->pc);
> +        val = env->pc;
>       } else if (n == 34) {
> -        return gdb_get_regl(mem_buf, env->CSR_BADV);
> +        val = env->CSR_BADV;
> +    }
> +
> +    if (0 <= n && n <= 34) {
> +        if (LOONGARCH_CPUCFG_ARCH(env, LA64)) {
> +            return gdb_get_reg64(mem_buf, val);
> +        } else {
> +            return gdb_get_reg32(mem_buf, val);
> +        }

Is it an existing bug that BADV is readable...


> @@ -52,15 +61,24 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>       CPULoongArchState *env = &cpu->env;
> -    target_ulong tmp = ldtul_p(mem_buf);
> +    target_ulong tmp;
> +    int read_length;
>       int length = 0;
>   
> +    if (LOONGARCH_CPUCFG_ARCH(env, LA64)) {
> +        tmp = ldq_p(mem_buf);
> +        read_length = 8;
> +    } else {
> +        tmp = ldl_p(mem_buf);
> +        read_length = 4;
> +    }
> +
>       if (0 <= n && n < 32) {
>           env->gpr[n] = tmp;
> -        length = sizeof(target_ulong);
> +        length = read_length;
>       } else if (n == 33) {
>           env->pc = tmp;
> -        length = sizeof(target_ulong);
> +        length = read_length;
>       }

... but not writable?  I can't immediately see any reason why gdbstub should reject writes 
to BADV.

But for this patch:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


