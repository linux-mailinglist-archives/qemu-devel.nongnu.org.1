Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D08A8AABC
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Apr 2025 00:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4oLh-0005kE-NS; Tue, 15 Apr 2025 18:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oLc-0005hG-Sl
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:01:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4oLZ-0007wH-Te
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 18:01:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227b828de00so56669035ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744754496; x=1745359296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bsxD2DryWZbldm0yS7PH7SBc4w6ylXKHtZU7k7QObrc=;
 b=mH7NfH9waGq1RRUMxU2CdEh4zM5EKKfnNXE8ZM5A3LIU2tMyLpTnwmdPab1aAeH+iH
 JJfGGeW1BA1orTeb9vAkPF6AgerXMoE+JPog91JnIJgMNiCUIDxQYuU4IbyJnLsVNDX7
 9ZPfTqJtsMa83qu5TizCh9PwsviJ+Ysp1SKySxpquRPwcJKdbh9heNR3FBsdJ2r1pQP2
 aZSMxyiOlSikXtMKilVki1AFrDf3rw5Bc6M+cHECP2eXPvuRbb6ffIUIZTSija2Sh/BZ
 jOzIwD6JY12VRGSzZmf1bAKqkWB+YVJcnG3OAQMlRG/6RtqBWZFxUSgWFuP1U7heh1dC
 77/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744754496; x=1745359296;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsxD2DryWZbldm0yS7PH7SBc4w6ylXKHtZU7k7QObrc=;
 b=ulQP6s59SeUfX189aDdr2BEEzGrkOhgsLstH+Q51T+aeheBeDuTeZGQBvQ8ccVXa4J
 hKdusptnB1XKdiY4RtQuztZ2HxxrIniAlQwoLXZYDKKqK7cw14eShr61+RPXv1UN0PVd
 0YbmuqqGe104G09TWoBLYjeyb0DPhL0j/nIBMH+CaTG9XGHHbjADpIUOcueRxYkIG1OE
 5qmN5MO3F1HQg0ZhuUqudNg0UZM/Pck9FVitjZRvEHy0D0Boky6bz0evj8wMkIfuE2iL
 hVjBfPAUlsjcul85iwcEiWSlLj4wuBbWvVhZSch60gWN5O5wwzjQ9ZvXHqOW6b2YKlFa
 aDvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVhos4NyWx1BrRl6cCCwb9D5+8v1I/QPaHWFrWRmC1r8BglBd3CQFajqB6gO+xsVeeVgNIEngwjVsf@nongnu.org
X-Gm-Message-State: AOJu0Yyqs8QC6uCgJz+7OCo8WK9VDQqu9Pbo/RgIKFZfXIhdsNz0gR9w
 WLu5n+9w0NcQ66FoGcbEsHlI5/wavvQ9nUDjs1jKP9auGkiihim2zsTVPaX+4a2azyqrgsYhLPL
 HYqE=
X-Gm-Gg: ASbGncuGdS2l2pEIDQJ7lVQ9K068sm4Or4gL3nR7Htmb5e2EzE347ItRJ5z2hZNcrH6
 TycE++wxctEJn+WKFjE3LiJsncArH2YDE8Xx1kaVSHCAM4u6VnbymdbQQu6L8I+qs5sGH/RnQ7z
 S5tbUy0nkGMzRuaP0v704lKeLnAgFvJULajxlJHA22UbReku/TuSZ+E+WdgwotAAWkUfl8/sZrw
 HNJiqv1TXjwp8STar4iDoAoGE3E6ajOn21o71AcvwiD3ZmS0A/hAjjfXRGcHFgW+j+2fh8QM6iQ
 vyTo1yabI57PsMIWl215/PvLuV6HQGfl6U5YHxI0p7ZtQTPbM438qQ==
X-Google-Smtp-Source: AGHT+IF0PWZ+tOAIJ1vsEm8wEHjzbVJadwaXn+ekQO9pvba8GlFZZbRKITYeb4s6UkIqeMR9RP59fw==
X-Received: by 2002:a17:903:1946:b0:224:c76:5e56 with SMTP id
 d9443c01a7336-22c319fe23bmr9158365ad.27.1744754496094; 
 Tue, 15 Apr 2025 15:01:36 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fa5e9esm218745ad.132.2025.04.15.15.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 15:01:35 -0700 (PDT)
Message-ID: <ff0a3501-b547-4a4b-bb1a-5fc3f1dbd2cb@linaro.org>
Date: Tue, 15 Apr 2025 15:01:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 104/163] tcg: Convert extract2 to TCGOutOpExtract2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-105-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-105-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  6 -----
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/tcg-op.c                     | 12 +++++-----
>   tcg/tcg.c                        | 24 ++++++++++++++++----
>   tcg/aarch64/tcg-target.c.inc     | 20 +++++++++--------
>   tcg/arm/tcg-target.c.inc         | 38 ++++++++++++--------------------
>   tcg/i386/tcg-target.c.inc        | 25 ++++++++++++---------
>   tcg/loongarch64/tcg-target.c.inc |  5 +++++
>   tcg/mips/tcg-target.c.inc        |  5 +++++
>   tcg/ppc/tcg-target.c.inc         |  4 ++++
>   tcg/riscv/tcg-target.c.inc       |  5 +++++
>   tcg/s390x/tcg-target.c.inc       |  4 ++++
>   tcg/sparc64/tcg-target.c.inc     |  4 ++++
>   tcg/tci/tcg-target.c.inc         |  4 ++++
>   23 files changed, 97 insertions(+), 77 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
> index 82d8cd5965..011a91c263 100644
> --- a/tcg/aarch64/tcg-target-has.h
> +++ b/tcg/aarch64/tcg-target-has.h
> @@ -13,13 +13,11 @@
>   #define have_lse2   (cpuinfo & CPUINFO_LSE2)
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32     1
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_extr_i64_i32     0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
> -#define TCG_TARGET_HAS_extract2_i64     1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
>   
> diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
> index c85b5da1e5..0d6a785542 100644
> --- a/tcg/arm/tcg-target-has.h
> +++ b/tcg/arm/tcg-target-has.h
> @@ -24,7 +24,6 @@ extern bool use_neon_instructions;
>   #endif
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32     1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
> diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
> index 6b91b23fe8..0328102c2a 100644
> --- a/tcg/i386/tcg-target-has.h
> +++ b/tcg/i386/tcg-target-has.h
> @@ -26,14 +26,12 @@
>   #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32     1
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
>   
>   #if TCG_TARGET_REG_BITS == 64
>   /* Keep 32-bit values zero-extended in a register.  */
>   #define TCG_TARGET_HAS_extr_i64_i32     1
> -#define TCG_TARGET_HAS_extract2_i64     1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
> index 10090102f7..a1bd71db6a 100644
> --- a/tcg/loongarch64/tcg-target-has.h
> +++ b/tcg/loongarch64/tcg-target-has.h
> @@ -10,13 +10,11 @@
>   #include "host/cpuinfo.h"
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_add2_i32         0
>   #define TCG_TARGET_HAS_sub2_i32         0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   /* 64-bit operations */
> -#define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_extr_i64_i32     1
>   #define TCG_TARGET_HAS_add2_i64         0
>   #define TCG_TARGET_HAS_sub2_i64         0
> diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
> index 24b00f1eec..48a1e68fbe 100644
> --- a/tcg/mips/tcg-target-has.h
> +++ b/tcg/mips/tcg-target-has.h
> @@ -51,13 +51,7 @@ extern bool use_mips32r2_instructions;
>   #endif
>   
>   /* optional instructions detected at runtime */
> -#define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> -
> -#if TCG_TARGET_REG_BITS == 64
> -#define TCG_TARGET_HAS_extract2_i64     0
> -#endif
> -
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>   #define TCG_TARGET_HAS_tst              0
>   
> diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
> index bd9c3d92ed..033d58e095 100644
> --- a/tcg/ppc/tcg-target-has.h
> +++ b/tcg/ppc/tcg-target-has.h
> @@ -17,14 +17,12 @@
>   #define have_vsx       (cpuinfo & CPUINFO_VSX)
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_add2_i32         0
>   #define TCG_TARGET_HAS_sub2_i32         0
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
>   #endif
> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
> index 88fadc2428..b2814f8ef9 100644
> --- a/tcg/riscv/tcg-target-has.h
> +++ b/tcg/riscv/tcg-target-has.h
> @@ -10,12 +10,10 @@
>   #include "host/cpuinfo.h"
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
> -#define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_extr_i64_i32     1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
> index 95407f61cf..4a2b71995d 100644
> --- a/tcg/s390x/tcg-target-has.h
> +++ b/tcg/s390x/tcg-target-has.h
> @@ -29,13 +29,11 @@ extern uint64_t s390_facilities[3];
>       ((s390_facilities[FACILITY_##X / 64] >> (63 - FACILITY_##X % 64)) & 1)
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32   0
>   #define TCG_TARGET_HAS_add2_i32       1
>   #define TCG_TARGET_HAS_sub2_i32       1
>   #define TCG_TARGET_HAS_extr_i64_i32   0
>   #define TCG_TARGET_HAS_qemu_st8_i32   0
>   
> -#define TCG_TARGET_HAS_extract2_i64   0
>   #define TCG_TARGET_HAS_add2_i64       1
>   #define TCG_TARGET_HAS_sub2_i64       1
>   
> diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
> index 2ced6f7c1c..b8760dd154 100644
> --- a/tcg/sparc64/tcg-target-has.h
> +++ b/tcg/sparc64/tcg-target-has.h
> @@ -14,13 +14,11 @@ extern bool use_vis3_instructions;
>   #endif
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
>   
> diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
> index 21bef070fe..6125ac677c 100644
> --- a/tcg/tcg-has.h
> +++ b/tcg/tcg-has.h
> @@ -12,7 +12,6 @@
>   #if TCG_TARGET_REG_BITS == 32
>   /* Turn some undef macros into false macros.  */
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_add2_i64         0
>   #define TCG_TARGET_HAS_sub2_i64         0
>   /* Turn some undef macros into true macros.  */
> diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
> index 90aa5c8bbb..4cb2b529ae 100644
> --- a/tcg/tci/tcg-target-has.h
> +++ b/tcg/tci/tcg-target-has.h
> @@ -7,12 +7,10 @@
>   #ifndef TCG_TARGET_HAS_H
>   #define TCG_TARGET_HAS_H
>   
> -#define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_add2_i64         1
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 961a39f446..5f95350d5d 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -921,7 +921,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
>   
>       t1 = tcg_temp_ebb_new_i32();
>   
> -    if (TCG_TARGET_HAS_extract2_i32) {
> +    if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
>           if (ofs + len == 32) {
>               tcg_gen_shli_i32(t1, arg1, len);
>               tcg_gen_extract2_i32(ret, t1, arg2, len);
> @@ -1077,7 +1077,7 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
>           tcg_gen_mov_i32(ret, ah);
>       } else if (al == ah) {
>           tcg_gen_rotri_i32(ret, al, ofs);
> -    } else if (TCG_TARGET_HAS_extract2_i32) {
> +    } else if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
>           tcg_gen_op4i_i32(INDEX_op_extract2_i32, ret, al, ah, ofs);
>       } else {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> @@ -1799,7 +1799,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
>               tcg_gen_movi_i32(TCGV_LOW(ret), 0);
>           }
>       } else if (right) {
> -        if (TCG_TARGET_HAS_extract2_i32) {
> +        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
>               tcg_gen_extract2_i32(TCGV_LOW(ret),
>                                    TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
>           } else {
> @@ -1813,7 +1813,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
>               tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
>           }
>       } else {
> -        if (TCG_TARGET_HAS_extract2_i32) {
> +        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
>               tcg_gen_extract2_i32(TCGV_HIGH(ret),
>                                    TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
>           } else {
> @@ -2553,7 +2553,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
>   
>       t1 = tcg_temp_ebb_new_i64();
>   
> -    if (TCG_TARGET_HAS_extract2_i64) {
> +    if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
>           if (ofs + len == 64) {
>               tcg_gen_shli_i64(t1, arg1, len);
>               tcg_gen_extract2_i64(ret, t1, arg2, len);
> @@ -2781,7 +2781,7 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
>           tcg_gen_mov_i64(ret, ah);
>       } else if (al == ah) {
>           tcg_gen_rotri_i64(ret, al, ofs);
> -    } else if (TCG_TARGET_HAS_extract2_i64) {
> +    } else if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
>           tcg_gen_op4i_i64(INDEX_op_extract2_i64, ret, al, ah, ofs);
>       } else {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 7d398354a2..f34f9cdd13 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1029,6 +1029,12 @@ typedef struct TCGOutOpExtract {
>                      unsigned ofs, unsigned len);
>   } TCGOutOpExtract;
>   
> +typedef struct TCGOutOpExtract2 {
> +    TCGOutOp base;
> +    void (*out_rrr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                    TCGReg a2, unsigned shr);
> +} TCGOutOpExtract2;
> +
>   typedef struct TCGOutOpMovcond {
>       TCGOutOp base;
>       void (*out)(TCGContext *s, TCGType type, TCGCond cond,
> @@ -1140,6 +1146,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
>       OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
>       OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
> +    OUTOP(INDEX_op_extract2_i32, TCGOutOpExtract2, outop_extract2),
> +    OUTOP(INDEX_op_extract2_i64, TCGOutOpExtract2, outop_extract2),
>       OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
>       OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
>       OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
> @@ -2399,8 +2407,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i32:
>           return true;
>   
> -    case INDEX_op_extract2_i32:
> -        return TCG_TARGET_HAS_extract2_i32;
>       case INDEX_op_add2_i32:
>           return TCG_TARGET_HAS_add2_i32;
>       case INDEX_op_sub2_i32:
> @@ -2427,8 +2433,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_extrh_i64_i32:
>           return TCG_TARGET_REG_BITS == 64;
>   
> -    case INDEX_op_extract2_i64:
> -        return TCG_TARGET_HAS_extract2_i64;
>       case INDEX_op_add2_i64:
>           return TCG_TARGET_HAS_add2_i64;
>       case INDEX_op_sub2_i64:
> @@ -5590,6 +5594,18 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           }
>           break;
>   
> +    case INDEX_op_extract2_i32:
> +    case INDEX_op_extract2_i64:
> +        {
> +            const TCGOutOpExtract2 *out = &outop_extract2;
> +
> +            tcg_debug_assert(!const_args[1]);
> +            tcg_debug_assert(!const_args[2]);
> +            out->out_rrr(s, type, new_args[0], new_args[1],
> +                         new_args[2], new_args[3]);
> +        }
> +        break;
> +
>       case INDEX_op_muls2:
>       case INDEX_op_mulu2:
>           {
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index dee4afcce1..bece494c55 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2634,6 +2634,17 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static void tgen_extract2(TCGContext *s, TCGType type, TCGReg a0,
> +                          TCGReg a1, TCGReg a2, unsigned shr)
> +{
> +    tcg_out_extr(s, type, a0, a2, a1, shr);
> +}
> +
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_O1_I2(r, rz, rz),
> +    .out_rrr = tgen_extract2,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -2714,11 +2725,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
>           tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
>           break;
>   
> -    case INDEX_op_extract2_i64:
> -    case INDEX_op_extract2_i32:
> -        tcg_out_extr(s, ext, a0, a2, a1, args[3]);
> -        break;
> -
>       case INDEX_op_add2_i32:
>           tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
>                           (int32_t)args[4], args[5], const_args[4],
> @@ -3231,10 +3237,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_qemu_st_i128:
>           return C_O0_I3(rz, rz, r);
>   
> -    case INDEX_op_extract2_i32:
> -    case INDEX_op_extract2_i64:
> -        return C_O1_I2(r, rz, rz);
> -
>       case INDEX_op_add2_i32:
>       case INDEX_op_add2_i64:
>       case INDEX_op_sub2_i32:
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 2bf6bfe274..f366424af5 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -2317,6 +2317,20 @@ static const TCGOutOpSetcond2 outop_setcond2 = {
>       .out = tgen_setcond2,
>   };
>   
> +static void tgen_extract2(TCGContext *s, TCGType type, TCGReg a0,
> +                          TCGReg a1, TCGReg a2, unsigned shr)
> +{
> +    /* We can do extract2 in 2 insns, vs the 3 required otherwise.  */
> +    tgen_shli(s, TCG_TYPE_I32, TCG_REG_TMP, a2, 32 - shr);
> +    tcg_out_dat_reg(s, COND_AL, ARITH_ORR, a0, TCG_REG_TMP,
> +                    a1, SHIFT_IMM_LSR(shr));
> +}
> +
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_O1_I2(r, r, r),
> +    .out_rrr = tgen_extract2,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> @@ -2411,28 +2425,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
>           break;
>   
> -    case INDEX_op_extract2_i32:
> -        /* ??? These optimization vs zero should be generic.  */
> -        /* ??? But we can't substitute 2 for 1 in the opcode stream yet.  */
> -        if (const_args[1]) {
> -            if (const_args[2]) {
> -                tcg_out_movi(s, TCG_TYPE_REG, args[0], 0);
> -            } else {
> -                tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
> -                                args[2], SHIFT_IMM_LSL(32 - args[3]));
> -            }
> -        } else if (const_args[2]) {
> -            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, args[0], 0,
> -                            args[1], SHIFT_IMM_LSR(args[3]));
> -        } else {
> -            /* We can do extract2 in 2 insns, vs the 3 required otherwise.  */
> -            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0,
> -                            args[2], SHIFT_IMM_LSL(32 - args[3]));
> -            tcg_out_dat_reg(s, COND_AL, ARITH_ORR, args[0], TCG_REG_TMP,
> -                            args[1], SHIFT_IMM_LSR(args[3]));
> -        }
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, args[0]);
>           break;
> @@ -2464,8 +2456,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i32:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_extract2_i32:
> -        return C_O1_I2(r, rZ, rZ);
>       case INDEX_op_add2_i32:
>           return C_O2_I4(r, r, r, r, rIN, rIK);
>       case INDEX_op_sub2_i32:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 1dd9741f45..2b2ad9ca95 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -3261,6 +3261,21 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static void tgen_extract2(TCGContext *s, TCGType type, TCGReg a0,
> +                          TCGReg a1, TCGReg a2, unsigned shr)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +
> +    /* Note that SHRD outputs to the r/m operand.  */
> +    tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
> +    tcg_out8(s, shr);
> +}
> +
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_O1_I2(r, 0, r),
> +    .out_rrr = tgen_extract2,
> +};
> +
>   
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
> @@ -3414,12 +3429,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           break;
>   #endif
>   
> -    OP_32_64(extract2):
> -        /* Note that SHRD outputs to the r/m operand.  */
> -        tcg_out_modrm(s, OPC_SHRD_Ib + rexw, a2, a0);
> -        tcg_out8(s, args[3]);
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, a0);
>           break;
> @@ -4008,10 +4017,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(re, r);
>   
> -    case INDEX_op_extract2_i32:
> -    case INDEX_op_extract2_i64:
> -        return C_O1_I2(r, 0, r);
> -
>       case INDEX_op_add2_i32:
>       case INDEX_op_add2_i64:
>       case INDEX_op_sub2_i32:
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index fcede3dd9f..735dcc117a 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1856,6 +1856,11 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index cd648ab1df..7fae1c51e9 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -2273,6 +2273,11 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index fc92a4896d..a964239aab 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3495,6 +3495,10 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 371e0c24c8..d74ac7587a 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2542,6 +2542,11 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index d72393315d..ff06834e6e 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -1637,6 +1637,10 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
>   {
>       ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 741de260e9..4c7d916302 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1795,6 +1795,10 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tgen_sextract,
>   };
>   
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index ef14e81609..9a5ca9c778 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -447,6 +447,10 @@ static const TCGOutOpExtract outop_sextract = {
>       .out_rr = tcg_out_sextract,
>   };
>   
> +static const TCGOutOpExtract2 outop_extract2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
>   {
>       tcg_out_sextract(s, type, rd, rs, 0, 8);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


