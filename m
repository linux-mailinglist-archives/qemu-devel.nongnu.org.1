Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC9A7C8F0F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiQ-0006Dh-GW; Fri, 13 Oct 2023 17:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiP-0006DF-8B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiK-0000Q8-Bv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-690b7cb71aeso1917656b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232535; x=1697837335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycI+cirYBOHyfBLT7A60qwim087wp8OAryRPNF0aDjE=;
 b=qHu5pQiMLq+9ewpoFfJL9npc1DeMr3FxOQh5/u3Fd9hZXR/319SEHyDo2BnCSveIvf
 bo9K0b8wTXQo41+dFbkSNUDTdXVLSF4U86dlu4+3hDK3O8/gSAePRywz4u+F3tSC9t06
 PmApmzSJKkxfpQoOpQUuIjmABNTwsyDQ1W1LZWgO+euBwLiRMjSDSbA4RJ4+H+NAk9gN
 yjVHFUygqtzhzYVMxTp0rq3UM7InrMlYXHXoGp8XiQwIVcoIcQTYG6BkCGEbkqHNxtui
 xRt80nKYMZmvqt426SMxHsdyiC+NBXweRgkODvx2mUj3egV6tTMvbQDjdX/Y2yLw+dqY
 NynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232535; x=1697837335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycI+cirYBOHyfBLT7A60qwim087wp8OAryRPNF0aDjE=;
 b=kem3R58HvAqjpSpJEirI1VuLmgO+mv27PSEz8SL5g5VvmkwzwQj4piQKSSgkto+bQs
 twjxPcTKjvKKZl1NXiQdd7Im3LwkZY67AaUWnHeZ/LVBq+k54tcaZP6FXKkjbaCC7Mq6
 Vs/bU7Lw3gRJXqD3GE8aSQhItjueg9hukyc1dXAl4WrACRm6Hdm9zj9k0TgdGOoYllh5
 6b7wWnAnSEbBa9EFizeQQhApmvS6Y6vJKA25cw+FJnoEzy/is+8MJ/b9peajQHgozvwM
 +iycRQ1fuYe+r6MVrUi7jC8d4KKWXI30wK9GHaSiCHzFYZ/z+i49t5KQTroO/TSo1b9g
 w8/g==
X-Gm-Message-State: AOJu0YznaMlsMNBwxqiEdBgojpM82eKCo79mqv38SFFjx5UZoR/J5nqL
 fJrjaPbd59leWmMcVMbIwEtZER7iR9hnENhZvAI=
X-Google-Smtp-Source: AGHT+IHSizUFgZGnumUFqy14oD2HwrSwRWz4wdkZvROR7KVsWJbvbtPKXGvnL0s11q+aOw1TPONWlg==
X-Received: by 2002:a05:6a00:80f1:b0:68f:c4a2:fb1f with SMTP id
 ei49-20020a056a0080f100b0068fc4a2fb1fmr1863797pfb.8.1697232534776; 
 Fri, 13 Oct 2023 14:28:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 07/85] target/sparc: Move BPcc and Bicc to decodetree
Date: Fri, 13 Oct 2023 14:27:28 -0700
Message-Id: <20231013212846.165724-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index bc1033231f..125015fe1e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1323,44 +1323,6 @@ static void gen_cond_reg(TCGv r_dst, int cond, TCGv r_src)
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
@@ -3002,6 +2964,64 @@ static bool advance_pc(DisasContext *dc)
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
@@ -3043,21 +3063,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -3087,13 +3093,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


