Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 750247E3346
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:53:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9N-0008PM-HX; Mon, 06 Nov 2023 21:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9L-0008OJ-D1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:07 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9J-0005tr-1j
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:07 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b5714439b3so2435875b6e.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325343; x=1699930143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BmxVri7VT4MUjzfnFpMDtKzBcAkAGuxFEEom/sZd+hA=;
 b=z0kxV8ERrJTipHip/Bt6HcQUM4DEQ7/QxKy3gQSCLEji1OSebG4hQYqUmYf7I49t++
 z0D/LfmyLvq+ehRzk+ItVXVsP7KfrYZMDTJkPA+7TBZGZWsE8k7DUCiW1bGgIy6o2mgA
 kh+VlQ1QkV9atCNRVyxucEF7QNFn9iG62KkHohDRB13OaEtHeEOiohHR7hCe/bBiPNdb
 n6ii2/i2YKNmgzO1JFeTka22U6L6RyYOQEEQFgiC/SZbe8ArUtbW6c8Zqmp5ckWIBi88
 BvEhsm3ig/JVi2+48lvllhv419RYCuTIhUY3s0ZsyYQMtQ82GzAzeDFeqFC7CohRzNj4
 uB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325343; x=1699930143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmxVri7VT4MUjzfnFpMDtKzBcAkAGuxFEEom/sZd+hA=;
 b=rDzHrncOC7qCKassIfwVAHl7YOoXgYsvGY1PQcdYtQLyMjWDqyjlI5Mdp+Frf4nhml
 C60XnAGf0r0oPJSSxx1sm66DCM8ErRfNx8YthGsNHHRChhzw3PwsME/Q4PEoL/mXcn0W
 pibbe0gO9WBxP7KMP1nuv2zqov8Bp7gJ7XmXtWb3FbGhnsb4CFoaM3YEKdaCJ241EzyN
 1dlP1b+0TKouMl10CLvLLA2zMFlpIYm5gSx8/0CFZyf9FlN7R7A99uQGe/IyXxxuinXx
 QnYzAQkiUTeXNOKrRPdNc7XCjIt1KaBYTJlU2V/N+yBBVqxQvZPoHR1lCXUfDBCaNz9+
 W3Pg==
X-Gm-Message-State: AOJu0YxyXDyw0avKqi5O5K2arZm8X6h6tLq4dDZmnfQPMwZO1IA8VwXO
 KY+9g1Y2K4mCWgEzrF5NW0QFqLn1yqDY3wd6KIg=
X-Google-Smtp-Source: AGHT+IH/LOR7AIoS/yKL1LgyuLbSxuGGaYEqyu44M+hmrQFFbXSy07gGpshK9Af5XLFhxLo4MdBKGQ==
X-Received: by 2002:a05:6808:9a3:b0:3b2:e9ad:c01f with SMTP id
 e3-20020a05680809a300b003b2e9adc01fmr25947185oig.44.1699325343678; 
 Mon, 06 Nov 2023 18:49:03 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/35] tcg: Remove TCG_TARGET_HAS_neg_{i32,i64}
Date: Mon,  6 Nov 2023 18:48:32 -0800
Message-Id: <20231107024842.7650-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

The movcond opcode is now mandatory for backends to implement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231026041404.1229328-7-richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        |  4 ++--
 include/tcg/tcg.h            |  1 -
 tcg/aarch64/tcg-target.h     |  2 --
 tcg/arm/tcg-target.h         |  1 -
 tcg/i386/tcg-target.h        |  2 --
 tcg/loongarch64/tcg-target.h |  2 --
 tcg/mips/tcg-target.h        |  2 --
 tcg/ppc/tcg-target.h         |  2 --
 tcg/riscv/tcg-target.h       |  2 --
 tcg/s390x/tcg-target.h       |  2 --
 tcg/sparc64/tcg-target.h     |  2 --
 tcg/tci/tcg-target.h         |  2 --
 tcg/optimize.c               |  4 ++--
 tcg/tcg-op.c                 | 22 +++++++++-------------
 tcg/tcg.c                    |  6 ++----
 tcg/tci.c                    |  2 --
 16 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index ecd08db0de..b80227fa1c 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -100,7 +100,7 @@ DEF(ext16u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16u_i32))
 DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap16_i32))
 DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap32_i32))
 DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not_i32))
-DEF(neg_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_i32))
+DEF(neg_i32, 1, 1, 0, 0)
 DEF(andc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc_i32))
 DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_i32))
 DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv_i32))
@@ -171,7 +171,7 @@ DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap16_i64))
 DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap32_i64))
 DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap64_i64))
 DEF(not_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_not_i64))
-DEF(neg_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_neg_i64))
+DEF(neg_i64, 1, 1, 0, IMPL64)
 DEF(andc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_andc_i64))
 DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc_i64))
 DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv_i64))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 32a208a02e..daf2a5bf9e 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -82,7 +82,6 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_neg_i64          0
 #define TCG_TARGET_HAS_not_i64          0
 #define TCG_TARGET_HAS_andc_i64         0
 #define TCG_TARGET_HAS_orc_i64          0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 352e19aba8..33f15a564a 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -71,7 +71,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
@@ -107,7 +106,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 439898efb3..a712cc80ad 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -101,7 +101,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          0
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7522ce7575..fa34deec47 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -135,7 +135,6 @@ typedef enum {
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_andc_i32         have_bmi1
 #define TCG_TARGET_HAS_orc_i32          0
@@ -171,7 +170,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_andc_i64         have_bmi1
 #define TCG_TARGET_HAS_orc_i64          0
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 189997644a..9c70ebfefc 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -119,7 +119,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
@@ -153,7 +152,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 20c14224fb..b98ffae1d0 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -184,12 +184,10 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a2856afd4d..5295e4f9ab 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -83,7 +83,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          1
@@ -120,7 +119,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          1
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index f3644a8bc1..a4edc3dc74 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -109,7 +109,6 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_bswap16_i32      have_zbb
 #define TCG_TARGET_HAS_bswap32_i32      have_zbb
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         have_zbb
 #define TCG_TARGET_HAS_orc_i32          have_zbb
 #define TCG_TARGET_HAS_eqv_i32          have_zbb
@@ -142,7 +141,6 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_bswap32_i64      have_zbb
 #define TCG_TARGET_HAS_bswap64_i64      have_zbb
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         have_zbb
 #define TCG_TARGET_HAS_orc_i64          have_zbb
 #define TCG_TARGET_HAS_eqv_i64          have_zbb
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 2c936c1bcb..e69b0d2ddd 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -82,7 +82,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_neg_i32        1
 #define TCG_TARGET_HAS_andc_i32       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_orc_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
@@ -117,7 +116,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_neg_i64        1
 #define TCG_TARGET_HAS_andc_i64       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_orc_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 4c286c6006..f8cf145266 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -91,7 +91,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16u_i32       0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
@@ -127,7 +126,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 3503fc4a4c..2a13816c8e 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -65,7 +65,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
@@ -99,7 +98,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2db5177c32..6b072d4cdb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2001,11 +2001,11 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         neg_op = INDEX_op_neg_i32;
-        have_neg = TCG_TARGET_HAS_neg_i32;
+        have_neg = true;
         break;
     case TCG_TYPE_I64:
         neg_op = INDEX_op_neg_i64;
-        have_neg = TCG_TARGET_HAS_neg_i64;
+        have_neg = true;
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 26bcd090c1..de096a6f93 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -363,9 +363,8 @@ void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
-    if (arg1 == 0 && TCG_TARGET_HAS_neg_i32) {
-        /* Don't recurse with tcg_gen_neg_i32.  */
-        tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg2);
+    if (arg1 == 0) {
+        tcg_gen_neg_i32(ret, arg2);
     } else {
         tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
     }
@@ -383,11 +382,7 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_neg_i32) {
-        tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
-    } else {
-        tcg_gen_subfi_i32(ret, 0, arg);
-    }
+    tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
 }
 
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
@@ -1744,9 +1739,8 @@ void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
-    if (arg1 == 0 && TCG_TARGET_HAS_neg_i64) {
-        /* Don't recurse with tcg_gen_neg_i64.  */
-        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg2);
+    if (arg1 == 0) {
+        tcg_gen_neg_i64(ret, arg2);
     } else if (TCG_TARGET_REG_BITS == 64) {
         tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
     } else {
@@ -1772,10 +1766,12 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_HAS_neg_i64) {
+    if (TCG_TARGET_REG_BITS == 64) {
         tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
     } else {
-        tcg_gen_subfi_i64(ret, 0, arg);
+        TCGv_i32 zero = tcg_constant_i32(0);
+        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                         zero, zero, TCGV_LOW(arg), TCGV_HIGH(arg));
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d59ff14f0f..d2ea22b397 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1988,6 +1988,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_st_i32:
     case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
+    case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_and_i32:
     case INDEX_op_or_i32:
@@ -2045,8 +2046,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not_i32;
-    case INDEX_op_neg_i32:
-        return TCG_TARGET_HAS_neg_i32;
     case INDEX_op_andc_i32:
         return TCG_TARGET_HAS_andc_i32;
     case INDEX_op_orc_i32:
@@ -2085,6 +2084,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_st_i64:
     case INDEX_op_add_i64:
     case INDEX_op_sub_i64:
+    case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
     case INDEX_op_and_i64:
     case INDEX_op_or_i64:
@@ -2141,8 +2141,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
         return TCG_TARGET_HAS_not_i64;
-    case INDEX_op_neg_i64:
-        return TCG_TARGET_HAS_neg_i64;
     case INDEX_op_andc_i64:
         return TCG_TARGET_HAS_andc_i64;
     case INDEX_op_orc_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index 4640902c88..3cc851b7bd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -733,12 +733,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ~regs[r1];
             break;
 #endif
-#if TCG_TARGET_HAS_neg_i32 || TCG_TARGET_HAS_neg_i64
         CASE_32_64(neg)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = -regs[r1];
             break;
-#endif
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
-- 
2.34.1


