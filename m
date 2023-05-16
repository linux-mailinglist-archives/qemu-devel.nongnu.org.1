Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF89A7057B1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:43:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yu-0006ml-If; Tue, 16 May 2023 15:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yt-0006mI-5o
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:19 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yr-0002tT-0Y
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:18 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-52c759b7d45so13439154a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266135; x=1686858135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HF3N9t+WR/vu9xazr4+Gr/alUcZraRNVjVLeq4yAhBM=;
 b=CZ1WcllT0I90o5dtNQ800ZBRZTeYQgIrM3yftTXD9Ivo6yQIKskvROD0GBS0r1Xu3a
 6aEasWlKb1+7dtTf6TnInRDlBiVtZ0iQheXOb94rFWOP/SS41mNu0Twz8bYh3pJ9Q5hr
 8ywaFSGi81Xfh34RzwYJEC3mnG4RuWxcDN3hKU39DlKXXLehTmSzthkEDepbEXnOF8Fs
 1quAXI7JRSjrycq8YiACnF94ZelHkrl0F1CXsDl06NOp/00yDIzqF8088Mp9UKow0L1y
 GtqXq/1GP7KvnBrxKG4aq21W0AhyDGCl3c2gcRCqefjTGpSZjw1jRt718oiZTCt2zXCn
 M6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266135; x=1686858135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HF3N9t+WR/vu9xazr4+Gr/alUcZraRNVjVLeq4yAhBM=;
 b=UgKB30X07HjYcGidAybYNZQZ+D0ws4E+GtRAzJMaC/TDdufmvrwj7pJ17TFME44DZ2
 8+jeE/KB09p61/maShSjD+U3ToCKOc6hVGzM0TWKZIZ+gI8L6yMrVCnj7xanS1ff07g9
 i+KUZCHqxP1AjQaBxAzDJ1SW5nQ86df3zEbzWW7iY6vmyWoydIKkHuBM/1VHr2dOd23k
 H7+OlXLmWFKEJdCLftot3UazmhFWprMB34+Oj2J10Z4LBm0aI2tsdOW3c06pgmWDecIx
 VZ1nb2zR8+b64d5KD65QSSHFhugBXrWl8ocxio6ZD9LaQ5SSzfZXZ402GLNG/JcnWyhb
 iSjg==
X-Gm-Message-State: AC+VfDxgao1JOa1S9dJ9J/GKqr24rIeXu3mp72oHAnOcAsqN7HADeXas
 hs9bFktzEhDSI39QgSD6cRN9P2Kv0fQRQHJGaZI=
X-Google-Smtp-Source: ACHHUZ7vutse8jxQDy+BuJxOWsRIHtkLGd/ioy1yzi25ACe5jhnogkJws8SWmESVLL7x5ED2Gukd7g==
X-Received: by 2002:a05:6a20:9144:b0:104:41a0:c51a with SMTP id
 x4-20020a056a20914400b0010441a0c51amr21079441pzc.38.1684266135561; 
 Tue, 16 May 2023 12:42:15 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 32/80] tcg: Introduce tcg_target_has_memory_bswap
Date: Tue, 16 May 2023 12:40:57 -0700
Message-Id: <20230516194145.1749305-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Replace the unparameterized TCG_TARGET_HAS_MEMORY_BSWAP macro
with a function with a memop argument.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h         |  1 -
 tcg/arm/tcg-target.h             |  1 -
 tcg/i386/tcg-target.h            |  3 ---
 tcg/loongarch64/tcg-target.h     |  2 --
 tcg/mips/tcg-target.h            |  2 --
 tcg/ppc/tcg-target.h             |  1 -
 tcg/riscv/tcg-target.h           |  2 --
 tcg/s390x/tcg-target.h           |  2 --
 tcg/sparc64/tcg-target.h         |  1 -
 tcg/tcg-internal.h               |  2 ++
 tcg/tci/tcg-target.h             |  2 --
 tcg/tcg-op.c                     | 20 +++++++++++---------
 tcg/aarch64/tcg-target.c.inc     |  5 +++++
 tcg/arm/tcg-target.c.inc         |  5 +++++
 tcg/i386/tcg-target.c.inc        |  5 +++++
 tcg/loongarch64/tcg-target.c.inc |  5 +++++
 tcg/mips/tcg-target.c.inc        |  5 +++++
 tcg/ppc/tcg-target.c.inc         |  5 +++++
 tcg/riscv/tcg-target.c.inc       |  5 +++++
 tcg/s390x/tcg-target.c.inc       |  5 +++++
 tcg/sparc64/tcg-target.c.inc     |  5 +++++
 tcg/tci/tcg-target.c.inc         |  5 +++++
 22 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 3c0b0d312d..378e01d9d8 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -154,7 +154,6 @@ extern bool have_lse2;
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_HAS_MEMORY_BSWAP     0
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index def2a189e6..4c2d3332d5 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -150,7 +150,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_HAS_MEMORY_BSWAP     0
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 0421776cb8..8fe6958abd 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -240,9 +240,6 @@ extern bool have_atomic16;
 #include "tcg/tcg-mo.h"
 
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
-#define TCG_TARGET_HAS_MEMORY_BSWAP  have_movbe
-
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 17b8193aa5..75c3d80ed2 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -173,6 +173,4 @@ typedef enum {
 
 #define TCG_TARGET_NEED_LDST_LABELS
 
-#define TCG_TARGET_HAS_MEMORY_BSWAP 0
-
 #endif /* LOONGARCH_TCG_TARGET_H */
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 42bd7fff01..47088af9cb 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -205,8 +205,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 #define TCG_TARGET_DEFAULT_MO           0
-#define TCG_TARGET_HAS_MEMORY_BSWAP     0
-
 #define TCG_TARGET_NEED_LDST_LABELS
 
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index af81c5a57f..d55f0266bb 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -179,7 +179,6 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_HAS_MEMORY_BSWAP     1
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index dddf2486c1..dece3b3c27 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -168,6 +168,4 @@ typedef enum {
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
 
-#define TCG_TARGET_HAS_MEMORY_BSWAP 0
-
 #endif
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index a05b473117..fe05680124 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -172,8 +172,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_BY_REF
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_BY_REF
 
-#define TCG_TARGET_HAS_MEMORY_BSWAP   1
-
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 7434cc99d4..f6cd86975a 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -154,7 +154,6 @@ extern bool use_vis3_instructions;
 #define TCG_AREG0 TCG_REG_I0
 
 #define TCG_TARGET_DEFAULT_MO (0)
-#define TCG_TARGET_HAS_MEMORY_BSWAP     1
 #define TCG_TARGET_NEED_LDST_LABELS
 #define TCG_TARGET_NEED_POOL_LABELS
 
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 0f1ba01a9a..67b698bd5c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -126,4 +126,6 @@ static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
     return temp_tcgv_i64(tcgv_i128_temp(t) + o);
 }
 
+bool tcg_target_has_memory_bswap(MemOp memop);
+
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 7140a76a73..364012e4d2 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -176,6 +176,4 @@ typedef enum {
    We prefer consistency across hosts on this.  */
 #define TCG_TARGET_DEFAULT_MO  (0)
 
-#define TCG_TARGET_HAS_MEMORY_BSWAP     1
-
 #endif /* TCG_TARGET_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 22481a344c..b13ded10df 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2959,7 +2959,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     oi = make_memop_idx(memop, idx);
 
     orig_memop = memop;
-    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         memop &= ~MO_BSWAP;
         /* The bswap primitive benefits from zero-extended input.  */
         if ((memop & MO_SSIZE) == MO_SW) {
@@ -2996,7 +2996,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     memop = tcg_canonicalize_memop(memop, 0, 1);
     oi = make_memop_idx(memop, idx);
 
-    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         swap = tcg_temp_ebb_new_i32();
         switch (memop & MO_SIZE) {
         case MO_16:
@@ -3045,7 +3045,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     oi = make_memop_idx(memop, idx);
 
     orig_memop = memop;
-    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         memop &= ~MO_BSWAP;
         /* The bswap primitive benefits from zero-extended input.  */
         if ((memop & MO_SIGN) && (memop & MO_SIZE) < MO_64) {
@@ -3091,7 +3091,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     memop = tcg_canonicalize_memop(memop, 1, 1);
     oi = make_memop_idx(memop, idx);
 
-    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
+    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
         swap = tcg_temp_ebb_new_i64();
         switch (memop & MO_SIZE) {
         case MO_16:
@@ -3157,11 +3157,6 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     tcg_debug_assert((orig & MO_SIZE) == MO_128);
     tcg_debug_assert((orig & MO_SIGN) == 0);
 
-    /* Use a memory ordering implemented by the host. */
-    if (!TCG_TARGET_HAS_MEMORY_BSWAP && (orig & MO_BSWAP)) {
-        mop_1 &= ~MO_BSWAP;
-    }
-
     /* Reduce the size to 64-bit. */
     mop_1 = (mop_1 & ~MO_SIZE) | MO_64;
 
@@ -3191,6 +3186,13 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     default:
         g_assert_not_reached();
     }
+
+    /* Use a memory ordering implemented by the host. */
+    if ((orig & MO_BSWAP) && !tcg_target_has_memory_bswap(mop_1)) {
+        mop_1 &= ~MO_BSWAP;
+        mop_2 &= ~MO_BSWAP;
+    }
+
     ret[0] = mop_1;
     ret[1] = mop_2;
 }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 36d8798bca..0cc719d799 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1595,6 +1595,11 @@ typedef struct {
     TCGType index_ext;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return false;
+}
+
 static const TCGLdstHelperParam ldst_helper_param = {
     .ntmp = 1, .tmp = { TCG_REG_TMP }
 };
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index eb0542f32e..e5aed03247 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1325,6 +1325,11 @@ typedef struct {
     bool index_scratch;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return false;
+}
+
 static TCGReg ldst_ra_gen(TCGContext *s, const TCGLabelQemuLdst *l, int arg)
 {
     /* We arrive at the slow path via "BLNE", so R14 contains l->raddr. */
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 21553f3c39..6d55ba5a1c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1776,6 +1776,11 @@ typedef struct {
     int seg;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return have_movbe;
+}
+
 /*
  * Because i686 has no register parameters and because x86_64 has xchg
  * to handle addr/data register overlap, we have placed all input arguments
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 7d0165349d..d26174dde5 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -828,6 +828,11 @@ typedef struct {
     TCGReg index;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return false;
+}
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index fa0f334e8d..cd0254a0d7 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1141,6 +1141,11 @@ typedef struct {
     MemOp align;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return false;
+}
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 218602c10c..b62a163014 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2017,6 +2017,11 @@ typedef struct {
     TCGReg index;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 415e6c6e15..37870c89fc 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -853,6 +853,11 @@ static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
     tcg_debug_assert(ok);
 }
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return false;
+}
+
 /* We have three temps, we might as well expose them. */
 static const TCGLdstHelperParam ldst_helper_param = {
     .ntmp = 3, .tmp = { TCG_REG_TMP0, TCG_REG_TMP1, TCG_REG_TMP2 }
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index de8aed5f77..22f0206b5a 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1574,6 +1574,11 @@ typedef struct {
     int disp;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
+
 static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc, TCGReg data,
                                    HostAddress h)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 0237188d65..bb23038529 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1011,6 +1011,11 @@ typedef struct {
     TCGReg index;
 } HostAddress;
 
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
+
 /*
  * For softmmu, perform the TLB load and compare.
  * For useronly, perform any required alignment tests.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4cf03a579c..41fbf042da 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -963,3 +963,8 @@ static void tcg_target_init(TCGContext *s)
 static inline void tcg_target_qemu_prologue(TCGContext *s)
 {
 }
+
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
-- 
2.34.1


