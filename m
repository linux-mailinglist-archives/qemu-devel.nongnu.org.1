Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F53A8A9FA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 23:19:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ngT-0003yJ-Sh; Tue, 15 Apr 2025 17:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ngJ-0003mo-GN
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:19:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ng9-0003hK-SD
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:18:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso5835195b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751928; x=1745356728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R16CGq/HjDcixOsdAo2rPq4HDUMrUf2MFZyWFmJbr+w=;
 b=PVRpBzMyAqjR8V9eWoff62eFNFX7n7/TrZbUBu8yJpSRe8ROjIS7rnxBUgeQ6xhW0D
 SSRtgIO/AeyNgfk8f28Gd5D9yi+KOp6VSrlyVH6ibrG25Wln0ruWb46UcqTbCyZnY9X9
 Y9DCDNcyYOrOQS597BXgUKve+XnYnF+5WF+cBySucLUF+QvWxRw+/Jm/lu1giICwtQ+3
 NzghAewhE/w49vuxsBlPkCEN82ojzZ8edG0F9YtNKeWJG4yYlC1JL0OqBh4CN6ejhVhu
 eBhtmLy2uO4gNYDqGTRa6I6bFMaijl+VRlRJsKHIA72QPkm4dEX7rq+Icj75KB3G+iDq
 ADrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751928; x=1745356728;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R16CGq/HjDcixOsdAo2rPq4HDUMrUf2MFZyWFmJbr+w=;
 b=tzlji/T0BnPDIm+FpUDRbycwG9AM7jbY4R0Sca+3NJxUhQEzZdhJGj/SN8Iqg3xlIB
 JYyFPr6wIZ7zhx8qnm+Nbkk0hCefP41vfaAuyat3DfqR8EMGk2k2kbDS5Fuor48S6yqA
 8TGwSyRe3RF7z8zHqUHN04VsP7b/gok6o3qFD1NQp6eq7lJiCTxt9rbVBIPJeTSJ8zIX
 SlzvPij7hckKnmL8CdwUvkzORBosm/NhU3+VEWLLj3Yf7rQUJO7cvonSPa/00FPs5TOL
 KtF28LdbnV+GUXMt7r1rN+261JCHTd//FwKwNf0k7HDmK04xuDlJyRzzukVkyx9M/Ptk
 2yUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ostHSXaZmiSPrxYQ6K9bWuLXGVfemIu92qPQlvcn/rFRQ5bFawMTBqPodFUKn0g8830v3YrCykAF@nongnu.org
X-Gm-Message-State: AOJu0YyOpQAa+nO/OVsfPcoztNbWxoKkeBlwcRoK1xvdjb0rLILvOb/+
 V3dJrFx4IU9V6MyY2WY3bk8nqLsa/2RILz91BMaVwjrBJR+uCAsZgBXZTirIPGo=
X-Gm-Gg: ASbGncsgkOV2B6/QuhR5HP1xyYew5AD8+HH9fI3JZa67D0g11YZWsNz9SNYqhwavRXj
 +tZcwNDq0o1Q+SdqS37tyQng9WngF2sfgFE+lfYSrTFhsNZ1gfNmG5bSDCEDfrxT216PAd+Xsn9
 xGW15jeFbn/W9zkfSQidtpg9yIBX3wyYf/rwx5oH2KVym5YUbtqVygZjdUUq0bYP5/TDE0XCBjg
 5rOmfR1IIlHq0jY0DXdFMz+p+IKYnJxWDSADIQJXcmfpnCv+Tut39pCoiXVu6Xyu0XSfyaxhaD0
 wjK4cppNm78GSa76hyRRQU4qr0P1M+jRu9r5LUZ/RjV54WUjtAJpIg==
X-Google-Smtp-Source: AGHT+IEXXvlVJuJi1PPJvIOedx77u5yN2Z39XwC6/dAjnyBtqNaqjL0KCRI5v/UbERl18BY6gYL9Wg==
X-Received: by 2002:a05:6a20:d04a:b0:1f5:9393:fd4d with SMTP id
 adf61e73a8af0-203ae04ccf7mr711574637.27.1744751927925; 
 Tue, 15 Apr 2025 14:18:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220ad44dsm674a12.7.2025.04.15.14.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:18:47 -0700 (PDT)
Message-ID: <568c24d8-e338-47c9-90d8-3e88830a322a@linaro.org>
Date: Tue, 15 Apr 2025 14:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 070/163] tcg: Convert mulu2 to TCGOutOpMul2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-71-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-71-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/15/25 12:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-con-set.h |  1 -
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  4 ----
>   tcg/tcg-op.c                     |  8 ++++----
>   tcg/tcg.c                        |  8 ++++----
>   tcg/tci.c                        | 23 ++++++++++-------------
>   tcg/aarch64/tcg-target.c.inc     |  4 ++++
>   tcg/arm/tcg-target.c.inc         | 27 +++++++++++++--------------
>   tcg/i386/tcg-target.c.inc        | 19 ++++++++++++-------
>   tcg/loongarch64/tcg-target.c.inc |  4 ++++
>   tcg/mips/tcg-target.c.inc        | 29 +++++++++++++++--------------
>   tcg/ppc/tcg-target.c.inc         |  4 ++++
>   tcg/riscv/tcg-target.c.inc       |  4 ++++
>   tcg/s390x/tcg-target.c.inc       | 31 +++++++++++++++++++++----------
>   tcg/sparc64/tcg-target.c.inc     | 23 ++++++++++++++---------
>   tcg/tci/tcg-target.c.inc         | 21 +++++++++++++--------
>   25 files changed, 122 insertions(+), 106 deletions(-)
> 
> diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
> index c351db223d..0c370d7dda 100644
> --- a/tcg/aarch64/tcg-target-has.h
> +++ b/tcg/aarch64/tcg-target-has.h
> @@ -19,7 +19,6 @@
>   #define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
> -#define TCG_TARGET_HAS_mulu2_i32        0
>   #define TCG_TARGET_HAS_extr_i64_i32     0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
> @@ -30,7 +29,6 @@
>   #define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> -#define TCG_TARGET_HAS_mulu2_i64        0
>   
>   /*
>    * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
> diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
> index e1f19ffbc9..ccbc39a23e 100644
> --- a/tcg/arm/tcg-target-has.h
> +++ b/tcg/arm/tcg-target-has.h
> @@ -28,7 +28,6 @@ extern bool use_neon_instructions;
>   #define TCG_TARGET_HAS_bswap32_i32      1
>   #define TCG_TARGET_HAS_extract2_i32     1
>   #define TCG_TARGET_HAS_negsetcond_i32   1
> -#define TCG_TARGET_HAS_mulu2_i32        1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
> diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
> index d63b3a3a89..c92a049fd7 100644
> --- a/tcg/i386/tcg-target-has.h
> +++ b/tcg/i386/tcg-target-has.h
> @@ -32,7 +32,6 @@
>   #define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
> -#define TCG_TARGET_HAS_mulu2_i32        1
>   
>   #if TCG_TARGET_REG_BITS == 64
>   /* Keep 32-bit values zero-extended in a register.  */
> @@ -44,7 +43,6 @@
>   #define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> -#define TCG_TARGET_HAS_mulu2_i64        1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   #else
>   #define TCG_TARGET_HAS_qemu_st8_i32     1
> diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
> index 491ebf0d06..12a721b4da 100644
> --- a/tcg/loongarch64/tcg-target-has.h
> +++ b/tcg/loongarch64/tcg-target-has.h
> @@ -14,7 +14,6 @@
>   #define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_add2_i32         0
>   #define TCG_TARGET_HAS_sub2_i32         0
> -#define TCG_TARGET_HAS_mulu2_i32        0
>   #define TCG_TARGET_HAS_bswap16_i32      1
>   #define TCG_TARGET_HAS_bswap32_i32      1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> @@ -28,7 +27,6 @@
>   #define TCG_TARGET_HAS_bswap64_i64      1
>   #define TCG_TARGET_HAS_add2_i64         0
>   #define TCG_TARGET_HAS_sub2_i64         0
> -#define TCG_TARGET_HAS_mulu2_i64        0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
>   
> diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
> index fd0b674402..05701fd228 100644
> --- a/tcg/mips/tcg-target-has.h
> +++ b/tcg/mips/tcg-target-has.h
> @@ -39,7 +39,6 @@ extern bool use_mips32r2_instructions;
>   #endif
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_mulu2_i32        (!use_mips32r6_instructions)
>   #define TCG_TARGET_HAS_bswap16_i32      1
>   #define TCG_TARGET_HAS_bswap32_i32      1
>   #define TCG_TARGET_HAS_negsetcond_i32   0
> @@ -50,7 +49,6 @@ extern bool use_mips32r2_instructions;
>   #define TCG_TARGET_HAS_extr_i64_i32     1
>   #define TCG_TARGET_HAS_add2_i64         0
>   #define TCG_TARGET_HAS_sub2_i64         0
> -#define TCG_TARGET_HAS_mulu2_i64        (!use_mips32r6_instructions)
>   #define TCG_TARGET_HAS_ext32s_i64       1
>   #define TCG_TARGET_HAS_ext32u_i64       1
>   #define TCG_TARGET_HAS_negsetcond_i64   0
> diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
> index e711aa0731..5cc059fe9a 100644
> --- a/tcg/ppc/tcg-target-has.h
> +++ b/tcg/ppc/tcg-target-has.h
> @@ -21,7 +21,6 @@
>   #define TCG_TARGET_HAS_bswap32_i32      1
>   #define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_negsetcond_i32   1
> -#define TCG_TARGET_HAS_mulu2_i32        0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #if TCG_TARGET_REG_BITS == 64
> @@ -35,7 +34,6 @@
>   #define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> -#define TCG_TARGET_HAS_mulu2_i64        0
>   #endif
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   \
> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
> index 7e260da61e..9b86b8bf48 100644
> --- a/tcg/riscv/tcg-target-has.h
> +++ b/tcg/riscv/tcg-target-has.h
> @@ -14,7 +14,6 @@
>   #define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
> -#define TCG_TARGET_HAS_mulu2_i32        0
>   #define TCG_TARGET_HAS_bswap16_i32      (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_bswap32_i32      (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> @@ -27,7 +26,6 @@
>   #define TCG_TARGET_HAS_bswap64_i64      (cpuinfo & CPUINFO_ZBB)
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> -#define TCG_TARGET_HAS_mulu2_i64        0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>   
> diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
> index 52a76fc0b5..894a9f64e0 100644
> --- a/tcg/s390x/tcg-target-has.h
> +++ b/tcg/s390x/tcg-target-has.h
> @@ -35,7 +35,6 @@ extern uint64_t s390_facilities[3];
>   #define TCG_TARGET_HAS_negsetcond_i32 1
>   #define TCG_TARGET_HAS_add2_i32       1
>   #define TCG_TARGET_HAS_sub2_i32       1
> -#define TCG_TARGET_HAS_mulu2_i32      0
>   #define TCG_TARGET_HAS_extr_i64_i32   0
>   #define TCG_TARGET_HAS_qemu_st8_i32   0
>   
> @@ -46,7 +45,6 @@ extern uint64_t s390_facilities[3];
>   #define TCG_TARGET_HAS_negsetcond_i64 1
>   #define TCG_TARGET_HAS_add2_i64       1
>   #define TCG_TARGET_HAS_sub2_i64       1
> -#define TCG_TARGET_HAS_mulu2_i64      1
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128 1
>   
> diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
> index d2ea184fa2..85dcfbc375 100644
> --- a/tcg/sparc64/tcg-target-con-set.h
> +++ b/tcg/sparc64/tcg-target-con-set.h
> @@ -18,5 +18,4 @@ C_O1_I2(r, r, rJ)
>   C_O1_I2(r, rz, rJ)
>   C_O1_I4(r, rz, rJ, rI, 0)
>   C_O2_I2(r, r, r, r)
> -C_O2_I2(r, r, rz, rJ)
>   C_O2_I4(r, r, rz, rz, rJ, rJ)
> diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
> index dea0941cac..258c978b5e 100644
> --- a/tcg/sparc64/tcg-target-has.h
> +++ b/tcg/sparc64/tcg-target-has.h
> @@ -20,7 +20,6 @@ extern bool use_vis3_instructions;
>   #define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
> -#define TCG_TARGET_HAS_mulu2_i32        1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> @@ -31,7 +30,6 @@ extern bool use_vis3_instructions;
>   #define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> -#define TCG_TARGET_HAS_mulu2_i64        0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
>   
> diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
> index ac387b2544..d4fc7148b4 100644
> --- a/tcg/tcg-has.h
> +++ b/tcg/tcg-has.h
> @@ -19,7 +19,6 @@
>   #define TCG_TARGET_HAS_negsetcond_i64   0
>   #define TCG_TARGET_HAS_add2_i64         0
>   #define TCG_TARGET_HAS_sub2_i64         0
> -#define TCG_TARGET_HAS_mulu2_i64        0
>   /* Turn some undef macros into true macros.  */
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
> diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
> index a3d04b0ee2..2402889bec 100644
> --- a/tcg/tci/tcg-target-has.h
> +++ b/tcg/tci/tcg-target-has.h
> @@ -22,12 +22,8 @@
>   #define TCG_TARGET_HAS_negsetcond_i64   0
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
> -#define TCG_TARGET_HAS_mulu2_i32        1
>   #define TCG_TARGET_HAS_add2_i64         1
>   #define TCG_TARGET_HAS_sub2_i64         1
> -#define TCG_TARGET_HAS_mulu2_i64        1
> -#else
> -#define TCG_TARGET_HAS_mulu2_i32        1
>   #endif /* TCG_TARGET_REG_BITS == 64 */
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 0f48484dfe..a4d976242a 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1138,7 +1138,7 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>   
>   void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
>   {
> -    if (TCG_TARGET_HAS_mulu2_i32) {
> +    if (tcg_op_supported(INDEX_op_mulu2_i32, TCG_TYPE_I32, 0)) {
>           tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
>       } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
>           TCGv_i32 t = tcg_temp_ebb_new_i32();
> @@ -1156,7 +1156,7 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
>           tcg_temp_free_i64(t0);
>           tcg_temp_free_i64(t1);
>       } else {
> -        qemu_build_not_reached();
> +        g_assert_not_reached();
>       }
>   }
>   
> @@ -2861,7 +2861,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>   
>   void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
>   {
> -    if (TCG_TARGET_HAS_mulu2_i64) {
> +    if (tcg_op_supported(INDEX_op_mulu2_i64, TCG_TYPE_I64, 0)) {
>           tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
>       } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t = tcg_temp_ebb_new_i64();
> @@ -2888,7 +2888,7 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
>           tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
>           tcg_gen_mov_i64(rl, t);
>           tcg_temp_free_i64(t);
> -    } else if (TCG_TARGET_HAS_mulu2_i64 ||
> +    } else if (tcg_op_supported(INDEX_op_mulu2_i64, TCG_TYPE_I64, 0) ||
>                  tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();
>           TCGv_i64 t1 = tcg_temp_ebb_new_i64();
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 8e6f8c1194..1291865575 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1043,6 +1043,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
>       OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
>       OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
>       OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
> +    OUTOP(INDEX_op_mulu2_i32, TCGOutOpMul2, outop_mulu2),
> +    OUTOP(INDEX_op_mulu2_i64, TCGOutOpMul2, outop_mulu2),
>       OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
>       OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
>       OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
> @@ -2290,8 +2292,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>           return TCG_TARGET_HAS_add2_i32;
>       case INDEX_op_sub2_i32:
>           return TCG_TARGET_HAS_sub2_i32;
> -    case INDEX_op_mulu2_i32:
> -        return TCG_TARGET_HAS_mulu2_i32;
>       case INDEX_op_bswap16_i32:
>           return TCG_TARGET_HAS_bswap16_i32;
>       case INDEX_op_bswap32_i32:
> @@ -2339,8 +2339,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
>           return TCG_TARGET_HAS_add2_i64;
>       case INDEX_op_sub2_i64:
>           return TCG_TARGET_HAS_sub2_i64;
> -    case INDEX_op_mulu2_i64:
> -        return TCG_TARGET_HAS_mulu2_i64;
>   
>       case INDEX_op_mov_vec:
>       case INDEX_op_dup_vec:
> @@ -5473,6 +5471,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
>           break;
>   
>       case INDEX_op_muls2:
> +    case INDEX_op_mulu2_i32:
> +    case INDEX_op_mulu2_i64:
>           {
>               const TCGOutOpMul2 *out =
>                   container_of(all_outop[op->opc], TCGOutOpMul2, base);
> diff --git a/tcg/tci.c b/tcg/tci.c
> index 708ded34c7..5c8c62c0ef 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -588,6 +588,16 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_write_reg64(regs, r1, r0, tmp64);
>   #else
>               muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
> +#endif
> +            break;
> +        case INDEX_op_mulu2_i32:
> +        case INDEX_op_mulu2_i64:
> +            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> +#if TCG_TARGET_REG_BITS == 32
> +            tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
> +            tci_write_reg64(regs, r1, r0, tmp64);
> +#else
> +            mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
>   #endif
>               break;
>   
> @@ -677,13 +687,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_write_reg64(regs, r1, r0, T1 - T2);
>               break;
>   #endif
> -#if TCG_TARGET_HAS_mulu2_i32
> -        case INDEX_op_mulu2_i32:
> -            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> -            tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
> -            tci_write_reg64(regs, r1, r0, tmp64);
> -            break;
> -#endif
>   #if TCG_TARGET_HAS_bswap16_i32 || TCG_TARGET_HAS_bswap16_i64
>           CASE_32_64(bswap16)
>               tci_args_rr(insn, &r0, &r1);
> @@ -741,12 +744,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tci_args_rrr(insn, &r0, &r1, &r2);
>               regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
>               break;
> -#if TCG_TARGET_HAS_mulu2_i64
> -        case INDEX_op_mulu2_i64:
> -            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> -            mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
> -            break;
> -#endif
>   #if TCG_TARGET_HAS_add2_i64
>           case INDEX_op_add2_i64:
>               tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 0996c6234b..46ad91f40e 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2226,6 +2226,10 @@ static const TCGOutOpBinary outop_mulsh = {
>       .out_rrr = tgen_mulsh,
>   };
>   
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_muluh(TCGContext *s, TCGType type,
>                          TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 8c0bc78be3..55e9f66340 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -921,14 +921,6 @@ static void tcg_out_dat_rIN(TCGContext *s, ARMCond cond, ARMInsn opc,
>       }
>   }
>   
> -static void tcg_out_umull32(TCGContext *s, ARMCond cond, TCGReg rd0,
> -                            TCGReg rd1, TCGReg rn, TCGReg rm)
> -{
> -    /* umull */
> -    tcg_out32(s, (cond << 28) | 0x00800090 |
> -              (rd1 << 16) | (rd0 << 12) | (rm << 8) | rn);
> -}
> -
>   static void tcg_out_ext8s(TCGContext *s, TCGType t, TCGReg rd, TCGReg rn)
>   {
>       /* sxtb */
> @@ -1982,6 +1974,19 @@ static const TCGOutOpBinary outop_mulsh = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_mulu2(TCGContext *s, TCGType type,
> +                       TCGReg rd0, TCGReg rd1, TCGReg rn, TCGReg rm)
> +{
> +    /* umull */
> +    tcg_out32(s, (COND_AL << 28) | 0x00800090 |
> +              (rd1 << 16) | (rd0 << 12) | (rm << 8) | rn);
> +}
> +
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_O2_I2(r, r, r, r),
> +    .out_rrrr = tgen_mulu2,
> +};
> +
>   static const TCGOutOpBinary outop_muluh = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -2248,9 +2253,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           }
>           tcg_out_mov_reg(s, COND_AL, args[0], a0);
>           break;
> -    case INDEX_op_mulu2_i32:
> -        tcg_out_umull32(s, COND_AL, args[0], args[1], args[2], args[3]);
> -        break;
>   
>       case INDEX_op_brcond_i32:
>           c = tcg_out_cmp(s, args[2], args[0], args[1], const_args[1]);
> @@ -2374,9 +2376,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_negsetcond_i32:
>           return C_O1_I2(r, r, rIN);
>   
> -    case INDEX_op_mulu2_i32:
> -        return C_O2_I2(r, r, r, r);
> -
>       case INDEX_op_brcond_i32:
>           return C_O0_I2(r, rIN);
>       case INDEX_op_deposit_i32:
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 43d63cab5c..d1b37c4388 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2763,6 +2763,18 @@ static const TCGOutOpBinary outop_muluh = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_mulu2(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
> +{
> +    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
> +    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, a3);
> +}
> +
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_O2_I2(a, d, a, r),
> +    .out_rrrr = tgen_mulu2,
> +};
> +
>   static const TCGOutOpBinary outop_nand = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -3145,9 +3157,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
>           break;
>   
> -    OP_32_64(mulu2):
> -        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_MUL, args[3]);
> -        break;
>       OP_32_64(add2):
>           if (const_args[4]) {
>               tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
> @@ -3935,10 +3944,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_movcond_i64:
>           return C_O1_I4(r, r, reT, r, 0);
>   
> -    case INDEX_op_mulu2_i32:
> -    case INDEX_op_mulu2_i64:
> -        return C_O2_I2(a, d, a, r);
> -
>       case INDEX_op_add2_i32:
>       case INDEX_op_add2_i64:
>       case INDEX_op_sub2_i32:
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index b7c05a3969..aed1d9712d 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -1428,6 +1428,10 @@ static const TCGOutOpBinary outop_mulsh = {
>       .out_rrr = tgen_mulsh,
>   };
>   
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_muluh(TCGContext *s, TCGType type,
>                          TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index a1f9efb18b..6a97264c7c 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1861,6 +1861,21 @@ static const TCGOutOpBinary outop_mulsh = {
>       .out_rrr = tgen_mulsh,
>   };
>   
> +static void tgen_mulu2(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
> +{
> +    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MULTU : OPC_DMULTU;
> +    tcg_out_opc_reg(s, insn, 0, a2, a3);
> +    tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
> +    tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
> +}
> +
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_mul2,
> +    .out_rrrr = tgen_mulu2,
> +};
> +
>   static void tgen_muluh(TCGContext *s, TCGType type,
>                          TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -2181,17 +2196,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_ldst(s, i1, a0, a1, a2);
>           break;
>   
> -    case INDEX_op_mulu2_i32:
> -        i1 = OPC_MULTU;
> -        goto do_hilo2;
> -    case INDEX_op_mulu2_i64:
> -        i1 = OPC_DMULTU;
> -    do_hilo2:
> -        tcg_out_opc_reg(s, i1, 0, a2, args[3]);
> -        tcg_out_opc_reg(s, OPC_MFLO, a0, 0, 0);
> -        tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
> -        break;
> -
>       case INDEX_op_bswap16_i32:
>       case INDEX_op_bswap16_i64:
>           tcg_out_bswap16(s, a0, a1, a2);
> @@ -2361,9 +2365,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_setcond_i32:
>       case INDEX_op_setcond_i64:
>           return C_O1_I2(r, rz, rz);
> -    case INDEX_op_mulu2_i32:
> -    case INDEX_op_mulu2_i64:
> -        return C_O2_I2(r, r, r, r);
>   
>       case INDEX_op_deposit_i32:
>       case INDEX_op_deposit_i64:
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index d4e34e3e7d..f2cb45029f 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3095,6 +3095,10 @@ static const TCGOutOpBinary outop_mulsh = {
>       .out_rrr = tgen_mulsh,
>   };
>   
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_muluh(TCGContext *s, TCGType type,
>                          TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 316621b285..071be449f6 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2138,6 +2138,10 @@ static const TCGOutOpBinary outop_mulsh = {
>       .out_rrr = tgen_mulsh,
>   };
>   
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_NotImplemented,
> +};
> +
>   static void tgen_muluh(TCGContext *s, TCGType type,
>                          TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 71f0eb40f8..18b83d5899 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2415,6 +2415,27 @@ static const TCGOutOpBinary outop_mulsh = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_mulu2(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
> +{
> +    tcg_debug_assert(a0 == a2);
> +    tcg_debug_assert((a1 & 1) == 0);
> +    tcg_debug_assert(a0 == a1 + 1);
> +    tcg_out_insn(s, RRE, MLGR, a1, a3);
> +}
> +
> +static TCGConstraintSetIndex cset_mulu2(TCGType type, unsigned flags)
> +{
> +    return (type == TCG_TYPE_I64 && HAVE_FACILITY(MISC_INSN_EXT2)
> +            ? C_O2_I2(o, m, 0, r) : C_NotImplemented);
> +}
> +
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_mulu2,
> +    .out_rrrr = tgen_mulu2,
> +};
> +
>   static const TCGOutOpBinary outop_muluh = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -2860,13 +2881,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
>           break;
>   
> -    case INDEX_op_mulu2_i64:
> -        tcg_debug_assert(args[0] == args[2]);
> -        tcg_debug_assert((args[1] & 1) == 0);
> -        tcg_debug_assert(args[0] == args[1] + 1);
> -        tcg_out_insn(s, RRE, MLGR, args[1], args[3]);
> -        break;
> -
>       case INDEX_op_add2_i64:
>           if (const_args[4]) {
>               if ((int64_t)args[4] >= 0) {
> @@ -3464,9 +3478,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_movcond_i64:
>           return C_O1_I4(r, r, rC, rI, r);
>   
> -    case INDEX_op_mulu2_i64:
> -        return C_O2_I2(o, m, 0, r);
> -
>       case INDEX_op_add2_i32:
>       case INDEX_op_sub2_i32:
>           return C_N1_O1_I4(r, r, 0, 1, ri, r);
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index be2072c027..41c4e77466 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -1457,6 +1457,19 @@ static const TCGOutOpBinary outop_mulsh = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_mulu2(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
> +{
> +    tcg_out_arith(s, a0, a2, a3, ARITH_UMUL);
> +    tcg_out_arithi(s, a1, a0, 32, SHIFT_SRLX);
> +}
> +
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_mul2,
> +    .out_rrrr = tgen_mulu2,
> +};
> +
>   static void tgen_muluh(TCGContext *s, TCGType type,
>                          TCGReg a0, TCGReg a1, TCGReg a2)
>   {
> @@ -1646,7 +1659,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
>       TCGArg a0, a1, a2;
> -    int c, c2;
> +    int c2;
>   
>       /* Hoist the loads of the most common arguments.  */
>       a0 = args[0];
> @@ -1718,12 +1731,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                               args[4], const_args[4], args[5], const_args[5],
>                               ARITH_SUBCC, ARITH_SUBC);
>           break;
> -    case INDEX_op_mulu2_i32:
> -        c = ARITH_UMUL;
> -        /* The 32-bit multiply insns produce a full 64-bit result. */
> -        tcg_out_arithc(s, a0, a2, args[3], const_args[3], c);
> -        tcg_out_arithi(s, a1, a0, 32, SHIFT_SRLX);
> -        break;
>   
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
> @@ -1847,8 +1854,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_sub2_i32:
>       case INDEX_op_sub2_i64:
>           return C_O2_I4(r, r, rz, rz, rJ, rJ);
> -    case INDEX_op_mulu2_i32:
> -        return C_O2_I2(r, r, rz, rJ);
>   
>       default:
>           return C_NotImplemented;
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index aa3ce929b4..4bce206f80 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -98,10 +98,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           return C_O0_I4(r, r, r, r);
>   #endif
>   
> -    case INDEX_op_mulu2_i32:
> -    case INDEX_op_mulu2_i64:
> -        return C_O2_I2(r, r, r, r);
> -
>       case INDEX_op_movcond_i32:
>       case INDEX_op_movcond_i64:
>       case INDEX_op_setcond2_i32:
> @@ -729,6 +725,19 @@ static const TCGOutOpBinary outop_mulsh = {
>       .base.static_constraint = C_NotImplemented,
>   };
>   
> +static void tgen_mulu2(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
> +{
> +    tcg_out_op_rrrr(s, glue(INDEX_op_mulu2_i,TCG_TARGET_REG_BITS),
> +                    a0, a1, a2, a3);
> +}
> +
> +static const TCGOutOpMul2 outop_mulu2 = {
> +    .base.static_constraint = C_Dynamic,
> +    .base.dynamic_constraint = cset_mul2,
> +    .out_rrrr = tgen_mulu2,
> +};
> +
>   static const TCGOutOpBinary outop_muluh = {
>       .base.static_constraint = C_NotImplemented,
>   };
> @@ -1023,10 +1032,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           break;
>   #endif
>   
> -    CASE_32_64(mulu2)
> -        tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], args[3]);
> -        break;
> -
>       case INDEX_op_qemu_ld_i64:
>       case INDEX_op_qemu_st_i64:
>           if (TCG_TARGET_REG_BITS == 32) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


