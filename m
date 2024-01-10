Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9CA82A430
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLS-0007c0-5A; Wed, 10 Jan 2024 17:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhL6-0006qG-IQ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:28 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhL3-0003OH-Ie
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:24 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-429b76f129eso5485491cf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926779; x=1705531579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PZbgXf7h9mbijZSSPVJBmVbPzLYGP5B2/srtOcMXg4=;
 b=ZD4MpuTvHdcS1RTnLBac9sAla6Bo8P9t0XEho+bRt56f7lFfhferHrMco4oCrgWv+V
 kHRbGlsdsOTGxugqLmiPP9XPxRK6fR2ZMVdPX62bNMQ3E3YAXo1M5pUTAIuDGMm5mlnb
 QVUkhsesCcMgOlXIlTubkvVoIXrOK/f+S0j76Fv1BCLfEfgYLs/skNC+lNBJrk4swvrX
 MQTELcbiMbmyhXoILCpOvUHOiJLk3DO/MJ1gQh09Qarrf3s6GObqHTBBBtkjCKGx7PnE
 mI6SzqA11p1s/qhOheCseg4xPiCLXxhQG7qHA7/7FkjfAzkQBCm422FcJGokmP4uwdOq
 bB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926779; x=1705531579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PZbgXf7h9mbijZSSPVJBmVbPzLYGP5B2/srtOcMXg4=;
 b=toiezqFMmpBMFC+hHZqbTDEe8D7GMPyWbDI1e00ZYxx1PLwGwtL5BU7bGhEMviJSag
 gY1D1ZdBRSlwMFfgEkxjPU2FJoRkWxTpECN75XjB5Cb0tYgsmbTHrHgBWHHKIlMQb1Cq
 iIC6ATqwibc0emzcWGpFJQrPdYvJCTr750fjl7riWnxd1wPCdPVyTtmSFgKmcAvFM2R5
 3JM/u5lq8ZJNHsEq3RxYfYS/opKREolsLfL9rok8am1RUKvidfJUg2TrXxX+fUHoFOge
 Bhn96TO+D7UqvNrxg1nA8qurjtutxLiHCB+5t+VBCJM07ScAa9CpzpSc1QBNQOyrkNHn
 VPkg==
X-Gm-Message-State: AOJu0YxEgeg7jWzxvnaxnuGjHMFPmWrylp/UjLH8gwBolcawVAQSDS+f
 zrhjFTW/cs26PKoExX3B/OoW+ipPYG3O9yqBoYURuzJq9EW2CAqp
X-Google-Smtp-Source: AGHT+IGUAR2TtOUl5Ni8shVTh5sVLaTOOGoYSiuSVk2D7PamUwH4bDTH6+L3QQ++6oIAAtZq3HqgXg==
X-Received: by 2002:a05:622a:1c3:b0:429:9a2b:89d7 with SMTP id
 t3-20020a05622a01c300b004299a2b89d7mr286776qtw.92.1704926778742; 
 Wed, 10 Jan 2024 14:46:18 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 25/38] tcg/i386: Improve TSTNE/TESTEQ vs powers of two
Date: Thu, 11 Jan 2024 09:43:55 +1100
Message-Id: <20240110224408.10444-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82d.google.com
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

Use "test x,x" when the bit is one of the 4 sign bits.
Use "bt imm,x" otherwise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  6 ++--
 tcg/i386/tcg-target-con-str.h |  1 +
 tcg/i386/tcg-target.c.inc     | 54 +++++++++++++++++++++++++++++++----
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 7d00a7dde8..e24241cfa2 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -20,7 +20,7 @@ C_O0_I2(L, L)
 C_O0_I2(qi, r)
 C_O0_I2(re, r)
 C_O0_I2(ri, r)
-C_O0_I2(r, re)
+C_O0_I2(r, reT)
 C_O0_I2(s, L)
 C_O0_I2(x, r)
 C_O0_I3(L, L, L)
@@ -34,7 +34,7 @@ C_O1_I1(r, r)
 C_O1_I1(x, r)
 C_O1_I1(x, x)
 C_O1_I2(q, 0, qi)
-C_O1_I2(q, r, re)
+C_O1_I2(q, r, reT)
 C_O1_I2(r, 0, ci)
 C_O1_I2(r, 0, r)
 C_O1_I2(r, 0, re)
@@ -50,7 +50,7 @@ C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
 C_O1_I3(x, 0, x, x)
 C_O1_I3(x, x, x, x)
-C_O1_I4(r, r, re, r, 0)
+C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index 95a30e58cd..cc22db227b 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -28,5 +28,6 @@ REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
  */
 CONST('e', TCG_CT_CONST_S32)
 CONST('I', TCG_CT_CONST_I32)
+CONST('T', TCG_CT_CONST_TST)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('Z', TCG_CT_CONST_U32)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f2414177bd..0b8c60d021 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -132,6 +132,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_U32 0x200
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
+#define TCG_CT_CONST_TST 0x1000
 
 /* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
@@ -202,7 +203,8 @@ static bool tcg_target_const_match(int64_t val, int ct,
         return 1;
     }
     if (type == TCG_TYPE_I32) {
-        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 | TCG_CT_CONST_I32)) {
+        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 |
+                  TCG_CT_CONST_I32 | TCG_CT_CONST_TST)) {
             return 1;
         }
     } else {
@@ -215,6 +217,17 @@ static bool tcg_target_const_match(int64_t val, int ct,
         if ((ct & TCG_CT_CONST_I32) && ~val == (int32_t)~val) {
             return 1;
         }
+        /*
+         * This will be used in combination with TCG_CT_CONST_S32,
+         * so "normal" TESTQ is already matched.  Also accept:
+         *    TESTQ -> TESTL   (uint32_t)
+         *    TESTQ -> BT      (is_power_of_2)
+         */
+        if ((ct & TCG_CT_CONST_TST)
+            && is_tst_cond(cond)
+            && (val == (uint32_t)val || is_power_of_2(val))) {
+            return 1;
+        }
     }
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
@@ -396,6 +409,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_SHRD_Ib     (0xac | P_EXT)
+#define OPC_TESTB	(0x84)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
 #define OPC_UD2         (0x0b | P_EXT)
@@ -442,6 +456,12 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_GRP3_Ev     (0xf7)
 #define OPC_GRP5        (0xff)
 #define OPC_GRP14       (0x73 | P_EXT | P_DATA16)
+#define OPC_GRPBT       (0xba | P_EXT)
+
+#define OPC_GRPBT_BT    4
+#define OPC_GRPBT_BTS   5
+#define OPC_GRPBT_BTR   6
+#define OPC_GRPBT_BTC   7
 
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
@@ -1454,7 +1474,7 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
-    int jz;
+    int jz, js;
 
     if (!is_tst_cond(cond)) {
         if (!const_arg2) {
@@ -1469,6 +1489,7 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
     }
 
     jz = tcg_cond_to_jcc[cond];
+    js = (cond == TCG_COND_TSTNE ? JCC_JS : JCC_JNS);
 
     if (!const_arg2) {
         tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
@@ -1476,17 +1497,40 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
     }
 
     if (arg2 <= 0xff && (TCG_TARGET_REG_BITS == 64 || arg1 < 4)) {
+        if (arg2 == 0x80) {
+            tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
+            return js;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
         tcg_out8(s, arg2);
         return jz;
     }
 
     if ((arg2 & ~0xff00) == 0 && arg1 < 4) {
+        if (arg2 == 0x8000) {
+            tcg_out_modrm(s, OPC_TESTB, arg1 + 4, arg1 + 4);
+            return js;
+        }
         tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
         tcg_out8(s, arg2 >> 8);
         return jz;
     }
 
+    if (is_power_of_2(rexw ? arg2 : (uint32_t)arg2)) {
+        int jc = (cond == TCG_COND_TSTNE ? JCC_JB : JCC_JAE);
+        int sh = ctz64(arg2);
+
+        rexw = (sh & 32 ? P_REXW : 0);
+        if ((sh & 31) == 31) {
+            tcg_out_modrm(s, OPC_TESTL | rexw, arg1, arg1);
+            return js;
+        } else {
+            tcg_out_modrm(s, OPC_GRPBT | rexw, OPC_GRPBT_BT, arg1);
+            tcg_out8(s, sh);
+            return jc;
+        }
+    }
+
     if (rexw) {
         if (arg2 == (uint32_t)arg2) {
             rexw = 0;
@@ -3399,7 +3443,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, re);
+        return C_O0_I2(r, reT);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3447,11 +3491,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(q, r, re);
+        return C_O1_I2(q, r, reT);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, re, r, 0);
+        return C_O1_I4(r, r, reT, r, 0);
 
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.34.1


