Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D07C8F2D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPij-0006M1-NV; Fri, 13 Oct 2023 17:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPie-0006Kc-D8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPib-0000Ug-53
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-690fe10b6a4so2076568b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232551; x=1697837351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20NBIfDeq7i/k9K9KB1Vp0gzcYLgBgC5UETDi49ec1M=;
 b=gz79zuBCJUrcMVEwDX48DSlfwlL7mj9NAbdNs9vM33n+gNDVm2F7zYaz8yAK/iOTqL
 6/l96t6P5I1ezOsQK+s1/H2+5perD//mZ6k5P1iViAZ9/swQBzQAuRBhgk9rNSkBC3Qw
 E8kW13iwAxZZdU/GKHsk4zwdUOxH6EwbcBTxbizlAYP68qatmtLkHEqjR1UWpLuZnWsh
 CdhFWKaze5WltOan5aREXehS3ZU1AvjxrVBkGA+IWWQQz+os1RPIDqbEqvqFmUzXPuC8
 T2O+QZD9DkR0tmMFDYw3TfaULIaQUHwWIYLj49YFxF49KUldyHCjFQEctpuem5GxPKPI
 7ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232551; x=1697837351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20NBIfDeq7i/k9K9KB1Vp0gzcYLgBgC5UETDi49ec1M=;
 b=VX6B8GJ+ZyMbRE4/jQB/QpG/r0mkxLttJZTEQAmwRUQDHd4EndiHG7Vpnebh05Wqoo
 VMvxAU32iJVx1dlqmbo+uym+rwChrUX7YOn1c0KpugnLo940oFei3GM1RF7qOKyJ8tuI
 RJGth+knVws4SqIH5iPDVVvxNOpPnhLztR3dZAutX7sNsB20t4hFdXoWkMRAzUBp/R0S
 XV2a/xq5s/5dT4lN4BLRQErhK3RCNnLBAiJsiJNP4YKlYr3m3Zzn4dtkhetxObcbySph
 zN3Poix/yIqUNwlH79/RBob8JslFQ6f3UtuX3Pmxtzsq/4Sli+dUJp3zwMe4X2S0w1rW
 /f6w==
X-Gm-Message-State: AOJu0YyfpzeNP+6S+UD51kjkIpzQ9fuKk9Kv+L5t4Yz20Z8GJrH8W64N
 /WlTWRk0P5oElrXc6cEOv4DhIHY66WNTwaPxrnQ=
X-Google-Smtp-Source: AGHT+IHWB9oOzPpw//1cyDjdYiVcel6EBd0xI82sKvO/mNLGv9luX3/dJBPiSsdhh+DE71WZLwu9EQ==
X-Received: by 2002:a05:6a20:4422:b0:16b:d137:dfb3 with SMTP id
 ce34-20020a056a20442200b0016bd137dfb3mr28654545pzb.59.1697232551542; 
 Fri, 13 Oct 2023 14:29:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 25/85] target/sparc: Move ADDC to decodetree
Date: Fri, 13 Oct 2023 14:27:46 -0700
Message-Id: <20231013212846.165724-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 41 +++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a95f682fa7..87108da5da 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -172,3 +172,5 @@ ORN         10 ..... 000110 ..... . .............          @r_r_ri
 ORNcc       10 ..... 010110 ..... . .............          @r_r_ri
 XORN        10 ..... 000111 ..... . .............          @r_r_ri
 XORNcc      10 ..... 010111 ..... . .............          @r_r_ri
+ADDC        10 ..... 001000 ..... . .............          @r_r_ri
+ADDCcc      10 ..... 011000 ..... . .............          @r_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a21c5ec329..37917ad397 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4159,6 +4159,43 @@ TRANS(ANDNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 
+static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
+{
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!imm && rs2_or_imm & ~0x1f) {
+        return NULL;
+    }
+    if (imm || rs2_or_imm == 0) {
+        return tcg_constant_tl(rs2_or_imm);
+    } else {
+        return cpu_regs[rs2_or_imm];
+    }
+}
+
+static bool trans_ADDC(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_op_addx_int(dc, gen_dest_gpr(dc, a->rd),
+                    gen_load_gpr(dc, a->rs1), src2, false);
+    return advance_pc(dc);
+}
+
+static bool trans_ADDCcc(DisasContext *dc, arg_r_r_ri *a)
+{
+    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
+
+    if (src2 == NULL) {
+        return false;
+    }
+    gen_op_addx_int(dc, gen_dest_gpr(dc, a->rd),
+                    gen_load_gpr(dc, a->rs1), src2, true);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4583,10 +4620,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0x8: /* addx, V9 addc */
-                        gen_op_addx_int(dc, cpu_dst, cpu_src1, cpu_src2,
-                                        (xop & 0x10));
-                        break;
 #ifdef TARGET_SPARC64
                     case 0x9: /* V9 mulx */
                         tcg_gen_mul_i64(cpu_dst, cpu_src1, cpu_src2);
-- 
2.34.1


