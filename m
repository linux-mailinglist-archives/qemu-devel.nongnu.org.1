Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52D7CBAAD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK9-0000B7-Gx; Tue, 17 Oct 2023 02:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK6-0008UH-TC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK4-0003r4-SC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:58 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ca72f8ff3aso11615905ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523175; x=1698127975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1prS6C+FwhKZyo+0txaEJWslfWJXoN0Tl5LZOeNLIlE=;
 b=uPV9cOtZFaXDkkW3J3qXNR4Q6yYRaYLKvSuajjKc2OTwNVC/sjaqTcNqkEo9CjLpiX
 tbIVlP51pRtHVvFFIXmcLOfwtUY4TrmG/b4kbaht1IWnTfSP+Y5v+vQJDPveFLQVzM5a
 rSkYxPpBG1fuHWYwuYPgZ2cOiVXqjNNjuekF7Nk4fVHc3hFAKZCsizvgiQsU8mwgPha0
 RQ1Z74n/hIRDd9IxVZ6rBJmsQbOzTrxwNREDRTW69g7VgjJypHvAXnBNJCe+B2Yhkj7A
 cK7Hr/blVEcUYoo/67gYU3CA1mXLQFpzCOgHdrbBqZ7khu3fAi4ML/TPBTZATUTKk2dw
 5aWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523175; x=1698127975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1prS6C+FwhKZyo+0txaEJWslfWJXoN0Tl5LZOeNLIlE=;
 b=XUv+s0nIKHnhW7e0kR3UsF8cy00EGFomaWFDvQiJ/UvKuV5j9oMMbnrcDQicU0RX8v
 E+bhllIuBniL7Pi4aWoY7KUU2dn/L67tPZ5KEjZ2p8/jc2K+UjftUwMBPye9nnIZmICk
 lC1UoRS7Q86SsPmNb+y3GDGYcqBpoZKX4oABVQATMaXxQYRpvcQhN/vADjZt/iNf4Pi8
 YICRjSoM1GqziTS/xLVnuLndqzfck1AniMuVCcFjANTKB8L6IwfcqQRDLVX+ICcT532M
 K0SMZi6VnfyMQ/8d4BA9/ykVvQozHUYCPzXUivHOYFxRG1c651eVPYcXrW2ItUA5FmJA
 6J9Q==
X-Gm-Message-State: AOJu0YyAz009LYcfeuSaxMXkdrcDkkhtwjNe4eJSXX5i/k01gq+TGcK5
 lsLk4e36fyfpKrOlNklsWZ1v48hs+0uDQNJJS68=
X-Google-Smtp-Source: AGHT+IETn9GSQSJEk1XcO8sUD4frbQKMQg14qSKMAa+Py0TxlH6yh5AKbV+XddQLwl6vlmyb7HxS/g==
X-Received: by 2002:a17:902:ce8d:b0:1c8:9a60:387f with SMTP id
 f13-20020a170902ce8d00b001c89a60387fmr1669404plg.56.1697523175647; 
 Mon, 16 Oct 2023 23:12:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 12/90] target/sparc: Move BPcc and Bicc to decodetree
Date: Mon, 16 Oct 2023 23:11:26 -0700
Message-Id: <20231017061244.681584-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/sparc/insns.decode |   4 ++
 target/sparc/translate.c  | 120 +++++++++++++++++++-------------------
 2 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a5f5d2681e..15cd975f4e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,4 +3,8 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+&bcc    i a cond cc
+BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
+Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=0
+
 CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 377f133595..7e14070322 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1362,44 +1362,6 @@ static void gen_cond_reg(TCGv r_dst, int cond, TCGv r_src)
 }
 #endif
 
-static void do_branch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
-{
-    unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
-    target_ulong target = dc->pc + offset;
-
-    if (unlikely(AM_CHECK(dc))) {
-        target &= 0xffffffffULL;
-    }
-    if (cond == 0x0) {
-        /* unconditional not taken */
-        if (a) {
-            dc->pc = dc->npc + 4;
-            dc->npc = dc->pc + 4;
-        } else {
-            dc->pc = dc->npc;
-            dc->npc = dc->pc + 4;
-        }
-    } else if (cond == 0x8) {
-        /* unconditional taken */
-        if (a) {
-            dc->pc = target;
-            dc->npc = dc->pc + 4;
-        } else {
-            dc->pc = dc->npc;
-            dc->npc = target;
-            tcg_gen_mov_tl(cpu_pc, cpu_npc);
-        }
-    } else {
-        flush_cond(dc);
-        gen_cond(cpu_cond, cc, cond, dc);
-        if (a) {
-            gen_branch_a(dc, target);
-        } else {
-            gen_branch_n(dc, target);
-        }
-    }
-}
-
 static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
 {
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
@@ -3041,6 +3003,64 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool advance_jump_uncond_never(DisasContext *dc, bool annul)
+{
+    if (annul) {
+        dc->pc = dc->npc + 4;
+        dc->npc = dc->pc + 4;
+    } else {
+        dc->pc = dc->npc;
+        dc->npc = dc->pc + 4;
+    }
+    return true;
+}
+
+static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
+                                       target_ulong dest)
+{
+    if (annul) {
+        dc->pc = dest;
+        dc->npc = dest + 4;
+    } else {
+        dc->pc = dc->npc;
+        dc->npc = dest;
+        tcg_gen_mov_tl(cpu_pc, cpu_npc);
+    }
+    return true;
+}
+
+static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
+{
+    if (annul) {
+        gen_branch_a(dc, dest);
+    } else {
+        gen_branch_n(dc, dest);
+    }
+    return true;
+}
+
+static bool do_bpcc(DisasContext *dc, arg_bcc *a)
+{
+    target_long target = dc->pc + a->i * 4;
+
+    if (unlikely(AM_CHECK(dc))) {
+        target &= 0xffffffffULL;
+    }
+    switch (a->cond) {
+    case 0x0:
+        return advance_jump_uncond_never(dc, a->a);
+    case 0x8:
+        return advance_jump_uncond_always(dc, a->a, target);
+    default:
+        flush_cond(dc);
+        gen_cond(cpu_cond, a->cc, a->cond, dc);
+        return advance_jump_cond(dc, a->a, target);
+    }
+}
+
+TRANS(BPcc,  64, do_bpcc, a)
+TRANS(Bicc, ALL, do_bpcc, a)
+
 static bool trans_CALL(DisasContext *dc, arg_CALL *a)
 {
     target_long target = dc->pc + a->i * 4;
@@ -3082,21 +3102,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             switch (xop) {
 #ifdef TARGET_SPARC64
             case 0x1:           /* V9 BPcc */
-                {
-                    int cc;
-
-                    target = GET_FIELD_SP(insn, 0, 18);
-                    target = sign_extend(target, 19);
-                    target <<= 2;
-                    cc = GET_FIELD_SP(insn, 20, 21);
-                    if (cc == 0)
-                        do_branch(dc, target, insn, 0);
-                    else if (cc == 2)
-                        do_branch(dc, target, insn, 1);
-                    else
-                        goto illegal_insn;
-                    goto jmp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
             case 0x3:           /* V9 BPr */
                 {
                     target = GET_FIELD_SP(insn, 0, 13) |
@@ -3126,13 +3132,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
 #endif
             case 0x2:           /* BN+x */
-                {
-                    target = GET_FIELD(insn, 10, 31);
-                    target = sign_extend(target, 22);
-                    target <<= 2;
-                    do_branch(dc, target, insn, 0);
-                    goto jmp_insn;
-                }
+                g_assert_not_reached(); /* in decodetree */
             case 0x6:           /* FBN+x */
                 {
                     if (gen_trap_ifnofpu(dc)) {
-- 
2.34.1


