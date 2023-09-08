Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5319C7981C8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUcq-0000LV-FE; Fri, 08 Sep 2023 02:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUco-0000Ka-5P
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:50 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcl-0005bK-Nz
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:49 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso13413035ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153145; x=1694757945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qepJics0tn9vo/6916LL1wFiawsxHmg1P1pjmA4MfdI=;
 b=pwEP/HGMqOCi0T51zz6yPVNaIqIHZQu1HNGqa0NJnVi37WVbiDpGf+eKl0Ggb9EdrI
 Rx+pK+JMtgPhULqaX2FTiyRwvKbjaQtJzPQrOPvfTJP28drG4R1auaNSHMCZHTJ9zs+v
 iRsTwRZ1M8RNpbxP9F/Kk/1qb0OZau2UtdCtISX1EkqAcxGvPN8tluvfUH+9BGca8aFe
 9lbYPLJXzWIuc0a2poKUAp1sPKmWKdgww/T0jSs75pUrXjOqp2+r/UeHMXCIQ+VmQ/tT
 LaKDJkQLRKP/8jVK+ztqwgC8GnjvyWgwvreN5RvMOm8jqBAhElpUHIS+GJFHvjF78hla
 dJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153145; x=1694757945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qepJics0tn9vo/6916LL1wFiawsxHmg1P1pjmA4MfdI=;
 b=X8l7A+tBLz5atYovzJITgto5PoFrw7SZCdy5PJH0HxWv4vvnb1Tajwidb0wLI/0keA
 dEqv89CfSxvCGcX3dQhT6+n9JkcDNkcHfNhuDRlsrnH0CM0pP1ZOayohAdXETxG+ybl2
 M+jHnnt9j37LrZOMuF0cSDpLTQiXZO06TXINhoucCV8bG/aYNimcEiDX25ODinJ32kLa
 a93FnozKK0sOC2sDZRUY552bYsXyM5b0BTvnJY9xjekn/JnOmx4tCOLXEa1nkH6OyByX
 afZwoKhnniBfquV3xKKmdObslQx0Zu9s8vTsnTeC66FXqJNAFw6AXln8o012bPQWnLpD
 e2Rg==
X-Gm-Message-State: AOJu0YyzzXN3fae8ZDlXvELRELaaTETpwmdYf8irpcBz7v+vr+rktsy+
 bFN584MDvroLPW3XyvOq6VnZJOTekfzj4Gnz
X-Google-Smtp-Source: AGHT+IHAp0kRiFQy7dc9doY79PFw1DvRwh+zwCAS7g2/kKos4dtRUMGTwGvLS/1K7sYrPvzMymg70Q==
X-Received: by 2002:a17:902:bcc6:b0:1bf:25a0:f875 with SMTP id
 o6-20020a170902bcc600b001bf25a0f875mr1371125pls.39.1694153145401; 
 Thu, 07 Sep 2023 23:05:45 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:05:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Dickon Hood <dickon.hood@codethink.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/65] target/riscv: Refactor translation of vector-widening
 instruction
Date: Fri,  8 Sep 2023 16:03:39 +1000
Message-ID: <20230908060431.1903919-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Dickon Hood <dickon.hood@codethink.co.uk>

Zvbb (implemented in later commit) has a widening instruction, which
requires an extra check on the enabled extensions.  Refactor
GEN_OPIVX_WIDEN_TRANS() to take a check function to avoid reimplementing
it.

Signed-off-by: Dickon Hood <dickon.hood@codethink.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20230711165917.2629866-7-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 52 +++++++++++--------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 5dfd524c7d..a556250553 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1526,30 +1526,24 @@ static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
-static bool do_opivx_widen(DisasContext *s, arg_rmrr *a,
-                           gen_helper_opivx *fn)
-{
-    if (opivx_widen_check(s, a)) {
-        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
-    }
-    return false;
-}
-
-#define GEN_OPIVX_WIDEN_TRANS(NAME) \
-static bool trans_##NAME(DisasContext *s, arg_rmrr *a)       \
-{                                                            \
-    static gen_helper_opivx * const fns[3] = {               \
-        gen_helper_##NAME##_b,                               \
-        gen_helper_##NAME##_h,                               \
-        gen_helper_##NAME##_w                                \
-    };                                                       \
-    return do_opivx_widen(s, a, fns[s->sew]);                \
+#define GEN_OPIVX_WIDEN_TRANS(NAME, CHECK) \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
+{                                                                         \
+    if (CHECK(s, a)) {                                                    \
+        static gen_helper_opivx * const fns[3] = {                        \
+            gen_helper_##NAME##_b,                                        \
+            gen_helper_##NAME##_h,                                        \
+            gen_helper_##NAME##_w                                         \
+        };                                                                \
+        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fns[s->sew], s); \
+    }                                                                     \
+    return false;                                                         \
 }
 
-GEN_OPIVX_WIDEN_TRANS(vwaddu_vx)
-GEN_OPIVX_WIDEN_TRANS(vwadd_vx)
-GEN_OPIVX_WIDEN_TRANS(vwsubu_vx)
-GEN_OPIVX_WIDEN_TRANS(vwsub_vx)
+GEN_OPIVX_WIDEN_TRANS(vwaddu_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwadd_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwsubu_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwsub_vx, opivx_widen_check)
 
 /* WIDEN OPIVV with WIDEN */
 static bool opiwv_widen_check(DisasContext *s, arg_rmrr *a)
@@ -1997,9 +1991,9 @@ GEN_OPIVX_TRANS(vrem_vx, opivx_check)
 GEN_OPIVV_WIDEN_TRANS(vwmul_vv, opivv_widen_check)
 GEN_OPIVV_WIDEN_TRANS(vwmulu_vv, opivv_widen_check)
 GEN_OPIVV_WIDEN_TRANS(vwmulsu_vv, opivv_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmul_vx)
-GEN_OPIVX_WIDEN_TRANS(vwmulu_vx)
-GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmul_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmulu_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmulsu_vx, opivx_widen_check)
 
 /* Vector Single-Width Integer Multiply-Add Instructions */
 GEN_OPIVV_TRANS(vmacc_vv, opivv_check)
@@ -2015,10 +2009,10 @@ GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
 GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_widen_check)
 GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_widen_check)
 GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx)
-GEN_OPIVX_WIDEN_TRANS(vwmacc_vx)
-GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx)
-GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx)
+GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmacc_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx, opivx_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx, opivx_widen_check)
 
 /* Vector Integer Merge and Move Instructions */
 static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
-- 
2.41.0


