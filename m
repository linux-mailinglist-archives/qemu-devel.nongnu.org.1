Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC9786167
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOm-0000XF-Eu; Wed, 23 Aug 2023 16:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L3-8W
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005UP-EQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a4bcf8a97so2873661b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822222; x=1693427022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPRAx5YETBqoL7VyE1c9XODTcIwclR3GJzVrX98m0+Q=;
 b=C3qloZVGNtJvHs1ZTBMVHKAgEQbIEFcne2M2J5kZHlv0qbLCHmi9bfvzv4DKa7XxwN
 4e3ipQ3UpHB4ONb84f5dFtNuuGL3QOYFr4ZhHf+l37BC/bW/RZySg+q75XboepwaRvvO
 NCGiF3DICsXpmNr5Y8hhP13+uPmadBiIgg4UWuZr0qjJLGSOavsOiAhlQdJpycrvyU7r
 LabwMhn5FvbP7+t3pXSMmTKqFxQyDV2u+cIFe8ny7qyha+aSTsOcxr7dlp8bIFE2lTrA
 TLoNziRgBDGwTBKrxU3AJzqyEgRxXw0ta6AHMN48xA9MxnI5z54q5A3PujQTE808ToH0
 cLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822222; x=1693427022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPRAx5YETBqoL7VyE1c9XODTcIwclR3GJzVrX98m0+Q=;
 b=lOUl4tCOjr4nF+95MjcAh/GjFP4tzmmtBocsUT+PanQ8JlbgVi7cec3YTzpRVmoL8t
 R4SSE+g1U7F+qnUeGF5Hg5TI7AN6qGZRsFyw+USyuLphKu9IwwLOdjRU9tJS07Fq+hoM
 vEa/HRG3hlDo5195/4DlJ23mVUFf0Ou2nJilEeV3SwCR2OGd0z6RFmaX9Rp+mA26fB9x
 wW5eMeZIe5zqdW07e4cLGg1X3d2Fm176KU5BgA/tnAS0moSVvD0SHMXLSV5DwofC0t6V
 L4oSa2MvNYH4DVvvfzmMIYrZyQVa5Hkup2+aTqEWNlP4bIf82YAXiyCkNNiVn0Rg5Z/O
 34Bw==
X-Gm-Message-State: AOJu0Yz/cUOw6wodN+wKo7KoqYs37bm5gKhZjkGAWKuNNa3wtWRLgWsR
 sbv2vPGchZY1JeiwvIDNJPZTWygeKLboDcoDFaY=
X-Google-Smtp-Source: AGHT+IG4XcG2XewdTGOPNWbEJad8/e7sQjzmn+nUU7Ih83TDYQ0TxfcMflWBZfU2uoD1iY7hSp7C8A==
X-Received: by 2002:a05:6a21:33a7:b0:12f:90d8:9755 with SMTP id
 yy39-20020a056a2133a700b0012f90d89755mr14416389pzb.15.1692822222019; 
 Wed, 23 Aug 2023 13:23:42 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/48] tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
Date: Wed, 23 Aug 2023 13:22:53 -0700
Message-Id: <20230823202326.1353645-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Replace the separate defines with TCG_TARGET_HAS_extr_i64_i32,
so that the two parts of backend-specific type changing cannot
be out of sync.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: <20230822175127.1173698-1-richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        | 4 ++--
 include/tcg/tcg.h            | 3 +--
 tcg/aarch64/tcg-target.h     | 3 +--
 tcg/i386/tcg-target.h        | 3 +--
 tcg/loongarch64/tcg-target.h | 3 +--
 tcg/mips/tcg-target.h        | 3 +--
 tcg/ppc/tcg-target.h         | 3 +--
 tcg/riscv/tcg-target.h       | 3 +--
 tcg/s390x/tcg-target.h       | 3 +--
 tcg/sparc64/tcg-target.h     | 3 +--
 tcg/tci/tcg-target.h         | 3 +--
 tcg/tcg-op.c                 | 4 ++--
 tcg/tcg.c                    | 3 +--
 13 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index acfa5ba753..c64dfe558c 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -152,10 +152,10 @@ DEF(extract2_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_extract2_i64))
 DEF(ext_i32_i64, 1, 1, 0, IMPL64)
 DEF(extu_i32_i64, 1, 1, 0, IMPL64)
 DEF(extrl_i64_i32, 1, 1, 0,
-    IMPL(TCG_TARGET_HAS_extrl_i64_i32)
+    IMPL(TCG_TARGET_HAS_extr_i64_i32)
     | (TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0))
 DEF(extrh_i64_i32, 1, 1, 0,
-    IMPL(TCG_TARGET_HAS_extrh_i64_i32)
+    IMPL(TCG_TARGET_HAS_extr_i64_i32)
     | (TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0))
 
 DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL64)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..ea7e55eeb8 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -68,8 +68,7 @@ typedef uint64_t TCGRegSet;
 
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extrl_i64_i32    0
-#define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_div_i64          0
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_div2_i64         0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ce64de06e5..12765cc281 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -92,8 +92,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_extrl_i64_i32    0
-#define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_div_i64          1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 30cce01ca4..32dd795259 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -159,8 +159,7 @@ typedef enum {
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
-#define TCG_TARGET_HAS_extrl_i64_i32    1
-#define TCG_TARGET_HAS_extrh_i64_i32    1
+#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_div2_i64         1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 26f1aab780..c94e0c6044 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -130,8 +130,7 @@ typedef enum {
 #define TCG_TARGET_HAS_extract_i64      1
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_extrl_i64_i32    1
-#define TCG_TARGET_HAS_extrh_i64_i32    1
+#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index dd2efa795c..bdfa25bef4 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -132,8 +132,7 @@ extern bool use_mips32r2_instructions;
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_extrl_i64_i32    1
-#define TCG_TARGET_HAS_extrh_i64_i32    1
+#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_not_i64          1
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 9a41fab8cc..37b54e6aeb 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -106,8 +106,7 @@ typedef enum {
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_extrl_i64_i32    0
-#define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          have_isa_3_00
 #define TCG_TARGET_HAS_rot_i64          1
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index e1d8110ee4..6cbd226ca9 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -131,8 +131,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_extrl_i64_i32    1
-#define TCG_TARGET_HAS_extrh_i64_i32    1
+#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
 #define TCG_TARGET_HAS_ext16s_i64       1
 #define TCG_TARGET_HAS_ext32s_i64       1
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 9a405003b9..2edc2056ba 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -102,8 +102,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_muls2_i32      0
 #define TCG_TARGET_HAS_muluh_i32      0
 #define TCG_TARGET_HAS_mulsh_i32      0
-#define TCG_TARGET_HAS_extrl_i64_i32  0
-#define TCG_TARGET_HAS_extrh_i64_i32  0
+#define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
 #define TCG_TARGET_HAS_div2_i64       1
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index d454278811..682e6f1613 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -114,8 +114,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_extrl_i64_i32    1
-#define TCG_TARGET_HAS_extrh_i64_i32    1
+#define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          0
 #define TCG_TARGET_HAS_rot_i64          0
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 37ee10c959..d33185fb36 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -76,8 +76,7 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_extrl_i64_i32    0
-#define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..68b93a3d4b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2681,7 +2681,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
-    } else if (TCG_TARGET_HAS_extrl_i64_i32) {
+    } else if (TCG_TARGET_HAS_extr_i64_i32) {
         tcg_gen_op2(INDEX_op_extrl_i64_i32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
@@ -2693,7 +2693,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
-    } else if (TCG_TARGET_HAS_extrh_i64_i32) {
+    } else if (TCG_TARGET_HAS_extr_i64_i32) {
         tcg_gen_op2(INDEX_op_extrh_i64_i32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ddfe9a96cb..a23348824b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2000,9 +2000,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_extract2_i64:
         return TCG_TARGET_HAS_extract2_i64;
     case INDEX_op_extrl_i64_i32:
-        return TCG_TARGET_HAS_extrl_i64_i32;
     case INDEX_op_extrh_i64_i32:
-        return TCG_TARGET_HAS_extrh_i64_i32;
+        return TCG_TARGET_HAS_extr_i64_i32;
     case INDEX_op_ext8s_i64:
         return TCG_TARGET_HAS_ext8s_i64;
     case INDEX_op_ext16s_i64:
-- 
2.34.1


