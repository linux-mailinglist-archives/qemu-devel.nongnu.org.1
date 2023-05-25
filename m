Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BEE711346
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQG-0008Ns-Nn; Thu, 25 May 2023 14:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQF-0008NE-0l
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:47 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQD-0005sZ-7F
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:46 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5341737d7aeso1703157a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038244; x=1687630244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+8VDPsv39XWgsAsG2YjKrkOuz6vMVoOvqu3SdlzPZ+I=;
 b=DOeM9uvSbjEGLIHWnmvWg9WMVXylB1lmys4cwKnXTyM5Q+7SDjSfi/dAkBllqCSLvS
 MHBSapKA+ao911IRO7lBPqlqGIyOGdzcuLGwyxGrdCe0AHSICfoz359iKQ+RUXMLjump
 thshcH+P60aLsy9K3Xu+EITPYZ+dKKwl1QFQ/YwBP/yJyOgSu4lYUZMOnbMRPGaxZL04
 +bYvEmgZL5llAa++okpPKnfvcYH/FbQq1oURTWp2l1RVujxpOLa5n+e8BZ0zReoZSM2W
 JEEZkXSCecXDPTAnqNHa0HakNrIzpau0iNtVpaokOx+0MliwBsyXJw0yOwnaD0BMD49w
 zfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038244; x=1687630244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8VDPsv39XWgsAsG2YjKrkOuz6vMVoOvqu3SdlzPZ+I=;
 b=FfkTXugG1OXxy7wHBEsX9rv/9rxw+pbQXiOrbrOPTvcp1Y25ow7+tDLGd2ii2p5gK2
 xqdQ/nZ0dcc3a5fiIamjl6iYiNjkI3achNVRofwt5vg6j7UobDHwkDbnYcKTLQi1isSm
 fVwOJiFifl+ThfQnoKbMNIEqYoBuxzxWwu/gg4PYFSf6bVQIVWcoCUFynW3ewH8txePY
 b+79+KQkEZctuWbQeBwYTNPw8JsHoZCLpDD6o5bMVofK15cLuYx18QjxlSnc6AZioCwf
 AuVCVmVJ7SnITch6cEyxh6FiG334YXXWrQxHDMUrd1F/BXrhXYYQ+ElAo6DE0O2ivWaT
 3vDA==
X-Gm-Message-State: AC+VfDyi7iYIHCuhBdI+GOM/7ooYBAxLOm2MUyXvOvIgMmFc9Aw72Fdu
 KaGBH4HoE4OsgfXGA4QLaG8PRqSchQsGHfIxxmo=
X-Google-Smtp-Source: ACHHUZ5Eqz1w5ypxRi25yGGb6qPhuIKD1QFSXPoQBM1V6L3qZhmlPkVQFEcNFPORozJNSNI+SYT7sQ==
X-Received: by 2002:a17:903:10c:b0:1af:beae:c0b with SMTP id
 y12-20020a170903010c00b001afbeae0c0bmr2366740plc.22.1685038243702; 
 Thu, 25 May 2023 11:10:43 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/23] tcg/mips: Use the constant pool for 64-bit constants
Date: Thu, 25 May 2023 11:10:20 -0700
Message-Id: <20230525181036.1559435-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

During normal processing, the constant pool is accessible via
TCG_REG_TB.  During the prologue, it is accessible via TCG_REG_T9.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.h     |  1 +
 tcg/mips/tcg-target.c.inc | 65 +++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 46b63e59cc..8fbb6c6507 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -208,5 +208,6 @@ extern bool use_mips32r2_instructions;
 
 #define TCG_TARGET_DEFAULT_MO           0
 #define TCG_TARGET_NEED_LDST_LABELS
+#define TCG_TARGET_NEED_POOL_LABELS
 
 #endif
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 7a19f8db1d..3b840ecc4c 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -25,6 +25,7 @@
  */
 
 #include "../tcg-ldst.c.inc"
+#include "../tcg-pool.c.inc"
 
 #if HOST_BIG_ENDIAN
 # define MIPS_BE  1
@@ -168,9 +169,18 @@ static bool reloc_pc16(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-    tcg_debug_assert(type == R_MIPS_PC16);
-    tcg_debug_assert(addend == 0);
-    return reloc_pc16(code_ptr, (const tcg_insn_unit *)value);
+    value += addend;
+    switch (type) {
+    case R_MIPS_PC16:
+        return reloc_pc16(code_ptr, (const tcg_insn_unit *)value);
+    case R_MIPS_16:
+        if (value != (int16_t)value) {
+            return false;
+        }
+        *code_ptr = deposit32(*code_ptr, 0, 16, value);
+        return true;
+    }
+    g_assert_not_reached();
 }
 
 #define TCG_CT_CONST_ZERO 0x100
@@ -486,6 +496,11 @@ static void tcg_out_nop(TCGContext *s)
     tcg_out32(s, 0);
 }
 
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0, count * sizeof(tcg_insn_unit));
+}
+
 static void tcg_out_dsll(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
 {
     tcg_out_opc_sa64(s, OPC_DSLL, OPC_DSLL32, rd, rt, sa);
@@ -543,8 +558,15 @@ static bool tcg_out_movi_two(TCGContext *s, TCGReg ret, tcg_target_long arg)
     return false;
 }
 
-static void tcg_out_movi(TCGContext *s, TCGType type,
-                         TCGReg ret, tcg_target_long arg)
+static void tcg_out_movi_pool(TCGContext *s, TCGReg ret,
+                              tcg_target_long arg, TCGReg tbreg)
+{
+    new_pool_label(s, arg, R_MIPS_16, s->code_ptr, tcg_tbrel_diff(s, NULL));
+    tcg_out_opc_imm(s, OPC_LD, ret, tbreg, 0);
+}
+
+static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
+                             tcg_target_long arg, TCGReg tbreg)
 {
     if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
         arg = (int32_t)arg;
@@ -554,18 +576,17 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     if (tcg_out_movi_two(s, ret, arg)) {
         return;
     }
+    assert(TCG_TARGET_REG_BITS == 64);
 
-    tcg_out_movi(s, TCG_TYPE_I32, ret, arg >> 31 >> 1);
-    if (arg & 0xffff0000ull) {
-        tcg_out_dsll(s, ret, ret, 16);
-        tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg >> 16);
-        tcg_out_dsll(s, ret, ret, 16);
-    } else {
-        tcg_out_dsll(s, ret, ret, 32);
-    }
-    if (arg & 0xffff) {
-        tcg_out_opc_imm(s, OPC_ORI, ret, ret, arg & 0xffff);
-    }
+    /* Otherwise, put 64-bit constants into the constant pool. */
+    tcg_out_movi_pool(s, ret, arg, tbreg);
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    TCGReg tbreg = TCG_TARGET_REG_BITS == 64 ? TCG_REG_TB : 0;
+    tcg_out_movi_int(s, type, ret, arg, tbreg);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
@@ -2383,10 +2404,20 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 #ifndef CONFIG_SOFTMMU
     if (guest_base != (int16_t)guest_base) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        /*
+         * The function call abi for n32 and n64 will have loaded $25 (t9)
+         * with the address of the prologue, so we can use that instead
+         * of TCG_REG_TB.
+         */
+#if TCG_TARGET_REG_BITS == 64 && !defined(__mips_abicalls)
+# error "Unknown mips abi"
+#endif
+        tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base,
+                         TCG_TARGET_REG_BITS == 64 ? TCG_REG_T9 : 0);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
 #endif
+
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
     }
-- 
2.34.1


