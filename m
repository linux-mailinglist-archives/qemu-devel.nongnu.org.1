Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E5CA9D582
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Apr 2025 00:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8REE-0002Qr-OB; Fri, 25 Apr 2025 18:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RBE-0004UF-25
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:56 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB8-0001vp-Eu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so2399278b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618749; x=1746223549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FziRGIXfSiS1sEmBICXYuOLaaaYBVzV0oep8Ljhm2cY=;
 b=qotmQxUJB0vj/0wjEDITGFAjwYz7OdBAiNsoSA5BbhlNFN6QHNs/oZnUUalZTLKLSc
 6fy4GOZiFpundzL3IrnHdhbvIqCmlPlm+uvfUh3ORUFVgDvUU9O1XYzRNR1PXL8EJNTi
 FgvG+Q8m7Suz/itkjO8THmMjt1fQoLDCxmYzbHxeDEzyTfBjOMLPYGx88Q143kH4hxj6
 myWhJSd0VIw5tmuD0SI6eeaOgGS3/TdeqAIWEZj4IEP7qFLlFoPmkRmqIZ+xo4g/TH8g
 LcAC1L+C8uPCvnxC5HVV+U3SckSRv7ypYcasewv6CbUA4blmReG2oeFgTMe5ph17rnA4
 xcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618749; x=1746223549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FziRGIXfSiS1sEmBICXYuOLaaaYBVzV0oep8Ljhm2cY=;
 b=bJYgqB0pqf/duxMMAcC0jHHDTIAoA9G28e1AhAscVV20+Dc7NscoiSBRE+d/WmjGsw
 1Lz6uuHAfhvX/dxQxzViLQzoMS0+2L0HNOZcgi9k1VLb2s6th0U0a7saY6e+s7TfXvwR
 HJ/e/GCAu3v4ktKlxKcARocUhRpKHKT54nH66j15VnmntIutI5U3wfwVmB24vE9pjj8w
 YVzULBZ+U4AySTyNnNouJpVkgAwSYkgMoi9brKqEmRrMfRJHOcdevTFyYj4kr5nyuDdq
 MafGyPY4oGJi3zPRetkZjbmRaiGmwL7pp0CBKe4VJf/QTzKnrl0PckelyW1SQP5Vru4W
 ifSw==
X-Gm-Message-State: AOJu0YxYDULoghYZBxtKKmTU5Fa3tPPTQkxnvYUB+nI+x/SHL+o/sTCI
 dFFD3TkZaD2Ad2Jy4qrdA5BjRkaSm9j+HwJK6DOL464NthZJcSaGb8Lo/nM+VpwGXPVn3T2dCzC
 8
X-Gm-Gg: ASbGncv8fBxGuuZnJAvp9g4yQ7mL17TEYR6gd+E4GoKuPIiuazhQ+MW1Gid1+N2ZpfI
 dJFk+bgYRIhpPsq4Au+WadBKMMy79hrkZ4g1fF+gpMnlG7HkCPrhWJVh4UaS0elFShkcvFPQNSL
 NreGh819z2P0t4FLGlp8Ej0fNwJ5GHKCThBhUSNWeCGo8mkjn6DSH7jldYQ+jaiCsh7gDvJbqoV
 vksmr06HnSXRdQMo1BoS9P8zX+sfzMRbReH044LyCYBzVnV7NFoJkz/VGK146DbwaGXiqBhvRec
 NzgSWAsRf8Q97E/BAzMDxhhw6kM5rXP77CedlzQzlbleCOtNRud536tkKV1HqCWeS8IT+pubEf8
 =
X-Google-Smtp-Source: AGHT+IEIOxcc2e0h88LS+vLEu0inwxnHanPXHen6CMdmAYiuXnJdjLtt6LLUYoP9Rgyvetvd47TUnw==
X-Received: by 2002:a05:6a00:cce:b0:736:532b:7c10 with SMTP id
 d2e1a72fcca58-73fd8f4d647mr5149546b3a.21.1745618748892; 
 Fri, 25 Apr 2025 15:05:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 155/159] tcg: Remove INDEX_op_qemu_st8_*
Date: Fri, 25 Apr 2025 14:54:49 -0700
Message-ID: <20250425215454.886111-156-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The i386 backend can now check TCGOP_FLAGS to select
the correct set of constraints.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 4 ----
 tcg/aarch64/tcg-target-has.h     | 1 -
 tcg/arm/tcg-target-has.h         | 1 -
 tcg/i386/tcg-target-con-str.h    | 2 +-
 tcg/i386/tcg-target-has.h        | 3 ---
 tcg/loongarch64/tcg-target-has.h | 3 ---
 tcg/mips/tcg-target-has.h        | 1 -
 tcg/ppc/tcg-target-has.h         | 2 --
 tcg/riscv/tcg-target-has.h       | 1 -
 tcg/s390x/tcg-target-has.h       | 1 -
 tcg/sparc64/tcg-target-has.h     | 1 -
 tcg/tci/tcg-target-has.h         | 2 --
 tcg/optimize.c                   | 1 -
 tcg/tcg-op-ldst.c                | 9 ++-------
 tcg/tcg.c                        | 4 ----
 docs/devel/tcg-ops.rst           | 6 ------
 tcg/i386/tcg-target.c.inc        | 9 ++++-----
 17 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a22433d8b5..0ce8332aab 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -133,10 +133,6 @@ DEF(qemu_ld_i64, DATA64_ARGS, 1, 1,
 DEF(qemu_st_i64, 0, DATA64_ARGS + 1, 1,
     TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
-/* Only used by i386 to cope with stupid register constraints. */
-DEF(qemu_st8_i32, 0, 1 + 1, 1,
-    TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
-
 /* Only for 64-bit hosts at the moment. */
 DEF(qemu_ld_i128, 2, 1, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 DEF(qemu_st_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index b155e37639..69e83efb69 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -14,7 +14,6 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 187269e5bd..3bbbde5d59 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,7 +24,6 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              1
 
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index 52142ab121..dbedff1f54 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -20,7 +20,7 @@ REGS('r', ALL_GENERAL_REGS)
 REGS('x', ALL_VECTOR_REGS)
 REGS('q', ALL_BYTEL_REGS)     /* regs that can be used as a byte operand */
 REGS('L', ALL_GENERAL_REGS & ~SOFTMMU_RESERVE_REGS)  /* qemu_ld/st */
-REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
+REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st MO_8 data */
 
 /*
  * Define constraint letters for constants:
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 628e736de7..42647fabbd 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -29,9 +29,6 @@
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-#else
-#define TCG_TARGET_HAS_qemu_st8_i32     1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 \
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 9c118bd1f6..32abc6f457 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -9,9 +9,6 @@
 
 #include "host/cpuinfo.h"
 
-/* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 /* 64-bit operations */
 #define TCG_TARGET_HAS_extr_i64_i32     1
 
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index d8f9f7beef..b9eb338528 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -46,7 +46,6 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
 
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index b978c91a62..81ec5aece7 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -17,8 +17,6 @@
 #define have_vsx       (cpuinfo & CPUINFO_VSX)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #endif
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index 8cd099546f..aef10c2d9d 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -10,7 +10,6 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              0
diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index c04cc4e377..0aeb5ba01a 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -30,7 +30,6 @@ extern uint64_t s390_facilities[3];
 
 /* optional instructions */
 #define TCG_TARGET_HAS_extr_i64_i32   0
-#define TCG_TARGET_HAS_qemu_st8_i32   0
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 #define TCG_TARGET_HAS_tst            1
 
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index d9f5ef3fc9..af6a949da3 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,7 +14,6 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_qemu_st8_i32     0
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 #define TCG_TARGET_HAS_tst              1
diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 497e8152b7..ab07ce1fcb 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -7,8 +7,6 @@
 #ifndef TCG_TARGET_HAS_H
 #define TCG_TARGET_HAS_H
 
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
 #endif /* TCG_TARGET_REG_BITS == 64 */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index cfb407c7fc..4d2220664a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3192,7 +3192,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_qemu_ld_i128:
             done = fold_qemu_ld_2reg(&ctx, op);
             break;
-        case INDEX_op_qemu_st8_i32:
         case INDEX_op_qemu_st_i32:
         case INDEX_op_qemu_st_i64:
         case INDEX_op_qemu_st_i128:
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 9e4626e51d..ac1af9f77c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -270,7 +270,6 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
 {
     TCGv_i32 swap = NULL;
     MemOpIdx orig_oi, oi;
-    TCGOpcode opc;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
@@ -293,12 +292,8 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    if (TCG_TARGET_HAS_qemu_st8_i32 && (memop & MO_SIZE) == MO_8) {
-        opc = INDEX_op_qemu_st8_i32;
-    } else {
-        opc = INDEX_op_qemu_st_i32;
-    }
-    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst(INDEX_op_qemu_st_i32, TCG_TYPE_I32,
+             tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 44b6b8319f..5c0cab205c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2438,9 +2438,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return true;
 
-    case INDEX_op_qemu_st8_i32:
-        return TCG_TARGET_HAS_qemu_st8_i32;
-
     case INDEX_op_qemu_ld_i128:
     case INDEX_op_qemu_st_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
@@ -3012,7 +3009,6 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                 break;
             case INDEX_op_qemu_ld_i32:
             case INDEX_op_qemu_st_i32:
-            case INDEX_op_qemu_st8_i32:
             case INDEX_op_qemu_ld_i64:
             case INDEX_op_qemu_st_i64:
             case INDEX_op_qemu_ld_i128:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index a7147407de..f26b837a30 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -744,8 +744,6 @@ QEMU specific operations
 
        qemu_st_i32/i64/i128 *t0*, *t1*, *flags*, *memidx*
 
-       qemu_st8_i32 *t0*, *t1*, *flags*, *memidx*
-
      - | Load data at the guest address *t1* into *t0*, or store data in *t0* at guest
          address *t1*.  The _i32/_i64/_i128 size applies to the size of the input/output
          register *t0* only.  The address *t1* is always sized according to the guest,
@@ -763,10 +761,6 @@ QEMU specific operations
          64-bit memory access specified in *flags*.
        |
        | For qemu_ld/st_i128, these are only supported for a 64-bit host.
-       |
-       | For i386, qemu_st8_i32 is exactly like qemu_st_i32, except the size of
-         the memory operation is known to be 8-bit.  This allows the backend to
-         provide a different set of register constraints.
 
 
 Host vector operations
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 52285bcd54..6c4c2ebd0e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2457,7 +2457,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 
     switch (memop & MO_SIZE) {
     case MO_8:
-        /* This is handled with constraints on INDEX_op_qemu_st8_i32. */
+        /* This is handled with constraints on INDEX_op_qemu_st_i32. */
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || datalo < 4);
         tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + h.seg,
                                  datalo, h.base, h.index, 0, h.ofs);
@@ -3568,7 +3568,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_st_i32:
-    case INDEX_op_qemu_st8_i32:
         tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
@@ -4140,9 +4139,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I1(r, L);
 
     case INDEX_op_qemu_st_i32:
-        return C_O0_I2(L, L);
-    case INDEX_op_qemu_st8_i32:
-        return C_O0_I2(s, L);
+        return (TCG_TARGET_REG_BITS == 32 && flags == MO_8
+                ? C_O0_I2(s, L)
+                : C_O0_I2(L, L));
 
     case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L) : C_O2_I1(r, r, L);
-- 
2.43.0


