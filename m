Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C746F76F477
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 23:11:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRfaQ-0000tM-Kc; Thu, 03 Aug 2023 17:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRfaO-0000sx-KS
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 17:10:20 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRfaM-0004zs-80
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 17:10:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc3bec2c95so10450435ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691097016; x=1691701816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vos1lAkqvKI/i5Zc0Lzp7rjGTn0nXpVBFPba1cNk8Js=;
 b=jicF8TAu1eDdmYgOyB19y63XWpXzdkLBMHNCINGHJu7Xgfsq4qBR6PXgTSYJg7VNZp
 E0TIvw05kVKiE6dvIKgySLwCwlbkQtJImjZqC0UXGtmKYz3etWi4zCiOEDCjmjPBxPwV
 xpFlkJo4v1MnYCgUT6lc6SQaBv5fkWe15Jo24oE8nyrdrsz5sgj/6+Xs49l4QJHuEwbt
 338r2R53wpKXVVNhC4cmVdNTOaPWugGp2/pJ2wgik5nJOiZATagYNoMbzF3JyXBxMDP+
 2lvbrlNNjU9g99MDMgFndD0ry9lAMKkhTFbzcxNlGl8rHEFgbAXF8IE4REQoMGNthwSF
 GWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691097016; x=1691701816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vos1lAkqvKI/i5Zc0Lzp7rjGTn0nXpVBFPba1cNk8Js=;
 b=V9VRgClt6OY36Re4UbwVLo1d1qF0WvTVaqjUNJTvKZv7rsO0Aaeaowz4Dlwli1/14r
 GZYr3S+C2w41hBAmG7QojM8senBt1Dm/c53I6r7ZDg/QkNn5GK0wid1RLltOd8sYg0Lu
 CUjZlHOlF1H8imXgYgRmzpaRk4+uvM9V5VcTSJYET5c4asT2/HgJh5gbKMFWVke+fwpK
 GAnxWK1ZdnYS+Fzg4A1ZPwx8iWdiimlEKmhRHTkYjWcPLECcmzpWlb0+XBhhZjDBN7Xd
 BAlCtwwMNP06sZ3bm3/w14Aw/mXYUuy9z8zMi9vddaUv/YeP8nIERZ4niuCoPT9q43FT
 hk1g==
X-Gm-Message-State: ABy/qLYur5fC5VuGUEWzFx/2RMIPhgswvufo6UTI4CYWYc8m7RaIzFxJ
 qp47A4FypTn2gxTW/Q3zR8VIUA==
X-Google-Smtp-Source: APBJJlFggU8tkBwK0Sc1VShksA00fcF9QHNNUBQfXtoeeZqy5AOZqeYLgQ23QIPTlG4r5XqIBzh/Bw==
X-Received: by 2002:a17:902:d506:b0:1b8:c8bc:c81b with SMTP id
 b6-20020a170902d50600b001b8c8bcc81bmr24873127plg.21.1691097015985; 
 Thu, 03 Aug 2023 14:10:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170903230400b001b531e8a000sm280710plh.157.2023.08.03.14.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 14:10:15 -0700 (PDT)
Message-ID: <679e6fca-f921-5eb8-f59d-8d11703e96c6@linaro.org>
Date: Thu, 3 Aug 2023 14:10:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] linux-user: Emulate /proc/cpuinfo on aarch64 and
 arm
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230803204803.639733-1-deller@gmx.de>
 <20230803204803.639733-3-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803204803.639733-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 13:48, Helge Deller wrote:
> Add emulation for /proc/cpuinfo for arm architecture.
> The output below mimics output as seen on debian porterboxes.
> 
> aarch64 output example:
> 
> processor       : 0
> model name      : ARMv8 Processor rev 0 (v8l)
> BogoMIPS        : 100.00
> Features        : swp half thumb fast_mult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae aes pmull sha1 sha2 crc32
> CPU implementer : 0x41
> CPU architecture: 8
> CPU variant     : 0x1
> CPU part        : 0xd07
> CPU revision    : 0
> Hardware        : QEMU v8.0.92 arm,cortex-a57
> 
> arm 32-bit output example:
> 
> processor       : 0
> model name      : ARMv5 Processor rev 6 (armv5l)
> BogoMIPS        : 50.00
> Features        : swp half thumb fast_mult edsp
> CPU implementer : 0x69
> CPU architecture: 5
> CPU variant     : 0
> CPU part        : 0x2d0
> CPU revision    : 6
> Hardware        : QEMU v8.0.92 marvell,xscale
> Revision        : 0000
> Serial          : 0000000000000000
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> v4:
> - more refinements based on Richards feedback
> v3:
> - show variant, part, revision and implementor based on midr
>    value (suggested by Richard Henderson)
> v2:
> - show features of CPU which is actually being emulated by qemu
>    (suggested by Peter Maydell)
> ---
>   linux-user/elfload.c | 130 +++++++++++++++++++++++++++++++++++++++++--
>   linux-user/loader.h  |   6 +-
>   linux-user/syscall.c |  76 ++++++++++++++++++++++++-
>   3 files changed, 205 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 861ec07abc..99804e477d 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -466,7 +466,7 @@ static bool init_guest_commpage(void)
>   #define ELF_HWCAP get_elf_hwcap()
>   #define ELF_HWCAP2 get_elf_hwcap2()
> 
> -static uint32_t get_elf_hwcap(void)
> +uint32_t get_elf_hwcap(void)
>   {
>       ARMCPU *cpu = ARM_CPU(thread_cpu);
>       uint32_t hwcaps = 0;
> @@ -508,7 +508,7 @@ static uint32_t get_elf_hwcap(void)
>       return hwcaps;
>   }
> 
> -static uint32_t get_elf_hwcap2(void)
> +uint32_t get_elf_hwcap2(void)
>   {
>       ARMCPU *cpu = ARM_CPU(thread_cpu);
>       uint32_t hwcaps = 0;
> @@ -521,6 +521,49 @@ static uint32_t get_elf_hwcap2(void)
>       return hwcaps;
>   }
> 
> +const char *elf_hwcap_str(uint32_t bit)
> +{
> +    static const char *hwcap_str[] = {
> +    [__builtin_ctz(ARM_HWCAP_ARM_SWP      )] = "swp",
> +    [__builtin_ctz(ARM_HWCAP_ARM_HALF     )] = "half",
> +    [__builtin_ctz(ARM_HWCAP_ARM_THUMB    )] = "thumb",
> +    [__builtin_ctz(ARM_HWCAP_ARM_26BIT    )] = "26bit",
> +    [__builtin_ctz(ARM_HWCAP_ARM_FAST_MULT)] = "fast_mult",
> +    [__builtin_ctz(ARM_HWCAP_ARM_FPA      )] = "fpa",
> +    [__builtin_ctz(ARM_HWCAP_ARM_VFP      )] = "vfp",
> +    [__builtin_ctz(ARM_HWCAP_ARM_EDSP     )] = "edsp",
> +    [__builtin_ctz(ARM_HWCAP_ARM_JAVA     )] = "java",
> +    [__builtin_ctz(ARM_HWCAP_ARM_IWMMXT   )] = "iwmmxt",
> +    [__builtin_ctz(ARM_HWCAP_ARM_CRUNCH   )] = "crunch",
> +    [__builtin_ctz(ARM_HWCAP_ARM_THUMBEE  )] = "thumbee",
> +    [__builtin_ctz(ARM_HWCAP_ARM_NEON     )] = "neon",
> +    [__builtin_ctz(ARM_HWCAP_ARM_VFPv3    )] = "vfpv3",
> +    [__builtin_ctz(ARM_HWCAP_ARM_VFPv3D16 )] = "vfpv3d16",
> +    [__builtin_ctz(ARM_HWCAP_ARM_TLS      )] = "tls",
> +    [__builtin_ctz(ARM_HWCAP_ARM_VFPv4    )] = "vfpv4",
> +    [__builtin_ctz(ARM_HWCAP_ARM_IDIVA    )] = "idiva",
> +    [__builtin_ctz(ARM_HWCAP_ARM_IDIVT    )] = "idivt",
> +    [__builtin_ctz(ARM_HWCAP_ARM_VFPD32   )] = "vfpd32",
> +    [__builtin_ctz(ARM_HWCAP_ARM_LPAE     )] = "lpae",
> +    [__builtin_ctz(ARM_HWCAP_ARM_EVTSTRM  )] = "evtstrm",
> +    };
> +
> +    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
> +}
> +
> +const char *elf_hwcap2_str(uint32_t bit)
> +{
> +    static const char *hwcap_str[] = {
> +    [__builtin_ctz(ARM_HWCAP2_ARM_AES  )] = "aes",
> +    [__builtin_ctz(ARM_HWCAP2_ARM_PMULL)] = "pmull",
> +    [__builtin_ctz(ARM_HWCAP2_ARM_SHA1 )] = "sha1",
> +    [__builtin_ctz(ARM_HWCAP2_ARM_SHA2 )] = "sha2",
> +    [__builtin_ctz(ARM_HWCAP2_ARM_CRC32)] = "crc32",
> +    };
> +
> +    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
> +}
> +
>   #undef GET_FEATURE
>   #undef GET_FEATURE_ID
> 
> @@ -668,7 +711,7 @@ enum {
>   #define GET_FEATURE_ID(feat, hwcap) \
>       do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
> 
> -static uint32_t get_elf_hwcap(void)
> +uint32_t get_elf_hwcap(void)
>   {
>       ARMCPU *cpu = ARM_CPU(thread_cpu);
>       uint32_t hwcaps = 0;
> @@ -706,7 +749,7 @@ static uint32_t get_elf_hwcap(void)
>       return hwcaps;
>   }
> 
> -static uint32_t get_elf_hwcap2(void)
> +uint32_t get_elf_hwcap2(void)
>   {
>       ARMCPU *cpu = ARM_CPU(thread_cpu);
>       uint32_t hwcaps = 0;
> @@ -741,6 +784,85 @@ static uint32_t get_elf_hwcap2(void)
>       return hwcaps;
>   }
> 
> +const char *elf_hwcap_str(uint32_t bit)
> +{
> +    static const char *hwcap_str[] = {
> +    [__builtin_ctz(ARM_HWCAP_A64_FP      )] = "fp",
> +    [__builtin_ctz(ARM_HWCAP_A64_ASIMD   )] = "asimd",
> +    [__builtin_ctz(ARM_HWCAP_A64_EVTSTRM )] = "evtstrm",
> +    [__builtin_ctz(ARM_HWCAP_A64_AES     )] = "aes",
> +    [__builtin_ctz(ARM_HWCAP_A64_PMULL   )] = "pmull",
> +    [__builtin_ctz(ARM_HWCAP_A64_SHA1    )] = "sha1",
> +    [__builtin_ctz(ARM_HWCAP_A64_SHA2    )] = "sha2",
> +    [__builtin_ctz(ARM_HWCAP_A64_CRC32   )] = "crc32",
> +    [__builtin_ctz(ARM_HWCAP_A64_ATOMICS )] = "atomics",
> +    [__builtin_ctz(ARM_HWCAP_A64_FPHP    )] = "fphp",
> +    [__builtin_ctz(ARM_HWCAP_A64_ASIMDHP )] = "asimdhp",
> +    [__builtin_ctz(ARM_HWCAP_A64_CPUID   )] = "cpuid",
> +    [__builtin_ctz(ARM_HWCAP_A64_ASIMDRDM)] = "asimdrdm",
> +    [__builtin_ctz(ARM_HWCAP_A64_JSCVT   )] = "jscvt",
> +    [__builtin_ctz(ARM_HWCAP_A64_FCMA    )] = "fcma",
> +    [__builtin_ctz(ARM_HWCAP_A64_LRCPC   )] = "lrcpc",
> +    [__builtin_ctz(ARM_HWCAP_A64_DCPOP   )] = "dcpop",
> +    [__builtin_ctz(ARM_HWCAP_A64_SHA3    )] = "sha3",
> +    [__builtin_ctz(ARM_HWCAP_A64_SM3     )] = "sm3",
> +    [__builtin_ctz(ARM_HWCAP_A64_SM4     )] = "sm4",
> +    [__builtin_ctz(ARM_HWCAP_A64_ASIMDDP )] = "asimddp",
> +    [__builtin_ctz(ARM_HWCAP_A64_SHA512  )] = "sha512",
> +    [__builtin_ctz(ARM_HWCAP_A64_SVE     )] = "sve",
> +    [__builtin_ctz(ARM_HWCAP_A64_ASIMDFHM)] = "asimdfhm",
> +    [__builtin_ctz(ARM_HWCAP_A64_DIT     )] = "dit",
> +    [__builtin_ctz(ARM_HWCAP_A64_USCAT   )] = "uscat",
> +    [__builtin_ctz(ARM_HWCAP_A64_ILRCPC  )] = "ilrcpc",
> +    [__builtin_ctz(ARM_HWCAP_A64_FLAGM   )] = "flagm",
> +    [__builtin_ctz(ARM_HWCAP_A64_SSBS    )] = "ssbs",
> +    [__builtin_ctz(ARM_HWCAP_A64_SB      )] = "sb",
> +    [__builtin_ctz(ARM_HWCAP_A64_PACA    )] = "paca",
> +    [__builtin_ctz(ARM_HWCAP_A64_PACG    )] = "pacg",
> +    };
> +
> +    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
> +}
> +
> +const char *elf_hwcap2_str(uint32_t bit)
> +{
> +    static const char *hwcap_str[] = {
> +    [__builtin_ctz(ARM_HWCAP2_A64_DCPODP       )] = "dcpodp",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVE2         )] = "sve2",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVEAES       )] = "sveaes",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVEPMULL     )] = "svepmull",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVEBITPERM   )] = "svebitperm",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVESHA3      )] = "svesha3",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVESM4       )] = "svesm4",
> +    [__builtin_ctz(ARM_HWCAP2_A64_FLAGM2       )] = "flagm2",
> +    [__builtin_ctz(ARM_HWCAP2_A64_FRINT        )] = "frint",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVEI8MM      )] = "svei8mm",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVEF32MM     )] = "svef32mm",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVEF64MM     )] = "svef64mm",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SVEBF16      )] = "svebf16",
> +    [__builtin_ctz(ARM_HWCAP2_A64_I8MM         )] = "i8mm",
> +    [__builtin_ctz(ARM_HWCAP2_A64_BF16         )] = "bf16",
> +    [__builtin_ctz(ARM_HWCAP2_A64_DGH          )] = "dgh",
> +    [__builtin_ctz(ARM_HWCAP2_A64_RNG          )] = "rng",
> +    [__builtin_ctz(ARM_HWCAP2_A64_BTI          )] = "bti",
> +    [__builtin_ctz(ARM_HWCAP2_A64_MTE          )] = "mte",
> +    [__builtin_ctz(ARM_HWCAP2_A64_ECV          )] = "ecv",
> +    [__builtin_ctz(ARM_HWCAP2_A64_AFP          )] = "afp",
> +    [__builtin_ctz(ARM_HWCAP2_A64_RPRES        )] = "rpres",
> +    [__builtin_ctz(ARM_HWCAP2_A64_MTE3         )] = "mte3",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME          )] = "sme",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME_I16I64   )] = "sme_i16i64",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME_F64F64   )] = "sme_f64f64",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME_I8I32    )] = "sme_i8i32",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME_F16F32   )] = "sme_f16f32",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] = "sme_b16f32",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] = "sme_f32f32",
> +    [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] = "sme_fa64",
> +    };
> +
> +    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
> +}
> +
>   #undef GET_FEATURE_ID
> 
>   #endif /* not TARGET_AARCH64 */
> diff --git a/linux-user/loader.h b/linux-user/loader.h
> index 59cbeacf24..324e5c872a 100644
> --- a/linux-user/loader.h
> +++ b/linux-user/loader.h
> @@ -56,9 +56,13 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
> 
>   extern unsigned long guest_stack_size;
> 
> -#ifdef TARGET_S390X
> +#if defined(TARGET_S390X) || defined(TARGET_AARCH64) || defined(TARGET_ARM)
>   uint32_t get_elf_hwcap(void);
>   const char *elf_hwcap_str(uint32_t bit);
>   #endif
> +#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
> +uint32_t get_elf_hwcap2(void);
> +const char *elf_hwcap2_str(uint32_t bit);
> +#endif
> 
>   #endif /* LINUX_USER_LOADER_H */
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1ec7d27e37..bac764f502 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8323,7 +8323,8 @@ void target_exception_dump(CPUArchState *env, const char *fmt, int code)
> 
>   #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN || \
>       defined(TARGET_SPARC) || defined(TARGET_M68K) || defined(TARGET_HPPA) || \
> -    defined(TARGET_RISCV) || defined(TARGET_S390X)
> +    defined(TARGET_RISCV) || defined(TARGET_S390X) || defined(TARGET_ARM) || \
> +    defined(TARGET_AARCH64)
>   static int is_proc(const char *filename, const char *entry)
>   {
>       return strcmp(filename, entry) == 0;
> @@ -8539,6 +8540,76 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
>   }
>   #endif
> 
> +#if defined(TARGET_AARCH64) || defined(TARGET_ARM)
> +static int open_cpuinfo(CPUArchState *cpu_env, int fd)
> +{
> +    ARMCPU *cpu = ARM_CPU(thread_cpu);
> +    const int rev  = FIELD_EX64(cpu->midr, MIDR_EL1, REVISION);
> +    int arch, is64;
> +    uint32_t elf_hwcap = get_elf_hwcap();
> +    uint32_t elf_hwcap2 = get_elf_hwcap2();
> +    const char *hwcap_str;
> +    int i, j, num_cpus;
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
> +        arch = 8;
> +    } else if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +        arch = 7;
> +    } else if (arm_feature(&cpu->env, ARM_FEATURE_V6)) {
> +        arch = 6;
> +    } else if (arm_feature(&cpu->env, ARM_FEATURE_V5)) {
> +        arch = 5;
> +    } else {
> +        arch = 4;
> +    }
> +    is64 = (arch >= 8) ? 1 : 0;

No, there's 32-bit armv8 as well.  Either

     is64 = is_a64(&cpu->env);

or

#ifdef TARGET_AARCH64
     is64 = true;
#endif


r~


> +
> +    num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +    for (i = 0; i < num_cpus; i++) {
> +        dprintf(fd, "processor\t: %d\n", i);
> +        dprintf(fd, "model name\t: ARMv%d Processor rev %d (%sv%d%c)\n",
> +            arch, rev, is64 ? "" : "arm", arch, TARGET_BIG_ENDIAN ? 'b' : 'l');
> +        dprintf(fd, "BogoMIPS\t: %d.00\n", is64 ? 100 : 50);
> +        dprintf(fd, "Features\t:");
> +        for (j = 0; j < sizeof(elf_hwcap) * 8; j++) {
> +            if (!(elf_hwcap & (1 << j))) {
> +                continue;
> +            }
> +            hwcap_str = elf_hwcap_str(j);
> +            if (hwcap_str) {
> +                dprintf(fd, " %s", hwcap_str);
> +            }
> +        }
> +        for (j = 0; j < sizeof(elf_hwcap2) * 8; j++) {
> +            if (!(elf_hwcap2 & (1 << j))) {
> +                continue;
> +            }
> +            hwcap_str = elf_hwcap2_str(j);
> +            if (hwcap_str) {
> +                dprintf(fd, " %s", hwcap_str);
> +            }
> +        }
> +        dprintf(fd, "\n");
> +        dprintf(fd, "CPU implementer\t: %#02x\n",
> +                (unsigned int) FIELD_EX64(cpu->midr, MIDR_EL1, IMPLEMENTER));
> +        dprintf(fd, "CPU architecture: %d\n", arch);
> +        dprintf(fd, "CPU variant\t: %#x\n",
> +                (unsigned int) FIELD_EX64(cpu->midr, MIDR_EL1, VARIANT));
> +        dprintf(fd, "CPU part\t: %#03x\n",
> +                (unsigned int) FIELD_EX64(cpu->midr, MIDR_EL1, PARTNUM));
> +        dprintf(fd, "CPU revision\t: %d\n\n", rev);
> +    }
> +
> +    dprintf(fd, "Hardware\t: QEMU v%s %s\n", QEMU_VERSION,
> +                cpu->dtb_compatible ? : "");
> +    if (!is64) {
> +        dprintf(fd, "Revision\t: 0000\n");
> +        dprintf(fd, "Serial\t\t: 0000000000000000\n");
> +    }
> +
> +    return 0;
> +}
> +#endif
> 
>   int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>                       int flags, mode_t mode, bool safe)
> @@ -8561,7 +8632,8 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
>           { "/proc/net/route", open_net_route, is_proc },
>   #endif
>   #if defined(TARGET_SPARC) || defined(TARGET_HPPA) || \
> -    defined(TARGET_RISCV) || defined(TARGET_S390X)
> +    defined(TARGET_RISCV) || defined(TARGET_S390X) || \
> +    defined(TARGET_ARM)   || defined(TARGET_AARCH64)
>           { "/proc/cpuinfo", open_cpuinfo, is_proc },
>   #endif
>   #if defined(TARGET_M68K)
> --
> 2.41.0
> 


