Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963DA80BD80
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:08:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxK-0004vP-2x; Sun, 10 Dec 2023 17:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxI-0004vG-Ud
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:20 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxH-0004YL-5h
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:20 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d9ac148ca3so2600895a34.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246037; x=1702850837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nToee3KpjsUzxDr4LX2hZbylR7YMxRwtPLDN/VMQMvY=;
 b=GJVnkktcM6klmPNoLz/t6YP05hLi09gU6IrCXp5r3V0aRRJDP/48aqtfLm3vqiL79E
 UotYxagmHOXprrMJzGdZaET8AMAlQOToSE64P/DCK3fClvKWAKLH/Dsdx7PKHuZkXOrr
 ZtWfwdYr/w8JT5SYXAEH4Fmg0eIRh+Z3UMme55pc4NzPKbCUBQ3LH/Z3T4lgKHemkSdX
 2jvZORwja38qcrTZbGUnD87DQ6XI533OKK+pWW6UuqClbhadJvHR6tPFu9ayOUicr1Kh
 CLOsupHWPtf82VypcRoV4kCmRswAmoMQ/T1lK5T2rb7/wTwgwKAr6EtnlPjTpYIconf1
 DR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246037; x=1702850837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nToee3KpjsUzxDr4LX2hZbylR7YMxRwtPLDN/VMQMvY=;
 b=RcAAZssNJyybveu8rFh9wMIjsgcAs790z7KYnFeEEQ83B9JJW3KP8NXvk+GAlwjvxu
 NRb5UzyCHYj0iKO8vdmSkKeoLylYHzt+2Spqmsqxy9fDJLZYZD/+G+loRtIn9Pd4mcyx
 oONO3AkUo2F4tUcTnhtPJYdG3mI7poD290Dlkd0rFZxIR4DEMCcIyOcVrPyqcYKG8uvB
 c5PXj62Et57rEG5d9KuuzErP0Bgpoel18UELAJHu+VLbmD6tr2LTDNTtejhtmfspGp8H
 mnSolUfIpb7d894ZsKvwat+d2NZGE2VJZb8X3B/1pbBi2urSscG2D1dYHor1Ok/pVR5l
 5eWg==
X-Gm-Message-State: AOJu0YzwJyUIvCAHPcTVBq973vYMOh5oIw9XZdEC4lzj4BwT+Q8AsUda
 vbB6aKLRngEEQWiFECyQCTChV1BORuOplA==
X-Google-Smtp-Source: AGHT+IEcOaZWCpJOmiVvvt0+sVk3RLBakMPgCbEo52guRGzuY1ZkEeoYGH4FxQb23QXwjlyUJ/z8ug==
X-Received: by 2002:a05:6830:1b72:b0:6d9:dd36:1079 with SMTP id
 d18-20020a0568301b7200b006d9dd361079mr2617877ote.30.1702246036967; 
 Sun, 10 Dec 2023 14:07:16 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:16 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 1/9] Hexagon (target/hexagon) Clean up handling of modifier
 registers
Date: Sun, 10 Dec 2023 15:07:04 -0700
Message-Id: <20231210220712.491494-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently, the register number (MuN) for modifier registers is the
modifier register number rather than the index into hex_gpr.  This
patch changes MuN to the hex_gpr index, which is consistent with
the handling of control registers.

Note that HELPER(fcircadd) needs the CS register corresponding to the
modifier register specified in the instruction.  We create a TCGv
variable "CS" to hold the value to pass to the helper.

Reviewed-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_tcg.h                    |  9 ++++-----
 target/hexagon/macros.h                     |  3 +--
 target/hexagon/idef-parser/parser-helpers.c |  8 +++-----
 target/hexagon/gen_tcg_funcs.py             | 13 +++++++++----
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index d992059fce..1c4391b415 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -68,15 +68,14 @@
     do { \
         TCGv tcgv_siV = tcg_constant_tl(siV); \
         tcg_gen_mov_tl(EA, RxV); \
-        gen_helper_fcircadd(RxV, RxV, tcgv_siV, MuV, \
-                            hex_gpr[HEX_REG_CS0 + MuN]); \
+        gen_helper_fcircadd(RxV, RxV, tcgv_siV, MuV, CS); \
     } while (0)
 #define GET_EA_pcr(SHIFT) \
     do { \
         TCGv ireg = tcg_temp_new(); \
         tcg_gen_mov_tl(EA, RxV); \
         gen_read_ireg(ireg, MuV, (SHIFT)); \
-        gen_helper_fcircadd(RxV, RxV, ireg, MuV, hex_gpr[HEX_REG_CS0 + MuN]); \
+        gen_helper_fcircadd(RxV, RxV, ireg, MuV, CS); \
     } while (0)
 
 /* Instructions with multiple definitions */
@@ -113,7 +112,7 @@
         TCGv ireg = tcg_temp_new(); \
         tcg_gen_mov_tl(EA, RxV); \
         gen_read_ireg(ireg, MuV, SHIFT); \
-        gen_helper_fcircadd(RxV, RxV, ireg, MuV, hex_gpr[HEX_REG_CS0 + MuN]); \
+        gen_helper_fcircadd(RxV, RxV, ireg, MuV, CS); \
         LOAD; \
     } while (0)
 
@@ -427,7 +426,7 @@
         TCGv BYTE G_GNUC_UNUSED = tcg_temp_new(); \
         tcg_gen_mov_tl(EA, RxV); \
         gen_read_ireg(ireg, MuV, SHIFT); \
-        gen_helper_fcircadd(RxV, RxV, ireg, MuV, hex_gpr[HEX_REG_CS0 + MuN]); \
+        gen_helper_fcircadd(RxV, RxV, ireg, MuV, CS); \
         STORE; \
     } while (0)
 
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 9a51b5709b..939f22e76b 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -462,8 +462,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #define fPM_CIRI(REG, IMM, MVAL) \
     do { \
         TCGv tcgv_siV = tcg_constant_tl(siV); \
-        gen_helper_fcircadd(REG, REG, tcgv_siV, MuV, \
-                            hex_gpr[HEX_REG_CS0 + MuN]); \
+        gen_helper_fcircadd(REG, REG, tcgv_siV, MuV, CS); \
     } while (0)
 #else
 #define fEA_IMM(IMM)        do { EA = (IMM); } while (0)
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 4af020933a..95f2b43076 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1541,10 +1541,8 @@ void gen_circ_op(Context *c,
                  HexValue *increment,
                  HexValue *modifier)
 {
-    HexValue cs = gen_tmp(c, locp, 32, UNSIGNED);
     HexValue increment_m = *increment;
     increment_m = rvalue_materialize(c, locp, &increment_m);
-    OUT(c, locp, "gen_read_reg(", &cs, ", HEX_REG_CS0 + MuN);\n");
     OUT(c,
         locp,
         "gen_helper_fcircadd(",
@@ -1555,7 +1553,7 @@ void gen_circ_op(Context *c,
         &increment_m,
         ", ",
         modifier);
-    OUT(c, locp, ", ", &cs, ");\n");
+    OUT(c, locp, ", CS);\n");
 }
 
 HexValue gen_locnt_op(Context *c, YYLTYPE *locp, HexValue *src)
@@ -2080,9 +2078,9 @@ void emit_arg(Context *c, YYLTYPE *locp, HexValue *arg)
             char reg_id[5];
             reg_compose(c, locp, &(arg->reg), reg_id);
             EMIT_SIG(c, ", %s %s", type, reg_id);
-            /* MuV register requires also MuN to provide its index */
+            /* MuV register requires also CS for circular addressing*/
             if (arg->reg.type == MODIFIER) {
-                EMIT_SIG(c, ", int MuN");
+                EMIT_SIG(c, ", TCGv CS");
             }
         }
         break;
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index f5246cee6d..02d93bc5ce 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -99,10 +99,15 @@ def genptr_decl(f, tag, regtype, regid, regno):
             hex_common.bad_register(regtype, regid)
     elif regtype == "M":
         if regid == "u":
-            f.write(f"    const int {regtype}{regid}N = " f"insn->regno[{regno}];\n")
             f.write(
-                f"    TCGv {regtype}{regid}V = hex_gpr[{regtype}{regid}N + "
-                "HEX_REG_M0];\n"
+                f"    const int {regN} = insn->regno[{regno}] + HEX_REG_M0;\n"
+            )
+            f.write(
+                f"    TCGv {regtype}{regid}V = hex_gpr[{regN}];\n"
+            )
+            f.write(
+                f"    TCGv CS G_GNUC_UNUSED = "
+                f"hex_gpr[{regN} - HEX_REG_M0 + HEX_REG_CS0];\n"
             )
         else:
             hex_common.bad_register(regtype, regid)
@@ -528,7 +533,7 @@ def gen_tcg_func(f, tag, regs, imms):
             ):
                 declared.append(f"{regtype}{regid}V")
                 if regtype == "M":
-                    declared.append(f"{regtype}{regid}N")
+                    declared.append("CS")
             elif hex_common.is_new_val(regtype, regid, tag):
                 declared.append(f"{regtype}{regid}N")
             else:
-- 
2.34.1


