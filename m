Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C36AC80445B
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:55:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKci-0002qM-HT; Mon, 04 Dec 2023 20:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcZ-0002op-HB
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:12 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcX-0005wW-37
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:11 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b9b5bff21dso879358b6e.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741187; x=1702345987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+xw6cDtD9Xo7VPFC8PF4shwTNOtffqrMA4Lsk7sfeY=;
 b=YdQZpYhri8hbj7UL9JipVnewvgMkL9NXmtaxqstXuWkdWDS4JBABMJxda9gwX0wkDZ
 XV6GucEYSBWYzuHAgQAiSG2YKPAOfAip8P458Ot1qD1U6aP55CNkQx28Ut4YEql379K0
 o8aOEaBatWvhdj8P8dPeVGv0U+/RUVWROAws9596jkiHt+mTenneTmdpgeopjgKlfvJn
 mJkiW48Rbs4ttqTKdtMcfKpBypgltsYgfp0X5dA1+yTGR+WnLhLBRyPXavjXA8hKSNKt
 g4kMqP46jMzhYi5781Z/M7h5PsleKb0g21WLbPDfLrNOmpSP4P4hAir7RlFg0hsYcWPm
 XGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741187; x=1702345987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+xw6cDtD9Xo7VPFC8PF4shwTNOtffqrMA4Lsk7sfeY=;
 b=kQD+lBKbWtKJbe58yGmyYXiK3lCstcBGzGNSOaAhGaTSjSy9/9GhxqsrtIyRJ7tPnO
 qIwhvDoCzG7wJ55poCL9i3NipeQ+5i1MctPA2VaN8Ai6mpuqVCyotuP/jrjkO1zK2SmD
 lYJy+9CkGI+vPCqljtJADYU5Lk0y4jj58oc76jFY8RE3GAWnJT7aa4ZFXhUbe+1LsWUC
 EKIP+KSEcbz/Mxf3tObgFJvTNTvUAS8hnaP8usf0VRZUy2qYIyJ8IwaDXf/X3DXoWgSp
 v+RZdbc8Ovd9fRI5BHSIoTydM5miQV38KwT5VqUiW6asYHZt3JRt7zpTaCv2y1uY4/8E
 lRjw==
X-Gm-Message-State: AOJu0Yw8EjztD/6H97pvO2g4LlqKaN5ZajvKm236KEL4v2XuKnGVk0g8
 gVylKvDLpDm3PXt5RVfkJU8eICZDoY02HQ==
X-Google-Smtp-Source: AGHT+IEV2TlfaIQq4yOQuUywlxoBSTGnOZc0wrQ7GHqY3PHlTdQ5Ro/jdfFJtgLlrgBzGydRap0LAw==
X-Received: by 2002:a05:6808:1451:b0:3b8:d135:dcfa with SMTP id
 x17-20020a056808145100b003b8d135dcfamr3199739oiv.34.1701741187120; 
 Mon, 04 Dec 2023 17:53:07 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:06 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 1/9] Hexagon (target/hexagon) Clean up handling of modifier
 registers
Date: Mon,  4 Dec 2023 18:52:55 -0700
Message-Id: <20231205015303.575807-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x235.google.com
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


