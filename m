Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB9821626
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 02:36:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKTgc-0006Y8-EK; Mon, 01 Jan 2024 20:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKTgV-0006Xz-6p
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:35:11 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKTgS-0004pV-32
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:35:10 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d4b650bc9cso8168915ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704159302; x=1704764102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8sooKBESMwiRbV7J/EJZrL8fz1lrtlkfYgONVpEAYSw=;
 b=vPwvFN3G9V4u6iQW3pnAd9IJ+5IKjrfDXAWZuodqaEk8AC1fpeDXSk8H75lKCd2YlX
 REom0czQOwSB4HRgOzKo3BJi2UU00/rweBvGOw9WSIh2T0V8NJHGTP1j8vAOrm41ZgaG
 wHJByH3QIpQBLqWDsAbkQgF4YQi9EOAp4fHXuOihm8kkeM/GgDC5d5AdqLioZbdIU+4e
 3U3OJ1t9V/slQYvVOzSMW+3hkeq84SKG78HZKYXUKEKqqmXoW/7wJlkZ+ugQzRFZZ0Jq
 gYpWxWwfQfyScBV8IJ2J12biA2YYjRrTNIre0yfKkHwi0QhVWl4+/4L1Tfltc/J68KJl
 5dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704159302; x=1704764102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8sooKBESMwiRbV7J/EJZrL8fz1lrtlkfYgONVpEAYSw=;
 b=dvUOIdkqLOCmRngOjDUOxdekiXwoveDP/Dh/kLUAEA/N3s2YJ3YtDRQ+jdVRAX3+is
 dDk4wwZY6rUF2Igz2EE43GrS4MbqWP6DJ+Pc9nWTPrEwdci2FX4Vpt2zmoP5/awQ/Z0L
 yCFC+jX718zaX87GYoG9FKRKX+J/0kBDRQ7EU7uHYf+l02paC6zXuwffhlr98iD9LAIz
 i4dyTNCqCl/B8P/mViijB1MfR+FSPVFfI95YWhMwimp7MWAbcf9w/igNQEfm8CwwhyJu
 FsRgI/ABtPkOqXH6wDtvurkH2JvGeJJiisdHZWGcHkD3Iop8VvQzWASx/QX8roPbQKeA
 Z98A==
X-Gm-Message-State: AOJu0YyJ7PdIWZUErF5+QvdNFtCO+9Qvf+6Ae5z8BbNQg5O2dP8Lgecx
 BO3srbjPe5vaH65MnNDl27sMMZ3LK9GJdKPDjVY1AP66xLA=
X-Google-Smtp-Source: AGHT+IHl3lSUajTFr9H6pJYOzbpOHiJZu5Srv4UL4A/wuHjsTKB06ozjCeMCROmG0JswtSYYP5m7Ag==
X-Received: by 2002:a17:902:b213:b0:1d4:3dfd:7e31 with SMTP id
 t19-20020a170902b21300b001d43dfd7e31mr17554714plr.139.1704159302604; 
 Mon, 01 Jan 2024 17:35:02 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 jm7-20020a17090304c700b001d3e6f58e5esm20675565plb.6.2024.01.01.17.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:35:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] tcg/ppc: Use new registers for LQ destination
Date: Tue,  2 Jan 2024 12:34:56 +1100
Message-Id: <20240102013456.131846-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

LQ has a constraint that RTp != RA, else SIGILL.
Therefore, force the destination of INDEX_op_qemu_*_ld128 to be a
new register pair, so that it cannot overlap the input address.

This requires new support in process_op_defs and tcg_reg_alloc_op.

Cc: qemu-stable@nongnu.org
Fixes: 526cd4ec01f ("tcg/ppc: Support 128-bit load/store")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

This bug may be triggered with qemu-aarch64 and
tests/tcg/multiarch/linux-test.c.

r~

---
 tcg/ppc/tcg-target-con-set.h |  2 +-
 tcg/tcg.c                    | 21 ++++++++++++++++-----
 tcg/ppc/tcg-target.c.inc     |  3 ++-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index bbd7b21247..cb47b29452 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -35,7 +35,7 @@ C_O1_I3(v, v, v, v)
 C_O1_I4(r, r, ri, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
-C_O2_I1(o, m, r)
+C_N1O1_I1(o, m, r)
 C_O2_I2(r, r, r, r)
 C_O2_I4(r, r, rI, rZM, r, r)
 C_O2_I4(r, r, r, r, rI, rZM)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 896a36caeb..e2c38f6d11 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -653,6 +653,7 @@ static void tcg_out_movext3(TCGContext *s, const TCGMovExtend *i1,
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4),
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2),
+#define C_N1O1_I1(O1, O2, I1)           C_PFX3(c_n1o1_i1_, O1, O2, I1),
 #define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1),
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1),
@@ -676,6 +677,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N1O1_I1
 #undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
@@ -696,6 +698,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
 #define C_O1_I4(O1, I1, I2, I3, I4)     { .args_ct_str = { #O1, #I1, #I2, #I3, #I4 } },
 
 #define C_N1_I2(O1, I1, I2)             { .args_ct_str = { "&" #O1, #I1, #I2 } },
+#define C_N1O1_I1(O1, O2, I1)           { .args_ct_str = { "&" #O1, #O2, #I1 } },
 #define C_N2_I1(O1, O2, I1)             { .args_ct_str = { "&" #O1, "&" #O2, #I1 } },
 
 #define C_O2_I1(O1, O2, I1)             { .args_ct_str = { #O1, #O2, #I1 } },
@@ -718,6 +721,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #undef C_O1_I3
 #undef C_O1_I4
 #undef C_N1_I2
+#undef C_N1O1_I1
 #undef C_N2_I1
 #undef C_O2_I1
 #undef C_O2_I2
@@ -738,6 +742,7 @@ static const TCGTargetOpDef constraint_sets[] = {
 #define C_O1_I4(O1, I1, I2, I3, I4)     C_PFX5(c_o1_i4_, O1, I1, I2, I3, I4)
 
 #define C_N1_I2(O1, I1, I2)             C_PFX3(c_n1_i2_, O1, I1, I2)
+#define C_N1O1_I1(O1, O2, I1)           C_PFX3(c_n1o1_i1_, O1, O2, I1)
 #define C_N2_I1(O1, O2, I1)             C_PFX3(c_n2_i1_, O1, O2, I1)
 
 #define C_O2_I1(O1, O2, I1)             C_PFX3(c_o2_i1_, O1, O2, I1)
@@ -2988,6 +2993,7 @@ static void process_op_defs(TCGContext *s)
                     .pair = 2,
                     .pair_index = o,
                     .regs = def->args_ct[o].regs << 1,
+                    .newreg = def->args_ct[o].newreg,
                 };
                 def->args_ct[o].pair = 1;
                 def->args_ct[o].pair_index = i;
@@ -3004,6 +3010,7 @@ static void process_op_defs(TCGContext *s)
                     .pair = 1,
                     .pair_index = o,
                     .regs = def->args_ct[o].regs >> 1,
+                    .newreg = def->args_ct[o].newreg,
                 };
                 def->args_ct[o].pair = 2;
                 def->args_ct[o].pair_index = i;
@@ -5036,17 +5043,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                 break;
 
             case 1: /* first of pair */
-                tcg_debug_assert(!arg_ct->newreg);
                 if (arg_ct->oalias) {
                     reg = new_args[arg_ct->alias_index];
-                    break;
+                } else if (arg_ct->newreg) {
+                    reg = tcg_reg_alloc_pair(s, arg_ct->regs,
+                                             i_allocated_regs | o_allocated_regs,
+                                             output_pref(op, k),
+                                             ts->indirect_base);
+                } else {
+                    reg = tcg_reg_alloc_pair(s, arg_ct->regs, o_allocated_regs,
+                                             output_pref(op, k),
+                                             ts->indirect_base);
                 }
-                reg = tcg_reg_alloc_pair(s, arg_ct->regs, o_allocated_regs,
-                                         output_pref(op, k), ts->indirect_base);
                 break;
 
             case 2: /* second of pair */
-                tcg_debug_assert(!arg_ct->newreg);
                 if (arg_ct->oalias) {
                     reg = new_args[arg_ct->alias_index];
                 } else {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 856c3b18f5..54816967bc 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2595,6 +2595,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
         tcg_debug_assert(!need_bswap);
         tcg_debug_assert(datalo & 1);
         tcg_debug_assert(datahi == datalo - 1);
+        tcg_debug_assert(!is_ld || datahi != index);
         insn = is_ld ? LQ : STQ;
         tcg_out32(s, insn | TAI(datahi, index, 0));
     } else {
@@ -4071,7 +4072,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_qemu_ld_a32_i128:
     case INDEX_op_qemu_ld_a64_i128:
-        return C_O2_I1(o, m, r);
+        return C_N1O1_I1(o, m, r);
     case INDEX_op_qemu_st_a32_i128:
     case INDEX_op_qemu_st_a64_i128:
         return C_O0_I3(o, m, r);
-- 
2.34.1


