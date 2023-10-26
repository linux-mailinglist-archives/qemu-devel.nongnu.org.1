Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B637D7B6C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:15:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrl9-0002WQ-3f; Thu, 26 Oct 2023 00:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl6-0002VD-FV
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl3-0000jA-FP
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so3475885ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698293648; x=1698898448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mlppooNW1d2qtQucki4AZw1DSpXcW2IllcDyJOYGRCQ=;
 b=bX/OO3dkkA2tJbvYma2G1KSZbCkFCEChFYceTvzjA8sSMNgQOZwsFOWyjx74tdbOnO
 IPWNRLzq+oOBd+t65NQ4uGWlMEueMaFN8dLBffiRFZ6i+YVRQAPpWdR6DkDzQSmT8rNb
 Z8Vf/htrTbJsQolnsrtzMltDr/1rESgjY+3zTYPj7Lujj1JnPZPGaTumfDgxTKIGuKZK
 /dklHcMf/9zagPL2FqfZ2adxeGckxelP+qBM0/im71TFH9Gc/Rvt4wmt+oQqPINVDtJQ
 Q23Jg7n3HffuudN8ohFaOOz5t9q/TRRCaDt4zWiNkRTB234+C28T9IA331tJdcbU8DRH
 bI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698293648; x=1698898448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlppooNW1d2qtQucki4AZw1DSpXcW2IllcDyJOYGRCQ=;
 b=diImRtq6kXrr2SzR1ZrwpPsPsauASx62+uyRZ6iLUDkJ8WNHHsWG+wM15SUYeB2KCT
 kIUjYfBGoqhb7GcSJgStIaCIiEClM24syGNIUeBoz8hJ61vhbxuVgg65sudhFaaswFDg
 efFnConr0THiep21VXdLGIqLS0NzDpW5PnWTBlBDuR6Lxl09yBpxnEWXxVBSsUeMtYYO
 WEBgtmSClERF2GhaI84sbr8jXPRSmYoH6rjF25IRCGj4h7kSsN0enZXT2rVx128TpCCh
 xfhQZQ7pKkfWHE1wdJVzbj7krjbTU2p1wF5tx+P3lNk1BayAj/AgmRIZkPH26ok3nrP5
 z06A==
X-Gm-Message-State: AOJu0Ywh6FdSt7bi1P4LREoH5kRxM8SFO6XxhDB10ocR2lpXz4rn3Oi8
 n9IJOBqJjnHIhetYkXa8cV2mlsQ77EpTHBwA0B8=
X-Google-Smtp-Source: AGHT+IFuY82xNcsIvv2T7LWVSMP+hD+xXRHruFjhtfH7R3PHmKy4mRGpfErOW/sWLOauFRrBcK10cA==
X-Received: by 2002:a17:902:d4cf:b0:1c3:92de:1b23 with SMTP id
 o15-20020a170902d4cf00b001c392de1b23mr20015716plg.59.1698293647800; 
 Wed, 25 Oct 2023 21:14:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001b8b2b95068sm9953929pli.204.2023.10.25.21.14.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 21:14:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] tcg: Remove TCG_TARGET_HAS_movcond_{i32,i64}
Date: Wed, 25 Oct 2023 21:14:01 -0700
Message-Id: <20231026041404.1229328-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026041404.1229328-1-richard.henderson@linaro.org>
References: <20231026041404.1229328-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

The movcond opcode is now mandatory for backends to implement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        |  4 +--
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
 tcg/tcg-op.c                 | 50 ++++++++----------------------------
 tcg/tcg.c                    |  6 ++---
 14 files changed, 14 insertions(+), 66 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 6eff3d9106..ecd08db0de 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -47,7 +47,7 @@ DEF(mb, 0, 0, 1, 0)
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_negsetcond_i32))
-DEF(movcond_i32, 1, 4, 1, IMPL(TCG_TARGET_HAS_movcond_i32))
+DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
 DEF(ld8s_i32, 1, 1, 1, 0)
@@ -113,7 +113,7 @@ DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
 DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond_i64))
-DEF(movcond_i64, 1, 4, 1, IMPL64 | IMPL(TCG_TARGET_HAS_movcond_i64))
+DEF(movcond_i64, 1, 4, 1, IMPL64)
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, IMPL64)
 DEF(ld8s_i64, 1, 1, 1, IMPL64)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a9282cdcc6..bb522a865c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -96,7 +96,6 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_movcond_i64      0
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 98727ea53b..352e19aba8 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -85,7 +85,6 @@ typedef enum {
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -122,7 +121,6 @@ typedef enum {
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 311a985209..439898efb3 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -115,7 +115,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_extract_i32      use_armv7_instructions
 #define TCG_TARGET_HAS_sextract_i32     use_armv7_instructions
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        1
 #define TCG_TARGET_HAS_muls2_i32        1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 8417ea4899..7522ce7575 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -149,7 +149,6 @@ typedef enum {
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -186,7 +185,6 @@ typedef enum {
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 03017672f6..bebb2c6a05 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -97,7 +97,6 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
 /* optional instructions */
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
@@ -134,7 +133,6 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 0a4083f0d9..5b3fdcc726 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -154,7 +154,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
@@ -169,7 +168,6 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 8bfb14998e..a2856afd4d 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -96,7 +96,6 @@ typedef enum {
 #define TCG_TARGET_HAS_extract_i32      1
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_mulu2_i32        0
 #define TCG_TARGET_HAS_muls2_i32        0
@@ -134,7 +133,6 @@ typedef enum {
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index c1132d178f..f3644a8bc1 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -87,7 +87,6 @@ extern bool have_zbb;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
@@ -123,7 +122,6 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 50e12ef9d6..2c936c1bcb 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -95,7 +95,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extract_i32    1
 #define TCG_TARGET_HAS_sextract_i32   0
 #define TCG_TARGET_HAS_extract2_i32   0
-#define TCG_TARGET_HAS_movcond_i32    1
 #define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
 #define TCG_TARGET_HAS_sub2_i32       1
@@ -131,7 +130,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_extract_i64    1
 #define TCG_TARGET_HAS_sextract_i64   0
 #define TCG_TARGET_HAS_extract2_i64   0
-#define TCG_TARGET_HAS_movcond_i64    1
 #define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
 #define TCG_TARGET_HAS_sub2_i64       1
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 5cfc4b4679..4c286c6006 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -105,7 +105,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -142,7 +141,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 91ca33b616..3503fc4a4c 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -69,7 +69,6 @@
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
@@ -104,7 +103,6 @@
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_add2_i32         1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 828eb9ee46..51de796769 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -864,17 +864,8 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
         tcg_gen_mov_i32(ret, v1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i32(ret, v2);
-    } else if (TCG_TARGET_HAS_movcond_i32) {
-        tcg_gen_op6i_i32(INDEX_op_movcond_i32, ret, c1, c2, v1, v2, cond);
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_negsetcond_i32(cond, t0, c1, c2);
-        tcg_gen_and_i32(t1, v1, t0);
-        tcg_gen_andc_i32(ret, v2, t0);
-        tcg_gen_or_i32(ret, ret, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        tcg_gen_op6i_i32(INDEX_op_movcond_i32, ret, c1, c2, v1, v2, cond);
     }
 }
 
@@ -2600,43 +2591,22 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
         tcg_gen_mov_i64(ret, v1);
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i64(ret, v2);
-    } else if (TCG_TARGET_REG_BITS == 32) {
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_op6i_i64(INDEX_op_movcond_i64, ret, c1, c2, v1, v2, cond);
+    } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        TCGv_i32 zero = tcg_constant_i32(0);
+
         tcg_gen_op6i_i32(INDEX_op_setcond2_i32, t0,
                          TCGV_LOW(c1), TCGV_HIGH(c1),
                          TCGV_LOW(c2), TCGV_HIGH(c2), cond);
 
-        if (TCG_TARGET_HAS_movcond_i32) {
-            tcg_gen_movi_i32(t1, 0);
-            tcg_gen_movcond_i32(TCG_COND_NE, TCGV_LOW(ret), t0, t1,
-                                TCGV_LOW(v1), TCGV_LOW(v2));
-            tcg_gen_movcond_i32(TCG_COND_NE, TCGV_HIGH(ret), t0, t1,
-                                TCGV_HIGH(v1), TCGV_HIGH(v2));
-        } else {
-            tcg_gen_neg_i32(t0, t0);
+        tcg_gen_movcond_i32(TCG_COND_NE, TCGV_LOW(ret), t0, zero,
+                            TCGV_LOW(v1), TCGV_LOW(v2));
+        tcg_gen_movcond_i32(TCG_COND_NE, TCGV_HIGH(ret), t0, zero,
+                            TCGV_HIGH(v1), TCGV_HIGH(v2));
 
-            tcg_gen_and_i32(t1, TCGV_LOW(v1), t0);
-            tcg_gen_andc_i32(TCGV_LOW(ret), TCGV_LOW(v2), t0);
-            tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(ret), t1);
-
-            tcg_gen_and_i32(t1, TCGV_HIGH(v1), t0);
-            tcg_gen_andc_i32(TCGV_HIGH(ret), TCGV_HIGH(v2), t0);
-            tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(ret), t1);
-        }
         tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    } else if (TCG_TARGET_HAS_movcond_i64) {
-        tcg_gen_op6i_i64(INDEX_op_movcond_i64, ret, c1, c2, v1, v2, cond);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_negsetcond_i64(cond, t0, c1, c2);
-        tcg_gen_and_i64(t1, v1, t0);
-        tcg_gen_andc_i64(ret, v2, t0);
-        tcg_gen_or_i64(ret, ret, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 57d0583fe7..5da03ba11d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1874,6 +1874,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_mov_i32:
     case INDEX_op_setcond_i32:
     case INDEX_op_brcond_i32:
+    case INDEX_op_movcond_i32:
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
@@ -1895,8 +1896,6 @@ bool tcg_op_supported(TCGOpcode op)
 
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond_i32;
-    case INDEX_op_movcond_i32:
-        return TCG_TARGET_HAS_movcond_i32;
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
         return TCG_TARGET_HAS_div_i32;
@@ -1969,6 +1968,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_mov_i64:
     case INDEX_op_setcond_i64:
     case INDEX_op_brcond_i64:
+    case INDEX_op_movcond_i64:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -1995,8 +1995,6 @@ bool tcg_op_supported(TCGOpcode op)
 
     case INDEX_op_negsetcond_i64:
         return TCG_TARGET_HAS_negsetcond_i64;
-    case INDEX_op_movcond_i64:
-        return TCG_TARGET_HAS_movcond_i64;
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
         return TCG_TARGET_HAS_div_i64;
-- 
2.34.1


